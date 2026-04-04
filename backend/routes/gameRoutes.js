const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// ROUTE 1: GET CURRENT STATUS (CLEAN VERSION)
// ==========================================
router.get('/status', async (req, res) => {
    const userId = req.user.userId;

    try {
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, s.permanent_skills 
            FROM current_life c 
            JOIN users u ON c.user_id = u.id 
            JOIN soul_library s ON c.user_id = s.user_id 
            WHERE c.user_id = ? AND c.is_alive = 1`, 
            [userId]
        );
        
        if (!playerRows.length) return res.status(404).json({ error: "No active life found." });
        const player = playerRows[0];

        // Fetch logs with Visuals
        const [logRows] = await db.execute(`
            SELECT user_action, system_response, choices, bg_image, encounter_image 
            FROM action_logs 
            WHERE life_id = ? ORDER BY created_at DESC LIMIT 5`,
            [player.life_id]
        );

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
// ROUTE 2: REINCARNATE (Upgraded with Gacha Pool)
// ==========================================
router.post('/reincarnate', async (req, res) => {
    const userId = req.user.userId;
    const { soulChoice } = req.body; // e.g., 'Scavenger', 'Predator', 'Prey'

    try {
        // 1. Pull a random starting body from the database based on their choice
        const [vesselRows] = await db.execute(
            'SELECT * FROM starting_vessels WHERE soul_path = ? ORDER BY RAND() LIMIT 1',
            [soulChoice]
        );

        // Fallback just in case they send a weird word
        const startingBody = vesselRows.length > 0 ? vesselRows[0] : {
            species: 'Glitch Slime', base_hp: 1, base_mp: 1, starting_location: 'elroe_upper'
        };

        // 2. Mark old bodies as dead
        await db.execute('UPDATE current_life SET is_alive = 0 WHERE user_id = ?', [userId]);

        // 3. Insert the new random body into the world
        const [resultDb] = await db.execute(
            'INSERT INTO current_life (user_id, species, current_location, hp, max_hp, mp, max_mp) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [
                userId, 
                startingBody.species, 
                startingBody.starting_location, 
                startingBody.base_hp, 
                startingBody.base_hp, 
                startingBody.base_mp, 
                startingBody.base_mp
            ]
        );
        const newLifeId = resultDb.insertId; 
        
        // 4. Ask Gemini to narrate the awakening
        const prompt = `A soul resonates with the ${soulChoice} path. They awaken as a ${startingBody.species} in the ${startingBody.starting_location}. Describe their confusing awakening in a cold, mechanical system voice and provide 3 choices.`;
        const result = await model.generateContent(prompt);
        const cleanStory = result.response.text();

        // 5. Save the history
        await db.execute(
            'INSERT INTO action_logs (life_id, user_action, system_response) VALUES (?, ?, ?)',
            [newLifeId, 'System Awakening', cleanStory]
        );
        
        // 6. Send it to the player
        res.json({ 
            species_assigned: startingBody.species,
            system_output: cleanStory 
        });

    } catch (err) {
        console.error("REINCARNATE ERROR:", err);
        res.status(500).json({ error: err.message });
    }
});

// ==========================================
// THE MASTER ACTION LOOP (PvP + PvE + Rumors)
// ==========================================
router.post('/action', async (req, res) => {
    const userId = req.user.userId; 
    const { action } = req.body;

    try {
        // --- 1. DATA SYNC: Fetch Player, Soul, and Current Location ---
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, s.permanent_skills 
            FROM current_life c 
            JOIN users u ON c.user_id = u.id 
            JOIN soul_library s ON c.user_id = s.user_id 
            WHERE c.user_id = ? AND c.is_alive = 1`, 
            [userId]
        );
        
        if (!playerRows.length) return res.status(404).json({ error: "No active life found." });
        const player = playerRows[0];

        // --- 2. FETCH LOCATION VISUALS (Background) ---
        const [locRows] = await db.execute(
            'SELECT location_image FROM location_seeds WHERE location_name = ?', 
            [player.current_location]
        );
        const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;

        // --- 3. ADMIN CHEAT INTERCEPT ---
        if (action.toLowerCase() === "i devour the system") {
            const cheatSkills = ["Immortality LV 10", "System Override", "Instant Death Magic"];
            const cheatChoices = ["Destroy the Labyrinth", "Summon a Dragon", "Teleport to the Surface"];
            
            await db.execute('UPDATE current_life SET hp = 9999, mp = 9999, current_level = 100 WHERE life_id = ?', [player.life_id]);
            await db.execute('UPDATE soul_library SET permanent_skills = ? WHERE user_id = ?', [JSON.stringify(cheatSkills), userId]);
            
            const godMsg = `[CRITICAL WARNING] FIREWALL BREACHED. Administrator status restored. Matrix absorbed.`;
            
            // Log with the current background
            await db.execute(
                'INSERT INTO action_logs (life_id, user_action, system_response, choices, bg_image) VALUES (?, ?, ?, ?, ?)',
                [player.life_id, action, godMsg, JSON.stringify(cheatChoices), backgroundUrl]
            );

            return res.json({ 
                status: "ALIVE", 
                stats: { hp: 9999, mp: 9999, level: 100 }, 
                skills: cheatSkills, 
                choices: cheatChoices, 
                system_output: godMsg,
                visuals: { background: backgroundUrl, entity: null }
            });
        }

        // --- 4. PvP DETECTION ---
        const [nearby] = await db.execute(`
            SELECT u.username, c.species, c.current_level 
            FROM current_life c JOIN users u ON c.user_id = u.id 
            WHERE c.pos_x = ? AND c.pos_y = ? AND c.is_alive = 1 AND c.user_id != ?`,
            [player.pos_x, player.pos_y, userId]
        );

        let pvpContext = "";
        let pvpButtons = [];
        if (nearby.length > 0) {
            const opp = nearby[0];
            pvpContext = `[PVP DETECTED: Soul ${opp.username} the ${opp.species} is at these coordinates]. `;
            pvpButtons.push(`Challenge ${opp.username} to a Duel`);
        }

        // --- 5. PvE DETECTION (Monster Spawn + Visuals) ---
        let monsterContext = "";
        let monsterButtons = [];
        let monsterImageUrl = null;
        const [spawns] = await db.execute(`
            SELECT m.* FROM zone_spawns z 
            JOIN master_npcs m ON z.npc_id = m.id 
            WHERE z.zone_name = ? AND RAND()*100 <= z.spawn_chance 
            LIMIT 1`, 
            [player.current_location]
        );

        if (spawns.length > 0) {
            const m = spawns[0];
            monsterContext = `[ENCOUNTER: WILD ${m.name} (${m.danger_rank})]. ${m.description}. `;
            monsterButtons.push(`Attack the ${m.name}`);
            monsterImageUrl = m.npc_image; // The visual for the monster
        }

        // --- 6. GLOBAL RUMOR SYSTEM ---
        const [news] = await db.execute('SELECT * FROM reincarnated_npcs ORDER BY RAND() LIMIT 1');
        let worldLore = news.length > 0 ? `[GLOBAL NEWS: Subject '${news[0].original_name}' ${news[0].status_log}].` : "";

        // --- 7. AI ENGINE CALL ---
        const fullContext = `${pvpContext}${monsterContext}${worldLore}`;
        const promptContext = buildSystemPrompt(player, { description_seed: player.current_location }, action, fullContext);

        const result = await model.generateContent(promptContext);
        const aiResponse = result.response.text();

        // --- 8. PARSING LOGIC (Stats & Skills) ---
        let newHp = player.hp, newMp = player.mp, isAlive = true;
        let currentSkills = [];
        try { currentSkills = JSON.parse(player.permanent_skills || '[]'); } catch(e) { currentSkills = []; }

        const hpM = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
        if (hpM) newHp = parseInt(hpM[1], 10);
        const mpM = aiResponse.match(/\[MP_SET:\s*(\d+)\]/);
        if (mpM) newMp = parseInt(mpM[1], 10);

        if (newHp <= 0 || aiResponse.includes("[STATUS: DECEASED]")) { isAlive = false; newHp = 0; }

        const skillM = [...aiResponse.matchAll(/\[NEW_SKILL:\s*(.*?)\]/g)];
        skillM.forEach(m => { if (!currentSkills.includes(m[1])) currentSkills.push(m[1]); });

        const choiceM = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)];
        let aiChoices = choiceM.map(m => m[1]);

        // Merge buttons: Duel/Attack take priority
        const finalChoices = [...pvpButtons, ...monsterButtons, ...aiChoices].slice(0, 4);

        // --- 9. FINAL DB UPDATE ---
        await db.execute(
            'UPDATE current_life SET hp = ?, mp = ?, is_alive = ?, current_level = current_level + 1 WHERE life_id = ?', 
            [newHp, newMp, isAlive ? 1 : 0, player.life_id]
        );
        await db.execute('UPDATE soul_library SET permanent_skills = ? WHERE user_id = ?', [JSON.stringify(currentSkills), userId]);
        
        if (!isAlive) await db.execute('UPDATE soul_library SET death_count = death_count + 1 WHERE user_id = ?', [userId]);

        // --- 10. CLEAN STORY & LOGGING ---
        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        
        // We log the images so the /status route can see them too!
        await db.execute(
            'INSERT INTO action_logs (life_id, user_action, system_response, choices, bg_image, encounter_image) VALUES (?, ?, ?, ?, ?, ?)',
            [player.life_id, action, cleanStory, JSON.stringify(finalChoices), backgroundUrl, monsterImageUrl]
        );

        res.json({ 
            status: isAlive ? "ALIVE" : "DEAD",
            stats: { hp: newHp, mp: newMp, level: player.current_level + 1 },
            skills: currentSkills,
            choices: finalChoices, 
            system_output: cleanStory,
            visuals: {
                background: backgroundUrl,
                entity: monsterImageUrl
            }
        });

    } catch (err) {
        console.error("ACTION_ERROR:", err);
        res.status(500).json({ error: "Voice of the World disconnected." });
    }
});



module.exports = router;