const parseSurvivalAction = (player, actionText, engineNotice) => {
    // 1. Load the player's inventory safely
    let inv = [];
    try { 
        inv = (typeof player.inventory === 'string') ? JSON.parse(player.inventory) : (player.inventory || []); 
    } catch(e) { inv = []; }
    
    const text = actionText.toLowerCase();

    // -- INVENTORY CHECK --
    if (text === 'inventory' || text.includes('check inventory') || text === 'bag') {
        const items = inv.length > 0 ? inv.join(', ') : 'Empty';
        engineNotice += ` [SYSTEM_EVENT: Player checked inventory. Current items: ${items}.]`;
    }

    // -- THE "HURT" / HUNT / FORAGE SCAN --
    else if (text.includes('hunt') || text.includes('forage') || text.includes('hurt')) {
        const roll = Math.random();
        
        if (roll > 0.8) {
            // RARE: High-value resource
            engineNotice += ` [SYSTEM_EVENT: AREA_SCAN_COMPLETE. Detected: 'Gravefruit Spire'. High caloric value, but guarded by height.]`;
        } else if (roll > 0.4) {
            // COMMON: Small Prey
            const preys = ['Lesser Frog', 'Blind Cave Rat', 'Drain Beetle'];
            const selected = preys[Math.floor(Math.random() * preys.length)];
            engineNotice += ` [SYSTEM_EVENT: AREA_SCAN_COMPLETE. Detected: '${selected}'. Survival Instincts: Twitchy. Potential for flight or minor resistance.]`;
        } else if (roll > 0.1) {
            // LOW: Forageable
            engineNotice += ` [SYSTEM_EVENT: AREA_SCAN_COMPLETE. Detected: 'Nutrient-Rich Moss' and 'Stagnant Water Hole'.]`;
        } else {
            // FAIL
            engineNotice += ` [SYSTEM_EVENT: AREA_SCAN_COMPLETE. No biological signatures found. The silence is absolute.]`;
        }
    }

    // -- COOK --
    else if (text.includes('cook') || text.includes('roast') || text.includes('make a fire')) {
        const meatIndex = inv.indexOf('Raw Meat');
        if (meatIndex !== -1) {
            inv[meatIndex] = 'Cooked Meat'; // Swap item
            engineNotice += ` [SYSTEM_EVENT: Cooking Successful. Transformed 'Raw Meat' into 'Cooked Meat'.]`;
        } else {
            engineNotice += ` [SYSTEM_EVENT: Cooking Failed. No raw ingredients in inventory.]`;
        }
    }

    // -- EAT --
    else if (text.includes('eat') || text.includes('consume') || text.includes('feed')) {
        const cookedIndex = inv.indexOf('Cooked Meat');
        const rawIndex = inv.indexOf('Raw Meat');

        if (cookedIndex !== -1) {
            inv.splice(cookedIndex, 1); // Remove item from inventory
            player.hunger = Math.min(100, Number(player.hunger) + 50);
            player.hp = Math.min(Number(player.max_hp), Number(player.hp) + 10);
            engineNotice += ` [SYSTEM_EVENT: Consumed 'Cooked Meat'. Restored 50 Hunger and 10 HP.]`;
        } else if (rawIndex !== -1) {
            inv.splice(rawIndex, 1);
            player.hunger = Math.min(100, Number(player.hunger) + 25);
            // Small risk of food poisoning from raw meat
            if (Math.random() > 0.7) {
                player.hp = Math.max(1, Number(player.hp) - 5);
                engineNotice += ` [SYSTEM_EVENT: Consumed 'Raw Meat'. Restored 25 Hunger but took 5 Poison Damage.]`;
            } else {
                engineNotice += ` [SYSTEM_EVENT: Consumed 'Raw Meat'. Restored 25 Hunger.]`;
            }
        } else {
            engineNotice += ` [SYSTEM_EVENT: Attempted to eat, but inventory is completely empty.]`;
        }
    }

    // -- REST / SLEEP (SP + hunger: survivalEngine; avoid duplicating full heals here) --
    else if (text.includes('rest') || text.includes('sleep') || text.includes('nap')
        || text.includes('wait') || text.includes('catch breath') || text.includes('breather')) {
        if (player.current_location === player.home_base) {
            engineNotice += ` [SYSTEM_EVENT: Safe haven. The noise of the labyrinth fades.]`;
        } else {
            engineNotice += ` [SYSTEM_EVENT: You settle in; the wild offers no guarantees.]`;
        }
    }

    // -- MARK TERRITORY --
    else if (text.includes('mark') || text.includes('territory') || text.includes('home base')) {
        player.home_base = player.current_location;
        engineNotice += ` [SYSTEM_EVENT: Claimed Territory. Home Base successfully set to ${player.current_location}.]`;
    }

    // -- MOVE / CHANGE LOCATION --
    else if (text.includes('move to') || text.includes('travel') || text.includes('go to')) {
        // Here you pass the intent to the AI to narrate the journey. 
        // Real location updating would check your location_connectors table.
        engineNotice += ` [SYSTEM_EVENT: Travel Initiated. Player is attempting to traverse the labyrinth.]`;
    }

    // 2. Save inventory back to player object as a string for the database
    player.inventory = JSON.stringify(inv);
    
    return { player, engineNotice };
};

module.exports = { parseSurvivalAction };