// backend/routes/gameRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');

const { fetchActivePlayerState, fetchLatestLifeForUser } = require('../utils/gameAction/fetchPlayerState');
const { applyActionFlow } = require('../utils/gameAction/applyActionFlow');
const {
    SOUL_STREAM_ACTION,
    processSoulStreamTransition,
    rebirthWithVessel,
    performReincarnationBirth,
    markAllCurrentLivesDead
} = require('../utils/reincarnationEngine');
const { buildAiGameResponse } = require('../utils/gameAction/buildAiGameResponse');
const { finalizeChoicesAndStatus } = require('../utils/gameAction/finalizeChoices');
const { saveUpdatedPlayerState } = require('../utils/gameAction/savePlayerState');
const { logActionResult } = require('../utils/gameAction/logActionResult');
const { getShopInventory, purchaseSkill } = require('../utils/meta/soulLibraryEngine');
const { buildPredictiveSuggestions } = require('../utils/gameAction/predictiveSuggestions');
const { resolvePendingMilestones } = require('../utils/storyMilestones');
const {
    fetchRecentDiscoveries,
    fetchActiveWorldFlags
} = require('../utils/worldBuilder/fetchCanonContext');
const { buildAndApplyWorldProposal } = require('../utils/worldBuilder/buildWorldProposal');
const { fetchNearbyNpcs, fetchNpcContext } = require('../utils/npc/fetchNpcContext');
const { buildNpcPromptContext } = require('../utils/npc/buildNpcPromptContext');
const { applyNpcInteractionOutcome } = require('../utils/npc/applyNpcInteractionOutcome');

/**
 * Layered visuals: background + side vessel sprite + encounter entity (matches `starting_vessels` by species).
 */
async function buildVisualsPayload(db, player, { backgroundUrl, entityUrl }) {
    let user_vessel = null;
    try {
        const species = String(player.species || '').trim();
        if (species) {
            const [rows] = await db.execute(
                'SELECT vessel_image FROM starting_vessels WHERE species = ? LIMIT 1',
                [species]
            );
            if (rows.length && rows[0].vessel_image) {
                user_vessel = rows[0].vessel_image;
            }
        }
    } catch (err) {
        console.error('VISUALS_VESSEL_LOOKUP:', err.message);
    }
    return {
        background: backgroundUrl || null,
        user_vessel: user_vessel,
        entity: entityUrl || null
    };
}

function buildStatsBlock(player, finalHp) {
    return {
        hp: finalHp,
        max_hp: player.max_hp,
        mp: player.mp,
        max_mp: player.max_mp,
        hunger: player.hunger,
        sp: player.sp || 0,
        max_sp: player.max_sp,
        level: player.current_level,
        xp: player.xp,
        next_mark: player.next_level_xp,
        attribute_points: player.attribute_points ?? 0,
        skill_points: player.skill_points ?? 0,
        offense: player.offense,
        defense: player.defense,
        magic_power: player.magic_power,
        resistance: player.resistance,
        speed: player.speed,
        species: player.species
    };
}

function parseLimit(value, fallback = 25, max = 100) {
    const n = Math.floor(Number(value));
    if (!Number.isFinite(n) || n <= 0) return fallback;
    return Math.min(max, n);
}

