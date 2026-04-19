// backend/utils/gameAction/applyActionFlow.js
const { handleAdminCheat } = require('../cheatEngine');
const { scanWorldContext } = require('../worldEngine');
const { checkLevelUp } = require('../gameEngine');
const { resolveCombatEncounter } = require('../combatEncounterEngine');
const { calculateSurvivalCost, isAggressiveAction } = require('../survivalEngine');
const { parseSurvivalAction } = require('../actionParser');
const { handleZoneTravel } = require('../travelEngine');
const { handleScavengeAction } = require('./scavengeEngine');
const { checkEvolutionEligibility, evolvePlayer } = require('../evolutionEngine');
const { maybeLearnEchoSenseFromSearch } = require('./learningInterceptor');
const { maybeProgressMastery } = require('./skillMasteryInterceptor');
const { enrichSearchExploration, isSearchLikeAction } = require('./searchExploration');

function emptyFlowTail() {
    return {
        levelUpNotice: '',
        monsterContext: '',
        monsterButtons: [],
        monsterImageUrl: null,
        worldLore: '',
        activeMonster: null,
        evolutionNotice: '',
        evolutionChoices: []
    };
}

async function applyActionFlow({ player, userId, action, db }) {
    const normalizedAction = String(action || '').trim();

    // --- 0. EVOLUTION COMMAND (e.g. "Evolve: Gloomthread Weaver") — meta action, skips combat/travel/AI ---
    const evoCmd = /^Evolve:\s*(.+)$/i.exec(normalizedAction);
    if (evoCmd) {
        const toSpecies = evoCmd[1].trim();
        const eligible = await checkEvolutionEligibility(db, player);
        const path = eligible.find((e) => e.to_species === toSpecies);
        if (path) {
            await evolvePlayer(db, player, toSpecies);
            const desc = path.description ? ` ${path.description}` : '';
            const story = `[SYSTEM: EVOLUTION COMPLETE] You have become ${toSpecies}.${desc}`.trim();
            return {
                player,
                engineNotice: story,
                evolutionResolved: true,
                evolutionStory: story,
                ...emptyFlowTail()
            };
        }
    }

    let earlyEvolutionWarning = '';
    if (evoCmd) {
        const badTarget = evoCmd[1].trim();
        earlyEvolutionWarning = `[SYSTEM] No valid evolution path to "${badTarget}" for your current species and level.`;
    }

    // --- 1. SCAVENGE / CONSUME / HARVEST (bypasses standard survival cost for this turn) ---
    const scavengeResult = handleScavengeAction(player, normalizedAction);
    const scavengeHandled = scavengeResult != null;

    let survival;
    if (scavengeHandled) {
        player = scavengeResult.player;
        survival = {
            hunger: player.hunger,
            sp: player.sp,
            healthPenalty: 0,
            statusNotice: ''
        };
    } else {
        survival = calculateSurvivalCost(player, normalizedAction, {
            aggressiveCombatStamina: isAggressiveAction(normalizedAction)
        });
        player.hunger = survival.hunger;
        player.sp = survival.sp;
        player.hp -= survival.healthPenalty;
    }

    // --- 2. CHEAT ENGINE CHECK ---
    const cheatCheck = await handleAdminCheat(normalizedAction, player, userId);
    if (cheatCheck.isCheat) {
        const error = new Error("CHEAT_RESPONSE");
        error.cheatResponse = cheatCheck.response;
        throw error;
    }

    // --- 3. WORLD ENGINE SCAN ---
    const worldData = await scanWorldContext(player, userId);

    // --- 4. COMBAT ENGINE LOGIC ---
    let engineNotice = scavengeHandled
        ? (scavengeResult.engineNotice || '')
        : (survival.statusNotice || '');
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const combatData = await resolveCombatEncounter({
        player,
        action: normalizedAction,
        engineNotice
    });

    player = combatData.player;
    engineNotice = combatData.engineNotice;
    monsterContext = combatData.monsterContext;
    monsterButtons = combatData.monsterButtons;
    monsterImageUrl = combatData.monsterImageUrl;

    // --- 4b. SEARCH / LOOK / SCAN — `location_seeds.hidden_lore` + `reincarnated_npcs` at current location_id ---
    if (isSearchLikeAction(normalizedAction)) {
        const searchExtra = await enrichSearchExploration(db, player, normalizedAction);
        if (searchExtra) {
            engineNotice = `${engineNotice} ${searchExtra}`.trim();
        }
    }

    // --- 5. SURVIVAL ACTION PARSER (skip if scavenge engine already resolved consume/harvest) ---
    if (
        !scavengeHandled &&
        !normalizedAction.startsWith('Attack') &&
        !normalizedAction.startsWith('Attempt to Flee')
    ) {
        const parsedSurvival = parseSurvivalAction(player, normalizedAction, engineNotice);
        player = parsedSurvival.player;
        engineNotice = parsedSurvival.engineNotice;
    }

    // --- 6. ZONE TRAVEL PARSER ---
    const travelData = await handleZoneTravel(normalizedAction, player, db);
    if (travelData.newLocation !== player.current_location) {
        player.current_location = travelData.newLocation;
    }
    engineNotice += travelData.travelNotice;
    if (earlyEvolutionWarning) {
        engineNotice = `${earlyEvolutionWarning} ${engineNotice}`.trim();
    }

    // --- 7. LEVEL UP (XP threshold vs next_level_xp; persists to DB) ---
    const { levelUpNotice } = await checkLevelUp(player, db);
    if (levelUpNotice) {
        engineNotice += ` ${levelUpNotice}`;
    }

    // --- 7.5. LEARNING (Search ×5 → Echo Sense L1 in soul_library.skills object) ---
    const learnResult = await maybeLearnEchoSenseFromSearch(db, userId, player, normalizedAction);
    if (learnResult.engineNotice) {
        engineNotice += ` ${learnResult.engineNotice}`;
    }

    // --- 7.6. MASTERY (e.g. Search + own Echo Sense → 20% chance to level temporary mastery) ---
    const masteryResult = await maybeProgressMastery(db, userId, player, normalizedAction);
    if (masteryResult.engineNotice) {
        engineNotice += ` ${masteryResult.engineNotice}`;
    }

    // --- 8. EVOLUTION AVAILABILITY (paths for current species / level) ---
    let evolutionNotice = '';
    let evolutionChoices = [];
    const evoOptions = await checkEvolutionEligibility(db, player);
    if (evoOptions.length > 0) {
        evolutionNotice =
            '[SYSTEM: EVOLUTION AVAILABLE] Your vessel may undergo metamorphosis. Choose an evolution from the options below, or speak a normal action to continue.';
        evolutionChoices = evoOptions.map((e) => `Evolve: ${e.to_species}`);
    }

    return {
        player,
        engineNotice,
        levelUpNotice: levelUpNotice || '',
        monsterContext,
        monsterButtons,
        monsterImageUrl,
        worldLore: worldData.worldLore || "",
        activeMonster: combatData.activeMonster,
        evolutionNotice,
        evolutionChoices
    };
}

module.exports = { applyActionFlow };
