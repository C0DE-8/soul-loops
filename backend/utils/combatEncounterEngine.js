const db = require('../config/db');
const { calculateCombat } = require('./gameEngine');

const getCounterDamage = (monster, player) => {
    // Note: Checking base_offense as that's standard, falling back to base_attack or 5
    const enemyAtk = Number(monster.base_offense || monster.base_attack || 5);
    return Math.max(
        1,
        Math.floor(enemyAtk - (Number(player.defense || 0) / 3))
    );
};

const loadOrCreateEncounter = async (player) => {
    let activeMonster = null;
    let isNewEncounter = false;

    const [activeFights] = await db.execute(`
        SELECT a.encounter_id, a.dynamic_level, a.current_hp, a.max_hp, m.*
        FROM active_encounters a
        JOIN master_npcs m ON a.npc_id = m.id
        WHERE a.life_id = ?
    `, [player.life_id]);

    if (activeFights.length > 0) {
        activeMonster = activeFights[0];
    } else {
        const [spawns] = await db.execute(`
            SELECT m.* FROM zone_spawns z 
            JOIN master_npcs m ON z.npc_id = m.id 
            WHERE z.zone_name = ? 
              AND RAND() * 100 <= z.spawn_chance
            LIMIT 1
        `, [player.current_location]);

        if (spawns.length > 0) {
            const m = spawns[0];
            const dLevel = Math.max(
                1,
                Number(player.current_level || 1) + Math.floor(Math.random() * 3) - 1
            );
            const dHp = Number(m.base_hp || 1) + (dLevel * 10);

            const [insertEnc] = await db.execute(`
                INSERT INTO active_encounters (life_id, npc_id, dynamic_level, current_hp, max_hp)
                VALUES (?, ?, ?, ?, ?)
            `, [player.life_id, m.id, dLevel, dHp, dHp]);

            activeMonster = {
                ...m,
                encounter_id: insertEnc.insertId,
                dynamic_level: dLevel,
                current_hp: dHp,
                max_hp: dHp
            };

            isNewEncounter = true;
        }
    }

    return { activeMonster, isNewEncounter };
};