async function listCanonRows(table, orderColumn, limit) {
    const allowed = new Set([
        'world_regions',
        'world_places',
        'world_entities',
        'factions',
        'world_powers',
        'lore_entries'
    ]);
    if (!allowed.has(table)) {
        throw new Error('Invalid canon table.');
    }
    const [rows] = await db.execute(
        `SELECT * FROM ${table} ORDER BY ${orderColumn} DESC LIMIT ${limit}`
    );
    return rows;
}

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// AI Soul Scan (Reincarnation) — consolidated under /api/game/reincarnate/reincarnation/*
// ==========================================
router.get('/reincarnate/reincarnation/questions', async (req, res) => {
    try {
        const prompt = `
            [SYSTEM: INITIATING SOUL SCAN]
            Role: 'Voice of the Deep' (Cold, mechanical, objective).
            Task: Generate 3 deep psychological questions to judge a human soul before reincarnation.
            Each question must have exactly 3 options that lean toward:
            1. Predator (Aggression/Power)
            2. Prey (Caution/Protection)
            3. Scavenger (Survival/Resourcefulness)
            
            Format the response as a JSON array of objects:
            [
              { "id": 1, "text": "...", "options": ["...", "...", "..."] }
            ]
            Only return the JSON.
        `;

        const result = await model.generateContent(prompt);
        const aiResponse = result.response.text();

        const questions = JSON.parse(aiResponse.replace(/```json|```/g, '').trim());

        res.json({
            system_log: '[SCANNING NEURAL FRAGMENTS... SENSORS ACTIVE]',
            questions
        });
    } catch (err) {
        console.error('AI_QUESTION_ERROR:', err);
        res.status(500).json({ error: 'The Void is too unstable to scan your soul.' });
    }
});

router.post('/reincarnate/reincarnation', async (req, res) => {
    const userId = req.user?.userId;
    const { answers } = req.body;

    if (!userId || !answers || !Array.isArray(answers)) {
        return res.status(400).json({ error: 'Soul records incomplete. Neural sync failed.' });
    }

    try {
        const blueprintPrompt = `
            [SYSTEM ANALYSIS: SOUL SCAN RESULTS]
            The subject has provided the following responses to the psychological scan:
            ${JSON.stringify(answers)}

            TASK:
            1. Analyze the 'weight' and 'intent' of these responses.
            2. Determine if the soul leans toward Predator, Prey, or Scavenger.
            3. Construct a high-tier reincarnation blueprint based on these answers.
            
            Return ONLY a JSON object:
            {
              "path": "Predator | Prey | Scavenger",
              "species": "Unique Species Name",
              "location": "nadir_upper | crown_citadel | magma_layer | drowned_veins | nadir_lower",
              "hp": 120, "mp": 60, "offense": 25, "defense": 25, "speed": 25, "sp": 60
            }
        `;

        const bpResult = await model.generateContent(blueprintPrompt);
        const blueprint = JSON.parse(bpResult.response.text().trim().replace(/```json|```/g, ''));

        const conn = await db.getConnection();
        let newLifeId;
        let vessel;
        try {
            await conn.beginTransaction();

            await markAllCurrentLivesDead(conn, userId);

            vessel = await performReincarnationBirth(userId, blueprint.path, blueprint, conn);

            const [insertResult] = await conn.execute(
                `INSERT INTO current_life (
                    user_id, species, vessel_type, current_location, 
                    hp, max_hp, mp, max_mp, hunger, sp, max_sp, 
                    offense, defense, speed, is_alive
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)`,
                [
                    userId,
                    vessel.species,
                    blueprint.path,
                    vessel.starting_location,
                    vessel.base_hp,
                    vessel.base_hp,
                    vessel.base_mp,
                    vessel.base_mp,
                    100,
                    vessel.base_sp,
                    vessel.base_sp,
                    vessel.base_offense,
                    vessel.base_defense,
                    vessel.base_speed
                ]
            );

            newLifeId = insertResult.insertId;

            await conn.commit();
        } catch (err) {
            await conn.rollback();
            throw err;
        } finally {
            conn.release();
        }

        const [userRows] = await db.execute('SELECT system_voice FROM users WHERE id = ?', [userId]);
        const systemVoice = userRows[0]?.system_voice || 'ADMIN';

        const aiPrompt = buildSystemPrompt(
            {
                ...vessel,
                hp: vessel.base_hp,
                max_hp: vessel.base_hp,
                hunger: 100,
                sp: vessel.base_sp,
                current_level: 1,
                vessel_type: blueprint.path,
                system_voice: systemVoice
            },
            { description_seed: vessel.starting_location },
            'Soul Scan Completed. Identity Confirmed.',
            `The Voice of the Deep has processed your essence as ${blueprint.path}. Awakening as ${vessel.species} in ${vessel.starting_location}.`
        );

        const narrationResult = await model.generateContent(aiPrompt);
        const aiResponse = narrationResult.response.text();

        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        const choices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)].map((m) => m[1]);

        await db.execute(
            `INSERT INTO action_logs (life_id, user_action, system_response, choices) VALUES (?, ?, ?, ?)`,
            [newLifeId, 'System Judgment Awakening', cleanStory, JSON.stringify(choices)]
        );

        res.json({
            status: 'AWAKENED',
            judgment: {
                path: blueprint.path,
                location: vessel.starting_location,
                species: vessel.species
            },
            narration: cleanStory,
            choices,
            stats: {
                hp: vessel.base_hp,
                offense: vessel.base_offense,
                hunger: 100,
                sp: vessel.base_sp
            }
        });
    } catch (err) {
        console.error('REINCARNATION_CRITICAL_FAILURE:', err);
        res.status(500).json({ error: 'The System failed to finalize your soul judgment.' });
    }
});

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

        const visuals = await buildVisualsPayload(db, player, {
            backgroundUrl: lastLog ? lastLog.bg_image : null,
            entityUrl: lastLog ? lastLog.encounter_image : null
        });
        const [nearbyNpcs, activeWorldFlags, recentDiscoveries] = await Promise.all([
            fetchNearbyNpcs(db, userId, player, 6),
            fetchActiveWorldFlags(db, player, 6),
            fetchRecentDiscoveries(db, userId, player, 10)
        ]);

        res.json({
            player_state: player,
            recent_history: history.map(h => ({
                user_action: h.user_action,
                system_response: h.system_response
            })),
            choices: lastLog ? JSON.parse(lastLog.choices) : [],
            visuals,
            nearby_npcs: nearbyNpcs,
            active_world_flags: activeWorldFlags,
            recent_discoveries: recentDiscoveries
        });

    } catch (err) {
        console.error("STATUS_ERROR:", err);
        res.status(500).json({ error: "Server malfunction." });
    }
});

