// backend/utils/gameAction/fetchPlayerState.js
const db = require('../../config/db');

async function fetchActivePlayerState(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills, u.karma
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

/**
 * Most recent life row (alive or dead). Used for Soul Stream / reincarnation gates.
 */
async function fetchLatestLifeForUser(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills, u.karma
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        JOIN soul_library s ON c.user_id = s.user_id
        WHERE c.user_id = ?
        ORDER BY c.life_id DESC
        LIMIT 1
    `, [userId]);

    if (!playerRows.length) {
        return null;
    }

    return playerRows[0];
}

module.exports = { fetchActivePlayerState, fetchLatestLifeForUser };