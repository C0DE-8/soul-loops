-- Rename old legacy external-IP seed content to original Soul Loop canon.
-- Run after the canon/NPC migration on databases that already contain old seed rows.

UPDATE `current_life`
SET `current_location` = CASE `current_location`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `current_location`
END;

UPDATE `current_life`
SET `home_base` = CASE `home_base`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `home_base`
END;

UPDATE `current_life`
SET `species` = CASE `species`
  WHEN CONCAT('Small Lesser Tara','tect') THEN 'Gloomthread Hatchling'
  WHEN CONCAT('Small Tara','tect') THEN 'Gloomthread Weaver'
  WHEN CONCAT('Small Poison Tara','tect') THEN 'Venomthread Gloomling'
  WHEN CONCAT('Lesser Fire Wy','rm') THEN 'Cinder Wyrmling'
  ELSE `species`
END;

UPDATE `current_life`
SET `inventory` = REPLACE(REPLACE(`inventory`, CONCAT('Tara','tect Silk'), 'Gloomthread Silk'), CONCAT('Hellfire Or','b'), 'Abyssal Cinder')
WHERE `inventory` IS NOT NULL;

UPDATE `location_connectors`
SET `from_location` = CASE `from_location`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `from_location`
END,
`to_location` = CASE `to_location`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `to_location`
END;

UPDATE `location_seeds`
SET `region_name` = 'nadir_labyrinth'
WHERE `region_name` = CONCAT('el','roe_labyrinth');

UPDATE `location_seeds`
SET `description_seed` = REPLACE(REPLACE(REPLACE(REPLACE(`description_seed`, CONCAT('El','roe'), 'Nadir'), CONCAT('earth dra','gons'), 'vault dragons'), CONCAT('Earth Dra','gon'), 'Vault Dragon'), CONCAT('water stra','tum'), 'drowned veins')
WHERE `description_seed` IS NOT NULL;

UPDATE `location_seeds`
SET `hidden_lore` = REPLACE(REPLACE(REPLACE(`hidden_lore`, CONCAT('Tara','tect'), 'Gloomthread'), CONCAT('El','roe'), 'Nadir'), 'reincarnator', 'soulmarked')
WHERE `hidden_lore` IS NOT NULL;

UPDATE `location_seeds` SET `location_id` = 'nadir_upper' WHERE `location_id` = CONCAT('el','roe_upper');
UPDATE `location_seeds` SET `location_id` = 'nadir_middle' WHERE `location_id` = CONCAT('el','roe_middle');
UPDATE `location_seeds` SET `location_id` = 'nadir_lower' WHERE `location_id` = CONCAT('el','roe_lower');
UPDATE `location_seeds` SET `location_id` = 'drowned_veins' WHERE `location_id` = CONCAT('water_','stratum');
UPDATE `location_seeds` SET `location_id` = 'crown_citadel' WHERE `location_id` = CONCAT('royal_','capital');

UPDATE `master_items`
SET `name` = 'Gloomthread Silk',
    `description` = 'Sticky, highly durable spider thread. Useful for crafting or traps.'
WHERE `name` = CONCAT('Tara','tect Silk');

UPDATE `master_npcs`
SET `name` = CASE `name`
  WHEN CONCAT('Small Lesser Tara','tect') THEN 'Gloomthread Hatchling'
  WHEN CONCAT('Small Tara','tect') THEN 'Gloomthread Weaver'
  WHEN CONCAT('Small Poison Tara','tect') THEN 'Venomthread Gloomling'
  WHEN CONCAT('El','roe Frog') THEN 'Mireglass Toad'
  WHEN CONCAT('Ano','gatch') THEN 'Craghowler'
  WHEN CONCAT('Earth Dra','gon Ara','ba') THEN 'Vault Dragon Oryxen'
  ELSE `name`
END,
`description` = REPLACE(REPLACE(REPLACE(`description`, CONCAT('Tara','tect'), 'Gloomthread'), CONCAT('El','roe'), 'Nadir'), CONCAT('Lower Stra','tum'), 'Lower Deep')
WHERE `name` IN (CONCAT('Small Lesser Tara','tect'),CONCAT('Small Tara','tect'),CONCAT('Small Poison Tara','tect'),CONCAT('El','roe Frog'),CONCAT('Ano','gatch'),CONCAT('Earth Dra','gon Ara','ba'))
   OR `description` LIKE CONCAT('%','Tara','tect','%')
   OR `description` LIKE CONCAT('%','El','roe','%')
   OR `description` LIKE CONCAT('%','Lower Stra','tum','%');

UPDATE `master_skills`
SET `name` = CASE `name`
  WHEN CONCAT('Venom Resist','ance') THEN 'Toxin Ward'
  WHEN CONCAT('Pain Nullifica','tion') THEN 'Pain Severance'
  WHEN CONCAT('Apprais','al') THEN 'True Sight'
  WHEN CONCAT('Hellfire Or','b') THEN 'Abyssal Cinder'
  ELSE `name`
END;