// ==========================================
// CANON + NPC READ ROUTES
// ==========================================
router.get('/canon/regions', async (req, res) => {
    try {
        const rows = await listCanonRows('world_regions', 'updated_at', parseLimit(req.query.limit));
        return res.json({ regions: rows });
    } catch (err) {
        console.error('CANON_REGIONS_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load regions.' });
    }
});

router.get('/canon/places', async (req, res) => {
    try {
        const rows = await listCanonRows('world_places', 'updated_at', parseLimit(req.query.limit));
        return res.json({ places: rows });
    } catch (err) {
        console.error('CANON_PLACES_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load places.' });
    }
});

router.get('/canon/entities', async (req, res) => {
    try {
        const rows = await listCanonRows('world_entities', 'updated_at', parseLimit(req.query.limit));
        return res.json({ entities: rows });
    } catch (err) {
        console.error('CANON_ENTITIES_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load entities.' });
    }
});

router.get('/canon/factions', async (req, res) => {
    try {
        const rows = await listCanonRows('factions', 'updated_at', parseLimit(req.query.limit));
        return res.json({ factions: rows });
    } catch (err) {
        console.error('CANON_FACTIONS_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load factions.' });
    }
});

router.get('/canon/powers', async (req, res) => {
    try {
        const rows = await listCanonRows('world_powers', 'updated_at', parseLimit(req.query.limit));
        return res.json({ powers: rows });
    } catch (err) {
        console.error('CANON_POWERS_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load powers.' });
    }
});

router.get('/canon/lore', async (req, res) => {
    try {
        const rows = await listCanonRows('lore_entries', 'updated_at', parseLimit(req.query.limit));
        return res.json({ lore: rows });
    } catch (err) {
        console.error('CANON_LORE_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load lore.' });
    }
});

