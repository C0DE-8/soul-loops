const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { verifyToken } = require('../middleware/auth');

router.use(verifyToken);

// ==========================================
// 1. GET PENDING CHALLENGES
// ==========================================
router.get('/pending', async (req, res) => {
    const userId = req.user.userId;
    try {
        const [rows] = await db.execute(`
            SELECT d.duel_id, u.username as partner_name, d.duel_type, d.created_at,
            CASE WHEN d.challenger_id = ? THEN 'OUTGOING' ELSE 'INCOMING' END as direction
            FROM duel_challenges d
            JOIN users u ON (d.challenger_id = u.id AND d.target_id = ?) OR (d.target_id = u.id AND d.challenger_id = ?)
            WHERE (d.challenger_id = ? OR d.target_id = ?) AND d.status = 'PENDING' AND u.id != ?`,
            [userId, userId, userId, userId, userId, userId]
        );
        res.json({ pending_duels: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve duel matrix." });
    }
});

// ==========================================
// 2. SEND CHALLENGE (Only Busy if status is 'ACCEPTED')
// ==========================================
router.post('/challenge', async (req, res) => {
    const challengerId = req.user.userId;
    const { targetUsername, duelType } = req.body; 

    try {
        // 1. Find Target ID
        const [targetRows] = await db.execute('SELECT id FROM users WHERE username = ?', [targetUsername]);
        if (!targetRows.length) return res.status(404).json({ error: "Target soul not found." });
        const targetId = targetRows[0].id;

        if (challengerId === targetId) return res.status(400).json({ error: "You cannot challenge your own soul." });

        // 2. BUSY CHECK: Only block if someone is ALREADY IN A FIGHT (ACCEPTED)
        const [busyRows] = await db.execute(`
            SELECT duel_id FROM duel_challenges 
            WHERE (challenger_id IN (?, ?) OR target_id IN (?, ?)) 
            AND status = 'ACCEPTED'`,
            [challengerId, targetId, challengerId, targetId]
        );

        if (busyRows.length > 0) {
            return res.status(403).json({ 
                error: "[SYSTEM ERROR]: Combat ongoing. One or both souls are currently locked in an active duel." 
            });
        }

        // 3. Social Check (Bond must be ACCEPTED)
        const [rel] = await db.execute(
            'SELECT bond_type FROM relationships WHERE user_id = ? AND target_id = ? AND status = "ACCEPTED"',
            [challengerId, targetId]
        );
        if (!rel.length) return res.status(403).json({ error: "No established bond found. Set as FRIEND or RIVAL first." });

        // 4. Insert the challenge
        const [result] = await db.execute(
            'INSERT INTO duel_challenges (challenger_id, target_id, duel_type) VALUES (?, ?, ?)',
            [challengerId, targetId, duelType]
        );
        
        res.json({ 
            message: `[SYSTEM]: Duel challenge sent to ${targetUsername}. Mode: ${duelType}`, 
            duel_id: result.insertId 
        });

    } catch (err) {
        console.error("CHALLENGE_ERROR:", err);
        res.status(500).json({ error: "Failed to broadcast duel challenge." });
    }
});


// ==========================================
// 1. GET DUEL STATUS (With Turn-Based Choice Hiding)
// ==========================================
router.get('/status/:duelId', async (req, res) => {
    const userId = req.user.userId;
    const duelId = req.params.duelId;

    try {
        const [duelRows] = await db.execute('SELECT * FROM duel_challenges WHERE duel_id = ?', [duelId]);
        if (!duelRows.length) return res.status(404).json({ error: "Duel not found." });
        const duel = duelRows[0];

        const [p1] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [duel.challenger_id]);
        const [p2] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [duel.target_id]);

        const [historyRows] = await db.execute(
            'SELECT actor_id, action_text, system_description, choices FROM duel_actions WHERE duel_id = ? ORDER BY created_at ASC',
            [duelId]
        );

        // --- TURN LOGIC FOR CHOICES ---
        const lastAction = historyRows[historyRows.length - 1];
        let currentChoices = [];
        let isMyTurn = false;

        if (lastAction) {
            const lastActorId = lastAction.actor_id;
            const lastText = lastAction.action_text;

            // 1. If it just started (ACCEPTED CHALLENGE), only the Challenger (Player A) gets choices
            if (lastText === "ACCEPTED CHALLENGE") {
                if (userId === duel.challenger_id) {
                    isMyTurn = true;
                }
            } 
            // 2. Otherwise, if the last person to move WAS NOT YOU, it is now your turn
            else if (lastActorId !== userId) {
                isMyTurn = true;
            }

            // 3. ONLY send the choices if it is actually the user's turn
            if (isMyTurn && lastAction.choices) {
                currentChoices = JSON.parse(lastAction.choices);
            }
        }

        res.json({
            duel_info: duel,
            is_my_turn: isMyTurn, // Useful for the React Frontend to show/hide the menu
            challenger: p1[0],
            defender: p2[0],
            combat_log: historyRows.map(h => ({
                actor_id: h.actor_id,
                action_text: h.action_text,
                system_description: h.system_description
                // We exclude 'choices' from the history to keep it clean
            })),
            choices: currentChoices 
        });

    } catch (err) {
        console.error("DUEL_STATUS_ERROR:", err);
        res.status(500).json({ error: "Failed to sync duel state." });
    }
});

