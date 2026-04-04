const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

// Lock down all player routes
router.use(verifyToken);

// ==========================================
// ROUTE 1: GET FULL PLAYER PROFILE (With Visuals)
// ==========================================
router.get('/profile', async (req, res) => {
    const userId = req.user.userId;

    try {
        // 1. Get User Account & Soul Library Data
        const [soulRows] = await db.execute(`
            SELECT u.username, u.email, s.soul_rank, s.accumulated_karma, s.permanent_skills, s.death_count 
            FROM users u 
            JOIN soul_library s ON u.id = s.user_id 
            WHERE u.id = ?`, 
            [userId]
        );

        if (!soulRows.length) return res.status(404).json({ error: "[SYSTEM ERROR]: Soul record not found." });
        const soul = soulRows[0];

        // 2. Get Current Life Stats + Vessel Image
        // We JOIN current_life with starting_vessels to get the image for that species
        const [lifeRows] = await db.execute(`
            SELECT c.species, c.current_level, c.hp, c.max_hp, c.mp, c.max_mp, 
                   c.pos_x, c.pos_y, c.current_location, v.vessel_image
            FROM current_life c
            LEFT JOIN starting_vessels v ON c.species = v.species
            WHERE c.user_id = ? AND c.is_alive = 1`, 
            [userId]
        );

        // 3. Get Social Bonds (Friends & Rivals)
        const [relationshipRows] = await db.execute(`
            SELECT u.username as target_name, r.bond_type 
            FROM relationships r 
            JOIN users u ON r.target_id = u.id 
            WHERE r.user_id = ? AND r.status = 'ACCEPTED'`, 
            [userId]
        );

        // Construct the ultimate profile object
        res.json({
            account: {
                username: soul.username,
                email: soul.email
            },
            soul_status: {
                rank: soul.soul_rank,
                karma: soul.accumulated_karma,
                deaths: soul.death_count,
                permanent_skills: JSON.parse(soul.permanent_skills || '[]')
            },
            // If the user is alive, current_vessel now includes the vessel_image URL
            current_vessel: lifeRows.length > 0 ? lifeRows[0] : null,
            social_circle: relationshipRows 
        });

    } catch (err) {
        console.error("PROFILE_FETCH_ERROR:", err);
        res.status(500).json({ error: "Failed to sync with the Voice of the World." });
    }
});