router.get('/npcs/nearby', async (req, res) => {
    const userId = req.user.userId;
    try {
        const player = await fetchActivePlayerState(userId);
        const nearbyNpcs = await fetchNearbyNpcs(db, userId, player, parseLimit(req.query.limit, 6, 20));
        return res.json({ nearby_npcs: nearbyNpcs });
    } catch (err) {
        console.error('NEARBY_NPCS_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load nearby NPCs.', details: err.message });
    }
});

router.get('/npcs/:npcId', async (req, res) => {
    const userId = req.user.userId;
    try {
        const player = await fetchActivePlayerState(userId);
        const npc = await fetchNpcContext(db, userId, player, req.params.npcId);
        if (!npc) return res.status(404).json({ error: 'NPC not found.' });
        return res.json({ npc });
    } catch (err) {
        console.error('NPC_DETAIL_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load NPC.', details: err.message });
    }
});

router.get('/chronicle/recent', async (req, res) => {
    const userId = req.user.userId;
    try {
        const player = await fetchActivePlayerState(userId);
        const limit = parseLimit(req.query.limit, 12, 50);
        const [logs, events, discoveries] = await Promise.all([
            db.execute(
                `SELECT user_action, system_response, created_at
                 FROM action_logs
                 WHERE life_id = ?
                 ORDER BY created_at DESC
                 LIMIT ${limit}`,
                [player.life_id]
            ),
            db.execute(
                `SELECT *
                 FROM world_events
                 WHERE status IN ('rumor','active','resolved')
                 ORDER BY updated_at DESC
                 LIMIT 10`
            ),
            fetchRecentDiscoveries(db, userId, player, 10)
        ]);
        return res.json({
            action_history: logs[0],
            world_events: events[0],
            recent_discoveries: discoveries
        });
    } catch (err) {
        console.error('CHRONICLE_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load chronicle.', details: err.message });
    }
});

// ==========================================
// GET /api/game/context — story milestones for AI injection
// ==========================================
router.get('/context', async (req, res) => {
    const userId = req.user?.userId;

    if (!userId) {
        return res.status(401).json({ error: 'Unauthorized.' });
    }

    try {
        const player = await fetchActivePlayerState(userId);
        const data = await resolvePendingMilestones(db, userId, player);
        return res.json({
            story_injection: data.story_injection,
            milestones_fired: data.milestones_fired
        });
    } catch (err) {
        if (err.message === 'No active life found.') {
            return res.status(404).json({ error: 'No active vessel found.' });
        }
        console.error('CONTEXT_ERROR:', err);
        return res.status(500).json({ error: 'Failed to load story context.', details: err.message });
    }
});