// ==========================================
// 3. THE DUEL ACTION LOOP (Strict Turn-Based)
// ==========================================
router.post('/duel-action', async (req, res) => {
    const userId = req.user.userId;
    const { duelId, playerAction } = req.body;

    try {
        // 1. Fetch Duel State
        const [duel] = await db.execute(
            'SELECT * FROM duel_challenges WHERE duel_id = ? AND status = "ACCEPTED"', 
            [duelId]
        );
        if (!duel.length) return res.status(404).json({ error: "No active duel found." });
        const d = duel[0];

        // 2. TURN GATEKEEPER: Check who moved last
        const [lastAction] = await db.execute(
            'SELECT actor_id FROM duel_actions WHERE duel_id = ? ORDER BY created_at DESC LIMIT 1',
            [duelId]
        );

        if (lastAction.length > 0 && lastAction[0].actor_id === userId) {
            return res.status(403).json({ 
                error: "[SYSTEM]: Patience, soul. It is not your turn to act." 
            });
        }

        // 3. Identify Combatants
        const opponentId = (userId === d.challenger_id) ? d.target_id : d.challenger_id;
        const [p1] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [userId]);
        const [p2] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [opponentId]);
        
        const player = p1[0];
        const opponent = p2[0];

        // 4. AI Narration
        const duelPrompt = `
            [SYSTEM: PVP DUEL TURN]
            Mode: ${d.duel_type}
            Actor: ${player.username} (${player.species}) HP: ${player.hp}
            Target: ${opponent.username} (${opponent.species}) HP: ${opponent.hp}
            Action Taken: "${playerAction}"
            
            1. Narrate the result in a mechanical, cold style.
            2. Update target's HP: [HP_SET: X]
            3. Provide 3 choices for the NEXT player: [CHOICE_1: ...][CHOICE_2: ...][CHOICE_3: ...]
        `;

        const result = await model.generateContent(duelPrompt);
        const aiResponse = result.response.text();

        // 5. Parse Data
        let targetNewHp = opponent.hp;
        const hpMatch = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
        if (hpMatch) targetNewHp = parseInt(hpMatch[1], 10);

        let uiChoices = [];
        const choiceMatches = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)];
        choiceMatches.forEach(match => uiChoices.push(match[1]));

        // 6. DB Updates (HP & Rumors)
        await db.execute('UPDATE current_life SET hp = ? WHERE user_id = ?', [Math.max(0, targetNewHp), opponentId]);

        let isOver = targetNewHp <= 0;
        if (isOver) {
            await db.execute('UPDATE duel_challenges SET status = "COMPLETED" WHERE duel_id = ?', [duelId]);
            if (d.duel_type === 'TO_DEATH') {
                await db.execute('UPDATE current_life SET is_alive = 0 WHERE user_id = ?', [opponentId]);
                const worldRumor = `${opponent.username} was eradicated by ${player.username} in a duel to the death.`;
                await db.execute(
                    'INSERT INTO reincarnated_npcs (original_name, new_name, current_species, status_log, current_location) VALUES (?, ?, ?, ?, ?)',
                    [opponent.username, 'DECEASED', opponent.species, worldRumor, player.current_location]
                );
            }
        }

        // 7. Log Action (Including the choices for the next player)
        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        await db.execute(
            'INSERT INTO duel_actions (duel_id, actor_id, action_text, system_description, choices) VALUES (?, ?, ?, ?, ?)',
            [duelId, userId, playerAction, cleanStory, JSON.stringify(uiChoices)]
        );

        res.json({
            system_output: cleanStory,
            choices: uiChoices,
            is_over: isOver,
            next_turn_for: opponent.username
        });

    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Combat engine failure." });
    }
});

