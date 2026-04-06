// backend/utils/gameAction/fetchPlayerState.js
const db = require('../../config/db');

async function fetchActivePlayerState(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, s.permanent_skills
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        JOIN soul_library s ON c.user_id = s.user_id
        WHERE c.user_id = ? AND c.is_alive = 1
    `, [userId]);

    if (!playerRows.length) {
        throw new Error("No active life found.");
    }

    return playerRows[0];
}

module.exports = { fetchActivePlayerState };