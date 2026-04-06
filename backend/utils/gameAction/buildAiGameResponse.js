// backend/utils/gameAction/buildAiGameResponse.js
const { model } = require('../../config/gemini');
const { buildSystemPrompt } = require('../../config/prompts');

async function buildAiGameResponse({ player, action, engineNotice, monsterContext, worldLore, db }) {
    const [locRows] = await db.execute(
        'SELECT location_image FROM location_seeds WHERE location_id = ?',
        [player.current_location]
    );

    const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;

    const fullContext = `${monsterContext}${worldLore}${engineNotice}`;

    const aiPrompt = buildSystemPrompt(
        player,
        { description_seed: player.current_location },
        action,
        fullContext
    );

    const aiResult = await model.generateContent(aiPrompt);
    const aiResponse = aiResult?.response?.text?.() || "";

    return {
        aiResponse,
        backgroundUrl
    };
}

module.exports = { buildAiGameResponse };