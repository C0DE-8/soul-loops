/**
 * utils/travelEngine.js
 * Parses travel intents and validates locations against the world map.
 */

const handleZoneTravel = async (action, player, db) => {
    let travelNotice = "";
    let newLocation = player.current_location;

    const normalizedAction = action.toLowerCase();
    
    // Check if player is trying to move
    if (normalizedAction.includes("travel to") || normalizedAction.includes("move to")) {
        const destinationMatch = normalizedAction.match(/(?:travel to|move to)\s+([a-z0-9_]+)/i);
        
        if (destinationMatch) {
            const targetLocation = destinationMatch[1].trim();

            // Validate that this location exists in the DB
            const [locationCheck] = await db.execute(
                'SELECT location_id FROM location_seeds WHERE location_id = ?', 
                [targetLocation]
            );

            if (locationCheck.length > 0) {
                newLocation = targetLocation;
                travelNotice = ` [ZONE_TRANSITION]: Relocating to ${targetLocation}.`;
            } else {
                travelNotice = ` [SYSTEM_ERROR]: Destination '${targetLocation}' not found in world map records.`;
            }
        }
    }

    return { newLocation, travelNotice };
};

module.exports = { handleZoneTravel };