/**
 * Soul Library — meta-progression shop (users.karma + users.permanent_skills).
 */

const defaultPool = require('../../config/db');

function parseOwnedSkills(value) {
    if (value == null || value === '') return [];
    if (Array.isArray(value)) return value.map(String);
    if (typeof value === 'string') {
        try {
            const parsed = JSON.parse(value);
            return Array.isArray(parsed) ? parsed.map(String) : [];
        } catch {
            return [];
        }
    }
    if (typeof value === 'object' && value !== null) {
        return Array.isArray(value) ? value.map(String) : [];
    }
    return [];
}

/**
 * @param {number} userId
 * @param {import('mysql2/promise').Pool} db
 * @returns {Promise<{ karma_balance: number, skills: Array<object> }>}
 */
async function getShopInventory(userId, db = defaultPool) {
    const uid = Number(userId);
    if (!Number.isFinite(uid) || uid <= 0) {
        const e = new Error('Invalid user.');
        e.code = 'INVALID_USER';
        throw e;
    }

    const [skillRows] = await db.execute(
        `SELECT id, name, description, karma_cost, skill_type
         FROM master_skills
         ORDER BY id ASC`
    );

    const [userRows] = await db.execute(
        'SELECT karma, permanent_skills FROM users WHERE id = ?',
        [uid]
    );

    if (!userRows.length) {
        const e = new Error('User not found.');
        e.code = 'USER_NOT_FOUND';
        throw e;
    }

    const karmaBalance = Math.max(0, Math.floor(Number(userRows[0].karma) || 0));
    const ownedNames = new Set(parseOwnedSkills(userRows[0].permanent_skills));

    const skills = skillRows.map((row) => ({
        id: row.id,
        name: row.name,
        description: row.description,
        karma_cost: Math.max(0, Math.floor(Number(row.karma_cost) || 0)),
        skill_type: row.skill_type,
        owned: ownedNames.has(String(row.name))
    }));

    return {
        karma_balance: karmaBalance,
        skills
    };
}

/**
 * @param {number} userId
 * @param {number} skillId
 * @param {import('mysql2/promise').Pool} db
 */
async function purchaseSkill(userId, skillId, db = defaultPool) {
    const uid = Number(userId);
    const sid = Number(skillId);

    if (!Number.isFinite(uid) || uid <= 0) {
        const e = new Error('Invalid user.');
        e.code = 'INVALID_USER';
        throw e;
    }
    if (!Number.isFinite(sid) || sid <= 0) {
        const e = new Error('Invalid skill_id.');
        e.code = 'INVALID_SKILL_ID';
        throw e;
    }

    const pool = db;
    const conn = await pool.getConnection();

    try {
        await conn.beginTransaction();

        const [userRows] = await conn.execute(
            'SELECT id, karma, permanent_skills FROM users WHERE id = ? FOR UPDATE',
            [uid]
        );

        if (!userRows.length) {
            const e = new Error('User not found.');
            e.code = 'USER_NOT_FOUND';
            throw e;
        }

        const [skillRows] = await conn.execute(
            `SELECT id, name, description, karma_cost, skill_type
             FROM master_skills
             WHERE id = ?`,
            [sid]
        );

        if (!skillRows.length) {
            const e = new Error('Skill not found.');
            e.code = 'SKILL_NOT_FOUND';
            throw e;
        }

        const skill = skillRows[0];
        const skillName = String(skill.name);
        const cost = Math.max(0, Math.floor(Number(skill.karma_cost) || 0));
        const balance = Math.max(0, Math.floor(Number(userRows[0].karma) || 0));

        const owned = parseOwnedSkills(userRows[0].permanent_skills);
        if (owned.includes(skillName)) {
            const e = new Error('Skill already owned.');
            e.code = 'ALREADY_OWNED';
            throw e;
        }

        if (balance < cost) {
            const e = new Error('Insufficient karma.');
            e.code = 'INSUFFICIENT_KARMA';
            e.karma_balance = balance;
            e.karma_required = cost;
            throw e;
        }

        const nextSkills = [...owned, skillName];
        const newBalance = balance - cost;

        await conn.execute(
            `UPDATE users
             SET karma = ?, permanent_skills = ?
             WHERE id = ?`,
            [newBalance, JSON.stringify(nextSkills), uid]
        );

        await conn.commit();

        return {
            success: true,
            karma_balance: newBalance,
            permanent_skills: nextSkills,
            purchased: {
                id: skill.id,
                name: skill.name,
                description: skill.description,
                karma_cost: cost,
                skill_type: skill.skill_type
            }
        };
    } catch (err) {
        await conn.rollback();
        throw err;
    } finally {
        conn.release();
    }
}

module.exports = {
    getShopInventory,
    purchaseSkill,
    parseOwnedSkills
};
