const db = require('../config/db');
const { calculateCombat } = require('./gameEngine');
const { clampSp, clampHunger, isAggressiveAction } = require('./survivalEngine');
const { MAX_MASTERY_LEVEL } = require('./gameAction/fetchPlayerState');

/**
 * Temporary mastery in `soul_library.skills` scales damage: Damage * (1 + (Level * 0.05)).
 * No library entry for this skill name → multiplier 1.
 */
function skillDamageMultiplierFromLibrary(player, skillName) {
    const m = player.library_skills_map || {};
    const n = String(skillName || '').trim();
    if (!n || m[n] == null) return 1;
    const lv = Math.min(
        MAX_MASTERY_LEVEL,
        Math.max(1, Math.floor(Number(m[n]) || 1))
    );
    return 1 + lv * 0.05;
}

const getCounterDamage = (monster, player) => {
    const enemyAtk = Number(monster.base_offense || monster.base_attack || 5);
    return Math.max(
        1,
        Math.floor(enemyAtk - (Number(player.defense || 0) / 3))
    );
};

/** Prefer longer skill names so partial names do not steal matches from full active skills. */
function findMatchedActiveSkill(actionLower, activeSkills) {
    if (!Array.isArray(activeSkills) || activeSkills.length === 0) return null;
    const sorted = [...activeSkills].sort(
        (a, b) => String(b.name || '').length - String(a.name || '').length
    );
    for (const skill of sorted) {
        const n = String(skill.name || '').toLowerCase().trim();
        if (n.length > 0 && actionLower.includes(n)) return skill;
    }
    return null;
}

/** Magical strike: same physical scaling as a normal hit, +30 guaranteed bonus damage. */
function computeMagicalStrikeDamage(player, monster) {
    const hungerFactor = Number(player.hunger) < 10 ? 0.5 : 1.0;
    const raw =
        (Number(player.offense || 0) * Number(player.current_level || 1) -
            Number(monster.base_defense || 0) / 2) *
        hungerFactor;
    const base = Math.max(1, Math.floor(raw));
    return base + 30;
}

function appendSpellXpGain(player, monster, finalDamage) {
    const levelDiff = Number(player.current_level || 1) - Number(monster.base_level || 1);
    let xpMultiplier = 1.0;
    if (levelDiff > 5) xpMultiplier = 0.5;
    if (levelDiff > 10) xpMultiplier = 0.1;
    if (levelDiff > 20) xpMultiplier = 0.0;
    const rankXP = { F: 20, E: 50, D: 100, C: 250, B: 500, A: 1000, S: 5000 };
    const isKill = finalDamage >= Number(monster.current_hp);
    const baseXP = isKill ? (rankXP[monster.danger_rank] || 20) : 5;
    const xpGained = Math.floor(baseXP * xpMultiplier);
    player.xp = Number(player.xp || 0) + xpGained;
    return xpGained;
}

/** No new spawn while player is resting, looting, searching, etc. */
const downtimeTriggers = [
    'scavenge',
    'eat',
    'consume',
    'rest',
    'search',
    'inventory',
    'wait',
    'look',
    'harvest',
    'loot',
    'camp',
    'stay',
    'heal'
];

/** Only these intents re-roll the zone spawn table (exploration pressure). */
const exploreTriggers = [
    'move',
    'walk',
    'explore',
    'travel',
    'continue',
    'leave',
    'forward',
    'deeper',
    'venture',
    'run',
    'scout'
];

function actionHasDowntimeIntent(actionLower) {
    return downtimeTriggers.some((t) => actionLower.includes(t));
}

function actionHasExploreIntent(actionLower) {
    return exploreTriggers.some((t) => actionLower.includes(t));
}

const loadOrCreateEncounter = async (player, action) => {
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
        return { activeMonster, isNewEncounter };
    }

    const actionLower = String(action || '').toLowerCase();

    if (actionHasDowntimeIntent(actionLower)) {
        return { activeMonster: null, isNewEncounter: false };
    }

    if (!actionHasExploreIntent(actionLower)) {
        return { activeMonster: null, isNewEncounter: false };
    }

    const [spawns] = await db.execute(
        `
        SELECT m.* FROM zone_spawns z 
        JOIN master_npcs m ON z.npc_id = m.id 
        WHERE z.zone_name = ? 
          AND RAND() * 100 <= z.spawn_chance
        LIMIT 1
    `,
        [player.current_location]
    );

    if (spawns.length > 0) {
        const m = spawns[0];
        const dLevel = Math.max(
            1,
            Number(player.current_level || 1) + Math.floor(Math.random() * 3) - 1
        );
        const dHp = Number(m.base_hp || 1) + dLevel * 10;

        const [insertEnc] = await db.execute(
            `
            INSERT INTO active_encounters (life_id, npc_id, dynamic_level, current_hp, max_hp)
            VALUES (?, ?, ?, ?, ?)
        `,
            [player.life_id, m.id, dLevel, dHp, dHp]
        );

        activeMonster = {
            ...m,
            encounter_id: insertEnc.insertId,
            dynamic_level: dLevel,
            current_hp: dHp,
            max_hp: dHp
        };

        isNewEncounter = true;
    }

    return { activeMonster, isNewEncounter };
};

