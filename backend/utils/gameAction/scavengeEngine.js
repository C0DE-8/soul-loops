/**
 * Scavenge, consume, and harvest — inventory + survival micro-actions.
 */

const { clampSp, clampHunger } = require('../survivalEngine');

const consumeTriggers = ['eat', 'consume', 'feed', 'devour'];

const harvestTriggers = [
    'harvest',
    'scavenge',
    'store',
    'take',
    'collect',
    'butcher',
    'loot'
];

function parseInventoryArray(player) {
    let inv = [];
    try {
        inv =
            typeof player.inventory === 'string'
                ? JSON.parse(player.inventory || '[]')
                : player.inventory || [];
    } catch {
        inv = [];
    }
    if (!Array.isArray(inv)) inv = [];
    return inv;
}

function pickLootLabel(actionLower) {
    if (actionLower.includes('silk')) return 'Gloomthread Silk';
    if (actionLower.includes('meat') || actionLower.includes('butcher')) return 'Monster Meat';
    if (actionLower.includes('chitin') || actionLower.includes('shell')) return 'Monster Chitin';
    return 'Monster Loot';
}

/**
 * @returns {{ player: object, engineNotice: string } | null}
 */
function handleScavengeAction(player, action) {
    const text = String(action || '').toLowerCase();

    const hasConsume = consumeTriggers.some((w) => text.includes(w));
    const hasHarvest = harvestTriggers.some((w) => text.includes(w));

    if (hasConsume) {
        const maxHp = Math.max(1, Math.floor(Number(player.max_hp) || 0));
        let hp = Number(player.hp);
        if (!Number.isFinite(hp)) hp = maxHp;
        const hungerBase = Number(player.hunger);
        player.hunger = clampHunger(
            (Number.isFinite(hungerBase) ? hungerBase : 50) + 35
        );
        player.hp = Math.min(maxHp, Math.max(0, hp + 15));
        player.sp = clampSp(player, Number(player.sp) - 5);

        return {
            player,
            engineNotice:
                '[SYSTEM: BIOMASS ASSIMILATED] Consumed organic matter. +35 Hunger, +15 HP, -5 SP.'
        };
    }

    if (hasHarvest) {
        player.sp = clampSp(player, Number(player.sp) - 10);

        const inv = parseInventoryArray(player);
        inv.push(pickLootLabel(text));
        player.inventory = JSON.stringify(inv);

        return {
            player,
            engineNotice: '[SYSTEM: INVENTORY UPDATED] Harvested materials. -10 SP.'
        };
    }

    return null;
}

module.exports = {
    handleScavengeAction,
    consumeTriggers,
    harvestTriggers
};
