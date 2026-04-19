function buildNpcPromptContext({ nearbyNpcs = [], focusedNpc = null } = {}) {
    const npcList = focusedNpc ? [focusedNpc] : nearbyNpcs;
    if (!npcList || npcList.length === 0) {
        return '[NPC EMOTION CONTEXT]\nNone';
    }

    const blocks = npcList.slice(0, 4).map((npc) => {
        const relationship = npc.relationship || {};
        const tags = (npc.memory_tags || [])
            .slice(0, 8)
            .map(tag => `${tag.memory_tag}: ${tag.memory_summary} (weight ${tag.emotional_weight})`)
            .join(' | ') || 'None';
        const lastScene = (npc.scene_history || [])[0];

        return [
            `NPC: ${npc.name} (${npc.role || 'unknown role'})`,
            `Faction: ${npc.faction_name || 'None'}`,
            `Personality: ${npc.personality_archetype || 'unknown'}`,
            `Current emotion: ${npc.current_emotional_state || 'guarded'}`,
            `Relationship: trust ${relationship.trust || 0}, fear ${relationship.fear || 0}, respect ${relationship.respect || 0}, affection ${relationship.affection || 0}, resentment ${relationship.resentment || 0}, loyalty ${relationship.loyalty || 0}, stage ${relationship.relationship_stage || 'stranger'}`,
            `Important memory tags: ${tags}`,
            `Last important scene: ${lastScene ? `${lastScene.scene_type}: ${lastScene.scene_summary}` : 'None'}`
        ].join('\n');
    });

    return `
[NPC EMOTION CONTEXT]
The backend owns relationship values. Express these states; do not invent new stats.
${blocks.join('\n---\n')}
`.trim();
}

module.exports = {
    buildNpcPromptContext
};
