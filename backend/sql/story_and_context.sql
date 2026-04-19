-- Story milestones + location hidden lore (run once against your soul_loop DB)

ALTER TABLE `location_seeds`
  ADD COLUMN `hidden_lore` text DEFAULT NULL AFTER `description_seed`;

UPDATE `location_seeds`
SET `hidden_lore` = 'A hidden spider-silk nest glimmers between two stalactites — abandoned, but strands still twitch as if something recently passed.'
WHERE `location_id` = 'webbed_hollows';

UPDATE `location_seeds`
SET `hidden_lore` = 'Carved into the damp stone: a faint mark that resembles a reincarnator\'s skill menu glyph.'
WHERE `location_id` = 'nadir_upper' AND (`hidden_lore` IS NULL OR `hidden_lore` = '');

CREATE TABLE IF NOT EXISTS `story_milestones` (
  `milestone_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `min_level` int(11) DEFAULT NULL,
  `location_id` varchar(50) DEFAULT NULL,
  `content` text NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  PRIMARY KEY (`milestone_id`),
  UNIQUE KEY `code` (`code`),
  KEY `idx_sort` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `user_story_milestones` (
  `user_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `triggered_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`milestone_id`),
  KEY `milestone_id` (`milestone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `story_milestones` (`code`, `min_level`, `location_id`, `content`, `sort_order`) VALUES
('soul_resonance_lv5', 5, NULL, '[STORY BEAT] The System\'s voice steadies: your soul-resonance has crossed a threshold. Distant threads of other reincarnators tug at the edge of your perception — not as enemies, but as echoes in the same cruel fairytale.', 10),
('labyrinth_whispers', NULL, 'nadir_upper', '[STORY BEAT] The upper labyrinth hums with more than monsters: somewhere, silk drags across stone, and a name you almost recognize flits through your thoughts.', 20)
ON DUPLICATE KEY UPDATE `content` = VALUES(`content`);
