// backend/utils/gameAction/fetchPlayerState.js
const db = require('../../config/db');

function parsePermanentSkillNames(raw) {
    if (raw == null || raw === '') return [];
    if (Array.isArray(raw)) return raw.map(String).filter(Boolean);
    if (typeof raw === 'string') {
        try {
            const parsed = JSON.parse(raw);
            return Array.isArray(parsed) ? parsed.map(String).filter(Boolean) : [];
        } catch {
            return [];
        }
    }
    return [];
}

const MAX_MASTERY_LEVEL = 10;

/**
 * `soul_library.skills` as JSON object: { "Echo Sense": 3, ... } (levels 1–10).
 * Migrates legacy JSON arrays ["Echo Sense"] → { "Echo Sense": 1 }.
 */
function parseLibrarySkillsObject(raw) {
    if (raw == null || raw === '') return {};
    if (typeof raw === 'object' && raw !== null && !Array.isArray(raw)) {
        const out = {};
        for (const [k, v] of Object.entries(raw)) {
            const lv = Math.floor(Number(v) || 1);
            out[String(k)] = Math.min(MAX_MASTERY_LEVEL, Math.max(1, lv));
        }
        return out;
    }
    if (typeof raw === 'string') {
        try {
            const parsed = JSON.parse(raw);
            if (Array.isArray(parsed)) {
                const out = {};
                for (const name of parsed) {
                    out[String(name)] = 1;
                }
                return out;
            }
            if (parsed && typeof parsed === 'object') {
                return parseLibrarySkillsObject(parsed);
            }
        } catch {
            return {};
        }
    }
    if (Array.isArray(raw)) {
        const out = {};
        for (const name of raw) {
            out[String(name)] = 1;
        }
        return out;
    }
    return {};
}

/**
 * Loads `master_skills` rows for names in `users.permanent_skills` and sets
 * `player.active_skills` / `player.passive_skills` (detailed objects for AI & combat).
 */
async function enrichPlayerWithMasterSkills(player) {
    const names = parsePermanentSkillNames(player.permanent_skills);
    if (names.length === 0) {
        player.active_skills = [];
        player.passive_skills = [];
        return player;
    }

    const placeholders = names.map(() => '?').join(',');
    const [rows] = await db.execute(
        `SELECT id, name, description, karma_cost, skill_type, sp_cost
         FROM master_skills
         WHERE name IN (${placeholders})`,
        names
    );

    const active = [];
    const passive = [];

    for (const row of rows) {
        const detail = {
            id: row.id,
            name: row.name,
            description: row.description || '',
            karma_cost: Math.max(0, Math.floor(Number(row.karma_cost) || 0)),
            skill_type: row.skill_type,
            sp_cost: Math.max(0, Math.floor(Number(row.sp_cost) || 0))
        };
        const t = String(row.skill_type || '').toUpperCase();
        if (t === 'ACTIVE') {
            active.push(detail);
        } else {
            passive.push(detail);
        }
    }

    player.active_skills = active;
    player.passive_skills = passive;
    return player;
}

/**
 * Unique skill names for the current life (AI + engines).
 * - Permanent: `users.permanent_skills` (Karma Gifts — persist across rebirth).
 * - Temporary: keys of `soul_library.skills` object (life masteries — cleared on reincarnation).
 */
function mergeAllSoulSkills(permanentSkillsRaw, librarySkillsRaw) {
    const permanent = parsePermanentSkillNames(permanentSkillsRaw);
    const libMap = parseLibrarySkillsObject(librarySkillsRaw);
    const temporary = Object.keys(libMap);
    return Array.from(new Set([...permanent, ...temporary]));
}

async function fetchActivePlayerState(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills,
               s.accumulated_karma AS karma,
               s.skills AS library_skills
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        JOIN soul_library s ON c.user_id = s.user_id
        WHERE c.user_id = ? AND c.is_alive = 1
    `, [userId]);

    if (!playerRows.length) {
        throw new Error("No active life found.");
    }

    const row = playerRows[0];
    row.library_skills_map = parseLibrarySkillsObject(row.library_skills);
    row.all_soul_skills = mergeAllSoulSkills(row.permanent_skills, row.library_skills);

    await enrichPlayerWithMasterSkills(row);
    return row;
}

/**
 * Most recent life row (alive or dead). Used for Soul Stream / reincarnation gates.
 */
async function fetchLatestLifeForUser(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills,
               s.accumulated_karma AS karma,
               s.skills AS library_skills
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

    const row = playerRows[0];
    row.library_skills_map = parseLibrarySkillsObject(row.library_skills);
    row.all_soul_skills = mergeAllSoulSkills(row.permanent_skills, row.library_skills);

    await enrichPlayerWithMasterSkills(row);
    return row;
}

module.exports = {
    fetchActivePlayerState,
    fetchLatestLifeForUser,
    enrichPlayerWithMasterSkills,
    parsePermanentSkillNames,
    parseLibrarySkillsObject,
    mergeAllSoulSkills,
    MAX_MASTERY_LEVEL
};
