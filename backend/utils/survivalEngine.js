/**
 * survivalEngine.js - Enhanced with Travel Costs
 */

const calculateSurvivalCost = (player, action) => {
    let hungerCost = 2; // Base activity cost
    let spCost = 5;     // Base activity cost

    const normalizedAction = action.toLowerCase();

    // --- 1. CONTEXT-SPECIFIC COSTS ---
    if (normalizedAction.includes('travel') || normalizedAction.includes('move to')) {
        // Traveling across zones is exhausting
        // Dwarves/Predators might have different modifiers
        hungerCost = 15; 
        
        // SPD Penalty: Lower Speed makes travel cost MORE Stamina
        const spdModifier = Math.max(1, 20 / (player.speed || 1)); 
        spCost = 20 * spdModifier; 

    } else if (normalizedAction.includes('attack')) {
        hungerCost = 8;
        spCost = 15;
    } else if (normalizedAction.includes('rest')) {
        hungerCost = 1;
        spCost = -25; // Restore SP
    } else if (normalizedAction.includes('eat')) {
        hungerCost = -40; // Restore Hunger (Significant)
        spCost = 5;
    }

    // --- 2. VESSEL MODIFIERS ---
    if (player.vessel_type === 'Predator') hungerCost *= 1.3;
    if (player.vessel_type === 'Scavenger') hungerCost *= 0.8; // Scavengers are efficient

    // --- 3. APPLY CALCULATIONS ---
    const newHunger = Math.max(0, Math.min(100, player.hunger - hungerCost));
    const newSP = Math.max(0, Math.min(player.max_sp, player.sp - spCost));

    let statusNotice = "";
    let healthPenalty = 0;

    if (newHunger <= 0) {
        statusNotice += "[SYSTEM: STARVATION DETECTED. HP REDUCED.] ";
        healthPenalty = 5;
    }
    if (newSP <= 0) {
        statusNotice += "[SYSTEM: EXHAUSTION DETECTED. ACTION EFFICIENCY DROPPED.] ";
    }

    return {
        hunger: Math.floor(newHunger),
        sp: Math.floor(newSP),
        healthPenalty,
        statusNotice
    };
};

module.exports = { calculateSurvivalCost };