const { VALID_ENUMS } = require('../../config/worldBuilderPrompts');

const BANNED_TERMS = [
    'naruto', 'sasuke', 'konoha', 'uchiha', 'goku', 'vegeta', 'frieza',
    'rimuru', 'tempest', 'ainz', 'nazarick', 'sao', 'kirito', 'asuna',
    'tanjiro', 'nezuko', 'demonslayer', 'one piece', 'luffy', 'zoro',
    'bleach', 'ichigo', 'kumoko', 'wakaba', 'shiraori', 'ariel', 'potimas'
];

function asArray(value) {
    return Array.isArray(value) ? value : [];
}

function cleanString(value, max = 2000) {
    return String(value || '').trim().slice(0, max);
}

function hasBannedTerm(value) {
    const text = String(value || '').toLowerCase();
    return BANNED_TERMS.some(term => text.includes(term));
}

function isAllowed(value, allowed, fallback) {
    return allowed.includes(value) ? value : fallback;
}

function clampInt(value, min, max, fallback) {
    const n = Math.floor(Number(value));
    if (!Number.isFinite(n)) return fallback;
    return Math.max(min, Math.min(max, n));
}

async function nameExists(db, name) {
    const cleanName = cleanString(name, 180);
    if (!cleanName) return false;
    const checks = [
        ['world_regions', 'name'],
        ['world_places', 'name'],
        ['factions', 'name'],
        ['world_entities', 'name'],
        ['monster_species', 'name'],
        ['world_powers', 'name'],
        ['lore_entries', 'title'],
        ['npcs', 'name']
    ];
    for (const [table, column] of checks) {
        const [rows] = await db.execute(
            `SELECT id FROM ${table} WHERE LOWER(${column}) = LOWER(?) LIMIT 1`,
            [cleanName]
        );
        if (rows.length) return true;
    }
    return false;
}

function rejectIfBadName(errors, label, value) {
    const name = cleanString(value, 180);
    if (!name) errors.push(`${label} is missing a name/title.`);
    if (hasBannedTerm(name)) errors.push(`${label} uses a banned copyrighted or copied term.`);
    return name;
}

