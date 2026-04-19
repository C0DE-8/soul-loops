const VALID_ENUMS = {
    discovery_status: ['hidden', 'rumor', 'discovered', 'confirmed'],
    faction_status: ['active', 'fallen', 'hidden', 'sealed'],
    entity_type: ['god', 'demon_lord', 'ruler', 'boss', 'spirit', 'guardian', 'legend', 'other'],
    entity_canon_status: ['rumor', 'suspected', 'confirmed', 'sealed', 'legendary'],
    monster_canon_status: ['rumor', 'confirmed'],
    power_source_type: ['natural', 'god', 'demon_lord', 'faction', 'artifact', 'species', 'unknown'],
    power_canon_status: ['rumor', 'suspected', 'confirmed'],
    lore_type: ['history', 'rumor', 'prophecy', 'war', 'religion', 'artifact', 'bloodline', 'catastrophe', 'other'],
    lore_canon_status: ['rumor', 'suspected', 'confirmed', 'sealed'],
    world_event_type: ['war', 'siege', 'uprising', 'ritual', 'catastrophe', 'corruption', 'political_shift', 'divine_sign', 'other'],
    world_event_status: ['rumor', 'active', 'resolved', 'hidden']
};

function buildWorldBuilderPrompt({ player, action, engineNotice, storyContext, canonContext, missingSignals }) {
    return `
[WORLD-BUILDER MODE]
Return valid JSON only. No markdown. No narration. No combat results.

The backend is the source of truth. You may only propose missing canon. The backend will validate and may reject it.

Tone target: dark fantasy, reincarnation, evolution, labyrinth survival, emotional mystery.
Do not use copyrighted media names, copied places, copied factions, copied powers, or copied lore.
Do not contradict existing canon. Use rumor/suspected/hidden when uncertainty is appropriate.

Allowed enum values:
${JSON.stringify(VALID_ENUMS)}

Current player:
${JSON.stringify({
    life_id: player.life_id,
    species: player.species,
    vessel_type: player.vessel_type,
    level: player.current_level,
    location: player.current_location
})}

Action:
${JSON.stringify(action)}

Backend engine result:
${JSON.stringify(engineNotice || '')}

Story context:
${JSON.stringify(storyContext || '')}

Existing canon context:
${JSON.stringify(canonContext || {})}

Missing canon signals:
${JSON.stringify(missingSignals || [])}

Return this exact JSON shape. Use empty arrays for categories you do not need:
{
  "regions": [],
  "places": [],
  "factions": [],
  "entities": [],
  "monster_species": [],
  "powers": [],
  "lore_entries": [],
  "world_events": [],
  "npcs": []
}

Field guidance:
- places may reference "region_name" when region_id is unknown.
- factions should be ideological groups, cults, courts, hives, orders, tribes, or sealed powers.
- entities are gods, demon lords, rulers, guardians, bosses, spirits, legends.
- monster_species are ecosystem species, not one-off individuals.
- powers are world-level power concepts, not a player's current stat.
- lore_entries should connect mystery to an existing or proposed region/place/entity/faction/power by name when possible.
- world_events are only major consequences or rumors worth remembering later.
- npcs are persistent social characters, not generic monsters.
`.trim();
}

module.exports = {
    VALID_ENUMS,
    buildWorldBuilderPrompt
};