const resolveCombatEncounter = async ({ player, action, engineNotice = "" }) => {
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const { activeMonster, isNewEncounter } = await loadOrCreateEncounter(player);

    if (!activeMonster) {
        return {
            player,
            engineNotice,
            monsterContext,
            monsterButtons,
            monsterImageUrl,
            activeMonster: null
        };
    }

    monsterImageUrl = activeMonster.npc_image || null;
    const actionLower = String(action).toLowerCase();

    // ==========================================
    // 1. COMBAT ACTION LOGIC (THE FIGHT)
    // ==========================================
    if (actionLower.startsWith("attack") || actionLower.includes("skill") || actionLower.includes("strike")) {
        const result = calculateCombat(player, activeMonster);

        // --- SKILL MULTIPLIER ---
        let finalDamage = result.damageDealt;
        let finalSpCost = result.spCost;

        if (actionLower.includes("skill")) {
            finalDamage = Math.floor(finalDamage * 1.5); // 50% more damage
            finalSpCost = finalSpCost * 2;              // Double stamina cost
            engineNotice += ` [SKILL_ACTIVATE: Inner Power channeled!]`;
        }

        player.xp = Number(player.xp || 0) + Number(result.xpGained || 0);
        player.sp = Math.max(0, Number(player.sp || 0) - finalSpCost);
        player.hunger = Math.max(0, Number(player.hunger || 0) - Number(result.hungerCost || 0));

        // Check if the monster dies based on its CURRENT HP, not base HP
        if (finalDamage >= activeMonster.current_hp) {
            // --- VICTORY ---
            engineNotice += ` [COMBAT_LOG: Action: Strike vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${finalDamage}. Status: TARGET_ELIMINATED. XP: ${result.xpGained}.]`;

            await db.execute(
                'DELETE FROM active_encounters WHERE encounter_id = ?',
                [activeMonster.encounter_id]
            );

            monsterContext = `[ENCOUNTER CLEARED] The corpse of the ${activeMonster.name} lies before you, dissolving into the dungeon's mana. `;
        } else {
            // --- COUNTER ATTACK ---
            const remainingHp = activeMonster.current_hp - finalDamage;
            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            engineNotice += ` [COMBAT_LOG: Action: Strike vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${finalDamage}. Enemy HP: ${remainingHp}/${activeMonster.max_hp}. Status: COUNTER_ATTACK_IMMINENT.]`;
            engineNotice += ` [COUNTER_LOG: ${activeMonster.name} retaliates. Player Damage Taken: ${counterDamage}.]`;

            await db.execute(
                'UPDATE active_encounters SET current_hp = ? WHERE encounter_id = ?',
                [remainingHp, activeMonster.encounter_id]
            );

            monsterContext = `[DUEL: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank})]. It prepares a follow-up strike! Enemy HP: ${remainingHp}/${activeMonster.max_hp}. `;
            
            // --- ANIME-STYLE BUTTONS ---
            monsterButtons = [
                `Attack the ${activeMonster.name}`,
                `[SKILL] Unleash Heavy Strike on ${activeMonster.name}`,
                `[DEFEND] Brace for ${activeMonster.name}'s next move`,
                `Attempt to Flee from the ${activeMonster.name}`
            ];
        }

    } else if (actionLower.includes("defend") || actionLower.includes("brace")) {
        // --- DEFENSIVE STANCE ---
        // Take 50% less damage this turn but gain no XP, and recover some SP
        const counterDamage = Math.floor(getCounterDamage(activeMonster, player) * 0.5);
        player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);
        player.sp = Math.min(Number(player.max_sp || 100), Number(player.sp || 0) + 5); 

        engineNotice += ` [COMBAT_LOG: You take a defensive stance. Damage mitigated. Took ${counterDamage} DMG.]`;
        
        monsterContext = `[DEFENDING: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} is circling you. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
        monsterButtons = [
            `Attack the ${activeMonster.name}`,
            `[SKILL] Counter-strike ${activeMonster.name}`,
            `Attempt to Flee from the ${activeMonster.name}`
        ];

    } else if (actionLower.startsWith("attempt to flee")) {
        // --- FLEE LOGIC ---
        if (Math.random() > 0.5) {
            engineNotice += ` [COMBAT_LOG: Escape successful. You broke line of sight.]`;

            await db.execute(
                'DELETE FROM active_encounters WHERE encounter_id = ?',
                [activeMonster.encounter_id]
            );

            monsterContext = `[FLED ENCOUNTER] You narrowly escaped the beast. `;
        } else {
            engineNotice += ` [COMBAT_LOG: Escape failed. The Lvl ${activeMonster.dynamic_level} ${activeMonster.name} blocks your path.]`;

            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            engineNotice += ` [COUNTER_LOG: ${activeMonster.name} punishes your escape attempt. Player Damage Taken: ${counterDamage}.]`;

            monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
            monsterButtons = [
                `Attack the ${activeMonster.name}`,
                `[DEFEND] Brace for ${activeMonster.name}'s next move`,
                `Attempt to Flee from the ${activeMonster.name}`
            ];
        }

    } else if (isNewEncounter) {
        // --- INITIAL ENCOUNTER ---
        monsterContext = `[ENCOUNTER: WILD Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank}). Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. ${activeMonster.description}. `;
        monsterButtons = [
            `Attack the ${activeMonster.name}`,
            `[SKILL] Preemptive Strike on ${activeMonster.name}`,
            `Attempt to Flee from the ${activeMonster.name}`
        ];

    } else {
        // --- HESITATION / CUSTOM ACTION ---
        const counterDamage = getCounterDamage(activeMonster, player);
        player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

        engineNotice += ` [COMBAT_LOG: Player attempted a custom action: "${action}". The Lvl ${activeMonster.dynamic_level} ${activeMonster.name} seized the opening and attacked! Player Damage Taken: ${counterDamage}.]`;

        monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
        monsterButtons = [
            `Attack the ${activeMonster.name}`,
            `[DEFEND] Brace for ${activeMonster.name}'s next move`,
            `Attempt to Flee from the ${activeMonster.name}`
        ];
    }

    return {
        player,
        engineNotice,
        monsterContext,
        monsterButtons,
        monsterImageUrl,
        activeMonster
    };
};

module.exports = {
    resolveCombatEncounter
};