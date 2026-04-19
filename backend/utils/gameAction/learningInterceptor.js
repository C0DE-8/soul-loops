const { parsePermanentSkillNames, parseLibrarySkillsObject } = require('./fetchPlayerState');

const ECHO_SENSE_SKILL = 'Echo Sense';
const SEARCHES_REQUIRED = 5;

function isSearchAction(normalizedAction) {
    return String(normalizedAction || '').trim().toLowerCase() === 'search';
}

/**
 * Reward repeated Search: after 5 Search actions in the current life, grant "Echo Sense" at Level 1.
 * Persists ONLY to `soul_library.skills` as JSON object `{ "Echo Sense": 1 }`. Never writes `users.permanent_skills`.
 *
 * @returns {Promise<{ engineNotice: string }>}
 */
async function maybeLearnEchoSenseFromSearch(db, userId, player, normalizedAction) {
    if (!isSearchAction(normalizedAction)) {
        return { engineNotice: '' };
    }

    const [countRows] = await db.execute(
        `SELECT COUNT(*) AS cnt FROM action_logs
         WHERE life_id = ? AND LOWER(TRIM(user_action)) = 'search'`,
        [player.life_id]
    );
    const previousSearches = Math.floor(Number(countRows[0]?.cnt || 0));
    const totalIncludingThis = previousSearches + 1;

    if (totalIncludingThis < SEARCHES_REQUIRED) {
        return { engineNotice: '' };
    }

    const map = parseLibrarySkillsObject(player.library_skills);
    if (map[ECHO_SENSE_SKILL] != null) {
        return { engineNotice: '' };
    }

    map[ECHO_SENSE_SKILL] = 1;
    const skillsJson = JSON.stringify(map);

    await db.execute(
        'UPDATE soul_library SET skills = ? WHERE user_id = ?',
        [skillsJson, userId]
    );

    player.library_skills = skillsJson;
    player.library_skills_map = map;
    const permanent = parsePermanentSkillNames(player.permanent_skills);
    player.all_soul_skills = Array.from(new Set([...permanent, ...Object.keys(map)]));

    return {
        engineNotice:
            "[SKILL EARNED: Your constant vigilance has unlocked the skill 'Echo Sense'!]"
    };
}

module.exports = {
    maybeLearnEchoSenseFromSearch,
    isSearchAction
};