// ==========================================
// 1. SEND BOND REQUEST (Friend/Rival)
// ==========================================
router.post('/relationship/request', async (req, res) => {
    const userId = req.user.userId;
    const { targetUsername, type } = req.body; // type: 'FRIEND' or 'RIVAL'

    try {
        const [targetRows] = await db.execute('SELECT id FROM users WHERE username = ?', [targetUsername]);
        if (!targetRows.length) return res.status(404).json({ error: "Soul not found." });
        const targetId = targetRows[0].id;

        if (userId === targetId) return res.status(400).json({ error: "You cannot bond with yourself." });

        // Insert as PENDING
        await db.execute(
            'INSERT INTO relationships (user_id, target_id, bond_type, status) VALUES (?, ?, ?, "PENDING") ON DUPLICATE KEY UPDATE bond_type = ?',
            [userId, targetId, type, type]
        );

        res.json({ message: `[SYSTEM]: ${type} request sent to ${targetUsername}. Awaiting soul resonance.` });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// ==========================================
// 2. ACCEPT BOND REQUEST
// ==========================================
router.post('/relationship/accept/:requesterId', async (req, res) => {
    const userId = req.user.userId; // The person clicking 'Accept'
    const requesterId = req.params.requesterId; // The ID from the URL

    try {
        // 1. Check if the pending request actually exists
        const [existing] = await db.execute(
            'SELECT bond_type FROM relationships WHERE user_id = ? AND target_id = ? AND status = "PENDING"',
            [requesterId, userId]
        );

        if (existing.length === 0) {
            return res.status(404).json({ error: "[SYSTEM]: No pending soul resonance found from this Subject." });
        }

        const type = existing[0].bond_type;

        // 2. Update the original request to ACCEPTED
        await db.execute(
            'UPDATE relationships SET status = "ACCEPTED" WHERE user_id = ? AND target_id = ?',
            [requesterId, userId]
        );

        // 3. Create the reciprocal bond so both players see each other
        await db.execute(
            'INSERT INTO relationships (user_id, target_id, bond_type, status) VALUES (?, ?, ?, "ACCEPTED") ON DUPLICATE KEY UPDATE status = "ACCEPTED"',
            [userId, requesterId, type]
        );

        res.json({ 
            message: `[SYSTEM]: Resonance SUCCESSFUL. Soul bond established as ${type}.`,
            partner_id: requesterId 
        });

    } catch (err) {
        console.error("ACCEPT_ERROR:", err);
        res.status(500).json({ error: "[SYSTEM ERROR]: Failed to finalize soul resonance." });
    }
});

// ==========================================
// 3. REJECT BOND REQUEST
// ==========================================
router.delete('/relationship/reject/:requesterId', async (req, res) => {
    const userId = req.user.userId; // The person clicking 'Reject'
    const requesterId = req.params.requesterId;

    try {
        // Find and delete the pending request sent TO you
        const [result] = await db.execute(
            'DELETE FROM relationships WHERE user_id = ? AND target_id = ? AND status = "PENDING"',
            [requesterId, userId]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ error: "[SYSTEM]: No pending request found to discard." });
        }

        res.json({ message: `[SYSTEM]: Soul resonance request from Subject ${requesterId} has been discarded.` });

    } catch (err) {
        console.error("REJECT_ERROR:", err);
        res.status(500).json({ error: "[SYSTEM ERROR]: Failed to discard request." });
    }
});

// ==========================================
// 2. GET ALL BONDS (With rel_id for UI Actions)
// ==========================================
router.get('/relationship/all', async (req, res) => {
    const userId = req.user.userId;

    try {
        // We pull rel_id so the frontend can use it for DELETE/POST routes
        const [rows] = await db.execute(`
            SELECT 
                r.rel_id,
                u.id as partner_id,
                u.username, 
                r.bond_type, 
                r.status,
                CASE 
                    WHEN r.user_id = ? THEN 'OUTGOING' 
                    ELSE 'INCOMING' 
                END as direction
            FROM relationships r
            JOIN users u ON (
                (r.user_id = u.id AND r.target_id = ?) OR 
                (r.target_id = u.id AND r.user_id = ?)
            )
            WHERE u.id != ?
            ORDER BY r.status DESC, r.created_at DESC`, 
            [userId, userId, userId, userId]
        );

        res.json({ social_circle: rows });
    } catch (err) {
        console.error("GET_BONDS_ERROR:", err);
        res.status(500).json({ error: "[SYSTEM ERROR]: Failed to retrieve social matrix." });
    }
});

// ==========================================
// 4. UNBOND (Unfriend / Remove Rival)
// ==========================================
router.delete('/relationship/sever/:targetId', async (req, res) => {
    const userId = req.user.userId; // Your ID from the Token
    const targetId = req.params.targetId; // The ID from the URL

    try {
        // 1. Check if the bond even exists before trying to delete
        const [existing] = await db.execute(
            'SELECT * FROM relationships WHERE (user_id = ? AND target_id = ?) OR (user_id = ? AND target_id = ?)',
            [userId, targetId, targetId, userId]
        );

        if (existing.length === 0) {
            return res.status(404).json({ error: "[SYSTEM]: No existing soul bond found to sever." });
        }

        // 2. Delete both directions of the bond
        await db.execute(
            'DELETE FROM relationships WHERE (user_id = ? AND target_id = ?) OR (user_id = ? AND target_id = ?)',
            [userId, targetId, targetId, userId]
        );

        res.json({ 
            message: `[SYSTEM]: Soul connection with Subject ${targetId} has been successfully severed.`,
            severed_target_id: targetId 
        });

    } catch (err) {
        console.error("SEVER_ERROR:", err);
        res.status(500).json({ error: "[SYSTEM ERROR]: Failed to sever the connection matrix." });
    }
});

// ==========================================
// ROUTE 3: EXECUTE DUEL (Requires Friend/Rival)
// ==========================================
router.post('/duel', async (req, res) => {
    const challengerId = req.user.userId;
    const { targetUsername, duelType } = req.body; // 'TO_POINT' or 'TO_DEATH'

    try {
        const [targetRows] = await db.execute('SELECT id FROM users WHERE username = ?', [targetUsername]);
        if (!targetRows.length) return res.status(404).json({ error: "Target not found." });
        const targetId = targetRows[0].id;

        // 1. Social Check
        const [relRows] = await db.execute(
            'SELECT bond_type FROM relationships WHERE user_id = ? AND target_id = ?',
            [challengerId, targetId]
        );

        if (relRows.length === 0) {
            return res.status(403).json({ 
                error: `[SYSTEM ERROR]: Access Denied. You have no bond with ${targetUsername}. Set them as a FRIEND or RIVAL first.` 
            });
        }

        const bond = relRows[0].bond_type;

        // 2. Fetch Combatants
        const [attacker] = await db.execute('SELECT * FROM current_life WHERE user_id = ? AND is_alive = 1', [challengerId]);
        const [defender] = await db.execute('SELECT * FROM current_life WHERE user_id = ? AND is_alive = 1', [targetId]);

        if (!attacker.length || !defender.length) return res.status(400).json({ error: "Both players must have an active vessel." });

        // 3. Combat Math (Level + RNG)
        const attackerPower = attacker[0].current_level + Math.floor(Math.random() * 15);
        const defenderPower = defender[0].current_level + Math.floor(Math.random() * 15);

        let winnerId, loserId;
        if (attackerPower > defenderPower) {
            winnerId = challengerId; loserId = targetId;
        } else {
            winnerId = targetId; loserId = challengerId;
        }

        // 4. Resolve Consequences
        let resultMessage = "";
        const bondText = bond === 'FRIEND' ? "Friendly Sparring" : "Rivalry Clash";

        if (duelType === 'TO_DEATH') {
            await db.execute('UPDATE current_life SET is_alive = 0, hp = 0 WHERE user_id = ?', [loserId]);
            await db.execute('UPDATE soul_library SET death_count = death_count + 1 WHERE user_id = ?', [loserId]);
            resultMessage = `[SYSTEM MESSAGE]: ${bondText} ended in tragedy. User ID ${winnerId} has eradicated User ID ${loserId}.`;
        } else {
            await db.execute('UPDATE current_life SET hp = 1 WHERE user_id = ?', [loserId]);
            resultMessage = `[SYSTEM MESSAGE]: ${bondText} concluded. User ID ${winnerId} is victorious. Target spared at 1 HP.`;
        }

        res.json({ message: resultMessage, winnerId, duel_type: duelType });

    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;