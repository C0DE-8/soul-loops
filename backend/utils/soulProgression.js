/**
 * Soul rank tiers from total accumulated karma (soul_library.accumulated_karma).
 * Rank N+1 requires karma >= RANK_KARMA_THRESHOLDS[N] (1-based rank uses index N-1 for rank N).
 */
const RANK_KARMA_THRESHOLDS = [
    0, 100, 300, 600, 1000, 1500, 2500, 4000, 6500, 10000, 15000, 22000, 32000, 45000, 65000
];

const HIGH_RANK_STEP = 20000;

/**
 * @param {number} accumulatedKarma
 * @returns {number} Soul rank in [1, 99]
 */
function computeSoulRankFromAccumulatedKarma(accumulatedKarma) {
    const k = Math.max(0, Math.floor(Number(accumulatedKarma) || 0));
    let rank = 1;
    for (let i = 1; i < RANK_KARMA_THRESHOLDS.length; i++) {
        if (k >= RANK_KARMA_THRESHOLDS[i]) rank = i + 1;
        else break;
    }

    const maxPresetRank = RANK_KARMA_THRESHOLDS.length;
    const topThreshold = RANK_KARMA_THRESHOLDS[RANK_KARMA_THRESHOLDS.length - 1];
    if (k >= topThreshold) {
        const extra = Math.floor((k - topThreshold) / HIGH_RANK_STEP);
        rank = Math.min(99, Math.max(rank, maxPresetRank + extra));
    }

    return Math.min(99, Math.max(1, rank));
}

/**
 * Sets soul_library.soul_rank from accumulated_karma and mirrors the balance to users.karma.
 *
 * @param {import('mysql2/promise').Pool|import('mysql2/promise').PoolConnection} conn
 * @param {number} userId
 */
async function refreshSoulRankAndMirrorKarma(conn, userId) {
    const uid = Number(userId);
    if (!Number.isFinite(uid) || uid <= 0) return;

    const [rows] = await conn.execute(
        'SELECT accumulated_karma FROM soul_library WHERE user_id = ? FOR UPDATE',
        [uid]
    );
    if (!rows.length) return;

    const karma = Math.max(0, Math.floor(Number(rows[0].accumulated_karma) || 0));
    const rank = computeSoulRankFromAccumulatedKarma(karma);

    await conn.execute('UPDATE soul_library SET soul_rank = ? WHERE user_id = ?', [rank, uid]);
    await conn.execute('UPDATE users SET karma = ? WHERE id = ?', [karma, uid]);
}

module.exports = {
    computeSoulRankFromAccumulatedKarma,
    refreshSoulRankAndMirrorKarma,
    RANK_KARMA_THRESHOLDS
};
