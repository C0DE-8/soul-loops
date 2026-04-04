const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { verifyToken, verifyAdmin } = require('../middleware/auth');
const upload = require('../utils/uploadService'); 

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
// --- SECTION 2: LOCATION ZONES ---
// ==========================================

// [GET ALL LOCATIONS]
router.get('/locations', async (req, res) => {
    try {
        const [rows] = await db.execute('SELECT * FROM location_seeds ORDER BY location_id DESC');
        res.json({ system_status: "SYNCHRONIZED", location_seeds: rows });
    } catch (err) {
        res.status(500).json({ error: "Failed to retrieve World Map." });
    }
});

// [ADD NEW LOCATION]
router.post('/locations/add', upload.single('image'), async (req, res) => {
    const { location_name, description_seed, danger_level, pos_x, pos_y } = req.body;

    try {
        let imageUrl = null;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        const [result] = await db.execute(
            'INSERT INTO location_seeds (location_name, description_seed, danger_level, pos_x, pos_y, location_image) VALUES (?, ?, ?, ?, ?, ?)',
            [location_name, description_seed, danger_level, pos_x, pos_y, imageUrl]
        );

        res.json({ 
            message: `[SYSTEM: STABILIZED] Zone '${location_name}' manifested.`,
            location_id: result.insertId,
            location_image: imageUrl
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Zone stabilization failure." });
    }
});

// [UPDATE LOCATION]
router.post('/locations/update/:id', upload.single('image'), async (req, res) => {
    const locId = req.params.id;
    const { location_name, description_seed, danger_level, pos_x, pos_y } = req.body;

    try {
        const [current] = await db.execute('SELECT location_image FROM location_seeds WHERE location_id = ?', [locId]);
        if (!current.length) return res.status(404).json({ error: "Zone not found." });

        let imageUrl = current[0].location_image;
        if (req.file) {
            imageUrl = `${getDynamicUrl(req)}/uploads/${req.file.filename}`;
        }

        await db.execute(
            'UPDATE location_seeds SET location_name = ?, description_seed = ?, danger_level = ?, pos_x = ?, pos_y = ?, location_image = ? WHERE location_id = ?',
            [location_name, description_seed, danger_level, pos_x, pos_y, imageUrl, locId]
        );

        res.json({ message: `[SYSTEM: RECONFIGURED] Zone '${location_name}' updated.` });
    } catch (err) {
        res.status(500).json({ error: "Map update failure." });
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
    try {
        await db.execute(
            'UPDATE soul_library SET accumulated_karma = accumulated_karma + ? WHERE user_id = ?',
            [karmaAmount, targetUserId]
        );
        res.json({ message: `[SYSTEM OVERRIDE] Granted ${karmaAmount} Karma to Soul ID: ${targetUserId}` });
    } catch (err) {
        res.status(500).json({ error: err.message });
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