const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken, verifyAdmin } = require('../middleware/auth');
const upload = require('../utils/uploadService');
const { refreshSoulRankAndMirrorKarma } = require('../utils/soulProgression'); 

router.use(verifyToken, verifyAdmin);
const getDynamicUrl = (req) => `${req.protocol}://${req.get('host')}`;

// ==========================================
// --- SECTION 1: MASTER NPC BESTIARY ---
// ==========================================

// [GET ALL NPCs]
router.get('/npcs', async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM master_npcs ORDER BY id DESC');
        res.json({ system_status: "SYNCHRONIZED", master_npcs: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve the Bestiary." });
    }
});

// [ADD NEW NPC]
router.post('/npcs/add', upload.single('image'), async (req, res) => {
    const { name, species_type, base_hp, base_level, danger_rank, description } = req.body;

    try {
        let imageUrl = null;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        const [result] = await db.execute(
            'INSERT INTO master_npcs (name, species_type, base_hp, base_level, danger_rank, description, npc_image) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [name, species_type, base_hp, base_level, danger_rank, description, imageUrl]
        );

        res.json({ 
            message: `[SYSTEM: MANIFESTED] Entity '${name}' added to Bestiary.`,
            npc_id: result.insertId,
            npc_image: imageUrl
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Manifestation failure." });
    }
});

// [UPDATE NPC]
router.post('/npcs/update/:id', upload.single('image'), async (req, res) => {
    const npcId = req.params.id;
    const { name, species_type, base_hp, base_level, danger_rank, description } = req.body;

    try {
        const [current] = await db.execute('SELECT npc_image FROM master_npcs WHERE id = ?', [npcId]);
        if (!current.length) return res.status(404).json({ error: "Entity not found." });

        let imageUrl = current[0].npc_image;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        await db.execute(
            'UPDATE master_npcs SET name = ?, species_type = ?, base_hp = ?, base_level = ?, danger_rank = ?, description = ?, npc_image = ? WHERE id = ?',
            [name, species_type, base_hp, base_level, danger_rank, description, imageUrl, npcId]
        );

        res.json({ message: `[SYSTEM: UPDATED] Entity '${name}' reconfiguration successful.` });
    } catch (err) {
        res.status(500).json({ error: "Update failure." });
    }
});


// ==========================================
// --- SECTION 2: LOCATION & WORLD SEEDS ---
// ==========================================

// [GET ALL LOCATIONS] - Now includes Region and Depth info
router.get('/locations', async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM location_seeds ORDER BY region_name, level_depth ASC');
        res.json({ system_status: "SYNCHRONIZED", location_seeds: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve World Map." });
    }
});

// [ADD NEW LOCATION] - Manifesting a new zone with Regional data
router.post('/locations/add', upload.single('image'), async (req, res) => {
    const { 
        location_id, 
        description_seed, 
        danger_level, 
        region_name, 
        level_depth 
    } = req.body;

    try {
        let imageUrl = null;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        await db.execute(
            `INSERT INTO location_seeds 
            (location_id, description_seed, danger_level, region_name, level_depth, location_image) 
            VALUES (?, ?, ?, ?, ?, ?)`,
            [location_id, description_seed, danger_level, region_name || 'nadir_labyrinth', level_depth || 0, imageUrl]
        );

        res.json({ 
            message: `[SYSTEM: STABILIZED] Zone '${location_id}' manifested in region '${region_name}'.`,
            location_id,
            location_image: imageUrl
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Zone stabilization failure." });
    }
});

// [UPDATE LOCATION] - Reconfiguring an existing floor
router.post('/locations/update/:id', upload.single('image'), async (req, res) => {
    const locId = req.params.id;
    const { description_seed, danger_level, region_name, level_depth } = req.body;

    try {
        const [current] = await db.execute('SELECT location_image FROM location_seeds WHERE location_id = ?', [locId]);
        if (!current.length) return res.status(404).json({ error: "Zone not found." });

        let imageUrl = current[0].location_image;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        await db.execute(
            `UPDATE location_seeds SET 
            description_seed = ?, danger_level = ?, region_name = ?, level_depth = ?, location_image = ? 
            WHERE location_id = ?`,
            [description_seed, danger_level, region_name, level_depth, imageUrl, locId]
        );

        res.json({ message: `[SYSTEM: RECONFIGURED] Zone '${locId}' updated.` });
    } catch (err) {
        res.status(500).json({ error: "Map update failure." });
    }
});

// ==========================================
// --- SECTION 2.5: LOCATION CONNECTORS ---
// ==========================================
// This is the "Wire" management to connect Floors

// [GET ALL CONNECTORS]
router.get('/connectors', async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM location_connectors');
        res.json({ system_status: "SYNCHRONIZED", world_paths: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve World Connectors." });
    }
});

// [ADD CONNECTOR] - Manifesting paths with Duplicate Protection
router.post('/connectors/add', async (req, res) => {
    const { from_location, to_location, direction, min_level_req } = req.body;

    const validDirections = ['UP', 'DOWN', 'NORTH', 'SOUTH', 'EAST', 'WEST', 'LEFT', 'RIGHT'];
    const dir = direction ? direction.toUpperCase() : null;

    if (!dir || !validDirections.includes(dir)) {
        return res.status(400).json({ error: `Invalid direction. Use: ${validDirections.join(', ')}` });
    }

    try {
        // --- 1. DUPLICATE CHECK ---
        const [existing] = await db.execute(
            'SELECT * FROM location_connectors WHERE from_location = ? AND direction = ?',
            [from_location, dir]
        );

        if (existing.length > 0) {
            return res.status(400).json({ 
                error: `[SYSTEM ERROR]: A path going ${dir} already exists for ${from_location}.` 
            });
        }

        // --- 2. INSERT IF UNIQUE ---
        const [result] = await db.execute(
            'INSERT INTO location_connectors (from_location, to_location, direction, min_level_req) VALUES (?, ?, ?, ?)',
            [from_location, to_location, dir, min_level_req || 1]
        );

        res.json({ 
            message: `[SYSTEM: LINKED] Path manifested: ${from_location} --[${dir}]--> ${to_location}`,
            connector_id: result.insertId 
        });

    } catch (err) {
        console.error("CONNECTOR_ERROR:", err);
        // Catching the SQL Unique constraint just in case the JS check misses it
        if (err.code === 'ER_DUP_ENTRY') {
            return res.status(400).json({ error: "This path configuration already exists in the database." });
        }
        res.status(500).json({ error: "Path link failure. System instability detected." });
    }
});

// [DELETE CONNECTOR] - Removing a path/collapsing a tunnel
router.delete('/connectors/delete/:id', async (req, res) => {
    const connectorId = req.params.id;
    try {
        await db.execute('DELETE FROM location_connectors WHERE connector_id = ?', [connectorId]);
        res.json({ message: `[SYSTEM: COLLAPSED] Path ID: ${connectorId} removed.` });
    } catch (err) {
        res.status(500).json({ error: "Path removal failure." });
    }
});

// [GET] Sorted World Map to see your 0, 0, 3 layout clearly
router.get('/world-map/structure', async (req, res) => {
    try {
        const [rows] = await db.execute(`
            SELECT location_id, region_name, level_depth, danger_level 
            FROM location_seeds 
            ORDER BY level_depth ASC, danger_level DESC
        `);
        // This will show your two '0' depth floors first, then the '3' depth floor
        res.json({ map_layout: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to render map structure." });
    }
});

// [POST] Create the "Jump" Connector
router.post('/connectors/shortcut', async (req, res) => {
    const { from_0, to_3 } = req.body; // e.g., 'nadir_upper' to 'deep_abyss'
    try {
        await db.execute(
            'INSERT INTO location_connectors (from_location, to_location, direction, min_level_req) VALUES (?, ?, "DOWN", 10)',
            [from_0, to_3]
        );
        res.json({ message: "[SYSTEM: VOID LINKED] A direct path from Depth 0 to Depth 3 has been manifested." });
    } catch (err) {
        res.status(500).json({ error: "Failed to create shortcut." });
    }
});

// ==========================================
// --- SECTION 4: STARTING VESSELS ---
// ==========================================

// [GET ALL VESSELS]
router.get('/vessels', async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM starting_vessels ORDER BY vessel_id ASC');
        res.json({ system_status: "SYNCHRONIZED", starting_vessels: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve the Vessel Library." });
    }
});

// [ADD NEW STARTING VESSEL]
// Talend: POST, form-data, key 'image'
router.post('/vessels/add', upload.single('image'), async (req, res) => {
    const { soul_path, species, base_hp, base_mp, starting_location } = req.body;

    try {
        let imageUrl = null;
        if (req.file) {
            // Dynamic URL logic: protocol + host
            imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
        }

        const [result] = await db.execute(
            'INSERT INTO starting_vessels (soul_path, species, base_hp, base_mp, starting_location, vessel_image) VALUES (?, ?, ?, ?, ?, ?)',
            [soul_path, species, base_hp, base_mp, starting_location, imageUrl]
        );

        res.json({ 
            message: `[SYSTEM: REGISTERED] New Vessel '${species}' added to reincarnation cycle.`,
            vessel_id: result.insertId,
            vessel_image: imageUrl
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Failed to register new vessel." });
    }
});

// [UPDATE STARTING VESSEL]
router.post('/vessels/update/:id', upload.single('image'), async (req, res) => {
    const vesselId = req.params.id;
    const { soul_path, species, base_hp, base_mp, starting_location } = req.body;

    try {
        const [current] = await db.execute('SELECT vessel_image FROM starting_vessels WHERE vessel_id = ?', [vesselId]);
        if (!current.length) return res.status(404).json({ error: "Vessel not found." });

        let imageUrl = current[0].vessel_image;
        if (req.file) {
            imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
        }

        await db.execute(
            'UPDATE starting_vessels SET soul_path = ?, species = ?, base_hp = ?, base_mp = ?, starting_location = ?, vessel_image = ? WHERE vessel_id = ?',
            [soul_path, species, base_hp, base_mp, starting_location, imageUrl, vesselId]
        );

        res.json({ message: `[SYSTEM: RECONFIGURED] Vessel '${species}' updated successfully.` });
    } catch (err) {
        res.status(500).json({ error: "Vessel update failure." });
    }
});

// ==========================================
// --- SECTION 3: DELETE ENTITY (GLOBAL) ---
// ==========================================

router.delete('/delete/:type/:id', async (req, res) => {
    const { type, id } = req.params;
    let table = type === 'npc' ? 'master_npcs' : (type === 'location' ? 'location_seeds' : null);
    let idCol = type === 'npc' ? 'id' : 'location_id';

    if (!table) return res.status(400).json({ error: "Invalid entity type." });

    try {
        await db.execute(`DELETE FROM ${table} WHERE ${idCol} = ?`, [id]);
        res.json({ message: `[SYSTEM: PURGED] Entity ID: ${id} removed from the world.` });
    } catch (err) {
        res.status(500).json({ error: "Purge failed." });
    }
});

// ==========================================
// some other routes for admin controls, like monitoring world state, granting karma, smiting players, etc.
router.get('/world-state', async (req, res) => {
    try {
        const [activePlayers] = await db.execute(
            'SELECT u.username, c.species, c.current_level, c.hp, c.current_location FROM current_life c JOIN users u ON c.user_id = u.id WHERE c.is_alive = 1'
        );
        res.json({ system_status: "ONLINE", active_souls: activePlayers });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

router.post('/grant-karma', async (req, res) => {
    const { targetUserId, karmaAmount } = req.body;
    const uid = Math.floor(Number(targetUserId));
    const delta = Math.floor(Number(karmaAmount));
    if (!Number.isFinite(uid) || uid <= 0 || !Number.isFinite(delta)) {
        return res.status(400).json({ error: 'Invalid targetUserId or karmaAmount.' });
    }

    const conn = await db.getConnection();
    try {
        await conn.beginTransaction();
        await conn.execute(
            'UPDATE soul_library SET accumulated_karma = GREATEST(0, accumulated_karma + ?) WHERE user_id = ?',
            [delta, uid]
        );
        await refreshSoulRankAndMirrorKarma(conn, uid);
        await conn.commit();
        res.json({ message: `[SYSTEM OVERRIDE] Granted ${delta} Karma to Soul ID: ${uid}` });
    } catch (err) {
        await conn.rollback();
        res.status(500).json({ error: err.message });
    } finally {
        conn.release();
    }
});

router.post('/smite', async (req, res) => {
    const { targetUserId } = req.body;
    try {
        await db.execute('UPDATE current_life SET hp = 0, is_alive = 0 WHERE user_id = ? AND is_alive = 1', [targetUserId]);
        await db.execute('UPDATE soul_library SET death_count = death_count + 1 WHERE user_id = ?', [targetUserId]);
        res.json({ message: `[SYSTEM OVERRIDE] Soul ID: ${targetUserId} has been eradicated.` });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;