-- Structured world canon, NPC memory, and world-event foundations.
-- Run once against an existing Soul Loop database.

CREATE TABLE IF NOT EXISTS `world_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `region_type` varchar(80) NOT NULL,
  `parent_region_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `danger_level` int(11) DEFAULT 1,
  `discovery_status` enum('hidden','rumor','discovered','confirmed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_world_regions_name` (`name`),
  KEY `idx_world_regions_parent` (`parent_region_id`),
  KEY `idx_world_regions_discovery` (`discovery_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `factions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `faction_type` varchar(80) NOT NULL,
  `ideology` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `leader_entity_id` int(11) DEFAULT NULL,
  `power_rank` int(11) DEFAULT 1,
  `relationship_to_player_default` int(11) DEFAULT 0,
  `status` enum('active','fallen','hidden','sealed') DEFAULT 'hidden',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_factions_name` (`name`),
  KEY `idx_factions_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `world_places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `region_id` int(11) DEFAULT NULL,
  `name` varchar(180) NOT NULL,
  `place_type` varchar(80) NOT NULL,
  `description` text DEFAULT NULL,
  `lore_summary` text DEFAULT NULL,
  `hidden_lore` text DEFAULT NULL,
  `ruling_faction_id` int(11) DEFAULT NULL,
  `discovery_status` enum('hidden','rumor','discovered','confirmed') DEFAULT 'rumor',
  `first_discovered_by_life_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_world_places_name` (`name`),
  KEY `idx_world_places_region` (`region_id`),
  KEY `idx_world_places_discovery` (`discovery_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `world_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `entity_type` enum('god','demon_lord','ruler','boss','spirit','guardian','legend','other') DEFAULT 'other',
  `title` varchar(180) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `lore_summary` text DEFAULT NULL,
  `origin_region_id` int(11) DEFAULT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `threat_rank` int(11) DEFAULT 1,
  `canon_status` enum('rumor','suspected','confirmed','sealed','legendary') DEFAULT 'rumor',
  `is_alive` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_world_entities_name` (`name`),
  KEY `idx_world_entities_region` (`origin_region_id`),
  KEY `idx_world_entities_faction` (`faction_id`),
  KEY `idx_world_entities_status` (`canon_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `monster_species` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `species_type` varchar(80) NOT NULL,
  `habitat_region_id` int(11) DEFAULT NULL,
  `temperament` varchar(180) DEFAULT NULL,
  `rarity` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `evolution_notes` text DEFAULT NULL,
  `canon_status` enum('rumor','confirmed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_monster_species_name` (`name`),
  KEY `idx_monster_species_region` (`habitat_region_id`),
  KEY `idx_monster_species_status` (`canon_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `world_powers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `power_type` varchar(80) NOT NULL,
  `element` varchar(80) DEFAULT NULL,
  `rarity` varchar(80) DEFAULT NULL,
  `source_type` enum('natural','god','demon_lord','faction','artifact','species','unknown') DEFAULT 'unknown',
  `source_entity_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `lore_summary` text DEFAULT NULL,
  `canon_status` enum('rumor','suspected','confirmed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_world_powers_name` (`name`),
  KEY `idx_world_powers_source` (`source_entity_id`),
  KEY `idx_world_powers_status` (`canon_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `lore_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(180) NOT NULL,
  `lore_type` enum('history','rumor','prophecy','war','religion','artifact','bloodline','catastrophe','other') DEFAULT 'other',
  `summary` text NOT NULL,
  `linked_region_id` int(11) DEFAULT NULL,
  `linked_place_id` int(11) DEFAULT NULL,
  `linked_entity_id` int(11) DEFAULT NULL,
  `linked_faction_id` int(11) DEFAULT NULL,
  `linked_power_id` int(11) DEFAULT NULL,
  `canon_status` enum('rumor','suspected','confirmed','sealed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_lore_entries_title` (`title`),
  KEY `idx_lore_region` (`linked_region_id`),
  KEY `idx_lore_place` (`linked_place_id`),
  KEY `idx_lore_entity` (`linked_entity_id`),
  KEY `idx_lore_status` (`canon_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `world_generation_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `life_id` int(11) DEFAULT NULL,
  `trigger_action` text DEFAULT NULL,
  `proposal_type` varchar(80) DEFAULT NULL,
  `proposal_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`proposal_json`)),
  `status` enum('pending','approved','rejected','merged') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_world_generation_life` (`life_id`),
  KEY `idx_world_generation_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `npcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(180) NOT NULL,
  `role` varchar(120) NOT NULL,
  `faction_id` int(11) DEFAULT NULL,
  `home_region_id` int(11) DEFAULT NULL,
  `home_place_id` int(11) DEFAULT NULL,
  `personality_archetype` varchar(180) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `current_emotional_state` varchar(120) DEFAULT 'wary',
  `secret_summary` text DEFAULT NULL,
  `status` enum('active','dead','missing','corrupted','sealed') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_npcs_name` (`name`),
  KEY `idx_npcs_faction` (`faction_id`),
  KEY `idx_npcs_home_region` (`home_region_id`),
  KEY `idx_npcs_home_place` (`home_place_id`),
  KEY `idx_npcs_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `npc_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `current_life_id` int(11) DEFAULT NULL,
  `trust` int(11) DEFAULT 0,
  `fear` int(11) DEFAULT 0,
  `respect` int(11) DEFAULT 0,
  `affection` int(11) DEFAULT 0,
  `resentment` int(11) DEFAULT 0,
  `loyalty` int(11) DEFAULT 0,
  `relationship_stage` enum('stranger','aware','familiar','trusted','bonded','conflicted','fractured','devoted','hostile','broken') DEFAULT 'stranger',
  `last_interaction_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_npc_relationship_user` (`npc_id`,`user_id`),
  KEY `idx_npc_relationship_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `npc_memory_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `current_life_id` int(11) DEFAULT NULL,
  `memory_tag` varchar(120) NOT NULL,
  `memory_summary` text NOT NULL,
  `emotional_weight` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_npc_memory_lookup` (`npc_id`,`user_id`),
  KEY `idx_npc_memory_life` (`current_life_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `npc_scene_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `npc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `current_life_id` int(11) DEFAULT NULL,
  `scene_type` varchar(100) NOT NULL,
  `scene_summary` text NOT NULL,
  `emotional_impact` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_npc_scene_lookup` (`npc_id`,`user_id`),
  KEY `idx_npc_scene_life` (`current_life_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `world_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(180) NOT NULL,
  `event_type` enum('war','siege','uprising','ritual','catastrophe','corruption','political_shift','divine_sign','other') DEFAULT 'other',
  `summary` text NOT NULL,
  `region_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `initiator_faction_id` int(11) DEFAULT NULL,
  `target_faction_id` int(11) DEFAULT NULL,
  `initiator_entity_id` int(11) DEFAULT NULL,
  `target_entity_id` int(11) DEFAULT NULL,
  `severity` int(11) DEFAULT 1,
  `status` enum('rumor','active','resolved','hidden') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_world_events_name` (`event_name`),
  KEY `idx_world_events_region` (`region_id`),
  KEY `idx_world_events_place` (`place_id`),
  KEY `idx_world_events_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO `world_regions` (`name`, `region_type`, `description`, `danger_level`, `discovery_status`)
SELECT DISTINCT
  COALESCE(NULLIF(`region_name`, ''), 'unknown_region') AS `name`,
  'labyrinth_region',
  CONCAT('Structured canon seed migrated from location_seeds for ', COALESCE(NULLIF(`region_name`, ''), 'unknown_region'), '.'),
  COALESCE(MAX(`danger_level`), 1),
  'discovered'
FROM `location_seeds`
GROUP BY COALESCE(NULLIF(`region_name`, ''), 'unknown_region');

INSERT IGNORE INTO `world_places`
(`region_id`, `name`, `place_type`, `description`, `lore_summary`, `hidden_lore`, `discovery_status`)
SELECT
  wr.`id`,
  ls.`location_id`,
  'zone_seed',
  ls.`description_seed`,
  ls.`description_seed`,
  ls.`hidden_lore`,
  'discovered'
FROM `location_seeds` ls
LEFT JOIN `world_regions` wr ON wr.`name` = COALESCE(NULLIF(ls.`region_name`, ''), 'unknown_region');

INSERT IGNORE INTO `npcs`
(`name`, `role`, `home_place_id`, `personality_archetype`, `description`, `current_emotional_state`, `secret_summary`, `status`)
SELECT
  COALESCE(NULLIF(`new_name`, ''), NULLIF(`original_name`, ''), CONCAT('Reincarnator ', `npc_id`)),
  COALESCE(NULLIF(`current_species`, ''), 'reincarnated soul'),
  wp.`id`,
  'reincarnated anomaly',
  COALESCE(`status_log`, 'A reincarnated presence with incomplete records.'),
  'guarded',
  `original_name`,
  CASE WHEN `new_name` = 'DECEASED' THEN 'dead' ELSE 'active' END
FROM `reincarnated_npcs` rn
LEFT JOIN `world_places` wp ON wp.`name` = rn.`current_location`;
