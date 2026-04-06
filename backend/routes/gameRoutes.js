// backend/routes/gameRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

const { fetchActivePlayerState, fetchLatestLifeForUser } = require('../utils/gameAction/fetchPlayerState');
const { applyActionFlow } = require('../utils/gameAction/applyActionFlow');
const {
    SOUL_STREAM_ACTION,
    processSoulStreamTransition,
    rebirthWithVessel
} = require('../utils/reincarnationEngine');
const { buildAiGameResponse } = require('../utils/gameAction/buildAiGameResponse');
const { finalizeChoicesAndStatus } = require('../utils/gameAction/finalizeChoices');
const { saveUpdatedPlayerState } = require('../utils/gameAction/savePlayerState');
const { logActionResult } = require('../utils/gameAction/logActionResult');
const { getShopInventory, purchaseSkill } = require('../utils/meta/soulLibraryEngine');

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// ROUTE 1: //api/game/status - Fetch current player state, recent history, and available choices
// ==========================================
router.get('/status', async (req, res) => {
    const userId = req.user.userId;

    try {
        const player = await fetchActivePlayerState(userId);

        const [logRows] = await db.execute(`
            SELECT user_action, system_response, choices, bg_image, encounter_image
            FROM action_logs
            WHERE life_id = ? ORDER BY created_at DESC LIMIT 5
        `, [player.life_id]);

        const history = logRows.reverse();
        const lastLog = history[history.length - 1];

        res.json({
            player_state: player,
            recent_history: history.map(h => ({
                user_action: h.user_action,
                system_response: h.system_response
            })),
            choices: lastLog ? JSON.parse(lastLog.choices) : [],
            visuals: {
                background: lastLog ? lastLog.bg_image : null,
                entity: lastLog ? lastLog.encounter_image : null
            }
        });

    } catch (err) {
        console.error("STATUS_ERROR:", err);
        res.status(500).json({ error: "Server malfunction." });
    }
});

// ==========================================
// ROUTE 2: //api/game/action - Master action route
// ==========================================
router.post('/action', async (req, res) => {
    const userId = req.user?.userId;
    const { action } = req.body || {};

    try {
        // --- 1. AUTH & INPUT VALIDATION ---
        if (!userId) {
            return res.status(401).json({ error: "Unauthorized." });
        }

        const normalizedAction = String(action || '').trim();

        if (!normalizedAction) {
            return res.status(400).json({ error: "action is required." });
        }

        // --- SOUL STREAM (death transition — bypass normal action pipeline) ---
        if (normalizedAction === SOUL_STREAM_ACTION) {
            const latestLife = await fetchLatestLifeForUser(userId);
            if (!latestLife) {
                return res.status(404).json({ error: "No life record found for this soul." });
            }
            if (Number(latestLife.is_alive) === 1) {
                return res.status(400).json({
                    error: "Your vessel still lives. The Soul Stream is only for the departed."
                });
            }
            const soulStreamPayload = await processSoulStreamTransition(userId, latestLife);
            return res.json(soulStreamPayload);
        }

        // --- 2. FETCH PLAYER STATE ---
        let player = await fetchActivePlayerState(userId);

        // --- 3. APPLY ACTION FLOW ---
        const actionFlow = await applyActionFlow({
            player,
            userId,
            action: normalizedAction,
            db
        });

        player = actionFlow.player;

        // --- 3.5. SHORT TERM MEMORY FETCH ---
        const [memoryRows] = await db.execute(`
            SELECT user_action, system_response 
            FROM action_logs 
            WHERE life_id = ? 
            ORDER BY created_at DESC 
            LIMIT 3
        `, [player.life_id]);

        let memoryContext = "";
        if (memoryRows.length > 0) {
            const chronologicalMemory = memoryRows.reverse();
            memoryContext = "\n--- SHORT TERM MEMORY (PAST EVENTS) ---\n";
            chronologicalMemory.forEach((log, index) => {
                const cleanResponse = log.system_response.replace(/\[.*?\]/g, '').substring(0, 150) + "..."; 
                memoryContext += `Past Turn ${index + 1} - Player did: "${log.user_action}". Result: "${cleanResponse}"\n`;
            });
            memoryContext += "[END MEMORY]\n";
        }

        // --- 4. BUILD AI RESPONSE ---
        // We now pass memoryContext to the builder
        const aiData = await buildAiGameResponse({
            player,
            action: normalizedAction,
            engineNotice: actionFlow.engineNotice,
            monsterContext: actionFlow.monsterContext,
            worldLore: actionFlow.worldLore,
            memoryContext: memoryContext,
            db
        });

        // --- 5. FINALIZE STATUS & CHOICES ---
        const finalData = finalizeChoicesAndStatus({
            aiResponse: aiData.aiResponse,
            monsterButtons: actionFlow.monsterButtons,
            player
        });

        // --- 6. SAVE UPDATED PLAYER STATE ---
        await saveUpdatedPlayerState({
            db,
            player,
            finalHp: finalData.finalHp,
            isAlive: finalData.isAlive
        });

        // --- 7. LOG ACTION RESULT ---
        await logActionResult({
            db,
            lifeId: player.life_id,
            action: normalizedAction,
            cleanStory: finalData.cleanStory,
            finalChoices: finalData.finalChoices,
            backgroundUrl: aiData.backgroundUrl,
            monsterImageUrl: actionFlow.monsterImageUrl
        });

        // --- 8. SEND RESPONSE ---
        return res.json({
            status: finalData.isAlive ? "ALIVE" : "DEAD",
            stats: {
                hp: finalData.finalHp,
                max_hp: player.max_hp,
                hunger: player.hunger,
                sp: player.sp || 0, // Fallback to prevent null errors
                level: player.current_level,
                xp: player.xp,
                next_mark: player.next_level_xp
            },
            // --- NEW: THE ENEMY HUD (DATABASE DRIVEN) ---
            enemy_stats: actionFlow.activeMonster ? {
                name: actionFlow.activeMonster.name,
                level: actionFlow.activeMonster.dynamic_level,
                hp: actionFlow.activeMonster.current_hp,
                max_hp: actionFlow.activeMonster.max_hp,
                rank: actionFlow.activeMonster.danger_rank,
                atk: Number(actionFlow.activeMonster.base_offense || 0),
                def: Number(actionFlow.activeMonster.base_defense || 0)
            } : null,
            // --------------------------------------------
            system_output: finalData.cleanStory,
            choices: finalData.finalChoices,
            visuals: {
                background: aiData.backgroundUrl,
                entity: actionFlow.monsterImageUrl
            }
        });

    } catch (err) {
        console.error("MASTER_ACTION_ERROR:", err);
        return res.status(500).json({ error: "System Error.", details: err.message });
    }
});

