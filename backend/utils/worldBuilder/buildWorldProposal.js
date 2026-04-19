const { model } = require('../../config/gemini');
const { buildWorldBuilderPrompt } = require('../../config/worldBuilderPrompts');
const { fetchCanonContext } = require('./fetchCanonContext');
const { validateWorldProposal } = require('./validateWorldProposal');
const { applyWorldProposal } = require('./applyWorldProposal');

function parseJsonOnly(text) {
    const cleaned = String(text || '').replace(/```json|```/g, '').trim();
    const start = cleaned.indexOf('{');
    const end = cleaned.lastIndexOf('}');
    if (start === -1 || end === -1 || end <= start) {
        throw new Error('World builder returned no JSON object.');
    }
    return JSON.parse(cleaned.slice(start, end + 1));
}

function inspectMissingCanon({ action, engineNotice, storyContext, canonContext, actionFlow }) {
    const text = `${action || ''} ${engineNotice || ''} ${storyContext || ''}`.toLowerCase();
    const signals = [];

    if (!canonContext?.place) {
        signals.push({
            type: 'place',
            reason: `Current location "${canonContext?.location_id || 'unknown'}" has no structured world_places canon.`
        });
    }

    if (!canonContext?.region && canonContext?.location_seed?.region_name) {
        signals.push({
            type: 'region',
            reason: `Location seed region "${canonContext.location_seed.region_name}" has no structured world_regions canon.`
        });
    }

    const locationSpeciesKnown = (canonContext?.monster_species || []).some(s => {
        const name = String(s.name || '').toLowerCase();
        return name && text.includes(name);
    });
    if (actionFlow?.activeMonster && !locationSpeciesKnown) {
        signals.push({
            type: 'monster_species',
            reason: `Active encounter "${actionFlow.activeMonster.name}" needs species canon.`
        });
    }

    const canonTriggers = [
        'ancient', 'god', 'demon lord', 'demon', 'throne', 'ruler', 'guardian',
        'ruin', 'cult', 'bloodline', 'prophecy', 'sealed', 'artifact', 'relic',
        'war', 'uprising', 'ritual', 'catastrophe', 'corruption', 'faction',
        'king', 'queen', 'lord', 'temple', 'sanctum', 'glyph'
    ];
    for (const trigger of canonTriggers) {
        if (text.includes(trigger)) {
            signals.push({
                type: 'hint',
                reason: `Action or engine text invoked canon trigger "${trigger}".`
            });
        }
    }

    const socialTriggers = ['talk', 'speak', 'ask', 'comfort', 'threaten', 'negotiate', 'merchant', 'villager', 'guard'];
    if (socialTriggers.some(t => text.includes(t)) && !canonContext?.nearby_npcs?.length) {
        signals.push({
            type: 'npc',
            reason: 'Social action may need a persistent NPC profile.'
        });
    }

    return signals.slice(0, 6);
}

async function buildAndApplyWorldProposal({ db, player, userId, action, engineNotice, storyContext, actionFlow }) {
    const canonContext = await fetchCanonContext(db, player, { includeHidden: false });
    const missingSignals = inspectMissingCanon({
        action,
        engineNotice,
        storyContext,
        canonContext,
        actionFlow
    });

    if (!missingSignals.length) {
        return {
            canonContext,
            missingSignals,
            canonUpdates: [],
            queueRecord: null
        };
    }

    const prompt = buildWorldBuilderPrompt({
        player,
        action,
        engineNotice,
        storyContext,
        canonContext,
        missingSignals
    });

    let proposal;
    let queueId = null;

    try {
        const result = await model.generateContent(prompt);
        proposal = parseJsonOnly(result?.response?.text?.() || '');
    } catch (err) {
        proposal = {
            regions: [],
            places: [],
            factions: [],
            entities: [],
            monster_species: [],
            powers: [],
            lore_entries: [
                {
                    title: `Unstable Echo at ${player.current_location}`,
                    lore_type: 'rumor',
                    summary: `The System detected a canon-worthy anomaly, but the world-builder signal degraded before it could be safely shaped: ${err.message}`,
                    linked_place_name: player.current_location,
                    canon_status: 'rumor'
                }
            ],
            world_events: [],
            npcs: []
        };
    }

    const [queueResult] = await db.execute(
        `INSERT INTO world_generation_queue (life_id, trigger_action, proposal_type, proposal_json, status)
         VALUES (?, ?, ?, ?, 'pending')`,
        [player.life_id, action, 'auto_scene_gap', JSON.stringify(proposal)]
    );
    queueId = queueResult.insertId;

    const validation = await validateWorldProposal(db, proposal);
    if (!validation.valid) {
        await db.execute(
            `UPDATE world_generation_queue
             SET status = 'rejected', reviewed_at = CURRENT_TIMESTAMP
             WHERE id = ?`,
            [queueId]
        );
        return {
            canonContext,
            missingSignals,
            canonUpdates: [],
            queueRecord: { id: queueId, status: 'rejected', errors: validation.errors }
        };
    }

    const canonUpdates = await applyWorldProposal(db, validation, { lifeId: player.life_id, userId });
    await db.execute(
        `UPDATE world_generation_queue
         SET status = 'approved', reviewed_at = CURRENT_TIMESTAMP
         WHERE id = ?`,
        [queueId]
    );

    const updatedCanonContext = await fetchCanonContext(db, player, { includeHidden: false });
    return {
        canonContext: updatedCanonContext,
        missingSignals,
        canonUpdates,
        queueRecord: { id: queueId, status: 'approved' }
    };
}

module.exports = {
    buildAndApplyWorldProposal,
    inspectMissingCanon
};
