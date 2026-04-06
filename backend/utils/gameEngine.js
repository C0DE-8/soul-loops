/**
 * gameEngine.js - THE "IMPOSSIBLE MODE" UPDATE
 */

const calculateCombat = (player, monster) => {
    // 1. DIMINISHING RETURNS (Anti-Farm Logic)
    // If you are way stronger than the prey, your soul doesn't grow from the kill.
    const levelDiff = player.current_level - monster.base_level;
    let xpMultiplier = 1.0;

    if (levelDiff > 5) xpMultiplier = 0.5;   // 50% XP
    if (levelDiff > 10) xpMultiplier = 0.1;  // 10% XP
    if (levelDiff > 20) xpMultiplier = 0.0;  // 0 XP (You gain nothing from ants)

    // 2. SURVIVAL DEBUFFS
    // Hunger < 10 = Weakened State (50% DMG)
    const hungerFactor = (player.hunger < 10) ? 0.5 : 1.0;
    
    const rawDamage = ((player.offense * player.current_level) - (monster.base_defense / 2)) * hungerFactor;
    const damageDealt = Math.max(1, Math.floor(rawDamage));
    
    const isMonsterDead = (monster.base_hp - damageDealt) <= 0;

    // 3. XP REWARD SCALING
    const rankXP = { 'F': 20, 'E': 50, 'D': 100, 'C': 250, 'B': 500, 'A': 1000, 'S': 5000 };
    const baseXP = isMonsterDead ? (rankXP[monster.danger_rank] || 20) : 5;
    
    // Apply the Level Difference Penalty
    const xpGained = Math.floor(baseXP * xpMultiplier);

    return { 
        damageDealt, 
        isMonsterDead, 
        xpGained, 
        monsterRemainingHp: Math.max(0, monster.base_hp - damageDealt) 
    };
};

const processLevelUp = (player) => {
    // EXP CURVE: Level cubed * 100. 
    // LV 1: 100 | LV 10: 100,000 | LV 20: 800,000
    const requiredXp = Math.pow(player.current_level, 3) * 100;

    if (player.xp >= requiredXp) {
        // --- THE EVOLUTION WALL ---
        // If the player hits Level 10, 20, or 30, they CANNOT level up 
        // until they evolve their vessel.
        const evolutionMilestones = [10, 20, 30, 50];
        if (evolutionMilestones.includes(player.current_level)) {
            return { 
                leveledUp: false, 
                evolutionRequired: true, 
                systemLog: "[SYSTEM_RESTRICTION]: Vessel reached maximum capacity. Evolution required to progress." 
            };
        }

        const newLevel = player.current_level + 1;
        return {
            leveledUp: true,
            current_level: newLevel,
            max_hp: player.max_hp + 10,
            offense: player.offense + 2,
            defense: player.defense + 2,
            next_level_xp: Math.pow(newLevel, 3) * 100,
            systemLog: `[SYSTEM_EVOLUTION]: Soul Density stabilized at Level ${newLevel}.`
        };
    }
    return { leveledUp: false };
};

module.exports = { calculateCombat, processLevelUp };