CREATE DATABASE IF NOT EXISTS soul_loop_db;
USE soul_loop_db;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'player',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS soul_library (
    user_id INT PRIMARY KEY,
    soul_rank INT DEFAULT 1,
    accumulated_karma INT DEFAULT 0,
    permanent_skills JSON, 
    death_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS current_life (
    life_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    species VARCHAR(100),
    current_level INT DEFAULT 1,
    hp INT DEFAULT 10,
    max_hp INT DEFAULT 10,
    mp INT DEFAULT 10,
    max_mp INT DEFAULT 10,
    current_location VARCHAR(50) DEFAULT 'elroe_upper',
    is_alive BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES soul_library(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS evolution_paths (
    evolution_id INT PRIMARY KEY AUTO_INCREMENT,
    from_species VARCHAR(100),
    to_species VARCHAR(100),
    req_level INT,
    description TEXT
);

CREATE TABLE IF NOT EXISTS location_seeds (
    location_id VARCHAR(50) PRIMARY KEY,
    description_seed TEXT,
    danger_level INT
);

-- SEEDS
INSERT IGNORE INTO location_seeds (location_id, description_seed, danger_level) VALUES 
('elroe_upper', 'Upper Elroe Labyrinth: A sprawling network of dark, damp limestone caves. Weak monsters and sticky webs everywhere.', 2),
('elroe_lower', 'Lower Elroe Labyrinth: A hellish, cavernous landscape teeming with earth dragons and venomous beasts.', 6),
('magma_layer', 'Magma Layer: Rivers of flowing lava and extreme heat. Fire resistance is mandatory.', 9);

INSERT IGNORE INTO evolution_paths (from_species, to_species, req_level, description) VALUES 
('Small Lesser Taratect', 'Small Taratect', 10, 'A balanced spider body with improved speed and thread production.'),
('Small Lesser Taratect', 'Small Poison Taratect', 10, 'Unlocks advanced Poison Synthesis but reduces physical defense.');