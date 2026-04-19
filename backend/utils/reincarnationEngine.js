const db = require('../config/db');
const { parseLibrarySkillsObject } = require('./gameAction/fetchPlayerState');
const { refreshSoulRankAndMirrorKarma } = require('./soulProgression');

/** Karma granted per temporary mastery in `soul_library.skills` when the life ends (Soul Stream). */
const KARMA_PER_TEMPORARY_SKILL = 5;

const SOUL_STREAM_ACTION = '[SYSTEM] Accept Death and Enter the Soul Stream';

const SYSTEM_OUTPUT_SOUL_STREAM =
    '[SYSTEM: SOUL DETACHED] Your vessel has crumbled to dust. Your experiences have condensed into Karma. The Soul Stream beckons... Choose your next form.';

/**
 * Convert a finished life's progress into Karma (integer, >= 0).
 */
function calculateKarma(player) {
    const lv = Math.max(1, Math.floor(Number(player.current_level) || 1));
    const xp = Math.max(0, Math.floor(Number(player.xp) || 0));
    const raw = lv * 40 + Math.floor(Math.sqrt(xp) * 3) + Math.floor(xp / 10);
    return Math.max(0, raw);
}

function mapStartingVesselToDraft(row) {
    if (!row) return null;
    return {
        id: row.vessel_id,
        name: row.species,
        soul_path: row.soul_path,
        description: `A ${row.soul_path || 'soul'} path vessel: ${row.species}.`,
        base_hp: Number(row.base_hp) || 10,
        base_mp: Number(row.base_mp) || 10,
        starting_location: row.starting_location || 'nadir_upper',
        vessel_image: row.vessel_image || null,
        base_offense: Number(row.base_offense) || 5,
        base_defense: Number(row.base_defense) || 5,
        base_magic_power: Number(row.base_magic_power) || 5,
        base_resistance: Number(row.base_resistance) || 5,
        base_speed: Number(row.base_speed) || 5,
        base_hunger: Number(row.base_hunger) || 100,
        base_sp: Number(row.base_sp) || 20
    };
}

/**
 * Pull 3 random low-tier starting vessels (starter-friendly HP cap).
 */
async function draftNewVessels(conn) {
    const pool = conn || db;
    let [rows] = await pool.execute(
        `SELECT * FROM starting_vessels
         WHERE base_hp IS NOT NULL AND base_hp <= 60
         ORDER BY RAND()
         LIMIT 3`
    );

    if (rows.length < 3) {
        const [fallback] = await pool.execute(
            'SELECT * FROM starting_vessels ORDER BY RAND() LIMIT 3'
        );
        rows = fallback;
    }

    return rows.map(mapStartingVesselToDraft).filter(Boolean);
}

/**
 * Clear combat state for archived life; life must already be marked dead.
 */
async function archiveLife(player, conn) {
    const pool = conn || db;
    const lifeId = player.life_id;
    if (!lifeId) return;

    await pool.execute('DELETE FROM active_encounters WHERE life_id = ?', [lifeId]);
}

async function getSoulStreamCache(conn, lifeId) {
    const pool = conn || db;
    const [logs] = await pool.execute(
        `SELECT choices, system_response FROM action_logs
         WHERE life_id = ? AND user_action = ?
         ORDER BY log_id DESC
         LIMIT 1`,
        [lifeId, SOUL_STREAM_ACTION]
    );

    if (!logs.length) return null;
    const row = logs[0];
    if (!row.system_response || !row.system_response.includes('[SOUL_STREAM_PROCESSED]')) {
        return null;
    }
    try {
        const parsed = JSON.parse(row.choices || '{}');
        if (parsed.type !== 'SOUL_STREAM' || !Array.isArray(parsed.vessel_draft)) return null;
        return {
            status: 'SOUL_STREAM',
            karma_earned: parsed.karma_earned,
            total_karma: parsed.total_karma,
            system_output: SYSTEM_OUTPUT_SOUL_STREAM,
            vessel_draft: parsed.vessel_draft
        };
    } catch {
        return null;
    }
}

/**
 * Karma credit, archive cleanup, vessel draft, idempotent log.
 */
