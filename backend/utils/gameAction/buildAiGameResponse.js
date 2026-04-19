// backend/utils/gameAction/buildAiGameResponse.js
const { model } = require('../../config/gemini');
const { buildSystemPrompt } = require('../../config/prompts');

// 🔁 retry helper
async function generateWithRetry(model, prompt, retries = 2) {
    for (let i = 0; i <= retries; i++) {
        try {
            const result = await model.generateContent(prompt);
            return result;
        } catch (err) {
            if (i === retries) throw err;

            await new Promise(res => setTimeout(res, 500 * (i + 1)));
        }
    }
}

async function buildAiGameResponse({
    player,
    action,
    engineNotice,
    monsterContext,
    worldLore,
    memoryContext,
    canonContext = null,
    npcPromptContext = '',
    canonUpdates = [],
    db,
    storyContext = '',
    prioritizeLifeActions = false
}) {
    let locRows;
    try {
        const [rows] = await db.execute(
            'SELECT location_image, description_seed, hidden_lore FROM location_seeds WHERE location_id = ?',
            [player.current_location]
        );
        locRows = rows;
    } catch (err) {
        if (err.code === 'ER_BAD_FIELD_ERROR') {
            const [rows] = await db.execute(
                'SELECT location_image, description_seed FROM location_seeds WHERE location_id = ?',
                [player.current_location]
            );
            locRows = rows;
        } else {
            throw err;
        }
    }

    const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;

    const location = {
        description_seed:
            locRows.length > 0 && locRows[0].description_seed
                ? locRows[0].description_seed
                : String(player.current_location || "Unknown location"),
        hidden_lore: locRows.length > 0 && locRows[0].hidden_lore ? locRows[0].hidden_lore : null
    };

    const fullContext = `
[SHORT TERM MEMORY]
${memoryContext || "None"}

[MONSTER CONTEXT]
${monsterContext || "None"}

[WORLD LORE]
${worldLore || "None"}

[APPROVED CANON CONTEXT]
${canonContext ? JSON.stringify({
    region: canonContext.region,
    place: canonContext.place,
    places: (canonContext.places || []).slice(0, 5),
    factions: (canonContext.factions || []).slice(0, 5),
    entities: (canonContext.entities || []).slice(0, 5),
    monster_species: (canonContext.monster_species || []).slice(0, 5),
    powers: (canonContext.powers || []).slice(0, 5),
    lore_entries: (canonContext.lore_entries || []).slice(0, 5),
    world_events: (canonContext.world_events || []).slice(0, 5)
}) : "None"}

[CANON UPDATES APPROVED THIS TURN]
${canonUpdates && canonUpdates.length ? JSON.stringify(canonUpdates) : "None"}

${npcPromptContext || "[NPC EMOTION CONTEXT]\nNone"}

[ENGINE FEED]
${engineNotice || "None"}
    `.trim();

    const aiPrompt = buildSystemPrompt(
        player,
        location,
        action,
        fullContext,
        { storyContext, prioritizeLifeActions }
    );

    let aiResponse = "";

    try {
        const aiResult = await generateWithRetry(model, aiPrompt);
        aiResponse = aiResult?.response?.text?.() || "";
    } catch (err) {
        console.error("AI ERROR:", err.message);

        // ⚡ FALLBACK RESPONSE
        if (prioritizeLifeActions) {
            aiResponse = `
The labyrinth holds its breath. No fangs snap at you—only space, thread, and echo.

---
[CHOICE_1: Improve Home Base (Cost: Med SP, Low Hunger)]
[CHOICE_2: (${String(player.vessel_type || 'BEAST').toUpperCase()}) Practice Skill: Thread Manipulation (Cost: Low SP)]
[CHOICE_3: Listen to the Labyrinth's Echoes (Cost: Low SP)]
            `.trim();
        } else {
            aiResponse = `
The system falters for a moment… but the world does not pause.

The air remains heavy. Danger still surrounds you. Your instincts must decide your next move.

---
[CHOICE_1: Attack forward. (Cost: Low SP)]
[CHOICE_2: Defend and stabilize. (Cost: Low SP)]
[CHOICE_3: Attempt escape. (Cost: Medium SP)]
            `.trim();
        }
    }

    return {
        aiResponse,
        backgroundUrl
    };
}

module.exports = { buildAiGameResponse };