UPDATE `soul_library`
SET `skills` = REPLACE(REPLACE(REPLACE(`skills`, CONCAT('Detec','tion'), 'Echo Sense'), CONCAT('Thread Manip','ulation'), 'Weaver Control'), CONCAT('Acid Resist','ance'), 'Corrosion Ward')
WHERE `skills` IS NOT NULL;

UPDATE `users`
SET `permanent_skills` = REPLACE(REPLACE(REPLACE(REPLACE(`permanent_skills`, CONCAT('Hellfire Or','b'), 'Abyssal Cinder'), CONCAT('Apprais','al'), 'True Sight'), CONCAT('Pain Nullifica','tion'), 'Pain Severance'), CONCAT('Venom Resist','ance'), 'Toxin Ward')
WHERE `permanent_skills` IS NOT NULL;

UPDATE `starting_vessels`
SET `starting_location` = CASE `starting_location`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `starting_location`
END,
`species` = CASE `species`
  WHEN CONCAT('Small Lesser Tara','tect') THEN 'Gloomthread Hatchling'
  WHEN CONCAT('Small Tara','tect') THEN 'Gloomthread Weaver'
  WHEN CONCAT('Small Poison Tara','tect') THEN 'Venomthread Gloomling'
  WHEN CONCAT('Lesser Fire Wy','rm') THEN 'Cinder Wyrmling'
  ELSE `species`
END;

UPDATE `evolution_paths`
SET `from_species` = CASE `from_species`
  WHEN CONCAT('Small Lesser Tara','tect') THEN 'Gloomthread Hatchling'
  WHEN CONCAT('Small Tara','tect') THEN 'Gloomthread Weaver'
  WHEN CONCAT('Small Poison Tara','tect') THEN 'Venomthread Gloomling'
  ELSE `from_species`
END,
`to_species` = CASE `to_species`
  WHEN CONCAT('Small Lesser Tara','tect') THEN 'Gloomthread Hatchling'
  WHEN CONCAT('Small Tara','tect') THEN 'Gloomthread Weaver'
  WHEN CONCAT('Small Poison Tara','tect') THEN 'Venomthread Gloomling'
  ELSE `to_species`
END;

UPDATE `reincarnated_npcs`
SET `original_name` = CASE `original_name`
  WHEN CONCAT('Sh','un') THEN 'Iren Vale'
  WHEN CONCAT('Shino','hara') THEN 'Mara Venn'
  WHEN CONCAT('Waka','ba') THEN 'Nocturne Witness'
  ELSE `original_name`
END,
`new_name` = CASE `new_name`
  WHEN CONCAT('Sch','lain') THEN 'Cael Voss'
  WHEN CONCAT('Fei','rune') THEN 'Veyra'
  WHEN CHAR(68) THEN 'The Veiled Auditor'
  ELSE `new_name`
END,
`current_species` = CASE `current_species`
  WHEN CONCAT('Human (Hero Ti','tle)') THEN 'Human (Oathmarked Heir)'
  WHEN CONCAT('Earth Dra','gon') THEN 'Vault Dragon'
  ELSE `current_species`
END,
`current_location` = CASE `current_location`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `current_location`
END,
`status_log` = REPLACE(REPLACE(REPLACE(REPLACE(`status_log`, CONCAT('Royal Acad','emy'), 'Ashen Lyceum'), CONCAT('Divine Mag','ic'), 'Sanctum Rite'), CONCAT('Fei','rune'), 'Veyra'), CONCAT('El','roe'), 'Nadir')
WHERE `status_log` IS NOT NULL
   OR `original_name` IN (CONCAT('Sh','un'),CONCAT('Shino','hara'),CONCAT('Waka','ba'))
   OR `new_name` IN (CONCAT('Sch','lain'),CONCAT('Fei','rune'),CHAR(68));

UPDATE `npcs`
SET `name` = CASE `name`
  WHEN CONCAT('Sch','lain') THEN 'Cael Voss'
  WHEN CONCAT('Fei','rune') THEN 'Veyra'
  WHEN CHAR(68) THEN 'The Veiled Auditor'
  ELSE `name`
END,
`role` = CASE `role`
  WHEN CONCAT('Human (Hero Ti','tle)') THEN 'Human (Oathmarked Heir)'
  WHEN CONCAT('Earth Dra','gon') THEN 'Vault Dragon'
  ELSE `role`
END,
`description` = REPLACE(REPLACE(REPLACE(REPLACE(`description`, CONCAT('Royal Acad','emy'), 'Ashen Lyceum'), CONCAT('Divine Mag','ic'), 'Sanctum Rite'), CONCAT('Fei','rune'), 'Veyra'), CONCAT('El','roe'), 'Nadir'),
`secret_summary` = CASE `secret_summary`
  WHEN CONCAT('Sh','un') THEN 'Iren Vale'
  WHEN CONCAT('Shino','hara') THEN 'Mara Venn'
  WHEN CONCAT('Waka','ba') THEN 'Nocturne Witness'
  ELSE `secret_summary`
