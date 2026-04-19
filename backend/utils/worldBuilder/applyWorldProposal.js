async function findIdByName(conn, table, column, name) {
    if (!name) return null;
    const [rows] = await conn.execute(
        `SELECT id FROM ${table} WHERE LOWER(${column}) = LOWER(?) LIMIT 1`,
        [name]
    );
    return rows[0]?.id || null;
}

function recordUpdate(type, row) {
    return {
        type,
        id: row.id,
        name: row.name || row.title || row.event_name,
        status: row.discovery_status || row.canon_status || row.status || null
    };
}

async function applyWorldProposal(db, validation, { lifeId = null } = {}) {
    if (!validation?.valid) {
        return [];
    }

    const canonUpdates = [];
    const data = validation.sanitized;
    const conn = await db.getConnection();

    try {
        await conn.beginTransaction();

        for (const r of data.regions) {
            const parentId = await findIdByName(conn, 'world_regions', 'name', r.parent_region_name);
            const [result] = await conn.execute(
                `INSERT INTO world_regions
                 (name, region_type, parent_region_id, description, danger_level, discovery_status)
                 VALUES (?, ?, ?, ?, ?, ?)`,
                [r.name, r.region_type, parentId, r.description, r.danger_level, r.discovery_status]
            );
            canonUpdates.push(recordUpdate('region', { ...r, id: result.insertId }));
        }

        for (const f of data.factions) {
            const leaderId = await findIdByName(conn, 'world_entities', 'name', f.leader_entity_name);
            const [result] = await conn.execute(
                `INSERT INTO factions
                 (name, faction_type, ideology, description, leader_entity_id, power_rank, relationship_to_player_default, status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
                [f.name, f.faction_type, f.ideology, f.description, leaderId, f.power_rank, f.relationship_to_player_default, f.status]
            );
            canonUpdates.push(recordUpdate('faction', { ...f, id: result.insertId }));
        }

        for (const p of data.places) {
            const regionId = await findIdByName(conn, 'world_regions', 'name', p.region_name);
            const factionId = await findIdByName(conn, 'factions', 'name', p.ruling_faction_name);
            const [result] = await conn.execute(
                `INSERT INTO world_places
                 (region_id, name, place_type, description, lore_summary, hidden_lore, ruling_faction_id, discovery_status, first_discovered_by_life_id)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [regionId, p.name, p.place_type, p.description, p.lore_summary, p.hidden_lore, factionId, p.discovery_status, lifeId]
            );
            canonUpdates.push(recordUpdate('place', { ...p, id: result.insertId }));
        }

        for (const e of data.entities) {
            const regionId = await findIdByName(conn, 'world_regions', 'name', e.origin_region_name);
            const factionId = await findIdByName(conn, 'factions', 'name', e.faction_name);
            const [result] = await conn.execute(
                `INSERT INTO world_entities
                 (name, entity_type, title, description, lore_summary, origin_region_id, faction_id, threat_rank, canon_status, is_alive)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [e.name, e.entity_type, e.title, e.description, e.lore_summary, regionId, factionId, e.threat_rank, e.canon_status, e.is_alive]
            );
            canonUpdates.push(recordUpdate('entity', { ...e, id: result.insertId }));
        }

        for (const m of data.monster_species) {
            const regionId = await findIdByName(conn, 'world_regions', 'name', m.habitat_region_name);
            const [result] = await conn.execute(
                `INSERT INTO monster_species
                 (name, species_type, habitat_region_id, temperament, rarity, description, evolution_notes, canon_status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
                [m.name, m.species_type, regionId, m.temperament, m.rarity, m.description, m.evolution_notes, m.canon_status]
            );
            canonUpdates.push(recordUpdate('monster_species', { ...m, id: result.insertId }));
        }

        for (const p of data.powers) {
            const sourceEntityId = await findIdByName(conn, 'world_entities', 'name', p.source_entity_name);
            const [result] = await conn.execute(
                `INSERT INTO world_powers
                 (name, power_type, element, rarity, source_type, source_entity_id, description, lore_summary, canon_status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [p.name, p.power_type, p.element, p.rarity, p.source_type, sourceEntityId, p.description, p.lore_summary, p.canon_status]
            );
            canonUpdates.push(recordUpdate('power', { ...p, id: result.insertId }));
        }

        for (const l of data.lore_entries) {
            const regionId = await findIdByName(conn, 'world_regions', 'name', l.linked_region_name);
            const placeId = await findIdByName(conn, 'world_places', 'name', l.linked_place_name);
            const entityId = await findIdByName(conn, 'world_entities', 'name', l.linked_entity_name);
            const factionId = await findIdByName(conn, 'factions', 'name', l.linked_faction_name);
            const powerId = await findIdByName(conn, 'world_powers', 'name', l.linked_power_name);
            const [result] = await conn.execute(
                `INSERT INTO lore_entries
                 (title, lore_type, summary, linked_region_id, linked_place_id, linked_entity_id, linked_faction_id, linked_power_id, canon_status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [l.title, l.lore_type, l.summary, regionId, placeId, entityId, factionId, powerId, l.canon_status]
            );
            canonUpdates.push(recordUpdate('lore', { ...l, id: result.insertId }));
        }

        for (const ev of data.world_events) {
            const regionId = await findIdByName(conn, 'world_regions', 'name', ev.region_name);
            const placeId = await findIdByName(conn, 'world_places', 'name', ev.place_name);
            const initiatorFactionId = await findIdByName(conn, 'factions', 'name', ev.initiator_faction_name);
            const targetFactionId = await findIdByName(conn, 'factions', 'name', ev.target_faction_name);
            const initiatorEntityId = await findIdByName(conn, 'world_entities', 'name', ev.initiator_entity_name);
            const targetEntityId = await findIdByName(conn, 'world_entities', 'name', ev.target_entity_name);
            const [result] = await conn.execute(
                `INSERT INTO world_events
                 (event_name, event_type, summary, region_id, place_id, initiator_faction_id, target_faction_id,
                  initiator_entity_id, target_entity_id, severity, status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                    ev.event_name, ev.event_type, ev.summary, regionId, placeId, initiatorFactionId,
                    targetFactionId, initiatorEntityId, targetEntityId, ev.severity, ev.status
                ]
            );
            canonUpdates.push(recordUpdate('world_event', { ...ev, id: result.insertId }));
        }

        for (const n of data.npcs) {
            const factionId = await findIdByName(conn, 'factions', 'name', n.faction_name);
            const regionId = await findIdByName(conn, 'world_regions', 'name', n.home_region_name);
            const placeId = await findIdByName(conn, 'world_places', 'name', n.home_place_name);
            const [result] = await conn.execute(
                `INSERT INTO npcs
                 (name, role, faction_id, home_region_id, home_place_id, personality_archetype,
                  description, current_emotional_state, secret_summary, status)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                    n.name, n.role, factionId, regionId, placeId, n.personality_archetype,
                    n.description, n.current_emotional_state, n.secret_summary, n.status
                ]
            );
            canonUpdates.push(recordUpdate('npc', { ...n, id: result.insertId }));
        }

        await conn.commit();
        return canonUpdates;
    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
}

module.exports = {
    applyWorldProposal
};
