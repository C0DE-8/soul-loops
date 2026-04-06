// backend/routes/gameRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken } = require('../middleware/auth');

const { fetchActivePlayerState } = require('../utils/gameAction/fetchPlayerState');
const { applyActionFlow } = require('../utils/gameAction/applyActionFlow');
const { buildAiGameResponse } = require('../utils/gameAction/buildAiGameResponse');
const { finalizeChoicesAndStatus } = require('../utils/gameAction/finalizeChoices');
const { saveUpdatedPlayerState } = require('../utils/gameAction/savePlayerState');
const { logActionResult } = require('../utils/gameAction/logActionResult');

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

module.exports = router;