const resolveCombatEncounter = async ({ player, action, engineNotice = "" }) => {
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const actionLower = String(action).toLowerCase();

    const isAggressive = isAggressiveAction(action);
    const isSkill = actionLower.includes("skill") || actionLower.includes("risky") || actionLower.includes("beast");

    const { activeMonster, isNewEncounter } = await loadOrCreateEncounter(player, action);

    if (!activeMonster) {
        // Empty room: monsterContext / monsterButtons stay blank so narration is pure downtime.
        // Aggressive actions with no target still pay a small whiff cost.
        if (isAggressive) {
            const whiffSp = isSkill ? 12 : 4;
            const cur = clampSp(player, player.sp);
            player.sp = clampSp(player, cur - whiffSp);
            player.hunger = clampHunger(Number(player.hunger || 0) - (isSkill ? 4 : 2));
            engineNotice += ` [COMBAT_LOG: No target in range. Stamina spent: ${whiffSp} SP.]`;
        }
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

    // ==========================================
    // 0. ACTIVE SPELL (strict magic — before standard aggression / calculateCombat)
    // ==========================================
    const matchedSpell = findMatchedActiveSkill(actionLower, player.active_skills);
    if (matchedSpell) {
        const spCost = Math.max(0, Math.floor(Number(matchedSpell.sp_cost) || 0));
        const curSp = clampSp(player, player.sp);

        if (curSp < spCost) {
            engineNotice +=
                ` [SPELL_FIZZLE: ${matchedSpell.name} failed — insufficient stamina (${curSp}/${spCost} SP). The spell fizzles; the ${activeMonster.name} presses the opening!]`;
            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            if (player.hp === 0) {
                engineNotice += ` [FATAL_BLOW_RECEIVED: ${activeMonster.name} struck for ${counterDamage} DMG while your spell collapsed. Player HP reached 0. Output [STATUS: DECEASED].]`;
                await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);
                monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
                monsterButtons = [];
            } else {
                engineNotice += ` [COUNTER_LOG: ${activeMonster.name} punishes your drained stamina! Took ${counterDamage} DMG.]`;
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
        }

        player.sp = clampSp(player, curSp - spCost);
        let finalDamage = computeMagicalStrikeDamage(player, activeMonster);
        const masteryMult = skillDamageMultiplierFromLibrary(player, matchedSpell.name);
        finalDamage = Math.max(1, Math.floor(finalDamage * masteryMult));
        const xpGained = appendSpellXpGain(player, activeMonster, finalDamage);

        engineNotice += ` [SPELL_CAST: Player successfully invoked ${matchedSpell.name}! Dealt massive damage.]`;

        if (finalDamage >= activeMonster.current_hp) {
            engineNotice += ` [COMBAT_LOG: Spell vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${finalDamage}. Status: TARGET_ELIMINATED. XP: ${xpGained}.]`;
            await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);

            activeMonster.current_hp = 0;

            monsterContext = `[ENCOUNTER CLEARED] The corpse of the ${activeMonster.name} lies before you. `;
        } else {
            const remainingHp = activeMonster.current_hp - finalDamage;
            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            if (player.hp === 0) {
                engineNotice += ` [FATAL_BLOW_RECEIVED: ${activeMonster.name} retaliated with ${counterDamage} DMG. Player HP reached 0. Output [STATUS: DECEASED]. Narrate the vessel's death and the soul leaving the body.]`;
                await db.execute('DELETE FROM active_encounters WHERE encounter_id = ?', [activeMonster.encounter_id]);

                activeMonster.current_hp = remainingHp;

                monsterContext = `[SYSTEM: VESSEL DESTROYED]`;
                monsterButtons = [];
            } else {
                engineNotice += ` [COMBAT_LOG: DMG: ${finalDamage}. Enemy HP: ${remainingHp}/${activeMonster.max_hp}.]`;
                engineNotice += ` [COUNTER_LOG: ${activeMonster.name} retaliates! Player took ${counterDamage} DMG.]`;

                await db.execute('UPDATE active_encounters SET current_hp = ? WHERE encounter_id = ?', [remainingHp, activeMonster.encounter_id]);

                activeMonster.current_hp = remainingHp;

                monsterContext = `[DUEL: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank})]. It prepares a follow-up strike! Enemy HP: ${remainingHp}/${activeMonster.max_hp}. `;
                monsterButtons = [
                    `Attack the ${activeMonster.name}`,
                    `[SKILL] Unleash Heavy Strike on ${activeMonster.name}`,
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
    }

    // ==========================================
    // 1. COMBAT ACTION LOGIC (THE FIGHT)
    // ==========================================
    if (isAggressive) {
        const result = calculateCombat(player, activeMonster, { isSkill });

        let finalDamage = result.damageDealt;
        const finalSpCost = Number(result.spCost) || 4;
        const hungerFromCombat = Number(result.hungerCost) || 2;

        const atkSkillMatch = findMatchedActiveSkill(actionLower, player.active_skills);
        const masteryMult = skillDamageMultiplierFromLibrary(
            player,
            atkSkillMatch ? atkSkillMatch.name : ''
        );

        if (isSkill) {
            finalDamage = Math.floor(finalDamage * 1.5 * masteryMult);
            engineNotice += ` [SKILL_ACTIVATE: Inner Power channeled!]`;
        } else if (atkSkillMatch && masteryMult > 1) {
            finalDamage = Math.max(1, Math.floor(finalDamage * masteryMult));
        }

        player.xp = Number(player.xp || 0) + Number(result.xpGained || 0);
        const spAfter = clampSp(player, clampSp(player, player.sp) - finalSpCost);
        player.sp = spAfter;
        player.hunger = clampHunger(Number(player.hunger || 0) - hungerFromCombat);

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
        player.sp = clampSp(player, clampSp(player, player.sp) + 5);

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