async function processSoulStreamTransition(userId, player) {
    const cached = await getSoulStreamCache(db, player.life_id);
    if (cached) return cached;

    const conn = await db.getConnection();

    try {
        await conn.beginTransaction();

        const [rows] = await conn.execute(
            'SELECT accumulated_karma, skills FROM soul_library WHERE user_id = ? FOR UPDATE',
            [userId]
        );
        if (!rows.length) {
            throw new Error('Soul library record missing.');
        }

        const temporarySkillCount = Object.keys(
            parseLibrarySkillsObject(rows[0].skills)
        ).length;
        const masteryKarmaBonus = temporarySkillCount * KARMA_PER_TEMPORARY_SKILL;
        const baseKarma = calculateKarma(player);
        const karmaEarned = baseKarma + masteryKarmaBonus;

        await conn.execute(
            `UPDATE soul_library
             SET accumulated_karma = accumulated_karma + ?,
                 skills = ?
             WHERE user_id = ?`,
            [karmaEarned, '{}', userId]
        );

        await refreshSoulRankAndMirrorKarma(conn, userId);

        const [totals] = await conn.execute(
            'SELECT accumulated_karma FROM soul_library WHERE user_id = ?',
            [userId]
        );
        const totalKarma = Math.max(0, Math.floor(Number(totals[0].accumulated_karma) || 0));

        await archiveLife(player, conn);

        const vesselDraftRows = await draftNewVessels(conn);
        if (vesselDraftRows.length === 0) {
            throw new Error('No starting vessels available in database.');
        }

        const payloadChoices = {
            type: 'SOUL_STREAM',
            karma_earned: karmaEarned,
            base_karma: baseKarma,
            mastery_karma_bonus: masteryKarmaBonus,
            temporary_skill_count: temporarySkillCount,
            total_karma: totalKarma,
            vessel_draft: vesselDraftRows
        };

        await conn.execute(
            `INSERT INTO action_logs (life_id, user_action, system_response, choices)
             VALUES (?, ?, ?, ?)`,
            [
                player.life_id,
                SOUL_STREAM_ACTION,
                `${SYSTEM_OUTPUT_SOUL_STREAM} [SOUL_STREAM_PROCESSED]`,
                JSON.stringify(payloadChoices)
            ]
        );

        await conn.commit();

        return {
            status: 'SOUL_STREAM',
            karma_earned: karmaEarned,
            base_karma: baseKarma,
            mastery_karma_bonus: masteryKarmaBonus,
            temporary_skill_count: temporarySkillCount,
            total_karma: totalKarma,
            system_output: SYSTEM_OUTPUT_SOUL_STREAM,
            vessel_draft: vesselDraftRows
        };
    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
}

async function assertNoActiveLife(conn, userId) {
    const [active] = await conn.execute(
        'SELECT life_id FROM current_life WHERE user_id = ? AND is_alive = 1 LIMIT 1',
        [userId]
    );
    if (active.length) {
        const e = new Error('ALREADY_ALIVE');
        e.code = 'ALREADY_ALIVE';
        throw e;
    }
}

/**
 * Ensures no stray active rows remain before inserting a new vessel (defensive).
 */
async function markAllCurrentLivesDead(conn, userId) {
    await conn.execute(
        'UPDATE current_life SET is_alive = 0, hp = 0 WHERE user_id = ? AND is_alive = 1',
        [userId]
    );
}

async function assertSoulStreamCompleted(conn, userId) {
    const pool = conn || db;
    const [rows] = await pool.execute(
        `SELECT al.choices, al.system_response
         FROM action_logs al
         INNER JOIN current_life c ON al.life_id = c.life_id
         WHERE c.user_id = ?
           AND al.user_action = ?
           AND al.system_response LIKE '%[SOUL_STREAM_PROCESSED]%'
         ORDER BY al.log_id DESC
         LIMIT 1`,
        [userId, SOUL_STREAM_ACTION]
    );
    if (!rows.length) {
        const e = new Error('SOUL_STREAM_REQUIRED');
        e.code = 'SOUL_STREAM_REQUIRED';
        throw e;
    }
}

/**
 * Create a new active life from a chosen starting_vessels row.
 */
async function rebirthWithVessel(userId, vesselId) {
    const vid = Math.floor(Number(vesselId));
    if (!Number.isFinite(vid) || vid <= 0) {
        const e = new Error('Invalid vessel_id.');
        e.code = 'INVALID_VESSEL';
        throw e;
    }

    const conn = await db.getConnection();

    try {
        await conn.beginTransaction();

        await assertNoActiveLife(conn, userId);
        await assertSoulStreamCompleted(conn, userId);
        await markAllCurrentLivesDead(conn, userId);

        await conn.execute(
            'UPDATE soul_library SET skills = ? WHERE user_id = ?',
            ['{}', userId]
        );

        const [vessels] = await conn.execute(
            'SELECT * FROM starting_vessels WHERE vessel_id = ? FOR UPDATE',
            [vid]
        );
        if (!vessels.length) {
            const e = new Error('Vessel template not found.');
            e.code = 'NOT_FOUND';
            throw e;
        }

        const v = vessels[0];
        const baseHp = Number(v.base_hp) || 10;
        const baseMp = Number(v.base_mp) || 10;
        const baseSp = Number(v.base_sp) || 20;
        const off = Number(v.base_offense) || 5;
        const def = Number(v.base_defense) || 5;
        const mag = Number(v.base_magic_power) || 5;
        const res = Number(v.base_resistance) || 5;
        const spd = Number(v.base_speed) || 5;
        const hunger = Number(v.base_hunger) || 100;
        const loc = v.starting_location || 'nadir_upper';
        const species = v.species || 'Unknown Vessel';
        const vesselType = v.soul_path || 'Beast';

        const [insertResult] = await conn.execute(
            `INSERT INTO current_life (
                user_id, species, vessel_type, current_level,
                hp, max_hp, mp, max_mp, hunger, sp, max_sp,
                current_location, is_alive, pos_x, pos_y, xp, next_level_xp,
                attribute_points, offense, defense, magic_power, resistance, speed, skill_points,
                inventory, home_base
            ) VALUES (?, ?, ?, 1, ?, ?, ?, ?, ?, ?, ?, ?, 1, 0, 0, 0, 100, 0, ?, ?, ?, ?, ?, 0, '[]', NULL)`,
            [
                userId,
                species,
                vesselType,
                baseHp,
                baseHp,
                baseMp,
                baseMp,
                hunger,
                baseSp,
                baseSp,
                loc,
                off,
                def,
                mag,
                res,
                spd
            ]
        );

        const newLifeId = insertResult.insertId;

        await conn.commit();

        return {
            status: 'ALIVE',
            life_id: newLifeId,
            species,
            vessel_type: vesselType,
            current_location: loc,
            stats: {
                hp: baseHp,
                max_hp: baseHp,
                mp: baseMp,
                max_mp: baseMp,
                hunger,
                sp: baseSp,
                max_sp: baseSp,
                level: 1,
                xp: 0,
                next_mark: 100,
                offense: off,
                defense: def,
                magic_power: mag,
                resistance: res,
                speed: spd
            }
        };
    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
}

/**
 * DYNAMIC BIRTH ENGINE (AI reincarnation route — existing)
 */
const performReincarnationBirth = async (userId, determinedPath, aiSuggestions, pool = db) => {
    let [vessels] = await pool.execute(
        'SELECT * FROM starting_vessels WHERE soul_path = ? ORDER BY RAND() LIMIT 1',
        [determinedPath]
    );

    let vessel;
    if (vessels.length === 0 || aiSuggestions.forceNew) {
        const species = aiSuggestions.species || `${determinedPath} Variant`;
        const location = aiSuggestions.location || 'nadir_upper';

        const [insertVessel] = await pool.execute(
            `INSERT INTO starting_vessels 
            (soul_path, species, base_hp, base_mp, base_offense, base_defense, base_speed, base_hunger, base_sp, starting_location) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                determinedPath,
                species,
                aiSuggestions.hp || 100,
                aiSuggestions.mp || 50,
                aiSuggestions.offense || 20,
                aiSuggestions.defense || 20,
                aiSuggestions.speed || 20,
                100,
                aiSuggestions.sp || 50,
                location
            ]
        );

        const [newRows] = await pool.execute('SELECT * FROM starting_vessels WHERE vessel_id = ?', [insertVessel.insertId]);
        vessel = newRows[0];
    } else {
        vessel = vessels[0];
    }

    return vessel;
};

module.exports = {
    performReincarnationBirth,
    SOUL_STREAM_ACTION,
    SYSTEM_OUTPUT_SOUL_STREAM,
    calculateKarma,
    KARMA_PER_TEMPORARY_SKILL,
    draftNewVessels,
    archiveLife,
    processSoulStreamTransition,
    rebirthWithVessel,
    mapStartingVesselToDraft,
    markAllCurrentLivesDead
};