// ==========================================
// ROUTE 3: POST /reincarnate — choose vessel after Soul Stream
// ==========================================
router.post('/reincarnate', async (req, res) => {
    const userId = req.user?.userId;
    const vesselId = req.body?.vessel_id ?? req.body?.vesselId;

    if (!userId) {
        return res.status(401).json({ error: "Unauthorized." });
    }

    try {
        const payload = await rebirthWithVessel(userId, vesselId);
        return res.status(201).json(payload);
    } catch (err) {
        if (err.code === 'ALREADY_ALIVE') {
            return res.status(400).json({ error: "An active vessel already exists. Finish or lose that life first." });
        }
        if (err.code === 'SOUL_STREAM_REQUIRED') {
            return res.status(400).json({
                error: "Complete the Soul Stream transition before choosing a vessel."
            });
        }
        if (err.code === 'INVALID_VESSEL') {
            return res.status(400).json({ error: err.message });
        }
        if (err.code === 'NOT_FOUND') {
            return res.status(404).json({ error: err.message });
        }
        console.error("REBIRTH_ERROR:", err);
        return res.status(500).json({ error: "Rebirth failed.", details: err.message });
    }
});

// ==========================================
// ROUTE 4 & 5: Soul Library (meta shop) — /api/game/shop/*
// ==========================================
router.get('/shop/library', async (req, res) => {
    const userId = req.user?.userId;

    try {
        const data = await getShopInventory(userId, db);
        return res.json(data);
    } catch (err) {
        if (err.code === 'USER_NOT_FOUND' || err.code === 'INVALID_USER') {
            return res.status(404).json({ error: err.message });
        }
        console.error('SHOP_LIBRARY_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load Soul Library.', details: err.message });
    }
});

router.post('/shop/buy', async (req, res) => {
    const userId = req.user?.userId;
    const skillId = req.body?.skill_id ?? req.body?.skillId;

    try {
        const result = await purchaseSkill(userId, skillId, db);
        return res.status(200).json(result);
    } catch (err) {
        if (err.code === 'INVALID_USER' || err.code === 'INVALID_SKILL_ID') {
            return res.status(400).json({ error: err.message, code: err.code });
        }
        if (err.code === 'USER_NOT_FOUND') {
            return res.status(404).json({ error: err.message, code: err.code });
        }
        if (err.code === 'SKILL_NOT_FOUND') {
            return res.status(404).json({ error: err.message, code: err.code });
        }
        if (err.code === 'ALREADY_OWNED') {
            return res.status(409).json({ error: err.message, code: err.code });
        }
        if (err.code === 'INSUFFICIENT_KARMA') {
            return res.status(400).json({
                error: err.message,
                code: err.code,
                karma_balance: err.karma_balance,
                karma_required: err.karma_required
            });
        }
        console.error('SHOP_BUY_ERROR:', err);
        return res.status(500).json({ error: 'Purchase failed.', details: err.message });
    }
});

module.exports = router;