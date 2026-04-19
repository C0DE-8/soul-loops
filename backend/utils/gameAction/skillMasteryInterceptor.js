const {
    parsePermanentSkillNames,
    parseLibrarySkillsObject,
    MAX_MASTERY_LEVEL
} = require('./fetchPlayerState');

/** Chance to gain one mastery level when using a matching action while owning the skill. */
const LEVEL_UP_ROLL = 0.2;

/**
 * Action → temporary mastery skill name (must exist in `soul_library.skills`).
 * Extend this table as you add more action/skill pairs.
 */
const ACTION_MASTERY_RULES = [
    {
        skillName: 'Echo Sense',
        matches: (normalizedAction) =>
            String(normalizedAction || '').trim().toLowerCase() === 'search'
    }
];

function syncMergedSkillNames(player, map) {
    const permanent = parsePermanentSkillNames(player.permanent_skills);
    player.all_soul_skills = Array.from(new Set([...permanent, ...Object.keys(map)]));
}

/**
 * Random chance to level a temporary mastery when the player uses a related action.
 *
 * @returns {Promise<{ engineNotice: string }>}
 */
async function maybeProgressMastery(db, userId, player, normalizedAction) {
    const map = { ...parseLibrarySkillsObject(player.library_skills) };
    let engineNotice = '';

    for (const rule of ACTION_MASTERY_RULES) {
        if (!rule.matches(normalizedAction)) continue;

        const skill = rule.skillName;
        if (map[skill] == null) continue;

        if (Math.random() >= LEVEL_UP_ROLL) continue;

        const cur = Math.min(
            MAX_MASTERY_LEVEL,
            Math.max(1, Math.floor(Number(map[skill]) || 1))
        );
        if (cur >= MAX_MASTERY_LEVEL) continue;

        const next = cur + 1;
        map[skill] = next;

        const skillsJson = JSON.stringify(map);
        await db.execute('UPDATE soul_library SET skills = ? WHERE user_id = ?', [
            skillsJson,
            userId
        ]);

        player.library_skills = skillsJson;
        player.library_skills_map = map;
        syncMergedSkillNames(player, map);

        if (next >= MAX_MASTERY_LEVEL) {
            engineNotice = `[SKILL MAXED: ${skill} has reached Level 10! It is ready to Evolve.]`;
        }
        break;
    }

    return { engineNotice };
}

module.exports = {
    maybeProgressMastery,
    LEVEL_UP_ROLL
};
