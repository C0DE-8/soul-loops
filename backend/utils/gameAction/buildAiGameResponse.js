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
    db
}) {
    const [locRows] = await db.execute(
        'SELECT location_image, description_seed FROM location_seeds WHERE location_id = ?',
        [player.current_location]
    );

    const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;

    const location = {
        description_seed:
            locRows.length > 0 && locRows[0].description_seed
                ? locRows[0].description_seed
                : String(player.current_location || "Unknown location")
    };

    const fullContext = `
[SHORT TERM MEMORY]
${memoryContext || "None"}

[MONSTER CONTEXT]
${monsterContext || "None"}

[WORLD LORE]
${worldLore || "None"}

[ENGINE FEED]
${engineNotice || "None"}
    `.trim();

    const aiPrompt = buildSystemPrompt(
        player,
        location,
        action,
        fullContext
    );

    let aiResponse = "";

    try {
        const aiResult = await generateWithRetry(model, aiPrompt);
        aiResponse = aiResult?.response?.text?.() || "";
    } catch (err) {
        console.error("AI ERROR:", err.message);

        // ⚡ FALLBACK RESPONSE
        aiResponse = `
The system falters for a moment… but the world does not pause.

The air remains heavy. Danger still surrounds you. Your instincts must decide your next move.

---
[CHOICE_1: Attack forward. (Cost: Low SP)]
[CHOICE_2: Defend and stabilize. (Cost: Low SP)]
[CHOICE_3: Attempt escape. (Cost: Medium SP)]
        `.trim();
    }

    return {
        aiResponse,
        backgroundUrl
    };
}

module.exports = { buildAiGameResponse };