// ==========================================
// 2. ACCEPT DUEL (Debugged & Verified)
// ==========================================
router.post('/accept/:duelId', async (req, res) => {
    const userId = req.user.userId;
    const duelId = req.params.duelId;

    try {
        // 1. Fetch Challenge
        const [duel] = await db.execute(
            'SELECT * FROM duel_challenges WHERE duel_id = ? AND target_id = ? AND status = "PENDING"', 
            [duelId, userId]
        );
        
        if (!duel.length) return res.status(404).json({ error: "Challenge not found." });
        const d = duel[0];

        // 2. Fetch Player Data for AI Context
        const [p1] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [d.challenger_id]);
        const [p2] = await db.execute('SELECT c.*, u.username FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.user_id = ?', [userId]);

        if (!p1.length || !p2.length) return res.status(400).json({ error: "One combatant is no longer alive." });

        const challenger = p1[0];
        const defender = p2[0];

        // 3. Call AI
        const introPrompt = `
            [SYSTEM: DUEL COMMENCEMENT]
            Location: ${challenger.current_location}
            Mode: ${d.duel_type}
            Combatant A: ${challenger.username} (${challenger.species})
            Combatant B: ${defender.username} (${defender.species})
            
            Narrate the meeting and provide exactly 3 tactical choices: [CHOICE_1: ...][CHOICE_2: ...][CHOICE_3: ...]
        `;

        const result = await model.generateContent(introPrompt);
        const aiResponse = result.response.text();

        // 4. Parse Choices
        let initialChoices = [];
        const choiceMatches = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)];
        choiceMatches.forEach(match => initialChoices.push(match[1]));

        // If AI failed to give choices, we provide fallbacks so the game doesn't break
        if (initialChoices.length === 0) initialChoices = ["Engage", "Observe", "Intimidate"];

        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();

        // 5. Database Transaction (Update & Log)
        await db.execute('UPDATE duel_challenges SET status = "ACCEPTED" WHERE duel_id = ?', [duelId]);

        await db.execute(
            'INSERT INTO duel_actions (duel_id, actor_id, action_text, system_description, choices) VALUES (?, ?, ?, ?, ?)',
            [duelId, userId, "ACCEPTED CHALLENGE", cleanStory, JSON.stringify(initialChoices)]
        );

        res.json({ 
            message: "Duel Accepted.", 
            system_output: cleanStory, 
            choices: initialChoices 
        });

    } catch (err) {
        // This will print the SPECIFIC SQL error in your terminal
        console.error("DETAILED_ACCEPT_ERROR:", err.message);
        res.status(500).json({ error: "Internal Server Error", detail: err.message });
    }
});

router.post('/reject/:duelId', async (req, res) => {
    try {
        await db.execute('UPDATE duel_challenges SET status = "REJECTED" WHERE duel_id = ? AND target_id = ?', [req.params.duelId, req.user.userId]);
        res.json({ message: "Duel Declined." });
    } catch (err) { res.status(500).json({ error: "Reject failed." }); }
});

// ==========================================
// 7. AUTO-RESOLVE TURN (The 15-Second Janitor)
// ==========================================
router.post('/auto-play/:duelId', async (req, res) => {
    const duelId = req.params.duelId;

    try {
        // 1. Get Duel and check timing
        const [duel] = await db.execute(
            'SELECT *, TIMESTAMPDIFF(SECOND, last_action_at, NOW()) as seconds_passed FROM duel_challenges WHERE duel_id = ? AND status = "ACCEPTED"',
            [duelId]
        );

        if (!duel.length) return res.status(404).json({ error: "No active duel found." });
        const d = duel[0];

        if (d.seconds_passed < 15) {
            return res.status(400).json({ error: `Timer has not expired. ${15 - d.seconds_passed}s remaining.` });
        }

        // 2. Identify the AFK Player (The one who is supposed to move)
        const [lastAction] = await db.execute(
            'SELECT actor_id, action_text, choices FROM duel_actions WHERE duel_id = ? ORDER BY created_at DESC LIMIT 1',
            [duelId]
        );

        if (!lastAction.length) return res.status(500).json({ error: "Combat state corrupted." });

        const lastMove = lastAction[0];
        let afkUserId;

        // Logic to find who is AFK
        if (lastMove.action_text === "ACCEPTED CHALLENGE") {
            // If it just started, the Challenger is the one taking too long
            afkUserId = d.challenger_id;
        } else {
            // Otherwise, it's the person who DIDN'T make the last move
            afkUserId = (lastMove.actor_id === d.challenger_id) ? d.target_id : d.challenger_id;
        }

        // 3. Pick a random choice from the last AI set
        const choices = JSON.parse(lastMove.choices || '[]');
        if (choices.length === 0) return res.status(500).json({ error: "No choices available for auto-play." });
        
        const randomChoice = choices[Math.floor(Math.random() * choices.length)];
        const autoActionDescription = `[SYSTEM FORCED]: Due to soul hesitation, instinct takes over: ${randomChoice}`;

        // 4. Update the DB to reset the timer (Prevent infinite loops)
        await db.execute('UPDATE duel_challenges SET last_action_at = NOW() WHERE duel_id = ?', [duelId]);

        // 5. Return info to the Frontend
        // IMPORTANT: In a real flow, you should now call your Duel AI logic here 
        // to actually subtract HP and generate the NEXT story part.
        res.json({ 
            message: "[SYSTEM]: Turn timer expired.",
            afk_player_id: afkUserId,
            forced_action: randomChoice,
            narrative: autoActionDescription
        });

    } catch (err) {
        console.error("AUTO_PLAY_ERROR:", err);
        res.status(500).json({ error: "Janitor system failed to resolve turn." });
    }
});

module.exports = router;