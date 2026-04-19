function normalizeName(value) {
    return String(value || '').trim().toLowerCase();
}

async function fetchCanonContext(db, player, { includeHidden = false } = {}) {
    const locationId = String(player?.current_location || '').trim();
    const context = {
        location_id: locationId,
        region: null,
        place: null,
        regions: [],
        places: [],
        factions: [],
        entities: [],
        monster_species: [],
        powers: [],
        lore_entries: [],
        world_events: []
    };

    const hiddenFilter = includeHidden ? '' : "AND discovery_status != 'hidden'";
    const hiddenPlaceFilter = includeHidden ? '' : "AND wp.discovery_status != 'hidden'";
    const canonFilter = includeHidden ? '' : "AND canon_status != 'sealed'";

    const [locRows] = await db.execute(
        `SELECT location_id, description_seed, hidden_lore, danger_level, region_name, level_depth
         FROM location_seeds
         WHERE location_id = ?
         LIMIT 1`,
        [locationId]
    );
    const loc = locRows[0] || null;

    if (loc?.region_name) {
        const [regionRows] = await db.execute(
            `SELECT *
             FROM world_regions
             WHERE LOWER(name) = LOWER(?)
             LIMIT 1`,
            [loc.region_name]
        );
        context.region = regionRows[0] || null;
    }

    const [placeRows] = await db.execute(
        `SELECT wp.*, wr.name AS region_name
         FROM world_places wp
         LEFT JOIN world_regions wr ON wr.id = wp.region_id
         WHERE (LOWER(wp.name) = LOWER(?) OR LOWER(REPLACE(wp.name, ' ', '_')) = LOWER(?))
           ${hiddenPlaceFilter}
         ORDER BY FIELD(wp.discovery_status, 'confirmed', 'discovered', 'rumor', 'hidden'), wp.updated_at DESC
         LIMIT 1`,
        [locationId, locationId]
    );
    context.place = placeRows[0] || null;

    const regionId = context.region?.id || context.place?.region_id || null;
    const placeId = context.place?.id || null;

    const [regionRows] = await db.execute(
        `SELECT *
         FROM world_regions
         WHERE (${regionId ? 'id = ? OR parent_region_id = ?' : '1 = 1'})
           ${hiddenFilter}
         ORDER BY danger_level DESC, updated_at DESC
         LIMIT 8`,
        regionId ? [regionId, regionId] : []
    );
    context.regions = regionRows;

    const [places] = await db.execute(
        `SELECT wp.*, wr.name AS region_name
         FROM world_places wp
         LEFT JOIN world_regions wr ON wr.id = wp.region_id
         WHERE (${regionId ? 'wp.region_id = ?' : '1 = 1'})
           ${hiddenPlaceFilter}
         ORDER BY wp.updated_at DESC
         LIMIT 10`,
        regionId ? [regionId] : []
    );
    context.places = places;

    const [factions] = await db.execute(
        `SELECT *
         FROM factions
         WHERE status != 'sealed'
         ORDER BY power_rank DESC, updated_at DESC
         LIMIT 8`
    );
    context.factions = factions;

    const [entities] = await db.execute(
        `SELECT we.*, wr.name AS origin_region_name, f.name AS faction_name
         FROM world_entities we
         LEFT JOIN world_regions wr ON wr.id = we.origin_region_id
         LEFT JOIN factions f ON f.id = we.faction_id
         WHERE (${regionId ? 'we.origin_region_id = ? OR we.origin_region_id IS NULL' : '1 = 1'})
           ${canonFilter.replace('canon_status', 'we.canon_status')}
         ORDER BY we.threat_rank DESC, we.updated_at DESC
         LIMIT 10`,
        regionId ? [regionId] : []
    );
    context.entities = entities;

    const [species] = await db.execute(
        `SELECT ms.*, wr.name AS habitat_region_name
         FROM monster_species ms
         LEFT JOIN world_regions wr ON wr.id = ms.habitat_region_id
         WHERE (${regionId ? 'ms.habitat_region_id = ? OR ms.habitat_region_id IS NULL' : '1 = 1'})
           ${canonFilter.replace('canon_status', 'ms.canon_status')}
         ORDER BY ms.updated_at DESC
         LIMIT 10`,
        regionId ? [regionId] : []
    );
    context.monster_species = species;

    const [powers] = await db.execute(
        `SELECT wpow.*, we.name AS source_entity_name
         FROM world_powers wpow
         LEFT JOIN world_entities we ON we.id = wpow.source_entity_id
         WHERE ${includeHidden ? '1 = 1' : "wpow.canon_status != 'suspected' OR wpow.rarity IN ('common','uncommon','rare')"}
         ORDER BY FIELD(wpow.rarity, 'mythic', 'legendary', 'epic', 'rare', 'uncommon', 'common'), wpow.updated_at DESC
         LIMIT 10`
    );
    context.powers = powers;

    const loreParams = [];
    const loreWhere = [];
    if (regionId) {
        loreWhere.push('le.linked_region_id = ?');
        loreParams.push(regionId);
    }
    if (placeId) {
        loreWhere.push('le.linked_place_id = ?');
        loreParams.push(placeId);
    }
    const [lore] = await db.execute(
        `SELECT le.*
         FROM lore_entries le
         WHERE (${loreWhere.length ? loreWhere.join(' OR ') : '1 = 1'})
           ${canonFilter.replace('canon_status', 'le.canon_status')}
         ORDER BY le.updated_at DESC
         LIMIT 10`,
        loreParams
    );
    context.lore_entries = lore;

    const eventParams = [];
    const eventWhere = [];
    if (regionId) {
        eventWhere.push('region_id = ?');
        eventParams.push(regionId);
    }
    if (placeId) {
        eventWhere.push('place_id = ?');
        eventParams.push(placeId);
    }
    const [events] = await db.execute(
        `SELECT *
         FROM world_events
         WHERE (${eventWhere.length ? eventWhere.join(' OR ') : '1 = 1'})
           AND status IN ('rumor','active')
         ORDER BY severity DESC, updated_at DESC
         LIMIT 8`,
        eventParams
    );
    context.world_events = events;

    context.location_seed = loc;
    context.known_names = [
        ...context.regions.map(r => r.name),
        ...context.places.map(p => p.name),
        ...context.factions.map(f => f.name),
        ...context.entities.map(e => e.name),
        ...context.monster_species.map(m => m.name),
        ...context.powers.map(p => p.name),
        ...context.lore_entries.map(l => l.title)
    ].map(normalizeName).filter(Boolean);

    return context;
}