async function validateWorldProposal(db, proposal) {
    const errors = [];
    const sanitized = {
        regions: [],
        places: [],
        factions: [],
        entities: [],
        monster_species: [],
        powers: [],
        lore_entries: [],
        world_events: [],
        npcs: []
    };

    const seen = new Set();
    async function acceptUnique(label, name) {
        const key = String(name || '').toLowerCase();
        if (seen.has(key)) {
            errors.push(`${label} duplicates another proposed name: ${name}.`);
            return false;
        }
        seen.add(key);
        if (await nameExists(db, name)) {
            errors.push(`${label} collides with existing canon: ${name}.`);
            return false;
        }
        return true;
    }

    for (const r of asArray(proposal?.regions).slice(0, 3)) {
        const name = rejectIfBadName(errors, 'region', r.name);
        if (!name || !(await acceptUnique('region', name))) continue;
        sanitized.regions.push({
            name,
            region_type: cleanString(r.region_type || 'wilds', 80),
            parent_region_name: cleanString(r.parent_region_name, 180) || null,
            description: cleanString(r.description, 2000),
            danger_level: clampInt(r.danger_level, 1, 10, 3),
            discovery_status: isAllowed(r.discovery_status, VALID_ENUMS.discovery_status, 'rumor')
        });
    }

    for (const p of asArray(proposal?.places).slice(0, 4)) {
        const name = rejectIfBadName(errors, 'place', p.name);
        if (!name || !(await acceptUnique('place', name))) continue;
        sanitized.places.push({
            region_name: cleanString(p.region_name, 180) || null,
            name,
            place_type: cleanString(p.place_type || 'site', 80),
            description: cleanString(p.description, 2000),
            lore_summary: cleanString(p.lore_summary || p.description, 1500),
            hidden_lore: cleanString(p.hidden_lore, 1500) || null,
            ruling_faction_name: cleanString(p.ruling_faction_name, 180) || null,
            discovery_status: isAllowed(p.discovery_status, VALID_ENUMS.discovery_status, 'rumor')
        });
    }

    for (const f of asArray(proposal?.factions).slice(0, 3)) {
        const name = rejectIfBadName(errors, 'faction', f.name);
        if (!name || !(await acceptUnique('faction', name))) continue;
        sanitized.factions.push({
            name,
            faction_type: cleanString(f.faction_type || 'order', 80),
            ideology: cleanString(f.ideology, 1000),
            description: cleanString(f.description, 2000),
            leader_entity_name: cleanString(f.leader_entity_name, 180) || null,
            power_rank: clampInt(f.power_rank, 1, 10, 2),
            relationship_to_player_default: clampInt(f.relationship_to_player_default, -100, 100, 0),
            status: isAllowed(f.status, VALID_ENUMS.faction_status, 'hidden')
        });
    }

    for (const e of asArray(proposal?.entities).slice(0, 3)) {
        const name = rejectIfBadName(errors, 'entity', e.name);
        if (!name || !(await acceptUnique('entity', name))) continue;
        sanitized.entities.push({
            name,
            entity_type: isAllowed(e.entity_type, VALID_ENUMS.entity_type, 'other'),
            title: cleanString(e.title, 180),
            description: cleanString(e.description, 2000),
            lore_summary: cleanString(e.lore_summary || e.description, 1500),
            origin_region_name: cleanString(e.origin_region_name, 180) || null,
            faction_name: cleanString(e.faction_name, 180) || null,
            threat_rank: clampInt(e.threat_rank, 1, 10, 3),
            canon_status: isAllowed(e.canon_status, VALID_ENUMS.entity_canon_status, 'rumor'),
            is_alive: e.is_alive === false ? 0 : 1
        });
    }

    for (const m of asArray(proposal?.monster_species).slice(0, 4)) {
        const name = rejectIfBadName(errors, 'monster species', m.name);
        if (!name || !(await acceptUnique('monster species', name))) continue;
        sanitized.monster_species.push({
            name,
            species_type: cleanString(m.species_type || 'beast', 80),
            habitat_region_name: cleanString(m.habitat_region_name, 180) || null,
            temperament: cleanString(m.temperament || 'unknown', 180),
            rarity: cleanString(m.rarity || 'uncommon', 80),
            description: cleanString(m.description, 2000),
            evolution_notes: cleanString(m.evolution_notes, 1500) || null,
            canon_status: isAllowed(m.canon_status, VALID_ENUMS.monster_canon_status, 'rumor')
        });
    }

    for (const p of asArray(proposal?.powers).slice(0, 3)) {
        const name = rejectIfBadName(errors, 'power', p.name);
        if (!name || !(await acceptUnique('power', name))) continue;
        sanitized.powers.push({
            name,
            power_type: cleanString(p.power_type || 'mystery', 80),
            element: cleanString(p.element, 80) || null,
            rarity: cleanString(p.rarity || 'rare', 80),
            source_type: isAllowed(p.source_type, VALID_ENUMS.power_source_type, 'unknown'),
            source_entity_name: cleanString(p.source_entity_name, 180) || null,
            description: cleanString(p.description, 2000),
            lore_summary: cleanString(p.lore_summary, 1500) || null,
            canon_status: isAllowed(p.canon_status, VALID_ENUMS.power_canon_status, 'suspected')
        });
    }

    for (const l of asArray(proposal?.lore_entries).slice(0, 4)) {
        const title = rejectIfBadName(errors, 'lore entry', l.title);
        if (!title || !(await acceptUnique('lore entry', title))) continue;
        sanitized.lore_entries.push({
            title,
            lore_type: isAllowed(l.lore_type, VALID_ENUMS.lore_type, 'other'),
            summary: cleanString(l.summary, 2000),
            linked_region_name: cleanString(l.linked_region_name, 180) || null,
            linked_place_name: cleanString(l.linked_place_name, 180) || null,
            linked_entity_name: cleanString(l.linked_entity_name, 180) || null,
            linked_faction_name: cleanString(l.linked_faction_name, 180) || null,
            linked_power_name: cleanString(l.linked_power_name, 180) || null,
            canon_status: isAllowed(l.canon_status, VALID_ENUMS.lore_canon_status, 'rumor')
        });
    }

    for (const ev of asArray(proposal?.world_events).slice(0, 2)) {
        const event_name = rejectIfBadName(errors, 'world event', ev.event_name);
        if (!event_name || !(await acceptUnique('world event', event_name))) continue;
        sanitized.world_events.push({
            event_name,
            event_type: isAllowed(ev.event_type, VALID_ENUMS.world_event_type, 'other'),
            summary: cleanString(ev.summary, 2000),
            region_name: cleanString(ev.region_name, 180) || null,
            place_name: cleanString(ev.place_name, 180) || null,
            initiator_faction_name: cleanString(ev.initiator_faction_name, 180) || null,
            target_faction_name: cleanString(ev.target_faction_name, 180) || null,
            initiator_entity_name: cleanString(ev.initiator_entity_name, 180) || null,
            target_entity_name: cleanString(ev.target_entity_name, 180) || null,
            severity: clampInt(ev.severity, 1, 10, 1),
            status: isAllowed(ev.status, VALID_ENUMS.world_event_status, 'rumor')
        });
    }

    for (const n of asArray(proposal?.npcs).slice(0, 3)) {
        const name = rejectIfBadName(errors, 'npc', n.name);
        if (!name || !(await acceptUnique('npc', name))) continue;
        sanitized.npcs.push({
            name,
            role: cleanString(n.role || 'wanderer', 120),
            faction_name: cleanString(n.faction_name, 180) || null,
            home_region_name: cleanString(n.home_region_name, 180) || null,
            home_place_name: cleanString(n.home_place_name, 180) || null,
            personality_archetype: cleanString(n.personality_archetype || 'guarded survivor', 180),
            description: cleanString(n.description, 2000),
            current_emotional_state: cleanString(n.current_emotional_state || 'wary', 120),
            secret_summary: cleanString(n.secret_summary, 1500) || null,
            status: isAllowed(n.status, ['active', 'dead', 'missing', 'corrupted', 'sealed'], 'active')
        });
    }

    const totalAccepted = Object.values(sanitized).reduce((sum, arr) => sum + arr.length, 0);
    if (totalAccepted === 0 && errors.length === 0) {
        errors.push('Proposal did not contain any usable canon.');
    }

    return {
        valid: errors.length === 0 && totalAccepted > 0,
        errors,
        sanitized
    };
}

module.exports = {
    validateWorldProposal
};