END
WHERE `name` IN (CONCAT('Sch','lain'),CONCAT('Fei','rune'),CHAR(68))
   OR `role` IN (CONCAT('Human (Hero Ti','tle)'),CONCAT('Earth Dra','gon'))
   OR `description` LIKE CONCAT('%','Royal Acad','emy','%')
   OR `description` LIKE CONCAT('%','Divine Mag','ic','%');

UPDATE `story_milestones`
SET `location_id` = CASE `location_id`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  ELSE `location_id`
END,
`content` = REPLACE(REPLACE(`content`, CONCAT('El','roe'), 'Nadir'), CONCAT('Tara','tect'), 'Gloomthread')
WHERE `location_id` IN (CONCAT('el','roe_upper'),CONCAT('el','roe_middle'),CONCAT('el','roe_lower'))
   OR `content` LIKE CONCAT('%','El','roe','%')
   OR `content` LIKE CONCAT('%','Tara','tect','%');

UPDATE `zone_spawns`
SET `zone_name` = CASE `zone_name`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  ELSE `zone_name`
END;

UPDATE `world_regions`
SET `name` = 'nadir_labyrinth',
    `description` = REPLACE(`description`, CONCAT('el','roe_labyrinth'), 'nadir_labyrinth')
WHERE `name` = CONCAT('el','roe_labyrinth');

UPDATE `world_places`
SET `name` = CASE `name`
  WHEN CONCAT('el','roe_upper') THEN 'nadir_upper'
  WHEN CONCAT('el','roe_middle') THEN 'nadir_middle'
  WHEN CONCAT('el','roe_lower') THEN 'nadir_lower'
  WHEN CONCAT('water_','stratum') THEN 'drowned_veins'
  WHEN CONCAT('royal_','capital') THEN 'crown_citadel'
  ELSE `name`
END,
`description` = REPLACE(REPLACE(REPLACE(`description`, CONCAT('El','roe'), 'Nadir'), CONCAT('earth dra','gons'), 'vault dragons'), CONCAT('Tara','tect'), 'Gloomthread'),
`lore_summary` = REPLACE(REPLACE(REPLACE(`lore_summary`, CONCAT('El','roe'), 'Nadir'), CONCAT('earth dra','gons'), 'vault dragons'), CONCAT('Tara','tect'), 'Gloomthread'),
`hidden_lore` = REPLACE(REPLACE(REPLACE(`hidden_lore`, CONCAT('El','roe'), 'Nadir'), CONCAT('Tara','tect'), 'Gloomthread'), 'reincarnator', 'soulmarked')
WHERE `name` IN (CONCAT('el','roe_upper'),CONCAT('el','roe_middle'),CONCAT('el','roe_lower'),CONCAT('water_','stratum'),CONCAT('royal_','capital'))
   OR `description` LIKE CONCAT('%','El','roe','%')
   OR `description` LIKE CONCAT('%','Tara','tect','%')
   OR `lore_summary` LIKE CONCAT('%','El','roe','%')
   OR `hidden_lore` LIKE CONCAT('%','El','roe','%');

UPDATE `action_logs`
SET `user_action` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(`user_action`, CONCAT('Small Lesser Tara','tect'), 'Gloomthread Hatchling'), CONCAT('Small Poison Tara','tect'), 'Venomthread Gloomling'), CONCAT('Tara','tect'), 'Gloomthread'), CONCAT('Hellfire Or','b'), 'Abyssal Cinder'), CONCAT('Thread Manip','ulation'), 'Weaver Control'), CONCAT('Detec','tion'), 'Echo Sense'), CONCAT('El','roe'), 'Nadir'), CONCAT('Fei','rune'), 'Veyra'), CONCAT('Subject ',CHAR(68)), 'The Veiled Auditor'),
    `system_response` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(`system_response`, CONCAT('Small Lesser Tara','tect'), 'Gloomthread Hatchling'), CONCAT('Small Poison Tara','tect'), 'Venomthread Gloomling'), CONCAT('Tara','tect'), 'Gloomthread'), CONCAT('Hellfire Or','b'), 'Abyssal Cinder'), CONCAT('Thread Manip','ulation'), 'Weaver Control'), CONCAT('Detec','tion'), 'Echo Sense'), CONCAT('El','roe'), 'Nadir'), CONCAT('Fei','rune'), 'Veyra'), CONCAT('Sch','lain'), 'Cael Voss'), CONCAT('Shino','hara'), 'Mara Venn'), CONCAT('Sh','un'), 'Iren Vale'), CONCAT('Waka','ba'), 'Nocturne Witness'), CONCAT('Royal Acad','emy'), 'Ashen Lyceum'),
    `choices` = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(`choices`, CONCAT('Small Lesser Tara','tect'), 'Gloomthread Hatchling'), CONCAT('Small Poison Tara','tect'), 'Venomthread Gloomling'), CONCAT('Tara','tect'), 'Gloomthread'), CONCAT('Hellfire Or','b'), 'Abyssal Cinder'), CONCAT('Thread Manip','ulation'), 'Weaver Control'), CONCAT('Detec','tion'), 'Echo Sense'), CONCAT('El','roe'), 'Nadir')
WHERE `user_action` IS NOT NULL OR `system_response` IS NOT NULL OR `choices` IS NOT NULL;