async function fetchRecentDiscoveries(db, userId, player, limit = 10) {
    const lifeId = player?.life_id || null;
    const [rows] = await db.execute(
        `SELECT 'place' AS discovery_type, id, name AS title, discovery_status AS status, description AS summary, updated_at
         FROM world_places
         WHERE discovery_status IN ('rumor','discovered','confirmed')
           AND (first_discovered_by_life_id IS NULL OR first_discovered_by_life_id = ?)
         UNION ALL
         SELECT 'power' AS discovery_type, id, name AS title, canon_status AS status, description AS summary, updated_at
         FROM world_powers
         WHERE canon_status IN ('rumor','suspected','confirmed')
         UNION ALL
         SELECT 'entity' AS discovery_type, id, name AS title, canon_status AS status, lore_summary AS summary, updated_at
         FROM world_entities
         WHERE canon_status IN ('rumor','suspected','confirmed','legendary')
         UNION ALL
         SELECT 'lore' AS discovery_type, id, title, canon_status AS status, summary, updated_at
         FROM lore_entries
         WHERE canon_status IN ('rumor','suspected','confirmed')
         ORDER BY updated_at DESC
         LIMIT ${Number(limit) || 10}`,
        [lifeId]
    );
    return rows;
}

async function fetchActiveWorldFlags(db, player, limit = 6) {
    const canon = await fetchCanonContext(db, player, { includeHidden: false });
    return (canon.world_events || []).slice(0, limit).map(event => ({
        id: event.id,
        event_name: event.event_name,
        event_type: event.event_type,
        severity: event.severity,
        status: event.status,
        summary: event.summary
    }));
}

module.exports = {
    fetchCanonContext,
    fetchRecentDiscoveries,
    fetchActiveWorldFlags
};
