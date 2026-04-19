async function fetchNearbyNpcs(db, userId, player, limit = 6) {
    const locationId = String(player?.current_location || '').trim();
    const [placeRows] = await db.execute(
        `SELECT wp.id, wp.region_id
         FROM world_places wp
         WHERE LOWER(wp.name) = LOWER(?) OR LOWER(REPLACE(wp.name, ' ', '_')) = LOWER(?)
         ORDER BY wp.updated_at DESC
         LIMIT 1`,
        [locationId, locationId]
    );

    const placeId = placeRows[0]?.id || null;
    const regionId = placeRows[0]?.region_id || null;

    const params = [userId];
    let locationWhere = '1 = 0';
    if (placeId && regionId) {
        locationWhere = '(n.home_place_id = ? OR n.home_region_id = ? OR n.home_place_id IS NULL)';
        params.push(placeId, regionId);
    } else if (regionId) {
        locationWhere = '(n.home_region_id = ? OR n.home_region_id IS NULL)';
        params.push(regionId);
    } else if (placeId) {
        locationWhere = '(n.home_place_id = ? OR n.home_place_id IS NULL)';
        params.push(placeId);
    }
    params.push(userId);

    const [rows] = await db.execute(
        `SELECT n.*, f.name AS faction_name,
                nr.trust, nr.fear, nr.respect, nr.affection, nr.resentment, nr.loyalty,
                nr.relationship_stage, nr.last_interaction_at
         FROM npcs n
         LEFT JOIN factions f ON f.id = n.faction_id
         LEFT JOIN npc_relationships nr ON nr.npc_id = n.id AND nr.user_id = ?
         WHERE n.status = 'active'
           AND ${locationWhere}
         ORDER BY
           CASE WHEN nr.user_id = ? THEN 0 ELSE 1 END,
           n.updated_at DESC
         LIMIT ${Number(limit) || 6}`,
        params
    );

    return rows.map(row => ({
        id: row.id,
        name: row.name,
        role: row.role,
        faction_id: row.faction_id,
        faction_name: row.faction_name,
        personality_archetype: row.personality_archetype,
        description: row.description,
        current_emotional_state: row.current_emotional_state,
        status: row.status,
        relationship: {
            trust: Number(row.trust || 0),
            fear: Number(row.fear || 0),
            respect: Number(row.respect || 0),
            affection: Number(row.affection || 0),
            resentment: Number(row.resentment || 0),
            loyalty: Number(row.loyalty || 0),
            relationship_stage: row.relationship_stage || 'stranger',
            last_interaction_at: row.last_interaction_at || null
        }
    }));
}

async function fetchNpcContext(db, userId, player, npcId) {
    const [npcRows] = await db.execute(
        `SELECT n.*, f.name AS faction_name, wr.name AS home_region_name, wp.name AS home_place_name,
                nr.trust, nr.fear, nr.respect, nr.affection, nr.resentment, nr.loyalty,
                nr.relationship_stage, nr.last_interaction_at
         FROM npcs n
         LEFT JOIN factions f ON f.id = n.faction_id
         LEFT JOIN world_regions wr ON wr.id = n.home_region_id
         LEFT JOIN world_places wp ON wp.id = n.home_place_id
         LEFT JOIN npc_relationships nr ON nr.npc_id = n.id AND nr.user_id = ?
         WHERE n.id = ?
         LIMIT 1`,
        [userId, npcId]
    );

    if (!npcRows.length) return null;
    const npc = npcRows[0];

    const [tags] = await db.execute(
        `SELECT memory_tag, memory_summary, emotional_weight, created_at
         FROM npc_memory_tags
         WHERE npc_id = ? AND user_id = ?
         ORDER BY ABS(emotional_weight) DESC, created_at DESC
         LIMIT 12`,
        [npcId, userId]
    );

    const [history] = await db.execute(
        `SELECT scene_type, scene_summary, emotional_impact, created_at
         FROM npc_scene_history
         WHERE npc_id = ? AND user_id = ?
         ORDER BY created_at DESC
         LIMIT 5`,
        [npcId, userId]
    );

    return {
        id: npc.id,
        name: npc.name,
        role: npc.role,
        faction_id: npc.faction_id,
        faction_name: npc.faction_name,
        home_region_name: npc.home_region_name,
        home_place_name: npc.home_place_name,
        personality_archetype: npc.personality_archetype,
        description: npc.description,
        current_emotional_state: npc.current_emotional_state,
        secret_summary: npc.secret_summary,
        status: npc.status,
        relationship: {
            trust: Number(npc.trust || 0),
            fear: Number(npc.fear || 0),
            respect: Number(npc.respect || 0),
            affection: Number(npc.affection || 0),
            resentment: Number(npc.resentment || 0),
            loyalty: Number(npc.loyalty || 0),
            relationship_stage: npc.relationship_stage || 'stranger',
            last_interaction_at: npc.last_interaction_at || null
        },
        memory_tags: tags,
        scene_history: history
    };
}

module.exports = {
    fetchNearbyNpcs,
    fetchNpcContext
};
