function clamp(value, min = -100, max = 100) {
    const n = Math.floor(Number(value) || 0);
    return Math.max(min, Math.min(max, n));
}

function classifySocialAction(action) {
    const text = String(action || '').toLowerCase();
    if (/\b(threaten|intimidate|attack|snarl|menace)\b/.test(text)) return 'hostile';
    if (/\b(help|save|protect|comfort|share|give|apologize|heal)\b/.test(text)) return 'kind';
    if (/\b(lie|betray|steal|mock|insult|deceive)\b/.test(text)) return 'betrayal';
    if (/\b(talk|speak|ask|greet|listen|negotiate|trade)\b/.test(text)) return 'social';
    return null;
}

function nextStage(stats) {
    if (stats.resentment >= 70 && stats.trust <= -40) return 'broken';
    if (stats.fear >= 65 && stats.trust < 10) return 'hostile';
    if (stats.resentment >= 45 && stats.trust < 20) return 'fractured';
    if (stats.loyalty >= 70 || stats.affection >= 70) return 'devoted';
    if (stats.trust >= 55 && stats.respect >= 35) return 'bonded';
    if (stats.trust >= 35 || stats.respect >= 35) return 'trusted';
    if (stats.trust >= 10 || stats.respect >= 10 || stats.affection >= 10) return 'familiar';
    if (stats.fear > 20 || stats.resentment > 20) return 'conflicted';
    return 'aware';
}

function tagForOutcome(kind) {
    if (kind === 'kind') return ['helped_by_player', 'The player acted with care or protection.', 12];
    if (kind === 'hostile') return ['fears_player_power', 'The player used fear or violence to shape the scene.', -12];
    if (kind === 'betrayal') return ['betrayed_by_player', 'The player damaged trust through betrayal or cruelty.', -20];
    return ['spoke_with_player', 'The player made direct social contact.', 4];
}

function emotionalStateFor(kind, stats) {
    if (kind === 'kind' && stats.trust >= 20) return 'softened';
    if (kind === 'hostile') return stats.fear > stats.resentment ? 'afraid' : 'angry';
    if (kind === 'betrayal') return 'wounded';
    if (stats.trust > 25) return 'curious';
    return 'wary';
}

function chooseTargetNpc(nearbyNpcs, action) {
    const text = String(action || '').toLowerCase();
    return nearbyNpcs.find(npc => text.includes(String(npc.name || '').toLowerCase())) || nearbyNpcs[0] || null;
}

async function applyNpcInteractionOutcome({ db, userId, player, action, nearbyNpcs, sceneSummary }) {
    const kind = classifySocialAction(action);
    if (!kind || !nearbyNpcs?.length) {
        return [];
    }

    const npc = chooseTargetNpc(nearbyNpcs, action);
    if (!npc) return [];

    const current = npc.relationship || {};
    const stats = {
        trust: Number(current.trust || 0),
        fear: Number(current.fear || 0),
        respect: Number(current.respect || 0),
        affection: Number(current.affection || 0),
        resentment: Number(current.resentment || 0),
        loyalty: Number(current.loyalty || 0)
    };

    if (kind === 'kind') {
        stats.trust += 8;
        stats.affection += 5;
        stats.respect += 3;
        stats.resentment -= 3;
    } else if (kind === 'hostile') {
        stats.fear += 12;
        stats.resentment += 8;
        stats.respect += 2;
        stats.trust -= 6;
    } else if (kind === 'betrayal') {
        stats.trust -= 18;
        stats.resentment += 18;
        stats.affection -= 10;
        stats.loyalty -= 12;
    } else {
        stats.trust += 3;
        stats.respect += 2;
    }

    for (const key of Object.keys(stats)) {
        stats[key] = clamp(stats[key]);
    }

    const relationshipStage = nextStage(stats);
    const emotionalState = emotionalStateFor(kind, stats);
    const [memoryTag, memorySummary, emotionalWeight] = tagForOutcome(kind);

    await db.execute(
        `INSERT INTO npc_relationships
         (npc_id, user_id, current_life_id, trust, fear, respect, affection, resentment, loyalty, relationship_stage, last_interaction_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
         ON DUPLICATE KEY UPDATE
           current_life_id = VALUES(current_life_id),
           trust = VALUES(trust),
           fear = VALUES(fear),
           respect = VALUES(respect),
           affection = VALUES(affection),
           resentment = VALUES(resentment),
           loyalty = VALUES(loyalty),
           relationship_stage = VALUES(relationship_stage),
           last_interaction_at = CURRENT_TIMESTAMP`,
        [
            npc.id, userId, player.life_id, stats.trust, stats.fear, stats.respect,
            stats.affection, stats.resentment, stats.loyalty, relationshipStage
        ]
    );

    await db.execute(
        `UPDATE npcs
         SET current_emotional_state = ?, updated_at = CURRENT_TIMESTAMP
         WHERE id = ?`,
        [emotionalState, npc.id]
    );

    await db.execute(
        `INSERT INTO npc_memory_tags
         (npc_id, user_id, current_life_id, memory_tag, memory_summary, emotional_weight)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [npc.id, userId, player.life_id, memoryTag, memorySummary, emotionalWeight]
    );

    await db.execute(
        `INSERT INTO npc_scene_history
         (npc_id, user_id, current_life_id, scene_type, scene_summary, emotional_impact)
         VALUES (?, ?, ?, ?, ?, ?)`,
        [
            npc.id,
            userId,
            player.life_id,
            kind,
            String(sceneSummary || action).replace(/\s+/g, ' ').slice(0, 900),
            `${emotionalState}; ${relationshipStage}; ${memoryTag}`
        ]
    );

    return [{
        npc_id: npc.id,
        npc_name: npc.name,
        emotional_state: emotionalState,
        relationship_stage: relationshipStage,
        relationship: stats,
        memory_tag: memoryTag
    }];
}

module.exports = {
    applyNpcInteractionOutcome,
    classifySocialAction
};
