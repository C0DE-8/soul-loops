const db = require('../config/db');
const { calculateCombat } = require('./gameEngine');

const getCounterDamage = (monster, player) => {
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

    // --- AGGRESSION ARRAY (Fixes the "Risky Action" bug) ---
    const aggressiveTriggers = ["attack", "skill", "strike", "grapple", "charge", "slash", "hit", "kill", "risky action", "beast"];
    const isAggressive = aggressiveTriggers.some(word => actionLower.includes(word));

    // ==========================================
    // 1. COMBAT ACTION LOGIC (THE FIGHT)
    // ==========================================
    if (isAggressive) {
        const result = calculateCombat(player, activeMonster);

        // --- SKILL MULTIPLIER ---
        let finalDamage = result.damageDealt;
        let finalSpCost = result.spCost;

        if (actionLower.includes("skill") || actionLower.includes("risky") || actionLower.includes("beast")) {
            finalDamage = Math.floor(finalDamage * 1.5); 
            finalSpCost = finalSpCost * 2;              
            engineNotice += ` [SKILL_ACTIVATE: Inner Power channeled!]`;
        }

        player.xp = Number(player.xp || 0) + Number(result.xpGained || 0);
        player.sp = Math.max(0, Number(player.sp || 0) - finalSpCost);
        player.hunger = Math.max(0, Number(player.hunger || 0) - Number(result.hungerCost || 0));

        if (finalDamage >= activeMonster.current_hp) {
            // --- VICTORY ---
            engineNotice += ` [COMBAT_LOG: Action: Strike vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${finalDamage}. Status: TARGET_ELIMINATED. XP: ${result.xpGained}.]`;
            await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
            
            // 👇 FIX: Show HP hitting 0 in the HUD 👇
            activeMonster.current_hp = 0; 

            monsterContext = `[ENCOUNTER CLEARED] The corpse of the ${activeMonster.name} lies before you. `;
        } else {
            // --- COUNTER ATTACK ---
            const remainingHp = activeMonster.current_hp - finalDamage;
            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            // --- DEATH CHECK 1 ---
            if (player.hp === 0) {
                engineNotice += ` [FATAL_BLOW_RECEIVED: ${activeMonster.name} retaliated with ${counterDamage} DMG. Player HP reached 0. Output [STATUS: DECEASED]. Narrate the vessel's death and the soul leaving the body.]`;
                await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
                
                // Keep the monster's HP updated in the HUD even if it kills you
                activeMonster.current_hp = remainingHp;

                monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
                monsterButtons = []; // Clear buttons because player is dead
            } else {
                engineNotice += ` [COMBAT_LOG: DMG: ${finalDamage}. Enemy HP: ${remainingHp}/${activeMonster.max_hp}.]`;
                engineNotice += ` [COUNTER_LOG: ${activeMonster.name} retaliates! Player took ${counterDamage} DMG.]`;

                await db.execute('UPDATE active_encounters SET current_hp = ? WHERE encounter_id = ?', [remainingHp, activeMonster.encounter_id]);

                // 👇 FIX: UPDATE THE OBJECT SO THE HUD SEES IT 👇
                activeMonster.current_hp = remainingHp;
                // 👆 --------------------------------------------- 👆

                monsterContext = `[DUEL: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank})]. It prepares a follow-up strike! Enemy HP: ${remainingHp}/${activeMonster.max_hp}. `;
                monsterButtons = [
                    `Attack the ${activeMonster.name}`,
                    `[SKILL] Unleash Heavy Strike on ${activeMonster.name}`,
                    `[DEFEND] Brace for ${activeMonster.name}'s next move`,
                    `Attempt to Flee from the ${activeMonster.name}`
                ];
            }
        }

    } else if (actionLower.includes("defend") || actionLower.includes("brace")) {
        // --- DEFENSIVE STANCE ---
        const counterDamage = Math.floor(getCounterDamage(activeMonster, player) * 0.5);
        player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);
        player.sp = Math.min(Number(player.max_sp || 100), Number(player.sp || 0) + 5); 

        // --- DEATH CHECK 2 ---
        if (player.hp === 0) {
            engineNotice += ` [FATAL_BLOW_RECEIVED: Your guard broke. The ${activeMonster.name} crushed you for ${counterDamage} DMG. Player HP reached 0. Output [STATUS: DECEASED]. Narrate the vessel's death.]`;
            await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
            monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
            monsterButtons = [];
        } else {
            engineNotice += ` [COMBAT_LOG: You take a defensive stance. Damage mitigated. Took ${counterDamage} DMG.]`;
            monsterContext = `[DEFENDING: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} is circling you. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
            monsterButtons = [
                `Attack the ${activeMonster.name}`,
                `[SKILL] Counter-strike ${activeMonster.name}`,
                `Attempt to Flee from the ${activeMonster.name}`
            ];
        }

    } else if (actionLower.startsWith("attempt to flee")) {
        // --- FLEE LOGIC ---
        if (Math.random() > 0.5) {
            engineNotice += ` [COMBAT_LOG: Escape successful. You broke line of sight.]`;
            await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
            monsterContext = `[FLED ENCOUNTER] You narrowly escaped the beast. `;
        } else {
            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            // --- DEATH CHECK 3 ---
            if (player.hp === 0) {
                engineNotice += ` [FATAL_BLOW_RECEIVED: Escape failed. The ${activeMonster.name} struck you down from behind for ${counterDamage} DMG. Player HP reached 0. Output [STATUS: DECEASED]. Narrate the vessel's death.]`;
                await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
                monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
                monsterButtons = [];
            } else {
                engineNotice += ` [COMBAT_LOG: Escape failed.] [COUNTER_LOG: ${activeMonster.name} punishes your attempt. Took ${counterDamage} DMG.]`;
                monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
                monsterButtons = [
                    `Attack the ${activeMonster.name}`,
                    `[DEFEND] Brace for ${activeMonster.name}'s next move`,
                    `Attempt to Flee from the ${activeMonster.name}`
                ];
            }
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

        // --- DEATH CHECK 4 ---
        if (player.hp === 0) {
            engineNotice += ` [FATAL_BLOW_RECEIVED: Your hesitation was fatal. The ${activeMonster.name} dealt ${counterDamage} DMG. Player HP reached 0. Output [STATUS: DECEASED]. Narrate the vessel's death.]`;
            await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
            monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
            monsterButtons = [];
        } else {
            engineNotice += ` [COMBAT_LOG: Custom action failed. The ${activeMonster.name} seized the opening! Took ${counterDamage} DMG.]`;
            monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
            monsterButtons = [
                `Attack the ${activeMonster.name}`,
                `[DEFEND] Brace for ${activeMonster.name}'s next move`,
                `Attempt to Flee from the ${activeMonster.name}`
            ];
        }
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