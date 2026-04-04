const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../config/db');
require('dotenv').config();

const router = express.Router();

// /api/auth/register
router.post('/register', async (req, res) => {
    const { email, username, password } = req.body;
    try {
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        const [result] = await db.execute(
            'INSERT INTO users (email, username, password_hash) VALUES (?, ?, ?)',
            [email, username, hashedPassword]
        );
        const newUserId = result.insertId;

        await db.execute(
            'INSERT INTO soul_library (user_id, permanent_skills) VALUES (?, ?)', 
            [newUserId, '[]']
        );

        res.status(201).json({ message: "Soul registered. Welcome to the Loop." });
    } catch (err) {
        if (err.code === 'ER_DUP_ENTRY') return res.status(400).json({ error: "Email/Username taken." });
        res.status(500).json({ error: err.message });
    }
});

// /api/auth/login
router.post('/login', async (req, res) => {
    // 1. Swap 'email' for 'identifier'
    const { identifier, password } = req.body; 
    
    try {
        // 2. Check the database for EITHER the email or the username
        const [rows] = await db.execute(
            'SELECT * FROM users WHERE email = ? OR username = ?', 
            [identifier, identifier]
        );
        
        if (rows.length === 0) return res.status(400).json({ error: "Invalid credentials." });
        
        const user = rows[0];
        const validPassword = await bcrypt.compare(password, user.password_hash);
        if (!validPassword) return res.status(400).json({ error: "Invalid credentials." });

        const token = jwt.sign(
            { userId: user.id, username: user.username, role: user.role }, 
            process.env.JWT_SECRET, 
            { expiresIn: '24h' }
        );

        res.json({ message: "Login successful.", token });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;