// ==========================================
// POST /api/game/suggest — predictive action auto-complete (DB + Gemini)
// ==========================================
router.post('/suggest', async (req, res) => {
    const userId = req.user?.userId;
    const partial = String(req.body?.partial ?? req.body?.text ?? '').trim();

    if (!userId) {
        return res.status(401).json({ error: 'Unauthorized.' });
    }
    if (!partial) {
        return res.status(400).json({ error: 'partial (or text) is required.' });
    }

    try {
        const suggestions = await buildPredictiveSuggestions(db, model, userId, partial);
        return res.json({ suggestions });
    } catch (err) {
        if (err.message === 'No active life found.') {
            return res.status(404).json({ error: 'No active vessel found.' });
        }
        console.error('SUGGEST_ERROR:', err);
        return res.status(500).json({ error: 'Suggestion failed.', details: err.message });
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

        // --- EVOLUTION COMPLETE (no AI round — vessel already updated in applyActionFlow) ---
        if (actionFlow.evolutionResolved) {
            const finalData = finalizeChoicesAndStatus({
                aiResponse: actionFlow.evolutionStory || actionFlow.engineNotice,
                monsterButtons: [],
                player,
                evolutionNotice: '',
                evolutionChoices: []
            });

            const [evoLoc] = await db.execute(
                'SELECT location_image FROM location_seeds WHERE location_id = ?',
                [player.current_location]
            );
            const evolutionBg = evoLoc.length > 0 ? evoLoc[0].location_image : null;

            await saveUpdatedPlayerState({
                db,
                player,
                finalHp: finalData.finalHp,
                isAlive: finalData.isAlive
            });

            await logActionResult({
                db,
                lifeId: player.life_id,
                action: normalizedAction,
                cleanStory: finalData.cleanStory,
                finalChoices: finalData.finalChoices,
                backgroundUrl: evolutionBg,
                monsterImageUrl: null
            });

            const visuals = await buildVisualsPayload(db, player, {
                backgroundUrl: evolutionBg,
                entityUrl: null
            });

            return res.json({
                status: finalData.isAlive ? "ALIVE" : "DEAD",
                stats: buildStatsBlock(player, finalData.finalHp),
                level_up_notice: null,
                enemy_stats: null,
                system_output: finalData.cleanStory,
                choices: finalData.finalChoices,
                visuals,
                evolution_complete: true,
                discoveries: [],
                npc_reactions: [],
                canon_updates: [],
                active_world_flags: []
            });
        }

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

        // --- 3.7 STORY MILESTONES — after action flow (level/location match DB state) but before AI generation ---
        const accountId = req.user.userId ?? req.user.id;
        const { story_injection, milestones_fired } = await resolvePendingMilestones(db, accountId, player);
        const prioritizeLifeActions = !actionFlow.activeMonster;

        // --- 3.8 STRUCTURED CANON PIPELINE — world-builder mode, JSON only, DB validated ---
        const worldBuild = await buildAndApplyWorldProposal({
            db,
            player,
            userId,
            action: normalizedAction,
            engineNotice: actionFlow.engineNotice,
            storyContext: story_injection || '',
            actionFlow
        });

        const nearbyNpcs = await fetchNearbyNpcs(db, userId, player, 6);
        const npcPromptContext = buildNpcPromptContext({ nearbyNpcs });

        // --- 4. BUILD AI RESPONSE (Gemini) ---
        const aiData = await buildAiGameResponse({
            player,
            action: normalizedAction,
            engineNotice: actionFlow.engineNotice,
            monsterContext: actionFlow.monsterContext,
            worldLore: actionFlow.worldLore,
            memoryContext: memoryContext,
            canonContext: worldBuild.canonContext,
            npcPromptContext,
            canonUpdates: worldBuild.canonUpdates,
            db,
            storyContext: story_injection || '',
            prioritizeLifeActions
        });

        const levelUpNotice = actionFlow.levelUpNotice || '';

        // --- 5. FINALIZE STATUS & CHOICES ---
        const finalData = finalizeChoicesAndStatus({
            aiResponse: aiData.aiResponse,
            monsterButtons: actionFlow.monsterButtons,
            player,
            evolutionNotice: actionFlow.evolutionNotice || '',
            evolutionChoices: actionFlow.evolutionChoices || []
        });

        const npcReactions = await applyNpcInteractionOutcome({
            db,
            userId,
            player,
            action: normalizedAction,
            nearbyNpcs,
            sceneSummary: finalData.cleanStory
        });

        const [activeWorldFlags, recentDiscoveries] = await Promise.all([
            fetchActiveWorldFlags(db, player, 6),
            fetchRecentDiscoveries(db, userId, player, 10)
        ]);

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

        const visuals = await buildVisualsPayload(db, player, {
            backgroundUrl: aiData.backgroundUrl,
            entityUrl: actionFlow.monsterImageUrl
        });

        // --- 8. SEND RESPONSE ---
        return res.json({
            status: finalData.isAlive ? "ALIVE" : "DEAD",
            stats: buildStatsBlock(player, finalData.finalHp),
            level_up_notice: levelUpNotice || null,
            story_injection: story_injection || null,
            milestones_fired,
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
            visuals,
            discoveries: recentDiscoveries,
            npc_reactions: npcReactions,
            canon_updates: worldBuild.canonUpdates,
            active_world_flags: activeWorldFlags
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
