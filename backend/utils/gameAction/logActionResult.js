// backend/utils/gameAction/logActionResult.js
async function logActionResult({ db, lifeId, action, cleanStory, finalChoices, backgroundUrl, monsterImageUrl }) {
    const logParams = [
        lifeId,
        action,
        cleanStory,
        JSON.stringify(finalChoices),
        backgroundUrl,
        monsterImageUrl
    ];

    await db.execute(
        `INSERT INTO action_logs (life_id, user_action, system_response, choices, bg_image, encounter_image)
         VALUES (?, ?, ?, ?, ?, ?)`,
        logParams
    );
}

module.exports = { logActionResult };