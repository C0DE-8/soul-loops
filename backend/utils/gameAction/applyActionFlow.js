// backend/utils/gameAction/applyActionFlow.js
const { handleAdminCheat } = require('../cheatEngine');
const { scanWorldContext } = require('../worldEngine');
const { processLevelUp } = require('../gameEngine');
const { resolveCombatEncounter } = require('../combatEncounterEngine');
const { calculateSurvivalCost } = require('../survivalEngine');
const { parseSurvivalAction } = require('../actionParser');
const { handleZoneTravel } = require('../travelEngine');

async function applyActionFlow({ player, userId, action, db }) {
    // --- 1. SURVIVAL CALCULATIONS ---
    const survival = calculateSurvivalCost(player, action);
    player.hunger = survival.hunger;
    player.sp = survival.sp;
    player.hp -= survival.healthPenalty;

    // --- 2. CHEAT ENGINE CHECK ---
    const cheatCheck = await handleAdminCheat(action, player, userId);
    if (cheatCheck.isCheat) {
        const error = new Error("CHEAT_RESPONSE");
        error.cheatResponse = cheatCheck.response;
        throw error;
    }

    // --- 3. WORLD ENGINE SCAN ---
    const worldData = await scanWorldContext(player, userId);

    // --- 4. COMBAT ENGINE LOGIC ---
    let engineNotice = survival.statusNotice || "";
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const combatData = await resolveCombatEncounter({
        player,
        action,
        engineNotice
    });

    player = combatData.player;
    engineNotice = combatData.engineNotice;
    monsterContext = combatData.monsterContext;
    monsterButtons = combatData.monsterButtons;
    monsterImageUrl = combatData.monsterImageUrl;

    // --- 5. SURVIVAL ACTION PARSER ---
    if (!action.startsWith("Attack") && !action.startsWith("Attempt to Flee")) {
        const parsedSurvival = parseSurvivalAction(player, action, engineNotice);
        player = parsedSurvival.player;
        engineNotice = parsedSurvival.engineNotice;
    }

    // --- 6. ZONE TRAVEL PARSER ---
    const travelData = await handleZoneTravel(action, player, db);
    if (travelData.newLocation !== player.current_location) {
        player.current_location = travelData.newLocation;
    }
    engineNotice += travelData.travelNotice;

    // --- 7. LEVEL ENGINE ---
    const levelData = processLevelUp(player);
    if (levelData.leveledUp) {
        Object.assign(player, levelData);
        engineNotice += ` ${levelData.systemLog}`;
    } else if (levelData.evolutionRequired) {
        engineNotice += ` ${levelData.systemLog}`;
    }

    return {
        player,
        engineNotice,
        monsterContext,
        monsterButtons,
        monsterImageUrl,
        worldLore: worldData.worldLore || "",
        activeMonster: combatData.activeMonster // <--- THE FIX: Passing the monster data down the chain!
    };
}

module.exports = { applyActionFlow };