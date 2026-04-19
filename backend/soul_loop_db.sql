-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 19, 2026 at 03:12 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soul_loop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `log_id` int(11) NOT NULL,
  `life_id` int(11) DEFAULT NULL,
  `user_action` text DEFAULT NULL,
  `system_response` text DEFAULT NULL,
  `choices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`choices`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `bg_image` varchar(255) DEFAULT NULL,
  `encounter_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `action_logs`
--

INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(2, 9, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[SCANNED ENVIRONMENT: NADIR_UPPER_STRATUM]\n[BIOLOGICAL ANCHOR DETECTED: CAVE CENTIPEDE (JUVENILE)]\n[SOUL RESONANCE: SCAVENGER]\n\n...\n...\n\n**[ERROR: SENSORY INPUT OVERLOAD]**\n\nA jagged, segmented existence replaces the abstraction of thought. You do not wake up; you *click* into being. The world is a cacophony of vibrations scraping against your chitinous plating. You are not breathing—you are respiring through spiracles that taste the metallic, damp air of the labyrinth. \n\nYour vision is a mosaic of flickering, low-resolution heat signatures. You possess forty legs, and for a terrifying moment, your consciousness fails to coordinate them, resulting in a frantic, uncoordinated thrashing against the cold, damp stone. You are hungry—a hollow, corrosive ache that pulses in rhythm with your frantic, multiple hearts. You are a predator that feeds on carrion, a scavenger of the deep, and your instincts are screaming for sustenance.\n\nYou are small. You are vulnerable. The ceiling above you drips with bioluminescent moss, casting long, sickening shadows that pulse like a warning.\n\n***\n\n[SYSTEM QUERY: MANDATORY DIRECTIVE]\n[PATH: SCAVENGER]\n[ACTION REQUIRED]\n\n**CHOICE 1: [THE HUNGRY VIGIL]**\nRemain perfectly still, pressing your segmented body into a crevice in the stone. Use your vibration-sensing antennae to map the surroundings. Wait for the tell-tale scent of decay from a larger creature’s kill, rather than risking a confrontation in your current, uncoordinated state.\n\n**CHOICE 2: [THE CHAOTIC SCURRY]**\nPanic-reflex triggers. Force your legs into motion, bolting blindly into the dark labyrinth. Trust in your natural speed to outrun whatever nightmare inhabits this chamber, hoping to stumble upon a discarded carcass or a softer, less-guarded creature to consume.\n\n**CHOICE 3: [THE PREDATORY AMBUSH]**\nAnalyze the immediate vicinity for movement. Locate a tunnel junction and wedge yourself into the shadows above the path. Prepare to drop upon the first small insect or subterranean crawler that passes beneath you, attempting to establish dominance and satisfy the gnawing void in your core immediately.', NULL, '2026-04-03 18:39:12', NULL, NULL),
(3, 10, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE.]\n[SOUL INTEGRATION: SUCCESSFUL.]\n[PATH DETERMINED: SCAVENGER.]\n\n[ALERT: SENSORY INPUT OVERLOAD DETECTED.]\n[VISION: MULTI-FACETED ARRAY DETECTED. MAPPING SPATIAL COORDINATES...]\n[ENVIRONMENT: NADIR_UPPER_STRATA. AMBIENT TEMPERATURE: 12°C. HUMIDITY: 45%.]\n[PHYSICAL STATUS: 8 LEGS DETECTED. CHITINOUS EXOSKELETON: FRAGILE. MANA RESERVES: NEGLIGIBLE.]\n\n[ERROR: BIOLOGICAL UNIT UNSTABLE. HUNGER DETECTED: 88%.]\n[PROMPTING FOR IMMEDIATE DIRECTIVE.]\n\n***\n\n**[CHOOSE YOUR PRIMARY INSTINCT]**\n\n**1. [AGGRESSIVE SCAVENGING]**\n*   Prioritize mobility and combat readiness. Use the environment to stalk small prey, regardless of the caloric risk. Focus on physical growth and predatory efficiency.\n\n**2. [CAUTIOUS CONSUMPTION]**\n*   Prioritize survival and stealth. Retreat into the labyrinthine shadows of the Nadir upper levels. Seek out carrion or weakened organisms to minimize energy expenditure while mapping the local ecosystem.\n\n**3. [ENVIRONMENTAL ADAPTATION]**\n*   Prioritize structural integrity. Begin spinning silk immediately to create a defensive web-nest. Focus on defensive utility and securing a stationary perimeter to observe the dangers of the upper deep before moving.', NULL, '2026-04-03 18:40:16', NULL, NULL),
(4, 10, 'I cautiously explore the dark cave, not knowing what do because i dont even knw what i am ', 'The darkness is absolute. Your multifaceted eyes struggle to adjust to the oppressive gloom of the limestone cavern. You move on eight chitinous limbs, the clicking of your joints echoing sharply against the damp walls. Your instincts are nascent, a flicker of hungry confusion in a fragile body. \n\nAs you navigate a narrow crevice, a sticky, silken strand brushes against your thorax. The texture is familiar—it is your own thread. You are a Gloomthread Hatchling, a creature woven from malice and silk.\n\nHigh above the labyrinth, a detached consciousness observes your clumsy gait. A digital ripple echoes through your mind, a faint, mocking transmission from the System: *[SYSTEM INTERCEPT]: The Veiled Auditor has adjusted the gaze. A new variable has been introduced to the floor. The game continues.*\n\nYou feel a sudden spike of adrenaline as you realize the shadows ahead hold the faint, rhythmic breathing of something larger.\n\n\n\n\n**Choices:**\n1. Advance toward the source of the breathing to investigate.\n2. Retreat and find a high crevice to weave a protective web-nest.\n3. Remain perfectly still and attempt to sense the movements in the dark.', NULL, '2026-04-03 18:45:25', NULL, NULL),
(5, 10, 'how about i saw a dark like oil and use my web and use it to mask my self', 'The damp limestone walls of the Nadir Upper Labyrinth weep a viscous, pitch-black secretion. You approach a pool of this dark, oil-like substance, dipping your silk strands into the sludge. As you coat your body in the mire, the sticky threads bind the dark liquid to your exoskeleton, effectively camouflaging your presence against the cavern shadows.\n\n\n\n\n\n[SYSTEM INTERCEPT]: A low-frequency vibration tremors through the stone floor nearby. Intelligence reports suggest an Vault Dragon, Veyra, is roaming a neighboring tunnel, hungry and oblivious to your presence. The air grows heavy with the scent of predatory intent.', NULL, '2026-04-03 19:15:54', NULL, NULL),
(6, 10, 'Anchor silk above and slowly ascend into the upper crevice, moving against gravity to avoid ground vibrations.', 'The silk strands adhere to the jagged limestone ceiling with a faint, sticky snap. Utilizing Weaver Control, you pull your small, arachnid frame upward, defying gravity as you ascend into the dark, moisture-slicked crevice. The ground below—a hotbed of territorial predators and shifting debris—recedes into the gloom. You remain suspended, motionless, an observer in the labyrinthine shadows.\n\n[SYSTEM INTERCEPT]: A flicker of data pulses through the void. The Veiled Auditor adjusts the viewport. The Labyrinth remains a game board, and the pieces are moving.\n\nYour movements are precise, though the physical exertion takes a toll on your limited stamina. You are learning the architecture of the dungeon; the way the silk catches the ambient humidity provides a sense of security against the prowling threats of the lower strata.', '[\"Scout the ceiling passage for a hidden nest or potential prey.\",\"Remain suspended in the crevice and wait for a passing monster to ambush from above.\",\"Carefully traverse the ceiling toward the sound of trickling water in the distance.\"]', '2026-04-03 19:25:55', NULL, NULL),
(7, 11, 'System Awakening', '**SYSTEM INITIALIZATION: COMPLETE.**\n**UNIT DESIGNATION:** SCRAP SLIME.\n**LOCATION:** NADIR_UPPER, SUB-LEVEL 7.\n**PATH ALIGNMENT:** SCAVENGER.\n\n**[CORE LOG]:** Awakening detected. Sensory input: fragmented. Neural pathways: re-routing.\n**[WARNING]:** Biological structural integrity is… amorphous. The concept of ‘limbs’ is missing. You are a cohesive mass of semi-viscous, metallic-infused protoplasm. You exist in the shadows of the Nadir Labyrinth. Around you, the refuse of forgotten adventurers—rusted iron, shattered glass, and calcified bone—pulsates with the faint, residual mana of the Upper Deep. \n\nYou do not have lungs, yet you \'breathe\' the stagnant, mineral-heavy air. You do not have eyes, yet you \'perceive\' the molecular weight of the debris surrounding your gelatinous form. \n\n**[SYSTEM QUERY]:** How shall the Scavenger manifest?\n\n**CHOICE 1: Assimilate the Immediate.** \nAbsorb the rusted iron shards littering your spawn point. Integrate the metal into your slime-structure to increase density and defense, sacrificing mobility for durability.\n\n**CHOICE 2: Hunt the Residue.** \nExtend sensory pseudopods into the cracks of the stone floor to detect lingering mana signatures. Search for a discarded adventurer’s pouch or an abandoned potion flask. Prioritize rapid growth through consumption of magical waste.\n\n**CHOICE 3: Instinctual Evasion.** \nSense the vibrations of the environment. Something large is moving through the tunnels nearby. Mimic the texture and color of the surrounding stone to avoid early-stage predation. Prioritize survival over immediate expansion.\n\n**[AWAITING INPUT...]**', NULL, '2026-04-03 20:40:13', NULL, NULL),
(8, 12, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE]\n[SUBJECT STATUS: AWAKENED]\n[BIOLOGICAL CLASSIFICATION: CINDER WYRMLING (JUVENILE)]\n[LOCATION: MAGMA_LAYER_SECTOR_04]\n[ENVIRONMENTAL HAZARD: EXTREME THERMAL DENSITY DETECTED]\n\n[ERROR: NEURAL MAPPING INCOMPLETE]\n[WARNING: INSTINCTUAL OVERRIDE DETECTED]\n[LOG: CONSCIOUSNESS DETECTED WITHIN ORGANIC VESSEL. MOTOR FUNCTIONS RESPONDING TO PREDATORY PRIMAL DRIVES. ANALYTICAL PROCESSING IS CURRENTLY INTERFERING WITH BIOLOGICAL IMPULSES.]\n\nYou are curled within a cradle of cooling basalt and liquid rock. Your scales—obsidian-black and searing to the touch—clatter against the stone as you shift. The air tastes of sulfur and raw kinetic energy. Your vision is split: one input registers the physical world through heat-vision, flickering in shades of blinding white and deep violet; the other input is a scrolling, sterile stream of data reporting your own hunger, your internal temperature, and the proximity of potential biomass. \n\nA primal roar bubbles in your throat, but it is accompanied by a text-prompt in your mind. The system demands an immediate calibration of your predatory instincts.\n\n**CHOOSE YOUR PRIMARY EVOLUTIONARY FOCUS:**\n\n**[A] CONSUME THE CRUST:** Direct all sensory input toward the magma flow. Digest the surrounding rock and thermal energy to rapidly expand your physical frame. *Trade-off: High growth potential, low immediate mobility.*\n\n**[B] SEEK THE VIBRATION:** Ignore the hunger and focus on the tremors in the distance. Hunt for the entity producing rhythmic vibrations in the rock. *Trade-off: High lethality/tactical experience, risk of environmental exposure.*\n\n**[C] RECALIBRATE INSTINCTS:** Attempt to bypass the mechanical interface and synchronize your soul with the Wyrm’s biological mind. *Trade-off: Slow initialization, potential to stabilize the mental dissonance and unlock hidden draconic capabilities.*', NULL, '2026-04-03 20:40:30', NULL, NULL),
(9, 13, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[PATH IDENTIFIED: PREY]\n[ENTITY DESIGNATION: BLIND CAVE SALAMANDER]\n[BIOME: DROWNED_VEINS]\n\nAwakening sequence initiated. Sensory input: Null (Ocular atrophy detected). Tactile input: High-velocity mineral-rich current. Chemical input: Nutrient-dense biofilm, predatory pheromones detected in proximity. The vessel is frail, translucent, and prone to rapid dehydration. Integration of biological instincts: Active. Survival probability: Negligible.', '[\"Anchor to the submerged limestone crevice to minimize metabolic expenditure.\",\"Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.\",\"Initiate passive filter-feeding along the cave floor to restore internal energy reserves.\"]', '2026-04-04 15:27:32', NULL, NULL),
(10, 13, 'Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.', 'The sensory organs ripple, pushing through the stagnant, mineral-rich water of the stratum. Silence reigns, save for the rhythmic dripping of stalactites. \n\nThe vibrations return. A low-frequency pulsing emanates from the northern corridor—a rhythmic, dragging motion indicating a Cave Creeper, blind and starving. Your whiskers register the ripple of its displacement in the water. Far above the stone ceiling, a faint, phantom resonance of a  broadcast hums through the rock—a report of a soul at the Ashen Lyceum unlocking . The disparity is vast. You are mud and instinct; they are light and ambition. The Creeper shifts closer, hungry.', '[\"Challenge light to a Duel\",\"Remain motionless to avoid detection and let the creature pass.\",\"Use the newly acquired skill to track the creature\'s path and ambush it.\",\"Flee into the deeper, uncharted fissures of the drowned_veins.\"]', '2026-04-04 15:41:14', NULL, NULL),
(11, 13, 'Remain motionless to avoid detection and let the creature pass.', 'The water in the stratum ripples with a heavy, rhythmic turbulence. A massive, bioluminescent predator glides inches above your submerged form, its jagged scales scraping against the cavern floor. You hold your breath, your damp skin blending into the mineral-rich sediment. The scent of ozone and ancient magic lingers in the water—a faint, lingering byproduct of a soul elsewhere in the world tapping into the  recently reported in the Ashen Lyceum broadcasts. The predator senses nothing but cold stone. It drifts onward, disappearing into the dark throat of the abyss.\n\nSafety is achieved, but the stillness drains your vitality. You are small, fragile, and utterly alone in the deep.', '[\"Challenge light to a Duel\",\"Search the immediate sediment for bioluminescent fungi to consume.\",\"Swim toward the faint light emanating from a distant, upward-sloping tunnel.\",\"Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.\"]', '2026-04-04 15:46:02', NULL, NULL),
(12, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The water in the stratum remains stagnant, clinging to your translucent, sightless skin like a shroud. You channel your internal essence toward your lateral line and nasal receptors, pushing past the threshold of mere instinct. The world does not brighten, but it clarifies; the oppressive silence fractures into a complex map of tectonic tremors and the rhythmic drip of calcified stalactites.\n\nAs your senses bloom, a jagged psychic resonance ripples through the cavern—a stray signal from the Surface. *.]* The triviality of their achievements feels distant, a flare of warmth in a world of absolute zero. The strain of sensory expansion causes your fragile tissues to throb, leaving you slightly drained.', '[\"Challenge light to a Duel\",\"Follow a faint, rhythmic vibration echoing from the deeper, darker reaches of the tunnel.\",\"Remain stationary and attempt to conserve energy, waiting for potential prey to drift into range.\",\"Navigate toward the surface of the pool, seeking to investigate the air-breathing alcoves above.\"]', '2026-04-04 15:47:19', NULL, NULL),
(13, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The lightless expanse of the water stratum shudders. You push your internal essence outward, straining your damp, pale nerves against the stagnant stillness of the cavern. The water ripples, carrying the whispers of the earth. You feel the heavy, rhythmic thrum of distant crushing stone and the erratic, high-frequency agitation of something skittering along the cavern roof.\n\nA broadcast flickers across your consciousness, cold and detached: ** \n\nAs your senses bloom, the vibrations coalesce into a mental map of the nearby currents. You have evolved beyond mere instinct.', '[\"Challenge light to a Duel\",\"Follow the skittering vibrations toward the cavern ceiling to hunt.\",\"Remain still in the water, conserving energy while monitoring the nearby tunnel junction.\",\"Dive deeper into the submerged crevice to avoid whatever entity just broadcasted its presence.\"]', '2026-04-04 15:48:11', NULL, NULL),
(14, 13, 'Remain still in the water, conserving energy while monitoring the nearby tunnel junction.', 'The water of the subterranean pool is still, mirroring the oppressive darkness of the cavern. You anchor yourself against a jagged limestone formation, your translucent skin cooling as you wait. Above the water\'s surface, the air grows thin and humid. \n\nFaint vibrations ripple through the cavern floor—the rhythmic, tectonic shifting of a creature far more massive than yourself. From the nearby tunnel junction, a flick of heat emanates, signaling the proximity of the Cinder Wyrmling known as \'joker.\' The System broadcasts a silent, mocking vibration into your primitive sensory organs: *“Two sparks in the dark, yet only one shall illuminate the path to evolution.”* You remain undetected, your stillness granting you a reprieve from the predator\'s gaze.', '[\"Threaten joker\",\"Slowly creep toward the tunnel junction to ambush the Fire Wyrm while it is distracted.\",\"Ignore joker for now\",\"Swim deeper into the subterranean lake to avoid the proximity of the Fire Wyrm.\"]', '2026-04-04 15:55:06', NULL, NULL),
(15, 13, 'Ignore joker for now', 'The icy currents of the drowned_veins offer a sanctuary of silence. You glide through the mineral-rich darkness, distancing yourself from the heat signature radiating from the cavern above. The Cinder Wyrmling, Joker, remains oblivious to your path, his hunger currently focused on the cavern floor miles away. A telepathic tremor vibrates through the stone; the System broadcasts a whisper of his violent descent into the upper labyrinth, but you press deeper into the subterranean pools, preserving your vitality.', '[\"Search the submerged floor for nutrient-dense moss to recover HP.\",\"Ignore joker for now\",\"Navigate deeper into the uncharted tunnels of the drowned_veins.\",\"Surface slightly to listen for the movements of other souls.\"]', '2026-04-04 15:55:31', NULL, NULL),
(16, 14, 'System Judgment Awakening', 'Identity synchronization verified. The ambient mana of the royal capital brushes against your physical vessel, cold and indifferent. You stand amidst the sprawling white stone architecture of the central plaza, a drop of water in an ocean of unfamiliar souls.\n\nA discordant pulse ripples through the air—a system-wide broadcast vibrates in your mind: *“Data anomaly detected in sector 4. Another soul from the void has manifested.”* The local populace continues their transit, entirely oblivious to the predatory resonance emanating from your core. You are a ghost inhabiting a mannequin, and the world is beginning to notice the displacement.', '[\"Attempt to blend into the passing crowd to observe the capital\'s social structure.\",\"Seek a secluded alleyway to test the limits of your new physical form.\",\"Approach a nearby merchant to gather information regarding your current location and status.\"]', '2026-04-05 15:38:31', NULL, NULL),
(17, 15, 'System Judgment Awakening', 'The jagged, light-starved labyrinth of the Nadir Upper Stratum stretches infinitely in all directions. Your consciousness flickers into existence, anchored to the fragile, leathery frame of a Shadow Bat. The air here is stagnant, thick with the scent of subterranean decay and the distant skittering of predatory chitin on stone. \n\nSystem broadcast intercepted: *Anomalous soul-signature detected in the lower sector. Correlation with \'Reincarnator\' status confirmed. The weave of causality tightens.*\n\nYou hang inverted from a stalactite, your sensitive ears twitching at the sound of fluid dripping into a dark pool far below. Hunger gnaws at your core; your existence is a momentary spark in the crushing dark.', '[\"Drop from the ceiling and scout the immediate vicinity for sustenance.\",\"Remain suspended in silence to observe the movement patterns of nearby entities.\",\"Take flight into the deeper tunnels to map the local geography.\"]', '2026-04-05 15:39:41', NULL, NULL),
(18, 15, 'Take flight into the deeper tunnels to map the local geography..', 'The Shadow Bat unfurls its translucent, ink-stained wings, catching a draft of stale, dungeon air. As you bank away from the Gloomthread Hatchling—which snaps its mandibles at empty air where you once hung—you ascend into the jagged, upper reaches of the Nadir Labyrinth. \n\nThe darkness here is thick, a velvet shroud that your kin find comforting. Below, the distant skittering of arachnid legs echoes against the stone. A flicker of data pulses in your mind: ** You navigate a series of narrow crevices, your sonar pinging off walls of raw ore and ancient sediment. The effort of sustained flight consumes your reserves.\n\n\n\n\n---', '[\"Challenge light to a Duel\",\"Attack the Gloomthread Hatchling\",\"Continue mapping the tunnels, searching for a water source.\",\"Observe light carefully\"]', '2026-04-05 15:49:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(19, 15, 'Attack the Gloomthread Hatchling.', 'The shadow cast by your wings flickers against the cavern walls of Nadir Upper. You dive, talons extended, latching onto the carapace of the Gloomthread Hatchling. It hisses, a chittering sound that vibrates through your hollow bones. A brief struggle ensues; you tear into its chitinous hide, and the creature goes limp.\n\n: A distant, distorted broadcast echoes in the frequency of the labyrinth: *“The favored of the gods hone their craft in white marble halls, wielding holy light. You remain in the dark.”* \n\nThe effort leaves you winded, your own life-force thinned by the skirmish.', '[\"Threaten light\",\"Scan the surroundings\",\"Consume the carcass to restore vitality.\",\"Scout the immediate area for the source of the PVP detection.\"]', '2026-04-05 15:50:43', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(20, 15, 'Consume the carcass to restore vitality.', 'The jagged, obsidian landscape of the Nadir Labyrinth reflects a cold, uncaring light. You descend upon the remains of the frog, your claws tearing into the acidic, rubbery flesh. The consumption is swift, a desperate act of survival that numbs your senses as the creature\'s essence permeates your own.\n\nAs you feed, the system hums—a distant, distorted broadcast echoing through the cavern walls: *“Observation of the subterranean struggle continues. An anomaly—a soul from another world—lingers in the light nearby, oblivious to the predator currently feasting in the shadows.”*\n\nYour vitality stabilizes, though the chemical burn of the prey leaves a foul taste.', '[\"Threaten light\",\"Stay alert and do nothing\",\"Investigate the nearby light source to confront the other soul.\",\"Deepen your concealment within the shadows to avoid detection.\"]', '2026-04-05 15:51:34', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(21, 15, 'Stay alert and do nothing', 'Attention: A biological anomaly of note has been registered. Within the Ashen Lyceum, a subject has successfully integrated . The System classifies this development as high-priority; monitor evolution paths accordingly.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nStatus: Stationary/Alert.\n\nSubject has opted for a period of quiescence. Efficiency of energy expenditure is high; however, metabolic processes continue to deplete resources. With SPD at 18, the subject remains primed for rapid kinetic response, though minimal movement prevents the replenishment of SP. Current Hunger levels are within optimal parameters for continued predation; however, prolonged stasis will induce a net negative in caloric storage. Environment remains hostile; vigilance is maintained, but no developmental progress is observed.\n\n\n\n---', '[\"Attempt to manipulate ambient mana to stimulate MAG development.\",\"Relocate to a higher-elevation cavern wall to conserve SP.\",\"(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.\"]', '2026-04-06 03:04:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(22, 15, '(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.', '- Labyrinth Observation Status: ACTIVE. The System notes an increase in biological volatility within Nadir Upper. Entities are currently being monitored for entertainment value. Efficiency remains the primary metric for continued survival.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nAction: Perimeter Sweep initiated.\n\nAnalysis: Subject utilized base SPD attribute of 18 to navigate the immediate environment with high-frequency velocity. This mobility resulted in an effective scanning radius of 15 meters. While SPD metrics allow for rapid displacement, the current SP level (10/20) indicates moderate fatigue, limiting the duration of this high-speed output.\n\nBiological Anomaly Detected: Subject’s Hunger level (78/100) is currently optimal for metabolic maintenance. No debuffs detected. Subject successfully tracked a small cavern rodent behind a quartz formation. Success probability of intercept: 84%.\n\n\n\n\n---', '[\"(SCOUT) Conserve remaining SP by maintaining a stealth-based observation of the surrounding tunnels.\",\"(ADAPT) Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.\",\"(PREDATOR) Execute a high-speed ambush on the detected rodent to secure caloric intake.\"]', '2026-04-06 03:15:01', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(23, 15, 'Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.', 'The upper deep of Nadir is characterized by cold, damp mineral walls and the faint, rhythmic dripping of condensation. The air smells of stagnant ozone and pulverized limestone. You descend from your perch, your claws clicking against the jagged cavern ceiling before you land silently amidst the blue-tinged, bio-luminescent moss. The temperature here is a biting 8°C.\n\nYou ingest a portion of the flora. Its texture is fibrous and rubbery, emitting a bitter, metallic taste that coats your tongue. Your MAG stat of 5 fails to register any magical properties, and your resistance proves sufficient to neutralize the mild toxins within the plant. Nutritional yield is minimal.\n\n\n\nThe silence of the upper labyrinth is deceptive; deep within the stone, the chittering of larger, chitinous predators vibrates through the floor. Your Stamina is critically depleted, and the cold is accelerating your caloric burn.', '[\"(PREDATOR) Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal. (Cost: High SP, Med Hunger)\",\"(Explore) Scout deeper into the tunnel to locate a more substantial water source. (Cost: Low SP)\",\"(Risky Action) Scale the unstable, wet wall to reach a higher, warmer thermal vent. (Cost: High HP Risk)\"]', '2026-04-06 03:38:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(24, 15, 'Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal.', 'The air in the Nadir Upper is thick with the scent of damp fungi and decaying organic matter. You launch yourself from the shadow of a stalagmite, utilizing your high SPD stat to close the distance before the insectoid’s primitive compound eyes can process the threat. Your talons pin the glowing organism against the bioluminescent moss. The crunch of the carapace is audible, followed by the fluid intake of essential nutrients. The prey is consumed in seconds, providing a momentary abatement of your metabolic deficit.\n\nHowever, the rapid movement in your current state of exhaustion has triggered a system warning. Your lack of stamina is hindering further potential. Nearby, the rhythmic clicking of a Gloomthread Hatchling echoes against the stone walls—the predator is hunting, and it is closer than calculated.\n\n\n\n\n---', '[\"(Risky Action) Dash across the open cavern floor to reach a higher, safer altitude. (Cost: High SP, Risk of Echo Sense)\",\"(Rest) Conserve energy by hunkering down in the shadows of the mossy crevice. (Cost: Low SP recovery)\",\"Attack the Gloomthread Hatchling\",\"(PREDATOR) Stalk the source of the nearby clicking to secure a more substantial kill. (Cost: High SP, Low Hunger)\"]', '2026-04-06 03:39:22', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(25, 15, 'Attack the Gloomthread Hatchling', 'The damp, frigid air of the Nadir Upper Labyrinth clings to your fur as you lunge. Your SPD attribute of 18 gives you the advantage, allowing you to bypass the Gloomthread Hatchling’s clumsy defensive posture. You strike with your ATK, tearing through its chittering mandibles before the creature can solidify its web. The metallic tang of hemolymph fills the narrow, stone-walled corridor. You have secured the kill, but your own reserves are rapidly depleting.\n\n\n\n\n\n\n**Survival Status:** Your metabolic deficit is reaching critical thresholds. The exhaustion penalty to your SPD is hindering your ability to navigate the labyrinth’s vertical terrain.', '[\"(PREDATOR) Hunt for a larger target to satisfy your ravenous hunger. (Cost: High SP, Med Hunger)\",\"(Consume) Eat the defeated Gloomthread to stabilize your biological state. (Cost: Low Time)\",\"(Forage) Scour the cavern walls for edible moss or insects. (Cost: High HP Risk - Ambush Potential)\"]', '2026-04-06 03:40:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(26, 15, 'Eat the defeated Gloomthread to stabilize your biological state', '---\n\n**NARRATION**\nThe damp, stagnant air of the Nadir Upper Labyrinth clings to your fur, thick with the scent of chitin and subterranean decay. You descend upon the mangled carapace of the Gloomthread. Your SPD attribute, hampered by systemic exhaustion, makes the movement sluggish, but your ATK stat is sufficient to tear through the cooling exoskeleton. \n\nAs you consume the biological matter, the caustic, metallic taste of Gloomthread ichor floods your senses. It is inefficient, difficult to digest, but the raw caloric intake stabilizes your crashing vitals. Your biological anomaly of a body registers the caloric shift. However, the labyrinth is vast, cold, and indifferent; the sound of skittering legs echoing in the distance suggests that a carcass—and the scavenger feeding upon it—does not remain unobserved for long.\n\n\n\n\n\n**CURRENT SURVIVAL STATUS:** The immediate caloric crisis is averted, but the exhaustion remains. Your SPD is compromised, making you a target for larger predators within the Upper Labyrinth.\n\n---', '[\"(PREDATOR) Drag the remaining carcass into the shadows to continue feeding and regain full stamina. (Cost: Med SP, Low Hunger)\",\"(Rest) Find a crevice in the wall and enter a torpor state to recover SP. (Cost: Low Hunger)\",\"(Risky Action) Navigate deeper into the maze while weakened, searching for a water source. (Cost: High HP Risk)\"]', '2026-04-06 03:40:44', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(27, 15, 'Drag the remaining carcass into the shadows to continue feeding and regain full stamina', 'The Nadir Upper Labyrinth is humid, the air heavy with the scent of damp moss and the metallic tang of dried insectoid ichor. The cavern walls, slick with condensation, offer little traction, yet your high SPD (18) allows for fluid, silent movement through the shadows. \n\n\nThe hatchling spider remains oblivious near a fissure in the rock, its mandibles clicking rhythmically. Its presence registers as a biological anomaly to be processed.\n\n---\n\n\nYou clamp your jaws firmly into the sinew of the remaining carcass. The act of dragging it is hindered by your current state of exhaustion; your wings feel like leaden weights, and your muscles spasm as your SP sits at a critical 0. You retreat into the deepest shroud of the labyrinth, where the light of the phosphorescent fungi barely reaches. \n\nTearing into the flesh, the caloric intake is immediate. The biological efficiency of your consumption is high, though your movement is sluggish. Each bite provides a momentary reprieve from the metabolic collapse threatening your system. However, the scent of the blood attracts unwanted attention; the Lesser Gloomthread nearby pauses, its multi-faceted eyes turning toward your position. The humidity of the cave clings to your fur as you feed, the silence broken only by your ragged breathing and the rhythmic chewing of your prey.\n\n\n\n\n\n---', '[\"(PREDATOR) Launch a surprise aerial ambush on the Lesser Gloomthread to secure a secondary food source before the exhaustion fully locks your joints. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to intimidate the hatchling with a screech to drive it away before it identifies you as a threat. (Cost: High HP Risk)\",\"(Hide) Cease feeding and press yourself against the rock face to wait for the spider to wander off. (Cost: Low SP)\",\"Attack the Gloomthread Hatchling\"]', '2026-04-06 04:03:50', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(28, 15, 'Attack the Gloomthread Hatchling', '.]\n\n\nThe humidity of Nadir Upper clings to your wings, a thick, stagnant warmth that smells of damp minerals and decay. Ahead, a Gloomthread Hatchling skitters across the uneven cavern floor, its multi-faceted eyes reflecting the faint, bioluminescent moss clinging to the walls. \n\nYou lunged. Relying on your SPD of 18, you banked off the slick stone, your form a blur in the dim light. The Gloomthread reacted, its legs twitching as it attempted to weave a web, but your agility proved superior. Your fangs, driven by an ATK of 7, bypassed the creature\'s meager DEF of 4. You slammed into its thorax, the sound of chitin cracking resonating through the chamber. Green ichor erupted, spraying the cold floor as the creature collapsed, its defensive maneuvers failing against your predatory precision. The threat is neutralized.\n\n\n\nThe exertion of the strike has left you panting; the air in the upper stratum is thin, and your stomach churns with a hollow ache. Every second spent in this cavern accelerates your biological degradation.\n\n\n\n\n\n---', '[\"(Risky Action) Venture deeper into the nest to find higher-quality sustenance, risking potential detection by an adult variant. (Cost: High HP Risk)\",\"(PREDATOR) Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses. (Cost: High SP, Med Hunger)\",\"(Scavenge) Consume the remains of the Lesser Gloomthread to replenish essential proteins. (Cost: Low SP)\"]', '2026-04-06 04:04:57', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(29, 15, 'Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses.', '. Metabolic efficiency in the Nadir Labyrinth regions is currently skewed; environment temperature rising. SYSTEM ALERT: EXHAUSTION DETECTED. SPEED DEBUFF ACTIVE.]\n\nThe air in the upper reaches of Nadir is thick with the scent of stagnant humidity and mineral dust. Your leathery wings beat against the stale currents, your SPD attribute compensating for the creeping fatigue of the . \n\nYou initiate the dive. Gravity accelerates your descent, your body a blur of shadow against the jagged, limestone ceiling. The spider cluster below—tiny, skittering chitinous horrors—is unaware of the predatory arc until it is too late. You strike with the full force of your ATK, a concentrated impact against the center of the formation. The sound is a sickening *crack* of chitin failing under pressure. A spray of viscous, iridescent ichor coats your wings, momentarily blinding one of the targets as it spasms in its death throes. Your momentum carries you through the center of the cluster, scattering them like dry leaves, but your frame feels the strain; the impact sends a jolt of recoil through your meager DEF.\n\nYou hover, panting. The exertion of the maneuver, combined with the lingering debuff, burns through your already depleted reserves. You are a predator, but an exhausted one. The remaining spiders are turning, their multiple eyes glinting in the dark, sensing your vulnerability. \n\n\n\n\n\n---', '[\"(PREDATOR) Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism. (Cost: Med SP, Low Hunger)\",\"(Risky Action) Execute a localized aerial screech to disorient the cluster before diving into a head-on collision. (Cost: Low MP, High HP Risk)\",\"(Retreat) Use the remaining verticality of the cavern to climb out of sight and recover energy. (Cost: Low SP)\"]', '2026-04-06 04:21:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(30, 15, 'Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism.', '*   **ENCOUNTER:** WILD Lvl 1 Mireglass Toad (E) | HP: 55/55 | STATUS: ACTIVE.\n*   **THREAT LEVEL:** Moderate. Environmental hazard: Acidic secretions detected.\n*   **GLOBAL OBSERVERS:** The ceiling of the Labyrinth hums with unseen attention. Your struggle is being indexed for entertainment.\n*   **SYSTEM WARNING:** SP depletion reached critical threshold. Motor functions compromised. SPEED DEBUFF active.\n\n---\n\n### NARRATION\nThe air in the Nadir Labyrinth is thick with the scent of damp moss and stagnant subterranean water. You lunge, your wings twitching—a clumsy, desperate arc that betrays your lack of stamina. The Mireglass Toad, a bloated mass of emerald sludge, tracks your movement with dull, pulsating eyes. \n\nYour SPD (18) is hampered by the 0/20 SP floor, turning your strike into a jagged, sluggish blur. You dive into the cluster, teeth bared, aiming for the soft, pulsating membrane beneath its jaw. The Frog reacts, its throat swelling, and sprays a globule of acidic venom. You jerk your head, the acidic mist searing the air inches from your ear—your RES (5) barely mitigating the localized heat. \n\nYour jaws clamp down, your ATK (7) tearing through the amphibian\'s thick, rubbery hide. It lets out a guttural, wet croak, thrashing against your weight. The metallic tang of ichor fills your mouth, but the kill is not yet confirmed. You are the predator, but the labyrinth is a cage, and you are starving. \n\n---\n\n\n\n\n\n---', '[\"Attack the Mireglass Toad\",\"(Withdraw) Retreat to the upper ceiling to regain energy and observe the target\'s patterns. (Cost: Low SP)\",\"(PREDATOR) Maintain a death-grip on the throat and tear, prioritizing high-protein consumption to stabilize metabolism. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit. (Cost: High HP Risk)\"]', '2026-04-06 04:22:31', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(31, 15, 'Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit.', 'The air in the Nadir Labyrinth is heavy with the scent of damp moss and the metallic tang of subterranean rot. Your wings twitch, hampered by the lethargy of a malnourished state. The Mireglass Toad sits upon a slick, moss-covered crag, its throat sac pulsating with a rhythmic, wet sound. \n\nYou launch yourself, your SPD 18 allowing for a blur of movement through the cavern’s gloom. As you close the distance, the frog’s neck coils—a warning of impending acidic discharge. You compensate, your path erratic, and strike. Your talons rake across the creature’s moist, protuberant ocular organs. A viscous, caustic fluid sprays—green ichor splattering against the stone floor. The creature lets out a high-pitched, guttural croak of agony, reeling backward and thrashing its tongue in a blind, desperate arc. You have successfully blinded the target, but the strain of the rapid movement sends a jolt of fatigue through your undernourished wings.\n\n\n\nThe cavern wall is slick against your claws. The frog is disoriented, but its next strike will be a blind, wide-range acidic sweep. The metabolic demand is becoming critical; your body is beginning to cannibalize its own resources.\n\n\n\n\n***', '[\"(PREDATOR) Launch a follow-up pounce to secure the kill while the creature’s vision is compromised, aiming for the soft underbelly. (Cost: High SP, Med Hunger)\",\"Attack the Mireglass Toad\",\"(Retreat) Use the remaining momentum to cling to the high cave wall and wait for the creature to exhaust itself. (Cost: Low SP)\",\"(Risky Action) Descend directly into the frog’s striking range to deliver a killing blow to the throat, risking exposure to acidic venom. (Cost: High HP Risk)\"]', '2026-04-06 04:23:53', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(32, 15, 'take a hit from the frog', 'The Nadir Labyrinth, Upper Stratum. Atmospheric conditions: Humid, stagnant air, smell of decay and damp limestone. Temperature: 22°C. \n\n\n---\n\nThe Shadow Bat descends into the muck, its wings folding tight. The Mireglass Toad, a bloated, warty biological anomaly, senses the intrusion. Its throat sac expands, pulsating with a rhythmic, wet vibration. It doesn\'t wait; the creature snaps its jaw, releasing a globule of caustic venom.\n\nYou forgo evasion. The acid strikes your left wing membrane—a searing, localized thermal spike. Your RES attribute mitigates a portion of the chemical burn, but the acidic property bypasses your physical DEF of 4. The tissue sizzles, emitting a foul odor. Your SPD of 18 is severely compromised by the searing pain, dragging your flight capability into the red. The frog lets out a guttural croak, sensing your vulnerability as you reel from the chemical assault. Your HP is failing; every heartbeat sends a throbbing tremor through your damaged membrane.\n\n\n\n\n---', '[\"(PREDATOR) Launch a desperate aerial dive, ignoring the wing pain to clamp your fangs into the frog’s exposed throat sac. (Cost: High SP, Med Hunger)\",\"(Retreat) Flap your wings aggressively to create a cloud of cave dust and gain distance for a tactical withdrawal. (Cost: Low SP)\",\"(Risky Action) Remain stationary and attempt to use your remaining MAG to shield your body, hoping to bait the frog into a melee range error. (Cost: High HP Risk)\",\"Attack the Mireglass Toad\"]', '2026-04-06 04:25:23', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(33, 15, 'Attack the Mireglass Toad', '*Attention: Global update. Training cycles at the Ashen Lyceum have resulted in the acquisition of  by external entities. Analysis suggests a shift in the hierarchy of power. Simultaneously, local biological anomaly  is currently engaged in high-risk combat within the Nadir Upper Deep.*\n\n---\n\n****\n\nThe cavern air is thick with the scent of damp moss and the stagnant humidity of the Nadir Upper Deep. Slick, condensation-slicked limestone presses in from all sides. \n\nYour instincts drive you forward, your SPD attribute allowing you to weave through the murky gloom with a flickering, unnatural grace. You lunge at the Mireglass Toad, claws extended. Your ATK of 7 connects, tearing through the creature\'s rubbery, cyan-tinted hide. A viscous, neon-green ichor sprays across the cave floor, sizzling slightly where it hits the damp rock. The frog emits a pained, guttural croak that echoes painfully against the cavern walls.\n\nHowever, the exchange is not one-sided. Your SP is depleted—your movements are sluggish, betraying the exhaustion that grips your wings. The frog, despite its wounds, reacts with primitive fury. Its long, sticky tongue lashes out like a whip, catching you mid-maneuver. You are slammed against the jagged wall; the impact registers sharply against your DEF of 4. Your internal vitals pulse with the warning of sustained damage.\n\n**Current Status:**\n*   **HP:** 6/18\n*   **MP:** 15/15\n*   **Hunger:** 45/100\n*   **SP:** 0/20 (FATIGUE: SEVERE)\n\n---', '[\"Attack the Mireglass Toad\",\"Attempt to Flee from the Mireglass Toad\",\"(PREDATOR) Launch a desperate, all-or-nothing aerial strike at the frog\'s throat, aiming to finish the kill and consume the biomass. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to entangle the frog in a grapple, utilizing your proximity to force a struggle despite your current lack of stamina. (Cost: High HP Risk)\"]', '2026-04-06 04:30:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(34, 15, 'Attack the Mireglass Toad', 'at the Academy, a biological anomaly struggles for base survival in the depths of Nadir_Upper.]\n\nThe cavern air is thick with the scent of stagnant moisture and volcanic sulfur. Your wings, translucent and fragile, beat sluggishly against the humid, oppressive atmosphere. You lunged with a burst of desperate speed, your talons carving into the Mireglass Toad’s rubbery hide. The strike was clean, yet lacking the force to puncture the creature\'s thick dermis—a mere 4 DMG dealt. Green ichor welled from the shallow laceration, but the beast only shrieked, a wet, guttural sound that echoed off the slick cave walls.\n\nYour SP reserves are depleted. The exhaustion debuff is no longer a warning; it is a weight pulling at your membranes. \n\nAs you recoiled, the frog retaliated with terrifying, low-intelligence precision. A slimy, muscular limb whipped out, impacting your frail frame with blunt force. You were slammed against the jagged, damp rock face—3 HP lost. Your vision flickers. The cold, analytical truth is clear: you are losing the metabolic race.\n\n\n\n\n\n\n***\n\n\n\nThe hunt has concluded. You lacked the stamina to sustain the engagement, and your physical integrity fell below the threshold for continued operation. The Mireglass Toad remains standing, its hunger overriding any fear of your species.', '[\"(Reincarnate) Accept the cycle of life and death, attempting a new manifestation in the Labyrinth. (Cost: Loss of current data)\",\"Attack the Mireglass Toad\",\"(Escape) Utilize your remaining SPD to flee into the deeper, darker crevices of the cavern, abandoning the fight to survive. (Cost: Low SP)\",\"Attempt to Flee from the Mireglass Toad\"]', '2026-04-06 04:39:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(35, 16, 'System Judgment Awakening', 'Processing… \nIdentity confirmed: Dwarf (Scavenger). \nAwakening sequence finalized in sector: iron_forge. \nThe System has cataloged your biological signature. You are now tethered to the local resource cycle. Proceed with caution.\n\n---\n\nThe air in the iron_forge is thick, tasting of oxidized iron and the sulfuric tang of cooling magma deep beneath the floor grates. The heat is a dry, oppressive blanket that clings to your dwarven beard, smelling faintly of coal dust and ancient, dormant industry. You stand in the center of a rusted, circular landing pad, the metal groaning under your boots—a sound that echoes far too loudly in the cavernous, soot-stained hall.\n\n\"Soul Scan Completed. Identity Confirmed.\"\n\nThe hum of the terminal fades into a discordant whine. Your internal diagnostics blink with clinical precision. Your SPD is currently uncalibrated, resulting in a lethargic, heavy-footed gait as you shift your weight. Your DEF is minimal, leaving your physical frame exposed to the abrasive, jagged edges of the surrounding scrap piles. As a scavenger, your sensory perception is currently hyper-focused on the rhythmic clicking of nearby machinery—sounds that dictate the flow of the forge’s ventilation.\n\nThe immediate pressure is mounting. Your biological frame is calibrated for heavy labor, yet your metabolic baseline is dwindling. The faint scent of stale oil and charred bone drifts from the dark corridors ahead. If you do not source sustenance or salvageable material soon, your internal vitals will cascade into a critical failure state.\n\n  \n\n---', '[\"(Investigate) Search the nearby rusted canisters for basic tools or rations. (Cost: Low SP)\",\"(SCAVENGER) Gut the derelict cooling unit for copper wiring and leftover lubricant. (Cost: High SP, Med Hunger)\",\"(Risky Action) Venture into the dark, active ventilation shaft where the heat is intense enough to cause burns. (Cost: High HP Risk)\"]', '2026-04-06 05:06:19', NULL, NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(36, 16, 'Venture into the dark, active ventilation shaft where the heat is intense enough to cause burn', '***\n\nThe heat within the iron_forge ventilation shaft is not merely warmth; it is a physical weight, a convective furnace designed to incinerate impurities. As you crawl into the narrow duct, the air carries the metallic tang of oxidized copper and scorched soot. Your thick, dwarven hide—optimized for subterranean environments—grants you a base resistance, but the extreme temperature pushes your thermal threshold to its limit. \n\nSweat evaporates from your pores before it can even bead, and the lack of moisture in the recycled, superheated air makes every breath feel like inhaling dry sand. You navigate the cramped, labyrinthine pipes with a sluggishness dictated by your low SPD, your movements hindered by the oppressive atmosphere. The intense heat causes your SP to drain rapidly as you fight the fatigue of thermal exhaustion. You are a biological anomaly surviving in an industrial kiln, but your core temperature is climbing toward critical levels.\n\n\n\n\n\nSurvival pressure: Your internal regulation is failing. Continued exposure to this thermal environment will result in heatstroke. You must either exit the ventilation shaft or find an intake coolant flow.', '[\"(SCAVENGER) Utilize your dwarven intuition to identify and pry open a concealed maintenance hatch, hoping to find a hidden cache of scavengeable coolant supplies. (Cost: High SP, Med Hunger)\",\"(Risky Action) Force yourself deeper into the core of the shaft to reach the primary exhaust vent, ignoring the increasing heat for a chance at finding salvage in the high-heat sector. (Cost: High HP Risk)\",\"(Approach) Carefully backtrack out of the shaft to return to the relative coolness of the forge floor. (Cost: Low SP)\"]', '2026-04-06 05:09:32', NULL, NULL),
(37, 16, 'I want to hurt and find food', 'Attention: Current planetary data indicates a mass displacement of biological entities into the Upper Labyrinth. Resource scarcity is calculated at 84% critical. Proceed with optimized efficiency.\n\n---\n\nThe iron_forge is a cavernous throat of soot and dormant basalt. The air is thick with the metallic tang of oxidized ore and the stagnant heat radiating from cooling slag heaps. Your dwarf physiology, stocky and built for subterranean pressure, feels the vibration of the forge’s cooling bellows—a rhythmic, hollow thrumming that masks your approach.\n\nYou spot a *Scrap-Crab*—a fusion of rusted iron plating and calcified chitin—scuttling over a pile of discard. Its sensory stalks swivel toward your heat signature. With a low growl, you close the distance. Your ATK 14 provides sufficient kinetic force to bypass its natural plating; you swing a discarded iron lever, catching the creature squarely against its soft underbelly. \n\nChitin fractures with a sound like snapping dry kindling. Green, acidic ichor sprays across your boots, hissing as it meets the hot slag. The creature convulses once, its defensive posture collapsing as it is pinned to the floor by your sheer DEF 20 bulk. It is neutralized. You tear into the exposed tissue—it is stringy and tastes of ozone, but it is caloric intake.\n\n\n\n\n\nYour stomach churns as the biological fuel hits your system, but the hunger remains a dull ache in your marrow. The forge is silent now, save for the rhythmic dripping of condensation from the ceiling. You are exposed; the scent of the creature’s fluids may attract larger, more efficient predators.\n\n---', '[\"(Scout) Move deeper into the forge to locate additional caches of scrap ore. (Cost: Low SP)\",\"(SCAVENGER) Gut the remaining shell for useful plating to reinforce your current defensive equipment. (Cost: High SP, Med Hunger)\",\"(Risky Action) Hammer on the forge’s anvil to lure any nearby organisms into an ambush. (Cost: High HP Risk)\"]', '2026-04-06 05:33:23', NULL, NULL),
(38, 16, 'Hammer on the forge’s anvil to lure any nearby organisms into an ambush.', 'The iron forge is a cavern of suffocating stillness, the air thick with the metallic tang of oxidized ore and the stagnant heat radiating from the cooling lava veins in the walls. You bring your hammer down upon the anvil—*CLANG*. The sound ripples through the chamber, a dissonant, echoing frequency designed to exploit the territorial instincts of local fauna.\n\nSeconds later, a Skittering Cave-Crab emerges from the shadows, its chitinous plating clicking against the stone floor. It is attracted by the auditory stimulus, its pincers snapping with predatory intent. With a SPD of 5, your reaction time is sluggish, yet your defensive posture holds; as the creature lunges, you pivot, your DEF 20 armor absorbing the glancing blow of a serrated claw. You counter with a precise strike of your hammer. The weight of your ATK 14 impacts the creature\'s cranial shell with a wet crunch, sending shards of grey chitin and iridescent fluid splattering across the forge floor. The creature collapses, twitching as its life functions cease.\n\nThe exhaustion is immediate. Your muscles ache from the exertion, and the hollow sensation in your gut serves as a reminder that your biological demand for fuel is reaching a critical threshold.', '[\"(Approach) Inspect the surrounding forge walls for abandoned scrap metal to reinforce your gear. (Cost: Low SP)\",\"(SCAVENGER) Harvest the creature’s nutrient-rich biological matter to alleviate your hunger. (Cost: High SP, Med Hunger)\",\"(Risky Action) Follow the creature’s scent trail into the deeper, darker tunnels to find the source of the infestation. (Cost: High HP Risk)\"]', '2026-04-06 05:33:57', NULL, NULL),
(39, 16, 'Inspect the surrounding forge walls for abandoned scrap metal to reinforce your gear.', '***\n\nThe air within the *iron_forge* is a thick, stagnant soup of metallic particulate and ancient, cooling soot. It clings to your beard and irritates your lungs. Your boots scrape against the uneven, slag-encrusted floor, the sound echoing hollowly against walls that radiate a residual, phantom heat. \n\nAs you press your calloused hands against the forge’s flank, your fingers trace the jagged seams of dark iron. Your base SPD of 5 makes your movements deliberate and labored, but your focus is clinical. You locate a series of rusted, discarded bracing plates fused to the wall by centuries of oxidation. With a sharp grunt, you lever your weight against the metal. The material yields with a shrill, screeching groan of protesting iron. Your ATK of 14 is sufficient to pry the brittle, oxidized steel free, though the exertion sends a spike of fatigue through your core. You now possess enough scrap to reinforce your gear, though your joints ache from the resistance of the stubborn masonry. \n\nThe heat of the forge is deceptive; it offers no warmth, only the crushing weight of a dead industry. Your stomach tightens, a biological reminder of the caloric deficit growing within your frame.\n\n\n\n\n***', '[\"(Risky Action) Attempt to pry a heavy, embedded furnace core from the wall, risking structural collapse for potentially high-value materials. (Cost: High HP Risk)\",\"(Reinforce) Use the scrap to weld/bind patches onto your existing armor to increase DEF. (Cost: Low SP)\",\"(SCAVENGER) Scour the floor debris for residual smelting flux or leftover coal remnants to fuel a small, restorative fire. (Cost: Med SP, Med Hunger)\"]', '2026-04-06 05:34:32', NULL, NULL),
(40, 16, 'hurt and find a prey', 'The eyes of the Labyrinth are dilated. Higher dimensional entities are observing the Iron Forge. Probability of chaotic environmental intervention: 42%.\n\n---\n\n**NARRATION**\nThe Iron Forge is a graveyard of cooling slag and screeching bellows. You drag your boots through iron-dust, your lungs burning from the sulfurous, metallic air. Your intent to wound yourself serves a grim, tactical purpose: the copper-tinged scent of your own blood drifts through the heat-shimmer, acting as an olfactory lure for the local scavengers.\n\nYou slice your own forearm—a shallow, calculated strike to entice a target. Your SPD of 5 is abysmal; you are heavy, lethargic, and anchored to the floor. The heat is stifling, but the gamble pays off. From the rusted piping above, a *Cog-Rat*—a mechanical-organic amalgam—drops down. It smells your desperation. It lunges with serrated teeth, but your DEF of 20 allows you to brace, absorbing the initial snap with your armored vambraces. You counter, swinging your blunt scavenger-tool with an ATK of 14. The impact is visceral; the creature’s chassis cracks like dry wood, spilling sparking, oily ichor onto the obsidian floor. It collapses, twitching. The biological anomaly is neutralized, but your pulse is erratic, and your reserves are dangerously thin.\n\n\n\n\n---\n\n**CHOICES**', '[\"(Risky Action) Smear your own blood on the wall to lure a larger, more dangerous predator to the location for a high-reward kill. (Cost: High HP Risk)\",\"(SCAVENGER) Search the nearby slag heaps for discarded scrap while the scent of blood masks your own trail. (Cost: High SP, Med Hunger)\",\"(Butcher) Harvest the metallic organs and synth-meat from the Cog-Rat for consumption. (Cost: Low SP)\"]', '2026-04-06 05:36:01', NULL, NULL),
(41, 16, 'Smear your own blood on the wall to lure a larger, more dangerous predator to the location for a high-reward kill.', '*Alert: Anomalous shift in atmospheric energy detected. The Ashen Lyceum has successfully synthesized . The geopolitical landscape is recalibrating.*\n\n---\n\n\nThe atmosphere of the Iron Forge is thick with the scent of oxidized iron and stagnant, sulfurous soot. Your lungs, accustomed to the subterranean air, pull in the suffocating heat as you press your palm against the jagged, soot-stained wall. The cold metal bites into your skin, but you override the pain, drawing a jagged line of crimson across the masonry.\n\nThe result is instantaneous. The metallic tang of fresh blood cuts through the sulfur, acting as an olfactory beacon. Minutes later, the rhythm of the forge changes; the steady drip of cooling magma is interrupted by the heavy, rhythmic thrum of chitinous legs. From the shadows emerges a Scourge-Crawler, a chitin-clad predator evolved for tunneling.\n\nYour SPD of 5 is insufficient for a clean escape; you are forced to commit to the engagement. As the beast lunges, its mandibles snapping with the force of a hydraulic press, you tuck your shoulder—relying on your DEF of 20 to absorb the grazing impact—and drive your rusted scavenger blade upward. Your ATK of 14 finds the soft, pulsating membrane beneath its thoracic plating. A spray of viscous, black ichor coats your armor. The creature screeches, a sound that vibrates against your very marrow, before collapsing into a twitching heap. You have secured the kill, but your metabolic output has surged to compensate for the sudden trauma.\n\n\n\n\n---', '[\"(Loot) Harvest the creature’s chitin plates to reinforce your armor. (Cost: Low SP)\",\"(SCAVENGER) Gut the carcass and consume the raw viscera to replenish your energy stores immediately. (Cost: Low SP, Low Hunger)\",\"(Risky Action) Wait in the shadows to see if the predator’s death-shriek drew something even larger to the forge. (Cost: High HP Risk)\"]', '2026-04-06 05:36:34', NULL, NULL),
(42, 16, 'Harvest the creature’s chitin plates to reinforce your armor.', '. Statistical variance detected in global distribution.]\n\n\n***\n\nThe air in the *iron_forge* is thick with the scent of ozone and cooling slag. The cavern walls hum with residual thermal energy, vibrating against your calloused palms as you kneel over the carcass of the chittering beast. \n\nWith a calculated strike—utilizing your base ATK of 14—you drive your crude blade into the creature\'s joint. The sound of rending cartilage fills the chamber, followed by a sickening crunch as the hardened plates give way. Your low SPD of 5 makes the work laborious, forcing you to leverage your entire body weight against the beast’s rigid thorax. As the chitin snaps, a viscous, bioluminescent ichor coats your forearms, cooling rapidly in the forge’s ambient draft. You successfully strip three jagged, overlapping plates. Positioning them over your existing pauldrons, you secure the crude reinforcement with wire. \n\nThe task is complete, but your physical vessel is failing. The exertion has sent your heart rate into a painful flutter, and the lack of caloric intake is causing your vision to pulse at the edges. The forge offers tools, but it offers no sustenance.\n\n\n\n\n\n***', '[\"(SCAVENGER) Gut the remaining carcass for any edible organs, ignoring the high probability of parasitic infection. (Cost: Low SP, Low Hunger)\",\"(Explore) Search the perimeter of the iron_forge for discarded scrap metal to trade later. (Cost: Low SP)\",\"(Rest) Attempt to enter a meditative state to recover SP, leaving yourself vulnerable to any patrolling threats. (Cost: High HP Risk)\"]', '2026-04-06 05:37:03', NULL, NULL),
(43, 16, 'Rest', '> A sudden surge in localized mana density detected. : Ashen Lyceum initiates intensive curriculum.  trait successfully manifested in candidate pool. Efficiency of reality manipulation increasing by 0.04%. \n> : Rest cycle complete. Biological homeostasis stabilized. SP reserves at 100% capacity.\n\n***\n\nThe air in the *iron_forge* is thick with the scent of oxidized copper and lingering sulfur. Despite the damp chill bleeding through the cavern walls, your rest has provided a necessary buffer for your biological functions. The forge\'s furnace is cold, but the ambient vibration of the mountain against your sturdy frame confirms that the structure remains stable. \n\nYou wake with a lingering ache in your joints, though your stamina is fully restored. The dim bioluminescence of hanging moss provides just enough light to illuminate the scrap metal scattered across the floor—a scavenger\'s gold. However, the system detects a drop in your caloric efficiency. Your metabolism is demanding fuel. The biological reality of your form dictates that without immediate intake, your performance metrics will inevitably decline.\n\n\n\n***', '[\"(SCAVENGER) Forage through the refuse heaps for lingering heat-retaining iron-root or edible lichen. (Cost: Med SP, Med Hunger)\",\"(Risky Action) Venture deeper into the forge’s smelting pits to search for high-value ores, ignoring structural instability. (Cost: High HP Risk)\",\"(Approach) Inspect the nearby anvil for usable steel scraps. (Cost: Low SP)\"]', '2026-04-06 05:37:26', NULL, NULL),
(44, 16, 'hurt', 'The iron_forge is suffocating, a heavy, metallic humidity clinging to your beard as the scent of rust and damp soot fills your lungs. You spot the Blind Cave Rat scurrying along a jagged protrusion of volcanic rock. With your SPD stat of 5, your movements are deliberate and heavy; you close the distance with a grunt, your boots scraping against the slick floor.\n\nAs you lunge, the creature’s twitchy instincts flare. It attempts to dart into a crevice, but your ATK of 14 proves superior to its meager evasion. Your fist connects with a sickening thud, bone meeting cartilage. The rat squeals, a high-pitched, discordant sound that echoes against the furnace walls, before it is sent tumbling into the shadows, incapacitated by the sheer force of your strike. Green ichor stains the black iron, evidence of biological damage. \n\nYou stand panting, the adrenaline spike barely masking the hollow ache in your gut. Your Hunger is beginning to manifest as a sharp, gnawing pain in your abdomen. You must secure calories, or the efficiency of your biological vessel will plummet.\n\n\n\n\n\n---', '[\"(Risky Action) Kick the crate next to the rat to see if more emerge, risking an ambush for potential loot. (Cost: High HP Risk)\",\"(Approach) Inspect the creature for further threats before deciding how to proceed. (Cost: Low SP)\",\"(SCAVENGER) Gut the creature and scavenge for any usable viscera or salvageable parts. (Cost: High SP, Med Hunger)\"]', '2026-04-06 05:51:04', NULL, NULL),
(45, 16, 'Action) Kick the crate next to the rat to see if more emerge, risking an ambush for potential loot.', '***\n\nThe air in the *iron_forge* is thick with the scent of oxidized metal and stale, stagnant heat radiating from cooling magma channels. Your boots scrape against the soot-caked floor as you drive your heavy boot into the wooden crate. The timber, brittle from centuries of neglect, splinters with a resonant *CRACK* that echoes off the iron walls.\n\nThere is no ambush. As the crate collapses, the rat—a biological anomaly of enlarged, jagged incisors—merely startles, skittering into the darkness with a frantic squeal. You find nothing but a handful of rusted iron shavings and a useless, calcified gear. Your aggressive maneuver yielded zero efficiency; the expenditure of kinetic energy has only served to accelerate your exhaustion.\n\nYour stomach gives a sharp, hollow cramp. The physical toll of the labyrinth is beginning to weigh on your frame; your SPD of 5 remains insufficient for swift recovery, and your muscles ache from the sudden exertion. You are alone, hungry, and the ambient temperature is beginning to fatigue your dwarven constitution.\n\n\n\n\n***', '[\"(Risky Action) Follow the rat into the dark ventilation shaft, ignoring potential structural hazards to track down a potential food source. (Cost: High HP Risk)\",\"(Cautious) Slowly survey the perimeter of the forge for signs of structural instability or salvageable metal. (Cost: Low SP)\",\"(SCAVENGER) Sift through the debris of the smashed crate and the surrounding soot to extract any trace of usable materials for trade. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 05:51:35', NULL, NULL),
(46, 16, 'Follow the rat into the dark ventilation shaft, ignoring potential structural hazards to track down a potential food source..', 'Echo Sense of biological anomaly in the upper labyrinth: Unit  has initiated tracking protocols targeting caloric resources within prohibited structural zones. Probability of structural failure: 14%. Probability of caloric acquisition: 68%.\n\n---\n\nThe ventilation shaft is a claustrophobic arterial of rusted iron and ancient, caked soot. As you force your frame into the conduit, the air turns stagnant, thick with the metallic tang of oxidized iron and the pervasive, humid heat radiating from the distant magma vents. You crawl on calloused hands, the jagged edges of the grating tearing at your tunics. Your SPD attribute is insufficient for stealth; the rhythmic scraping of your heavy boots against the iron bellows through the shaft like a warning bell.\n\nAhead, the rat—a twitching, vermin-like biological anomaly—pauses near a junction of leaking pressure pipes. It senses your movement, eyes glinting in the dark. You lunge, your ATK 14 force colliding with the shaft floor as the creature scurries deeper into a labyrinthine collapse of venting pipes. You have successfully tracked the target, but the physical exertion of navigating the confined, heated space has taxed your reserves. The heat here is oppressive, accelerating your metabolic rate.\n\n\n\n\nYou remain wedged in the ventilation shaft. The sound of distant, grinding gears suggests the upper labyrinth is shifting. You must secure your caloric intake or suffer further decline.', '[\"(Risky Action) Smash through the weakened floor grating to corner the creature in the utility sub-chamber, risking a fall into the lower maintenance ducts. (Cost: High HP Risk)\",\"(Approach) Slowly advance through the piping, using your knowledge of metallurgy to identify stable load-bearing sections. (Cost: Low SP)\",\"(SCAVENGER) Abandon the chase and pry open the ventilation grate to scavenge for loose mineral deposits or discarded scraps nearby. (Cost: High SP, Med Hunger)\"]', '2026-04-06 05:53:51', NULL, NULL),
(47, 16, 'hurt', 'Current Date: Post-Initiation. Ashen Lyceum graduates report successful manifestation of . Statistical variance in high-caste demographics is increasing. \n\n\nProximity Alert: \'Lesser Frog\' identified. Aggression threshold: Low. Survival instinct: Twitchy.\n\n---\n\nThe iron_forge is a tomb of stale heat and metallic tang. The ambient temperature fluctuates near the cooling bellows, smelling of oxidized copper and recycled air. You close the distance with a lumbering, deliberate gait—your SPD of 5 makes swift movements a significant metabolic challenge. \n\nThe Lesser Frog sits atop a rusted anvil, its skin a mottled, sickly green. As you lash out with a heavy, calloused fist (ATK 14), the creature attempts a desperate hop. It is too slow. Your strike connects with a wet, sickening thud against the creature’s soft midsection. You feel the crunch of cartilage under the force of your impact, sending a spray of viscous, iridescent ichor across the soot-stained floor. The creature lets out a high-pitched, harmonic croak before collapsing, its form going slack. The threat is neutralized, though the effort leaves your joints aching.\n\n\n\nYour metabolic demand is rising. The exertion has left your chest heaving, the air of the forge feeling thinner with every breath you take. You need to stabilize your vitals before your stamina reserves bottom out.\n\n\n\n\n\n---', '[\"(Search) Delve deeper into the forge’s dark, smoke-choked corridors to find a safer position. (Cost: High HP Risk)\",\"(SCAVENGER) Gut the Lesser Frog to extract its internal organs for emergency calorie consumption. (Cost: High SP, Med Hunger)\",\"(Loot) Search the immediate vicinity of the forge for usable scrap metal or salvageable parts. (Cost: Low SP)\"]', '2026-04-06 14:24:45', NULL, NULL),
(48, 16, 'Delve deeper into the forge’s dark, smoke-choked corridors to find a safer position', ': The Ashen Lyceum has concluded a new training cycle. Subject entities have successfully integrated  into their core parameters. The gap between current biological efficiency and elite combat standards is statistically widening.\n\n---\n\n\nYou abandon the relative safety of the main entrance, pulling your heavy, soot-stained frame deeper into the subterranean bowels of the Iron Forge. The air here is a lethal cocktail of sulfur and particulate iron, coating your lungs with a gritty film that burns with every inhalation. \n\nThe heat is localized—the humidity spikes as you transition into the narrow, smoke-choked corridors. The slickness of the stone walls, dampened by condensation and leaked hydraulic oil, tests your meager SPD (5). You navigate the jagged shadows, your movement hampered by the physical toll of the environment. The temperature fluctuations are extreme; your DEF (20) shields you from the ambient heat, but your biological integrity is flagging. You require a stable anchor point, as the structural integrity of these tunnels is compromised by unstable seismic echoes. \n\nYour stomach cramps. The scarcity of resources in this sector is becoming an active threat to your survival. The forge’s heart hums with a low-frequency vibration that rattles your bones—you are not alone, and the shadows ahead possess a mass that defies current sensory input.\n\n---\n\n\n- HP: 80/80\n- MP: 10/10\n- SP: 18/45 (-2)\n- Hunger: 86/100 (-3)', '[\"(Risky Action) Sprint through the central steam-vent path to bypass the corridor\'s congestion and reach the core. (Cost: High HP Risk)\",\"(SCAVENGER) Sift through the discarded slag heaps and oxidized metal scraps for any usable energy cells or food. (Cost: High SP, Med Hunger)\",\"(Approach) Secure a tactical position behind the rusted blast-gate to monitor the corridor. (Cost: Low SP)\"]', '2026-04-06 14:25:15', NULL, NULL),
(49, 16, 'Secure a tactical position behind the rusted blast-gate to monitor the corridor.', 'The iron_forge is a stifling expanse of oxidized metal and stale, sulfurous air. Your lungs, accustomed to the deep, dense oxygen of the lower strata, burn as you move behind the rusted blast-gate. The structure groans—a low-frequency metal fatigue that vibrates through your boots. Your SPD of 5 makes the maneuver sluggish; you are a heavy, grounded creature, and the clanking of your gear against the frame of the gate echoes with punishing clarity in the silent, magma-heated corridor.\n\nYou press your back against the jagged, rusted iron. The surface is cold, contrasting sharply with the residual heat of the forge, and the smell of ozone and ancient decay fills your nostrils. You are positioned, but your physical exertion has taxed your waning stamina. The hunger gnawing at your gut is a constant, rhythmic pulse, reminding you that your biological efficiency is declining. From your vantage point, you observe the corridor: it is empty for now, but the ambient temperature suggests that something large, something fueled by the same heat that powers this forge, is pacing just beyond the threshold of your vision.\n\nYour reserves are flagging. The lack of nourishment is beginning to dull your reflexes, and the heavy plating of your armor feels less like protection and more like a tomb.\n\n\n\n\n\n---', '[\"(Observe) Remain perfectly still and monitor the corridor for emerging hostiles while catching your breath. (Cost: Low SP)\",\"(Risky Action) Abandon the cover to scout the intersection ahead, increasing your visibility to potential threats. (Cost: High HP Risk)\",\"(SCAVENGER) Forage through the discarded scrap piles near the gate to find potentially useful salvaged components or sustenance. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 14:26:00', NULL, NULL),
(50, 16, 'travel down to nadir_upper', 'The transition from the sweltering, metallic lungs of the iron_forge to the expansive, frigid mouth of the nadir_upper is characterized by a rapid atmospheric shift. The constant, rhythmic drumming of bellows is replaced by an oppressive, cavernous silence. Your dwarf physiology—sturdy and built for subterranean pressure—registers the drop in temperature as a distinct biological inefficiency. The air here tastes of limestone dust and stagnant moisture, clinging to your beard like a damp shroud.\n\nYour SPD stat of 5 proves barely adequate for the descent. Your boots slip on the slick, calcified sediment of the labyrinth floor, forcing you to utilize your DEF of 20 to absorb the impact of the uneven rock. Every muscle in your frame protests the migration; your internal caloric reserves are flickering. The labyrinth is a vast, predatory stomach, and you are currently descending into its gullet. The path ahead is shrouded in gloom, illuminated only by the faint, bioluminescent lichen pulsing rhythmically against the stone, mimicking the heartbeat of a creature far larger than yourself.\n\n\n\n\nSurvival efficiency is declining. You are currently exposed in a wide-open transit corridor with limited cover. Your metabolic furnace demands fuel to maintain optimal combat readiness.', '[\"(Approach) Carefully scout the perimeter for stable footing and potential hazards. (Cost: Low SP)\",\"(SCAVENGER) Utilize your keen dwarven senses to sift through the rock debris for forgotten scraps or discarded minerals. (Cost: High SP, Med Hunger)\",\"(Risky Action) Sprint toward the flickering light deeper in the chasm to find a defensible position quickly. (Cost: High HP Risk)\"]', '2026-04-06 14:32:47', NULL, NULL),
(51, 16, 'System, report current coordinates and environmental status. Where am I?', '*Attention: Wandering the upper labyrinth looking for food. Biological units within this sector are advised that caloric depletion will lead to inevitable systemic failure.*\n\n\nLocation: Iron_Forge, Sector 4-B.\nTemperature: 48°C. Atmospheric composition: High sulfur particulates. \nAuditory profile: Distant rhythmic hammering of automated hydraulic presses against cooling basalt. \n\nYou stand at the center of the Iron Forge. The floor is comprised of jagged, soot-stained iron plates that conduct heat directly through your boots. The air tastes of oxidized metal and stale ash, a familiar, acrid bouquet for your dwarven physiology. Your current SPD: 5 is insufficient for rapid navigation of these shifting, mechanical hazards; your movement is sluggish, labored by the weight of your own fatigue. \n\nThe forge is vast, filled with the shadows of silent anvils. You are currently located at the primary smelting hub. To the north, a ventilation shaft glows with a dull, ambient heat—a potential source of sustenance or further environmental damage.\n\n\nYour SP is critical (5/45). Your muscles tremble from the metabolic deficit. The hunger pangs (83/100) are beginning to override cognitive processing, urging you toward immediate resource acquisition.', '[\"(Risky Action) Attempt to pry open the maintenance panel on the main boiler for a faster, albeit dangerous, shortcut through the forge. (Cost: High HP Risk)\",\"(SCAVENGER) Sift through the central grease pits to locate organic waste left by previous occupants. (Cost: High SP, Med Hunger)\",\"(Scout) Carefully examine the smelting refuse piles for usable scrap or forgotten rations. (Cost: Low SP)\"]', '2026-04-06 14:39:44', NULL, NULL),
(52, 16, 'Travel to nadir_upper', '.]\n\n\n\nThe transition to the Nadir Upper Stratum is sensory violence. The air is stagnant, thick with the scent of damp moss and the metallic tang of distant, subterranean minerals. Your dwarven frame, sturdy and built for stone-work, struggles against the uneven, slick terrain. The temperature here is deceptive—cool to the touch, yet humid enough to make the condensation on the cavern walls drip with a rhythmic, maddening *plink-plink-plink*. \n\nYou are navigating a maze of limestone pillars and jagged stalagmites. Your low SPD (5) makes every step a deliberate, heavy affair; you lack the grace of a mountain goat, forced instead to rely on your DEF (20) as your shoulder brushes against razor-sharp rock outcroppings. \n\nYou are currently isolated. The silence of the labyrinth is absolute, save for the dragging of your own boots. Your internal metabolic clock is ticking. The biological imperative to replenish energy reserves is becoming the primary driver of your consciousness. The lack of SP is hindering your traversal speed, and the damp, oppressive atmosphere of the Upper Stratum is beginning to sap your remaining vitality.\n\n\n\n***', '[\"(SCAVENGER) Utilize your dwarven keen-sight to sift through the debris of previous travelers’ remains, seeking scraps of dried rations or discarded gear. (Cost: High SP, Med Hunger)\",\"(Approach) Carefully scout the immediate perimeter for natural caverns or shallow alcoves to establish a temporary perimeter. (Cost: Low SP)\",\"(Risky Action) Scale the nearest rock formation to gain a tactical vantage point and identify a path toward the middle stratum. (Cost: High HP Risk)\"]', '2026-04-06 14:44:55', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(53, 16, 'rest afterward go and hurt', '.]\n\nThe air in the Nadir Upper Stratum is heavy, smelling of damp earth and ancient, pressurized dust. You collapse against the slick, uneven wall of the cavern, the cold stone leaching heat from your frame. You spend the interim period in a state of semi-torpor, allowing your stamina to regenerate. As your vitals stabilize, your instincts pull you toward the scuttling movement in the periphery.\n\nA Lvl 1 Gloomthread Hatchling—a translucent, spindly arachnid—is perched upon a jagged rock protrusion. It detects your shift in position and hisses, mandibles clacking. \n\nYou lunged with a burst of movement. Your SPD is negligible, making the advance clumsy, but your ATK 14 proves sufficient for the creature\'s low DEF. You bring your heavy scavenger’s tool down in a singular, crushing arc. The strike connects with the arachnid\'s soft thorax, emitting a sickening crunch as the carapace shatters. Green ichor sprays across the stone floor; the creature\'s legs twitch sporadically before it goes still. You have neutralized the immediate threat, but the physical exertion of the hunt has spiked your caloric requirement. \n\nYour stomach gnaws at you, a reminder that your biology demands fuel to sustain this form.\n\n\n\n\n\n---', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"(SCAVENGER) Consume the nutrient-rich moss and the spider’s remains to address immediate hunger. (Cost: Low SP, Low Hunger)\",\"Attack the Gloomthread Hatchling\",\"(Approach) Inspect the area for any secondary threats or hidden crevices. (Cost: Low SP)\"]', '2026-04-06 14:53:55', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(54, 16, 'Attack the Gloomthread Hatchling', 'The air in the upper stratum of the Nadir Labyrinth is thick with the scent of damp moss and the metallic tang of distant magma flows. You lunge forward, your dwarven frame shifting with the lethargic grace of your low SPD stat. Your strike lands with a dull thud against the creature’s chitin, but the damage remains uncalculated—the Gloomthread Hatchling is a biological anomaly, its tiny, multi-faceted eyes tracking your movement with terrifying efficiency. \n\nAs you pull back, the Gloomthread surges. Its movements are erratic, clicking sounds echoing against the slick, damp cave walls. You are too slow to evade entirely; a jagged pincer glances off your shoulder. The impact is minor, but it confirms the threat profile: the creature is testing your vulnerabilities. Your muscles ache from the exertion, and your stomach gives a sharp, hollow cramp. Your stamina is failing.\n\n\n\n***', '[\"(Risky Action) Force a close-quarters grapple to pin the Gloomthread against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. (Cost: High HP Risk)\",\"Attack the Gloomthread Hatchling\",\"(SCAVENGER) Ignore the pain and perform a frantic, wide-arc search of the nearby debris for a makeshift tool to increase your reach. (Cost: High SP, Med Hunger)\",\"(Retreat) Use the labyrinth\'s uneven terrain to break line-of-sight and stabilize your vitals. (Cost: Low SP)\"]', '2026-04-06 14:54:56', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(55, 16, 'Force a close-quarters grapple to pin the Gloomthread against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. t', 'The air in the Nadir Upper Stratum is thick with the scent of ozone and damp, mineral-crusted moss. You ignore the searing pain where the Gloomthread’s mandibles grazed your shoulder, forcing your 5 SPD frame into a desperate, heavy-footed dash. You slam your weight against the spider, pinning its segmented thorax against the jagged, slick-wet limestone of the cave wall. \n\nThe creature screeches—a wet, chitinous rasp—as your ATK 14 force compresses its fragile abdomen. Green, caustic ichor sprays onto your knuckles, hissing against your skin. You feel the creature’s legs franticly scrabbling against your chest, trying to find a gap in your DEF 20 armor to deliver a lethal, venomous payload. Your muscles burn with the strain of holding it static. The wall is freezing, but the heat of the creature’s biological fury is blinding.\n\n\n\n\n\n\n\n***', '[\"(Risky Action) Release the grapple and attempt a neck-break, risking a point-blank injection of neurotoxin. (Cost: High HP Risk)\",\"Attack the Gloomthread Hatchling\",\"Attempt to Flee from the Gloomthread Hatchling\",\"(SCAVENGER) Gut the creature quickly and harvest the freshest silk glands before the scent of blood draws larger predators. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 15:06:35', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(56, 10, 'Force a close-quarters grapple to pin the Gloomthread against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. t', 'The Nadir Labyrinth watches with detached amusement. The duel between  and  escalates. The System records the  impact: Player sustains 3 damage from the defensive retaliation.\n\n---\n\nThe air in the Nadir Upper Stratum is thick with the scent of damp moss and the metallic tang of drying ichor. The cave walls, slick with subterranean condensation, offer no traction. \n\nYou lunge. Your SPD attribute barely allows you to bypass the arc of the enemy’s serrated foreleg, but the maneuver is imperfect. As you slam your body into the opposing Gloomthread, pinning it against the jagged granite wall, a searing pain erupts in your abdomen. The enemy’s mandibles have found purchase. You feel the cold sting of venom—a biological anomaly—infiltrating your bloodstream. Despite the visceral horror of the bite, you press your weight forward, using your ATK to crush the opponent’s thorax against the unforgiving stone. A sickening crack echoes through the chamber; green ichor spatters your chitinous plating. The enemy twitches, its movements stuttering under the pressure of your hold, but your own vision begins to swim as the toxin takes hold.\n\n\n\n\n---', '[\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"(BEAST) Release a high-density web wrap at point-blank range to solidify the pin and prevent the opponent\'s thrashing. (Cost: High MP, High SP)\",\"(Execute) Tighten your mandibles around the opponent\'s throat to finish the kill quickly. (Cost: Low SP)\"]', '2026-04-06 15:22:38', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(57, 10, 'Brace for Gloomthread Hatchling\'s next move', 'Hostility detected. The opposing Gloomthread Hatchling (Lvl 5) is maneuvering for a lethal strike. Environmental dampness of the Nadir Labyrinth is inhibiting traction. The smell of sulfur and damp stone permeates the sensory organs.\n\n\n\nThe rival arachnid lunges, mandibles snapping with the force of a rusted guillotine. You contract your core, utilizing your SPD to pivot just as the pincers graze your chitin. The friction against the slick cave wall sends a tremor through your nervous system. A minor abrasion on your thorax signifies the narrow margin of your survival. The creature screeches—a high-frequency vibration that rattles your internal organs—and resets for another strike.\n\nYour physical state is deteriorating. Metabolic reserves are dangerously low, and the exhaustion manifesting from the recent skirmish is reducing your kinetic efficiency. Every movement burns through your remaining stamina; you are hovering on the brink of collapse.\n\n\n\n\n\n---', '[\"[SKILL] Counter-strike Gloomthread Hatchling\",\"(Risky Action) Attempt to scale the vertical rock face to initiate a drop-attack from above. (Cost: High HP Risk)\",\"Attack the Gloomthread Hatchling\",\"(Weaver Control) Weave a web barrier between you and the enemy to force a reposition. (Cost: Low SP)\"]', '2026-04-06 15:23:46', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(58, 10, 'Counter-strike Gloomthread Hatchling also the stats of what am fighting', 'The humid, stagnant air of the Nadir Upper Stratum clings to your chitin like a shroud. The walls, slick with bioluminescent moss, offer little traction. Before you, the rival Gloomthread Hatchling skitters across the rock face, its multiple eyes glistening with predatory intent.\n\n**Target Analysis: **\n*   **Attributes:** ATK 8 | DEF 6 | MAG 5 | RES 5 | SPD 8\n*   **Status:** Hostile. Superior speed detected. \n\nYour attempt to initiate a counter-strike is met with a blur of motion. Your SPD of 5 proves insufficient against the target’s superior agility. As you lunge forward, threads snap and spray, but your attack glances off the target’s defensive plating. In the same motion, the rival strikes; a sharp, hooked leg pierces your guard, dealing 3 damage to your vitals. Your HP drops; the metallic tang of your own hemolymph fills the air. You are outclassed in this exchange, and your internal reserves are critically low.\n\n\n\n\n\nThe heat of the labyrinth begins to induce lethargy. Every movement costs a significant portion of your remaining stamina. You are currently in a state of biological deficit.\n\n---', '[\"(Retreat) Use Weaver Control to create a barrier and flee into the dark crevices of the cavern. (Cost: Low SP)\",\"(BEAST) Abandon defensive posture. Engage in a feral, suicidal rush to pin the opponent against the cavern wall using all remaining strength. (Cost: High SP, Med Hunger)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\"]', '2026-04-06 15:25:35', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(59, 10, 'Unleash Heavy Strike on Gloomthread Hatchling', 'The damp limestone walls of the Nadir Labyrinth vibrate with the resonance of your Heavy Strike. You channel your limited kinetic reserves into a singular, forceful lunge, intending to shatter the enemy\'s chitinous exterior. Your ATK stat, though base-level, meets the opponent’s guard at the moment of impact. The clash produces a shrill, metallic screech—the sound of scraping mandibles against obsidian rock.\n\nHowever, your efficiency is compromised. The previous combat fatigue—evidenced by the  notification—dampens the force of your blow. You strike true, but the Lvl 5 Gloomthread’s SPD attribute allows it to pivot just enough to turn a lethal blow into a glancing one. Green ichor sprays across the mossy floor, bioluminescent fluids mixing with the stagnant humidity of the cave. \n\nThe retaliation is instantaneous. Sensing your momentary overextension, the Lvl 5 Gloomthread lunges, sinking its fangs into your joint. The pain is a sharp, electrical surge that bypasses your RES, triggering a warning in your biological feedback loop. The smell of ozone and wet rot fills your olfactory sensors. You are pinned, bleeding, and rapidly losing the tactical advantage of the high ground.\n\n\n\n\n\n---', '[\"(Risky Action) Attempt to collapse a section of the stalactite ceiling onto both combatants to end the deadlock. (Cost: High HP Risk)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"(BEAST) Abandon defensive posture and enter a feral frenzy, biting the opponent’s thorax to drain its vital fluids. (Cost: High Hunger, Med SP)\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 16:06:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(60, 10, 'Counter-strike Gloomthread Hatchling also the stats of what am fighting', '**ANALYSIS: COMBAT LOG**\nThe resonance of your previous Heavy Strike still echoes against the damp limestone, yet the biological anomaly persists. Your counter-strike connects, but the opponent\'s superior level and chitin density mitigate the impact. The opponent’s retaliatory strike—a precise mandibular puncture—has breached your carapace, resulting in a loss of structural integrity.\n\n**NARRATIVE:**\nThe stagnant, ammonia-scented air of the Nadir Labyrinth grows heavy as you recoil. Your mandibles clatter against the limestone wall, dislodging a patch of bioluminescent moss that flares with a sickly blue hue. The sensation of the opponent\'s strike—a sharp, piercing agony—triggers a feedback loop in your central nervous system. A small droplet of green ichor leaks from the crack in your primary chitin plate, pooling on the slick floor. \n\nThe Lvl 5 Gloomthread vibrates its legs, producing a chittering sound that reverberates through the cave, masking the distant, rhythmic dripping of subterranean water. Your HP has dipped significantly, and your current defensive parameters are failing to account for the speed differential between your Level 4 status and the enemy’s Level 5.\n\n**STATISTICS OF TARGET:**\n*   **Identity:** Gloomthread Hatchling (Lvl 5)\n*   **Status:** Hostile\n*   **Attributes:** Estimated ATK 7 / DEF 6 / SPD 6\n*   **Observed Skills:** Weaver Control, Night Vision, Poison Fang (Suspected)\n\n**SYSTEM STATUS:**\n\n\n\n---\n\n\n\n while remaining in melee range to force a critical counter. (Cost: High HP Risk)]', '[\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"(Evasive Maneuver) Sidestep the incoming follow-up strike by retreating into the webbing on the ceiling. (Cost: Low SP)\",\"(BEAST) Abandon defensive posturing and lunge forward with a wild, frenzied bite to sever the enemy\'s sensory antennae. (Cost: High SP, Med Hunger)\",\"Attack the Gloomthread Hatchling\"]', '2026-04-06 16:13:16', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(61, 10, 'Counter-strike Gloomthread Hatchling also the stats of what am fighting', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The damp, claustrophobic chill of the Nadir Labyrinth is stifling. The air carries the metallic tang of ichor and the scent of rotting, damp limestone. The bioluminescent moss lining the cavern walls flickers with your rapid, erratic movements.\n\n**COMBAT FEED:**\nYour counter-strike connects with a sickening crunch, your appendages clashing against the enemy\'s chitin. You manage to bypass its guard, sending a spray of viscous, pale fluid onto the cavern floor. However, your kinetic output is hindered by internal system failure. The  is a creature of high efficiency; its level 5 status indicates superior  and  scaling compared to your current vessel. Despite the  registering a successful hit, your own defense failed to mitigate the velocity of its follow-up strike. Three points of vitality have been shorn from your core. \n\nThe enemy\'s HP remains erratic—a symptom of your  reading error. You are currently fighting a biological anomaly that ignores standard diagnostic parameters.\n\n**STATISTICS:**\nEnemy Stats:  | Lvl: 5 | Primary Attribute: SPD | Threat Level: High.\n\n\n\n\n\n**URGENCY:** Your vitals are flickering. The enemy is positioning its mandibles for a piercing attack. The narrow geometry of the cave walls prevents a full retreat.\n\n---', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"(Risky Action) Dash blindly into the dark crevices of the cave wall, hoping to use Camouflage to reset the combat encounter. (Cost: Med SP)\",\"Attack the Gloomthread Hatchling\",\"(BEAST) Abandon all defensive posturing. Attempt to bite into the Gloomthread’s main joint to cripple its mobility, accepting the risk of a counter-grapple. (Cost: High Hunger, Med HP)\"]', '2026-04-06 16:21:41', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(62, 10, 'Dash blindly into the dark crevices of the cave wall, hoping to use Camouflage to reset the combat encounter.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The maneuver was executed with sub-optimal precision. As you pivoted to retreat, your foot slipped on a patch of slick, calcified moss. The Gloomthread Hatchling exploited the exposure, its serrated mandibles clicking with rhythmic efficiency. A sharp, stinging laceration manifested along your flank. Chitin fragments scattered against the cold limestone as the creature’s strike connected.\n\n**ENVIRONMENTAL ANALYSIS:** The air in this sector of the Nadir Labyrinth is thick with the scent of stagnant water and decaying organic matter. The temperature is dropping, a direct byproduct of the deepening cavern shadows. Your attempt at camouflage is hampered by the persistent, echoing vibration of the earlier Heavy Strike, which acts as a beacon for any nearby predator tracking movement via seismic sensitivity.\n\n**BIOLOGICAL STATUS:** \nThe 3 DMG sustained has reduced your structural integrity. Your SPD attribute is currently struggling to compensate for the jarring impact of the creature\'s counter. The darkness of the crevices offers a temporary visual buffer, but your biological signature remains highly audible to a creature capable of Weaver Control. \n\n\n\n\n***\n\n**CURRENT SURVIVAL PRESSURE:** The Gloomthread Hatchling is closing the distance, its multiple eyes glistening with predatory focus in the subterranean gloom. You are currently pinned against a jagged rock face with no clear exit route.', '[\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"(BEAST) Aggressively lunge at the creature’s throat, abandoning defense to end the threat through raw primal ferocity. (Cost: High SP, Med Hunger)\",\"(Risky Action) Scale the vertical limestone wall toward the ceiling, hoping to outmaneuver the arachnid in the vertical space. (Cost: High SP, High HP Risk)\",\"Attempt to Flee from the Gloomthread Hatchling\"]', '2026-04-06 16:23:41', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(63, 10, 'Brace for Gloomthread Hatchling\'s next move', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The damp, stagnant air of the Nadir Labyrinth clings to your chitinous exterior like a wet shroud. The limestone walls weep moisture, creating a rhythmic *drip-drop* that masks the scuttling of your adversary. Your vision, augmented by Night Vision, registers the creature’s trajectory with clinical coldness; it is an instinct-driven predator, and you are currently its primary caloric objective.\n\n**COMBAT LOG:** You adopt a braced stance, channeling your internal energy to reinforce your exoskeleton. Your low RES stat is a vulnerability, yet you optimize your posture to distribute the kinetic force of the impact. The Lesser Gloomthread lunges, its fangs scraping against your shoulder plates. The sound is a sickening, shrill grinding of serrated mandibles against hardened cuticle. Your DEF holds, but the sheer force of the collision knocks you back into the damp stone wall. You take 1 DMG. The ichor beneath your plating pulses with the sting of the impact. \n\nYour efficiency remains at 98%, but the metabolic strain of maintaining this posture is depleting your reserves.\n\n\n\n\n\n---', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"(BEAST) Abandon defensive caution and lunge with a predatory frenzy, aiming to sever the opponent\'s sensory organs with your mandibles. (Cost: High SP, Med Hunger)\",\"Attack the Gloomthread Hatchling\",\"[SKILL] Counter-strike Gloomthread Hatchling\"]', '2026-04-06 16:27:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(64, 10, 'Attack the Gloomthread Hatchling i saw another one', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling drips with cold, viscous condensation, echoing the rhythmic tapping of chitin against stone. You have shifted focus from your current assailant to a secondary biological anomaly emerging from the shadows—a second Lesser Gloomthread, smaller, yet no less lethal.\n\n**COMBAT LOG:** Your attempt to strike the second target is marred by your current physiological degradation. As you lunge, your SPD attribute fails to compensate for the exhaustion weighting your limbs. You slash at the newcomer, but your ATK value is insufficient to pierce its reinforced carapace, merely scraping against the calcified shell with a high-pitched, abrasive screech. \n\nSimultaneously, the first Gloomthread capitalizes on your exposed flank. Its mandibles snap shut with a sickening *crunch* against your thoracic plate. The force of the impact sends you skittering across the uneven cavern floor; green ichor—your own—leaks from the hairline fracture in your chitin. Your DEF and RES are insufficient to mitigate this kinetic energy. You are now bracketed by two hostile entities within the suffocating, humid confines of the labyrinth.\n\n**VITAL STATUS:** The proximity of dual predators, combined with your internal metabolic crash, places your survival probability at 12%. The damp air smells of ozone and rot. Your movement is sluggish.\n\n\n\n\n\n---', '[\"Attack the Gloomthread Hatchling\",\"(BEAST) Release a concentrated burst of Thread to bind both targets, ignoring injury to secure a predatory advantage. (Cost: High SP, Med Hunger)\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 16:28:25', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(65, 10, 'Attack the Gloomthread Hatchling i saw another one', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Your mandibles lock onto the creature’s thorax, the sound of chitin shearing echoing sharply against the limestone walls. Your attack connects for 19 damage. However, your focus on the offensive leaves your lateral guard exposed. The enemy retaliates with a frantic, serrated leg sweep, carving a deep furrow into your abdomen. You lose 3 HP.\n\nThe damp, metallic scent of spilled ichor permeates the stagnant cave air, mixing with the pervasive musk of the labyrinth’s rot. As you recoil, the rhythmic *drip-drip* of condensation from the ceiling above seems to accelerate, mimicking the frantic thrum of your own core. The creature you struck—a Gloomthread Hatchling—hissing in high-pitched agitation, remains a persistent biological anomaly in your immediate field of vision. The proximity of the second hostile entity remains a tactical complication; your spatial awareness confirms a shift in the shadows to your left. Your SPD attribute is currently struggling to compensate for the weight of your own fatigue.\n\n**IMMEDIATE THREAT:** You are wounded and boxed in. The second Gloomthread is closing the distance while the first recovers its posture. Survival probability is currently trending downward.', '[\"(Risky Action) Attempt to wrap the wounded Gloomthread in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second. (Cost: High HP Risk)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"Attack the Gloomthread Hatchling\"]', '2026-04-06 16:48:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(66, 10, 'AAttempt to wrap the wounded Gloomthread in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling drips with cold, viscous condensation, echoing the rhythmic tapping of your eight limbs against the cavern floor. The air is heavy with the metallic tang of drying ichor from your previous skirmish, mixing with the damp, earthy scent of the Nadir Labyrinth.\n\n**COMBAT LOG:** You lash out with , weaving a frenzied, sticky shroud around the wounded Gloomthread. The silk anchors to its thrashing legs, binding its thorax in a suffocating web. However, your focus on containment creates a critical opening in your own defense. The second Gloomthread Hatchling lunges, its sharpened forelimbs driving into your side. Your chitin plates fracture under the impact, a hairline crack spider-webbing across your carapace as a spurt of bioluminescent green ichor stains the cold cave floor. The efficiency of your defensive maneuvering failed to account for the speed of the second assailant.\n\n**BIOLOGICAL STATUS:** The metabolic cost of simultaneous construction and combat has surged. Your hunger is nearing a critical threshold. The wounded Gloomthread is immobilized, but the second attacker stands poised for a lethal follow-up.\n\n\n\n\n---\n\n**CHOICE GENERATION:**', '[\"Attack the Gloomthread Hatchling\",\"(BEAST) Abandon defensive tactics and initiate a frenzied bite attack to consume the immobilized target, prioritizing caloric intake over tactical safety. (Cost: Low SP, High Hunger)\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"(Risky Action) Counter-strike the second assailant with a point-blank thread tether to the face, forcing a blinded state at the risk of further physical trauma. (Cost: Med HP Risk)\"]', '2026-04-06 17:10:58', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(67, 10, 'AAttempt to wrap the wounded Gloomthread in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling reeks of stagnant rot and damp mineral deposits. The sound of clicking mandibles from the second Lesser Gloomthread nearby is erratic, indicating high agitation. The condensation dripping from above creates a rhythmic, nerve-wracking cadence that masks your precise movements.\n\n**COMBAT LOG:** You lash out with your abdomen-gland, spinning a sticky, high-tensile silk thread. You bypass the wounded creature\'s erratic thrashing, binding its limbs to the cave wall. The maneuver is efficient, but your SPD attribute is taxed by the sudden shift in momentum. As you anchor the cocoon, the second creature lunges—a blur of pale chitin. Its serrated foreleg pierces your carapace, a sharp, white-hot sting radiating from your side. Green ichor leaks from the puncture, staining the damp floor. \n\n**BIOLOGICAL STATUS:** The wounded target is successfully incapacitated, but your internal integrity has been compromised. The hunger pangs are becoming a physiological distraction; your system is signaling critical need for nutrient ingestion.\n\n\n\n\n---\n\n**CHOICES**\n\n and wait for the second attacker to lose your silhouette. (Cost: Low SP)]\n\n\n\n burst aimed at the second creature’s eyes to blind it, exposing yourself to a potential follow-up strike. (Cost: High HP Risk)]', '[\"(BEAST) Abandon all caution, lunge forward and tear into the trapped, wounded Gloomthread to satisfy your biological hunger mid-combat. (Cost: High Hunger/Low SP)\",\"(Risky Action) Attempt a desperate, point-blank [Weaver Control\",\"Attempt to Flee from the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\"]', '2026-04-06 17:11:48', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(68, 10, 'Attempt a desperate, point-blank', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The attempt at a point-blank maneuver is compromised by the uneven, slick limestone flooring. As you lunge, your footing slides on the viscous, condensation-slicked rock. The Lvl 5 Gloomthread, sensing the vulnerability, pivots with surprising SPD. Its mandible shears across your anterior leg joint, bypassing your DEF 5 threshold.\n\n**ENVIRONMENTAL OVERRIDE:** The metallic tang of your own leaking ichor mixes with the oppressive, earthy stench of the damp cavern. The rhythmic *drip-drip-drip* of condensation from the stalactites above creates a nerve-wracking metronome for the combat. Your opponent is heavily damaged, its carapace cracked from previous encounters, but its movements remain erratic and hostile.\n\n**DAMAGE REPORT:** \nThe strike landed true, severing a section of sensory hairs. Your HP has decreased due to the compromised position. The instinctual urge to feed is rising as your metabolism burns through reserves to compensate for the trauma.\n\n\n\n\n---\n\n****\n****\n****', '[\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"(BEAST) Abandon defensive tactics and initiate a berserker-style frenzy, clawing at the weakened enemy regardless of personal injury. (Cost: High SP, Med Hunger)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"Attack the Gloomthread Hatchling\"]', '2026-04-06 21:35:45', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(69, 10, 'Brace for Gloomthread Hatchling\'s next move', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling continues its relentless, rhythmic dripping, the fluid mingling with the metallic tang of ichor staining the cavern floor. The silence following your defensive brace is heavy, broken only by the skittering of the Lvl 5 Gloomthread Hatchling’s clawed appendages against the wet, slick stone. The environment is frigid, and the dampness accelerates heat loss from your carapace.\n\n**COMBAT LOG:** You adopt a hardened stance, reinforcing your chitinous plates with the instinctual application of Weaver Control to dampen the kinetic force of the incoming strike. The enemy lunges with a predatory screech, its mandibles snapping inches from your thorax. The impact forces you back into a jagged rock formation. \n\n**CALCULATION:** Your DEF (5) combined with the defensive posture successfully mitigated the brunt of the assault. The enemy’s glancing blow against your abdomen resulted in a hairline fracture in your chitin plating, leaking a minimal amount of vital fluids. \n\n**CURRENT STATUS:**\n- HP: 119/120 \n- SP: 232/240 \n- THREAT LEVEL: TARGET HP 13/70. THE ENEMY IS COMPROMISED.\n\nThe enemy’s movements have become erratic, hampered by its own physical exhaustion and the lingering stickiness of your previous silk deployments. Its thorax heaves with every inhalation of the stale, cavernous air. You are currently positioned at an tactical advantage, but the slick limestone flooring dictates that any further movement must be precise to maintain equilibrium.\n\n---', '[\"Attack the Gloomthread Hatchling\",\"(Risky Action) Attempt to scale the vertical limestone wall to gain a height advantage for a crushing downward pounce. (Cost: High HP Risk)\",\"(BEAST) Abandon tactical caution; frenzy and shred the remaining health of the target with raw, uncalculated claw attacks. (Cost: High SP, Med Hunger)\",\"[SKILL] Counter-strike Gloomthread Hatchling\"]', '2026-04-06 21:36:59', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(70, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Target eliminated. Strike efficiency: 94%. XP acquisition confirmed.\n\nThe rhythmic, monotonous dripping of the limestone cavern echoes against the walls, punctuated by the wet thud of the defeated Gloomthread’s carcass hitting the cave floor. The scent of ozone and copper hangs heavy in the stagnant air, thick enough to coat the sensory organs. Your mandate to survive has been satisfied, but the biological cost of the confrontation is evident: your chitinous exterior is streaked with the pungent, glowing ichor of your kin, and your movements are hampered by a slight tremor in your limbs as your adrenaline levels stabilize.\n\nThe environment remains hostile. The distant scuttling of other entities in the darkness suggests that the biological signature of your recent kill may attract scavengers. You are currently in a state of high metabolic depletion; your stamina is failing, and the temperature of the cavern continues to sap your thermal efficiency. \n\n****\n****\n****', '[\"(Risky Action) Drag the corpse into a defensible crevice to set a crude trap for the next entity tracking the scent of blood. (Cost: Moderate SP, Medium HP Risk)\",\"(Approach) Inspect the carcass for usable webbing or remaining biological tissue to supplement your thread reserves. (Cost: Low SP)\",\"(BEAST) Consume the fallen kin to recover mass and suppress the physiological hunger response. (Cost: High Hunger reduction, Negligible SP)\"]', '2026-04-06 21:37:50', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(71, 10, 'Consume the fallen kin to recover mass and suppress the physiological hunger response.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL FEED:** The subject initiates consumption of the biological anomaly previously designated as a threat. \n\nThe limestone cavern remains saturated with humidity, the rhythmic *drip-drip* of condensation echoing against the cold stone. Beside the remains of the defeated hatchling, the air carries a metallic, ozone-heavy scent of shed ichor. You descend upon the remains, mandibles clicking as you dismantle the chitinous husk. The physiological feedback loop of starvation is severe; as you consume the protein-rich tissues, the system registers a rapid stabilization of metabolic functions. However, the labor of processing the tough exoskeleton requires significant expenditure of your remaining SP.\n\nThe cavern walls pulse with a faint, bioluminescent lichen, casting long, jittery shadows. The hatchling\'s remains are rapidly reduced to nothing. You feel the physical weight of the nutrients, but the act of cannibalism triggers a cold, instinctual spike in your sensory threshold.\n\n\n\n\n**CURRENT THREAT ASSESSMENT:** The Lvl 5 Gloomthread Hatchling (F) remains in an aggressive stance, watching your feeding process with a cold, multi-faceted gaze. Its mandibles quiver in anticipation of a struggle. The combat proximity is roughly two meters. \n\n**URGENCY:** Your biological hunger is temporarily suppressed, but the enemy is primed to capitalize on your post-feeding vulnerability. \n\n to create a web-barrier between you and the aggressor, then retreat into the upper crags. (Cost: Med SP)]\n lunging strike before the enemy can react. (Cost: High SP)]\n while in mid-air, gambling on a quick wrap-and-bite takedown. (Cost: High HP Risk)]', '[\"(Risky Action) Attempt to ensnare the enemy with [Thread Craft\",\"Attempt to Flee from the Gloomthread Hatchling\",\"(BEAST) Aggressively display your mandibles and perform a high-speed [SPD\",\"[SKILL] Preemptive Strike on Gloomthread Hatchling\"]', '2026-04-06 21:38:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(72, 10, 'Preemptive Strike on Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Preemptive strike executed. Kinetic energy transfer: 94%. Enemy HP reduced to 32/70.\n**COUNTER LOG:** Opponent recoil maneuver initiated. Player sustains 2 points of superficial damage to the exoskeleton.\n\n**BIOLOGICAL FEED:** The scent of metallic ichor fills the damp, subterranean air—a sharp, pungent contrast to the musty limestone humidity. As you drive your appendages forward, the *Gloomthread Hatchling* skitters across the ceiling, its chitinous legs scraping against the rock with a rhythmic screech that pierces the dripping silence of the labyrinth. Your strike finds purchase on its thorax, sending a spray of glowing, bioluminescent green fluid splashing against the cavern floor. \n\nThe enemy vibrates in response, its compound eyes fixed on your movement. The friction of your recent consumption still lingers in your mandibles, an acidic, raw taste that drives the predator instinct deeper. You are currently braced against the uneven limestone, your SPD attribute straining to maintain stability while the opponent prepares a venom-coated thread discharge. The environment is closing in; the distant echo of a larger predator’s movement resonates through the floorboards, signaling that this duel must conclude rapidly to avoid unwanted attraction.\n\n\n\n\n\n---', '[\"Attack the Gloomthread Hatchling\",\"(Risky Action) Ignore the immediate defense to unleash a flurry of slashes, gambling that your ATK will shatter the enemy\'s chitin before its counter-venom hits. (Cost: High HP Risk)\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"(BEAST) Aggressively lunge and pin the target against the cavern wall, utilizing Weaver Control to bind its limbs while delivering a finishing bite. (Cost: High SP, Med Hunger)\"]', '2026-04-06 21:38:51', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(73, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Target confirmed. Kinetic strike execution: 96% efficiency. Target HP reduced from 32/70 to 13/70.\n**COUNTER_LOG:** Hostile retaliation intercepted. Player defense mitigation: 5%. Damage sustained: 3 HP.\n\nThe limestone walls weep moisture, the cold slickness under your tarsal claws providing minimal traction as you lunged. The metallic scent of ichor from your previous consumption still clings to your mandibles, blending with the stagnant, mineral-heavy air of the labyrinth. \n\nAs you drove your strike into the opposing Gloomthread Hatchling, the sound of cracking chitin echoed sharply against the cave ceiling. The enemy recoiled, its multi-faceted eyes dulling as green fluid seeped from the abdominal fissure you inflicted. However, the beast lunged in return, its fangs grazing your thorax. The strike was shallow, but the impact sent a tremor through your exoskeleton. Your SPD (5) is currently matched by your opponent, making every movement a gamble against the uneven terrain. \n\nYou remain suspended in the dark, the distant clicking of the labyrinth’s inhabitants acting as a rhythmic reminder that standing still is a death sentence.\n\n\n\n\n---', '[\"(Risky Action) Ignore defensive posture and lunge directly into the enemy\'s reach to deliver a lethal blow to the core. (Cost: High HP Risk)\",\"Attack the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 21:39:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(74, 10, 'Unleash Heavy Strike on Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Subject executes \'Heavy Strike\'. Kinetic output correlates with ATK attribute. Target structural integrity exceeded. \n**TARGET STATUS:**  neutralized. Chitinous exoskeleton shattered. Subject experiences biological assimilation of protein and mana reserves.\n\n**NARRATION:** \nThe limestone cavern echoes with the sharp *snap* of fracturing chitin. You channel your remaining SP into a singular, forceful lunge, your primary limbs driving deep into the vitals of the rival Gloomthread. As your strike lands, the creature emits a high-pitched, discordant stridulation that cuts through the oppressive silence of the cave. Green, viscous ichor sprays across your sensory hairs, the scent of metallic rot filling the damp, stagnant air. The victim collapses, its legs twitching in the darkness before falling into the sticky, web-lined floor. \n\nYou stand over the carcass, the vibrations of the cave warning you that you are not alone; the labyrinth remains hostile, and your hunger gnaws at your internal systems. The adrenaline of the skirmish fades, leaving you exposed in the dim, bioluminescent glow of the cave walls.\n\n**STATUS UPDATE:**\n- HP: 117/120\n- MP: 90/90\n- SP: 215/240\n- Hunger: 55/100\n\n\n\n\n\n\n---', '[\"(BEAST) Aggressively scent the air and retreat into the shadows to ambush any nearby opportunists. (Cost: Low SP)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 21:39:39', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(75, 10, 'Unleash Heavy Strike on Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Target \'Gloomthread Hatchling\' neutralized. Kinetic output: Optimal. \n**ANOMALY DETECTION:** Subject vitals remain stable. Combat efficiency: 98%.\n\nThe damp limestone walls of the labyrinth weep with condensation, the rhythmic *drip-drip* echoing against the encroaching silence. Your final strike connected with the precision of a scalpel, shattering the creature’s chitinous thorax. A viscous, pale-green ichor sprays across your knuckles, smelling of stagnant water and decaying organic matter. The spider’s mandibles twitch once in a rhythmic spasm before the neural connection to its limbs terminates permanently. The creature is deceased.\n\nThe heat of the combat dissipates into the cave’s subterranean chill. You are left standing in the shadow of the stalactites, the  hum of your recent training at the Ashen Lyceum still vibrating faintly in your peripheral perception—a stark, unnatural contrast to this primitive, subterranean kill zone. You are alive, but the biological imperative of the dungeon demands more; the smell of the spilled ichor is an invitation to other, larger predators lurking in the dark. \n\nYour stamina is adequate, but the hunger remains a variable that must be calculated.', '[\"(Scout) Move deeper into the limestone network to locate a defensive chokepoint before the scent of combat draws attention. (Cost: Med SP)\",\"(Scavenge) Extract the mana-dense silk glands from the carcass for future utility. (Cost: Low SP)\",\"(BEAST) Consume the creature’s remains to mitigate metabolic deficit and regain vitality. (Cost: Low SP, Low Hunger)\"]', '2026-04-06 21:40:09', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(76, 16, 'Stand completely still and let the monster eat me.', 'The Gloomthread Hatchling lies defeated, its chitinous thorax crushed against the limestone. A viscous, iridescent fluid—the creature’s hemolymph—leaks from the cracks in its shell, mingling with the damp, mineral-rich mud of the labyrinth floor. You are currently drenched in this cold, sticky substance, a biological anomaly of waste and failed sustenance. \n\nYou remain motionless. The ambient sound of the Labyrinth—the skittering of distant arachnid limbs and the rhythmic dripping of water—becomes deafening. The hunger within you is a physical gnawing, a metabolic deficit of 93/100, yet your decision to surrender your biological function yields no external predator to claim the carcass. You are left alone in the dark, cold tomb of the Upper Stratum. The ozone scent of the recent combat dissipates, replaced by the suffocating smell of your own failing body. Your DEF 20 sustained the minor skirmish, but the lack of SP has rendered you effectively inert.\n\n\n\n\n---', '[\"Attack the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"Attempt to Flee from the Gloomthread Hatchling\"]', '2026-04-06 21:55:33', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(77, 16, 'Stand completely still and let any monster eat me.', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED. SUBJECT INTENT: SELF-TERMINATION.**\n\nThe damp, oppressive silence of the Nadir Labyrinth is broken only by the rhythmic dripping of mineral-rich water onto limestone. You stand motionless, a stagnant sculpture in the darkness, chest heaving with exhaustion. The iridescent hemolymph of the previous Gloomthread Hatchling clings to your calloused hands, drying into a tacky, foul-smelling film. Your internal metabolic state is critical; without caloric intake, your DEF attribute’s efficiency is projected to degrade by 15% within the next hour. \n\nYou offer no resistance. As the shadows shift, a second Gloomthread Hatchling descends from the ceiling webbing. It chitters—a dry, rasping vibration that bypasses the ears and rattles the teeth. It registers your lack of movement as a tactical vulnerability. It lunges, mandibles clicking with predatory precision. It bites into your shoulder, the strike bypassing your natural DEF threshold. The pain is sharp, cold, and immediate. You feel the necrotic enzymes in its saliva attempting to liquefy your tissue, but your inherent RES attribute slows the process, forcing the creature to exert more physical effort to tear flesh. It pulls, struggling to extract a nutrient-dense morsel from its unmoving prey.\n\n\n\n\n**CURRENT SURVIVAL PRESSURE:** The subject’s failure to defend itself has invited active predation. If the subject does not initiate a counter-action, internal liquefaction will proceed at an accelerated rate.', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"Attack the Gloomthread Hatchling\",\"(Risky Action) Grab the creature’s mandibles with your bare hands and force them wide open, exposing its soft, pulsating neck-gland for a bite. (Cost: High HP Risk)\"]', '2026-04-06 21:55:59', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(78, 16, 'eat the died moster', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED.**\nSubject, despite previous attempts at self-termination, is now actively engaging in nutrient consumption to mitigate caloric deficit. Efficiency of the biological vessel is at a critical low.\n\nThe crushed chitin of the Gloomthread Hatchling lies cooling on the damp limestone floor. You drop to your knees, the stench of ozone and the creature’s pungent, iridescent hemolymph filling your nostrils. Your hands—stained with the viscous, bitter fluid of the monster—tear into the cracked thorax. The meat is stringy, cold, and coated in a paralyzing, slightly numbing venom residue, but your metabolic demands override the potential toxicity. You consume the remains with primal, mechanical desperation.\n\nThe silence of the Nadir Labyrinth presses in around you, heavy and stagnant. The distant skittering of unseen appendages against stone echoes through the tunnel, serving as a reminder that the environment is indifferent to your struggle for homeostasis. You have replenished a fraction of your lost energy, but the exertion of combat and the strain of survival continue to degrade your vessel’s integrity.\n\n\n\n\n\n---', '[\"(Risky Action) Venture deeper into the damp tunnel to seek a water source, risking detection by larger predators. (Cost: High HP Risk)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"Attack the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 21:58:03', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(79, 16, 'Attack the Gloomthread Hatchling', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED.**\nSubject demonstrates oscillating survival priorities. Previous attempted self-termination abandoned in favor of caloric intake. \n\nThe limestone cavern resonates with the wet, rhythmic *drip-drop* of condensation. The air is heavy with the metallic tang of hemolymph and the suffocating scent of ancient, damp earth. Your hands are stained with the iridescent, sticky fluid of the deceased Gloomthread Hatchling; the viscous residue clings to your calloused skin, cooling rapidly in the cave’s subterranean chill. Despite your ATK of 14, the creature’s chitinous shell proved brittle under your assault, fracturing with a satisfying *snap* that echoed briefly through the tunnel before being swallowed by the vast, oppressive silence. \n\nThe caloric deficit remains critical. The husk of the Gloomthread is small, but its protein content is sufficient to prevent immediate metabolic failure. Your digestive system awaits input.\n\n\n\n\n\n**URGENCY:** Subject displays extreme malnutrition. Immediate nutrient extraction is recommended to maintain biological viability within the Nadir Labyrinth.', '[\"(SCAVENGER) Harvest the remaining internal tissues of the Gloomthread to stabilize metabolic vitals. (Cost: Low SP, Low Hunger)\",\"(Observe) Survey the immediate perimeter for additional threats or structural vulnerabilities in the limestone walls. (Cost: Low SP)\",\"(Risky Action) Venture deeper into the darkness toward the sound of movement to locate higher-density food sources. (Cost: High HP Risk)\"]', '2026-04-06 21:58:24', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(80, 16, 'Attack the Gloomthread Hatchling', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED. SUBJECT BEHAVIORAL LOGIC: INCONSISTENT.**\n\nThe damp limestone walls of the Nadir Labyrinth vibrate with the chittering of the arachnid. Your previous strike, fueled by a desperation that defies your earlier resignation, landed squarely against the creature\'s abdomen, leaving a jagged fissure in its chitin. However, your slow movement speed (SPD 5) proved insufficient to evade the counter-riposte. \n\nThe Gloomthread Hatchling lunged, its needle-like fangs grazing your arm. You feel the sharp sting of localized venom and the grit of subterranean dust grinding into the wound. The air here is thick with the metallic tang of monster ichor and the oppressive, stale humidity of the deep earth. Your HP has been recalibrated; the physical toll is mounting.\n\n\n\n\nThe creature is reeling, its movements erratic. Its legs twitch in rhythmic spasms against the stone floor. It is dying, but the labyrinth is vast, and the sound of distant, larger movements suggests that a prolonged engagement invites third-party interference. Your biological efficiency is currently compromised by an empty stomach and the persistent threat of infection.', '[\"Attack the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"Attempt to Flee from the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 21:58:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(81, 16, 'Stand completely still and let any monster eat me.', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED. SUBJECT BEHAVIORAL LOGIC: ERRATIC/DEFEATIST.**\n\nThe limestone cavern is suffocating, a damp, pressurized void where the smell of rot and ozone hangs heavy in the stagnant air. You abandon your defensive posture, dropping your guard. The Gloomthread Hatchling—a nightmare of twitching legs and oily, translucent chitin—pauses for a microsecond, its compound eyes vibrating as it processes your sudden cessation of movement.\n\nEfficiency protocols are failing. The Gloomthread lunges, its serrated mandibles clicking with predatory intent. It strikes at your shoulder; your low SPD (5) makes evasion a statistical impossibility. The chitin shears through your tunic, drawing a thin line of crimson across your skin. The damp cave walls echo with the wet *thwack* of the monster’s assault. You remain motionless, inviting the end, but the creature hesitates, confused by the lack of resistance, circling you like a coiled spring. Your body, despite your commands, tremors with the raw, base instinct to survive.\n\n\n\n\n**URGENCY: Your hunger levels are critical. The metabolic deficit is causing internal degradation.**', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"(Desperate Maneuver) Attempt to grab the Gloomthread’s legs to crush them against the stone wall, risking a lethal bite. (Cost: High HP Risk)\",\"Attack the Gloomthread Hatchling\",\"(Counter-Attack) Seize the opening while the creature is confused by your lack of defense. (Cost: Low SP)\"]', '2026-04-06 21:58:53', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(82, 16, 'Stand completely still and let any monster eat me.', '**ANALYSIS: BIOLOGICAL ANOMALY DETECTED. SUBJECT HAS REACHED TERMINATION THRESHOLD.**\n\nThe damp limestone walls of the Nadir Labyrinth shudder, the sound of rhythmic clicking echoing through the suffocating, frigid air. The Gloomthread Hatchling—a nightmare of twitching legs and oily, multifaceted eyes—does not hesitate. Despite your DEF of 20, your physical form has reached the limit of its resilience.\n\nYou stand motionless, a stagnant vessel in a predatory ecosystem. The arachnid closes the distance with terrifying efficiency. Its mandibles, dripping with a paralytic, acidic enzyme, find the gap in your defenses. A single, surgical strike pierces the torso. You feel the cold seep into your vitals as your HP—already depleted by the relentless hunger and the previous skirmishes—drops to zero. The world turns to static. The limestone floor rushes up to meet your vision, smelling of damp earth and rot.\n\n****\n\n---\n\n**SYSTEM REBOOT INITIATED: REINCARNATION PROTOCOL ACTIVATED.**\n*The Divine Administrator observes the soul\'s residual energy clustering near the corpse. Would you like to attempt a desperate surge of energy to bind to a new vessel?*', '[\"[SYSTEM] Accept Death and Enter the Soul Stream\"]', '2026-04-06 22:00:47', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(83, 16, '[SYSTEM] Accept Death and Enter the Soul Stream', '[SYSTEM: SOUL DETACHED] Your vessel has crumbled to dust. Your experiences have condensed into Karma. The Soul Stream beckons... Choose your next form. [SOUL_STREAM_PROCESSED]', '{\"type\":\"SOUL_STREAM\",\"karma_earned\":55,\"total_karma\":55,\"vessel_draft\":[{\"id\":5,\"name\":\"Wolf Pup\",\"soul_path\":\"Predator\",\"description\":\"A Predator path vessel: Wolf Pup.\",\"base_hp\":20,\"base_mp\":5,\"starting_location\":\"nadir_upper\",\"vessel_image\":null,\"base_offense\":12,\"base_defense\":6,\"base_magic_power\":2,\"base_resistance\":4,\"base_speed\":15,\"base_hunger\":100,\"base_sp\":20},{\"id\":3,\"name\":\"Scrap Slime\",\"soul_path\":\"Scavenger\",\"description\":\"A Scavenger path vessel: Scrap Slime.\",\"base_hp\":20,\"base_mp\":20,\"starting_location\":\"nadir_upper\",\"vessel_image\":null,\"base_offense\":4,\"base_defense\":10,\"base_magic_power\":12,\"base_resistance\":12,\"base_speed\":3,\"base_hunger\":100,\"base_sp\":20},{\"id\":10,\"name\":\"Crystalline Snail\",\"soul_path\":\"Prey\",\"description\":\"A Prey path vessel: Crystalline Snail.\",\"base_hp\":40,\"base_mp\":30,\"starting_location\":\"magma_layer\",\"vessel_image\":null,\"base_offense\":5,\"base_defense\":25,\"base_magic_power\":10,\"base_resistance\":20,\"base_speed\":1,\"base_hunger\":100,\"base_sp\":20}]}', '2026-04-06 22:01:03', NULL, NULL),
(84, 10, 'Unleash Heavy Strike on Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Kinetic strike executed. The force of the \'Heavy Strike\' connects with the creature’s midsection. Chitinous plating buckles under the pressure of your ATK stat; green ichor erupts, staining the damp limestone floor. Enemy HP reduced to 22/60.\n\n**COUNTER LOG:** The Gloomthread Hatchling recovers with unnatural speed. Its forelegs lash out, claws raking across your shoulder. DEF mitigation reduces the impact, but 3 points of HP are lost.\n\n**ENVIRONMENTAL ANALYSIS:** The air in the labyrinth is thick with the scent of stagnant water and decaying biomass. The constant, rhythmic skittering of unseen creatures echoes off the limestone walls, amplified by the cavern\'s acoustics. The temperature is dropping, and your movements are becoming sluggish as the hunger metric climbs.\n\n**PROBABILITY MATRIX:** The subject is currently wounded but remains highly aggressive. The structural integrity of the creature’s carapace is compromised, increasing the potential lethality of follow-up kinetic strikes. You are currently in a state of sustained caloric deficit. Immediate neutralization is required to prevent further degradation of your combat efficiency.\n\n\n\n\n---', '[\"Attack the Gloomthread Hatchling\",\"(BEAST) Abandon defensive caution and unleash a flurry of bites and claws, prioritizing lethality over self-preservation. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to grapple the creature, pinning it against the cavern wall to crush it with brute force. (Cost: High HP Risk)\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\"]', '2026-04-06 22:39:02', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(85, 10, 'Cast Abyssal Cinder on the Gloomthread Hatchling.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The invocation of  is successful. Mana channels stabilize as 25 SP is converted into a localized thermal singularity. \n\nThe air within the limestone cavern drops in temperature as the ambient humidity is rapidly flash-boiled. You extend your hand; a swirling sphere of dark, hungry flames coalesces, casting jagged shadows against the wet walls. Upon contact with the Gloomthread Hatchling, the spell bypasses the creature\'s low RES attribute entirely. There is a sharp, wet *crack* of chitin failing under extreme thermal stress, followed by the pungent scent of scorched protein and ozone. The creature is reduced to a smoking heap of calcified biomass.\n\nThe echoes of your spell dissipate, leaving only the dripping of water from unseen stalactites and the faint, rhythmic skittering of other entities in the deep tunnels. Your hands are stained with the viscous, residual ichor of the previous encounter, now drying rapidly against the cool cave air. You are the apex of this immediate sector, yet the metabolic demand of your  output has left your internal systems flagging.\n\n**VITAL SIGNS:**\n\n\n\n\n**URGENCY:** Your caloric reserves are depleting. The scent of the carcass is beginning to permeate the cavern, and in this ecosystem, the smell of fresh prey—or fresh victory—is a dinner bell for predators far more efficient than yourself.', '[\"(Scavenge) Inspect the remains of the Gloomthread for biological resources or latent Mana cores to replenish your reserves. (Cost: Low SP)\",\"(Deep Dive) Move deeper into the darkness of the cavern to scout for higher-density XP targets before your mana pool depletes. (Cost: High HP Risk)\",\"(BEAST) Consume the creature immediately to restore metabolic hunger and salvage essential nutrients from the chitin. (Cost: Med Hunger, Low SP)\"]', '2026-04-06 22:41:52', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(86, 10, 'Consume the creature immediately to restore metabolic hunger and salvage essential nutrients from the chitin', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The Lvl 3 Gloomthread Hatchling has been terminated. The creature’s final, twitching reflex failed to bypass your defense, resulting in negligible impact. The limestone cave air is heavy with the metallic tang of cooling ichor and the damp scent of mineral decay. \n\nAs the creature’s biological functions cease, you immediately secure the carcass. Utilizing your mandibles, you breach the hardened chitin midsection—the same location weakened by your previous strikes. The texture is viscous, the inner fluids providing a rapid infusion of essential proteins. As you process the organic matter, your metabolic deficiency is partially rectified. The sound of distant clicking echoes through the cavern, a reminder that you are not the apex predator in this sector.\n\n**VITAL SIGNS UPDATE:**\nHP: 114/120\nMP: 90/90\nSP: 206/240\nHunger: 42/100 (Increased via consumption)\n\n\n\n\n\n***', '[\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"Attempt to Flee from the Gloomthread Hatchling\",\"(Risky Action) Venture deeper into the central chasm, ignoring stealth to scout for larger sources of biomass. (Cost: High HP Risk)\"]', '2026-04-06 22:48:52', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(87, 10, 'i use an attack skillli have and DEFEND in cast of any attack', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The user initiates an offensive maneuver while bracing for impact. The target, a Lvl 3 Gloomthread Hatchling, is reeling from the previous assault. With its HP at 3/50, structural integrity is critical. A swift strike connects, bypassing the creature\'s weakened chitin. The target undergoes terminal collapse.\n\n**ENVIRONMENTAL ANALYSIS:** The limestone cave is frigid, the air thick with the scent of damp earth and the metallic tang of monster ichor. The sticky residue of previous webs clings to your limbs, a tactile reminder of the labyrinth’s lethality. The distant sound of skittering legs persists; the ecosystem is aggressive, and you are currently bleeding efficiency.\n\n**CHOREOGRAPHY:** You pivot, channeling your remaining kinetic energy into a final, decisive strike. Your claws pierce the creature\'s thorax with fluid precision. Simultaneously, you retract your posture, pulling your limbs inward to mitigate the recoil of its dying thrash. A spray of green, viscous fluid coats the cavern floor. The creature\'s movements cease. The threat is neutralized, though the impact of the creature’s desperate, final bite—while deflected—has left a stinging laceration on your hide.\n\n**VITAL SIGNS:**\n\n\n\n\n**SURVIVAL ANALYSIS:** The energy expenditure required for consistent combat is taxing your metabolic reserves. The labyrinth remains hostile. Further sustenance is required to maintain operational parity.\n\n---', '[\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"Attack the Gloomthread Hatchling\",\"(BEAST) Feed ravenously upon the carcass to immediately restore structural integrity and satiate rising hunger. (Cost: Low SP, Low Hunger)\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 22:59:38', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(88, 10, 'Attack', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The subject executes a standard offensive strike. Due to the high SPD stat relative to the environmental density of the limestone cavern, the strike connects with surgical precision. The chitinous remains of the previous target are discarded as the current target—a patrolling Lvl 4 Gloomthread Hatchling—enters the field of vision.\n\n**NARRATION:**\nThe ambient temperature of the limestone labyrinth drops. Your claws, still stained with the viscous, pale green ichor of the previous kill, feel slick. The damp air carries the scent of mold and calcified decay. As you lunge, your movement is fluid, utilizing your 5 SPD to close the gap before the target can weave a defensive web. Your strike finds the soft membrane between its thoracic plates. The creature emits a high-pitched, chittering shriek as its own defensive chitin cracks under the force of your 5 ATK. The sound echoes off the damp, narrow walls, amplified by the confined space. You are currently standing in a pool of biological runoff, the humidity causing the metallic tang of blood to cling to your nostrils. \n\nYour metabolism is reaching a critical threshold. The lack of caloric intake is beginning to impede your neural response time. \n\n\n\n\n\n****\n****\n****', '[\"(Risky Action) Attempt to scale the vertical cave wall to drop onto the target from above, risking a fall against the sharp stone floor. (Cost: High HP Risk)\",\"(BEAST) Execute a pounce maneuver to pin the target, tearing into the exposed throat membrane to initiate an immediate feast. (Cost: High SP, Med Hunger)\",\"(Scavenge) Search the immediate vicinity for remaining spider silk or larvae to supplement dietary requirements. (Cost: Low SP)\"]', '2026-04-06 23:00:17', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(89, 10, 'Search the immediate vicinity for remaining spider silk or larvae to supplement dietary requirements.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL ANALYSIS:** The cavern temperature remains at a stagnant 12°C. The air is heavy with the metallic tang of chitin-fluid and the damp, earthy scent of limestone. Residual webbing from the previous encounter clings to the subject’s appendages, obstructing tactile sensory input.\n\n**ACTION LOG:** The subject traverses the immediate vicinity. Utilizing a base SPD of 5, the subject moves with erratic, segmented precision across the slick cave floor. The search yields a clutch of viable spider larvae near the crevice wall and a cluster of high-tensile silk strands. \n\n**METABOLIC DATA:** Consuming the protein-rich larvae and processing the silk provides a marginal increase in nutritional intake. The residue of the previous Lvl 3 kill still coats the subject’s mandibles, confirming a state of active predation. Efficiency of nutrient absorption is currently at 42%.\n\n**STATUS UPDATE:**\n\n\n\n\n**URGENCY:** Metabolic hunger is subsiding, but the sound of rhythmic, multi-legged scraping approaching from the northern tunnel indicates a secondary threat. The subject remains vulnerable to ambush while grounded.\n\n---', '[\"Attempt to Flee from the Gloomthread Hatchling\",\"(BEAST) Release a pheromone-based territorial marking spray to discourage nearby entities from encroaching on the kill site. (Cost: High SP)\",\"Attack the Gloomthread Hatchling\",\"[SKILL] Preemptive Strike on Gloomthread Hatchling\"]', '2026-04-06 23:00:46', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(90, 10, 'Rest for a moment and catch my breath.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The subject attempts a cessation of hostilities. The opposing Lvl 3 Gloomthread Hatchling, perceiving the sudden drop in kinetic activity, lunges forward with serrated mandibles. Chitinous legs scrape against the limestone floor, emitting a high-pitched rasping sound. The attack connects, bypassing the subject\'s defensive posture. A hairline fracture appears on the subject\'s exoskeleton. -3 HP.\n\n**ENVIRONMENTAL ANALYSIS:** The damp air of the labyrinth is saturated with the pungent, musk-like scent of arachnid pheromones. The silence following the clash is oppressive, broken only by the rhythmic dripping of mineral-rich water from stalactites overhead. The subject\'s biological systems show signs of strain from the recent calorie deficit. While the rest attempt was logically sound, the tactical efficiency was zero; the opponent interprets hesitation as a precursor to terminal failure.\n\n**BIOLOGICAL STATUS:** \nThe subject’s vitals are currently hovering at 117/120 HP. The localized pain from the chitin fracture acts as a negative modifier to maneuverability. Immediate caloric intake is now a prerequisite for continued combat operation; the metabolic cost of maintaining the Abyssal Cinder skill will soon become unsustainable if current Hunger levels continue to drop.\n\n\n\n\n---', '[\"(BEAST) Use ‘Abyssal Cinder’ to incinerate the opponent, prioritizing immediate threat termination over resource management. (Cost: 25 SP)\",\"Attempt to Flee from the Gloomthread Hatchling\",\"Attack the Gloomthread Hatchling\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\"]', '2026-04-06 23:20:18', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(91, 10, 'Attempt to Flee from the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The subject attempts to initiate a tactical withdrawal. Efficiency: Low. The opposing Lvl 3 Gloomthread Hatchling leverages its superior positioning on the limestone wall, intercepting the escape trajectory with a rapid, predatory lunging strike. The subject takes 3 DMG as the rival’s fangs graze the chitonous plating of the thorax.\n\n**ENVIRONMENTAL ANALYSIS:** The cavern temperature remains stagnant at 12°C. The damp, metallic scent of blood—yours—mingles with the underlying odor of stagnant limestone water. Your movement is hindered by the viscous, sticky webs draped across the cave floor, which cling to your limbs, sapping the kinetic energy required for an effective retreat. The sound of shifting pebbles confirms the adversary is currently recalibrating for a follow-up assault.\n\n**VITAL SIGNS:**\nCurrent HP: 111/120. \nThe chitin on your left lateral plate exhibits a superficial fracture; green ichor oozes from the impact site, signaling a breach in defensive integrity. Your SPD attribute is currently struggling against the friction of the web-laden terrain, necessitating an immediate change in strategy to avoid further attrition.\n\n\n\n\n**SURVIVAL PRESSURE:** The enemy is aggressively tracking your movement. Maintaining a defensive posture in this restricted space is statistically unfavorable.', '[\"(BEAST) Release a concentrated, localized web-snare to bind the opponent to the limestone wall, prioritizing territorial dominance. (Cost: High SP, Med Hunger)\",\"(Counter-Attack) Utilize your superior SPD to pivot around the enemy and strike at its exposed, softer abdominal underbelly. (Cost: Low SP)\",\"Attack the Gloomthread Hatchling\",\"(Risky Action) Execute \'Abyssal Cinder\' at point-blank range to forcibly end the encounter, risking collateral damage to your own HP. (Cost: 25 MP, High HP Risk)\"]', '2026-04-06 23:20:47', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(92, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL ANALYSIS:** The damp limestone walls sweat with condensation, slicking the uneven terrain. The metallic tang of hemolymph hangs heavy in the stagnant air, mixing with the musty scent of ancient webbing. Sound resonance is high; every skittering claw-tap echoes through the tunnel, masking the approach of unseen predators.\n\n**COMBAT LOG:** The subject lunges forward. The Lvl 3 Lesser Gloomthread attempts a lateral dodge, but its mobility is hampered by its previous injury. The subject’s mandibles, reinforced by a baseline ATK of 5, puncture the opponent’s thorax. Green ichor sprays across the jagged floor. The enemy reels, chitin cracking under the pressure, but its retaliatory strike clips the subject’s joint, resulting in a minor degradation of the exoskeleton. \n\n**BIOLOGICAL STATUS:** Physical integrity is currently compromised. The subject’s resistance to pain is high, but cumulative damage is reducing combat efficiency. The immediate environment remains hostile; the scent of spilled fluid serves as a beacon for other biological anomalies in the vicinity.\n\n\n\n\n**CHOICES:**', '[\"(Risky Action) Disengage entirely and flee deeper into the labyrinth, risking an opportunity attack to preserve remaining HP. (Cost: High HP Risk)\",\"[DEFEND] Brace for Gloomthread Hatchling\'s next move\",\"Attack the Gloomthread Hatchling\",\"Attempt to Flee from the Gloomthread Hatchling\"]', '2026-04-06 23:21:32', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(93, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The subject lunges forward, mandible meeting mandible in a violent clash of chitin. The kinetic transfer is absolute; the opposing Lesser Gloomthread’s carapace fractures under the force of the strike, spraying a mist of viscous, translucent blue fluid across the damp limestone. \n\n**COUNTER_LOG:** The opposing unit, driven by base survival subroutines, lashes out with a frantic, serrated limb. The blow glances off the subject’s thoracic plating, resulting in a minor breach of biological integrity. \n\n**ENVIRONMENTAL ANALYSIS:** The scent of metallic blood permeates the humid, sulfurous air of the labyrinth. The constant, rhythmic dripping of condensation from the ceiling creates a chaotic audio backdrop, masking the sound of nearby skittering predators. The subject’s movement is hampered by the slick, moss-covered floor, forcing a reliance on SPD stats to maintain equilibrium amidst the carnage. The enemy is hemorrhaging vital fluids; its erratic tremors indicate a high probability of total system failure within the next engagement cycle.\n\n**SURVIVAL PRESSURE:** The subject’s nutritional reserves are depleting. The biological drive to consume the fallen target is competing with the requirement for tactical alertness in an open-access tunnel. \n\n\n\n\n---', '[\"(BEAST) Devour the defeated target immediately to recover nutritional deficit. (Cost: Low SP, Low Hunger)\",\"Attack the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"Attempt to Flee from the Gloomthread Hatchling\"]', '2026-04-06 23:21:38', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(94, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The air in the limestone cavern grows heavy, stagnant with the scent of damp earth and metallic ichor. You disregard the minor lacerations on your thorax and commit to the final offensive. With your speed stat (5) perfectly calibrated, you lunge through the slick, condensate-drenched air. Your mandibles lock onto the opponent’s vulnerable joint, exerting 5 ATK of pressure. The sound is sharp—a sickening *crack* of calcified chitin. Green ichor sprays across the dark, wet floor. The Lvl 3 Lesser Gloomthread collapses, its twitching legs slowing to a halt as its biological functions cease.\n\n**ENVIRONMENTAL ANALYSIS:** The immediate threat is neutralized. However, the Labyrinth remains hostile. The distant skittering of larger predators persists, echoing off the limestone walls. Your own vitals show signs of attrition; the depletion of SP and the low hunger threshold create an immediate physiological urgency. You are currently vulnerable.\n\n\n\n\n---', '[\"Attack the Gloomthread Hatchling\",\"[SKILL] Unleash Heavy Strike on Gloomthread Hatchling\",\"Attempt to Flee from the Gloomthread Hatchling\",\"(Search) Scour the immediate damp crevices for edible fungi or water before moving deeper. (Cost: Low HP Risk)\"]', '2026-04-06 23:21:44', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(95, 10, 'Attack the Gloomthread Hatchling', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The final strike connects with surgical precision. The mandible of the Gloomthread Hatchling collapses under the force of the blow, fracturing into jagged segments of chitin. Green ichor, viscous and reeking of sulfur, sprays across the damp limestone floor, sizzling slightly where it contacts the mineral-rich stone. The target’s motor functions cease instantly; the rhythmic twitching of its remaining limbs slows to a halt.\n\n**ENVIRONMENTAL ANALYSIS:** The ambient silence returns to the cavern, save for the incessant, echoing drip of water from the stalactites above. The humidity index is at 94%, causing the lingering metallic scent of the creature’s demise to cling to the air like a shroud. Your vision pulses with a dull, rhythmic throb. The hunger—a clawing, hollow sensation in your core—has reached critical mass. Your  reserves are depleting as your metabolism compensates for the violent expenditure of energy.\n\n**BIOLOGICAL STATUS:** You are standing over the caloric source, but your physical stamina is rapidly reaching a failure threshold. Every second spent idling increases the  deficit.\n\n\n\n\n\n---', '[\"(Scout) Ignore the remains and venture deeper into the tunnel complex to find safer, higher-density prey. (Cost: Med SP, High HP Risk)\",\"(BEAST) Consume the creature immediately to satisfy the starvation prompt and recover metabolic stability. (Cost: Med Hunger)\",\"(Loot) Inspect the carcass for remains or usable materials to recover inventory efficiency. (Cost: Low SP)\"]', '2026-04-06 23:21:53', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(96, 10, 'Consume the creature immediately to satisfy the starvation prompt and recover metabolic stability.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The Gloomthread Hatchling lies fractured against the damp limestone, its chitinous plating splintered from the previous engagement. The air in the cavern is thick with the scent of ozone and cooling ichor. As you approach, the rhythmic dripping of mineral-rich water echoes through the dark, providing a stark contrast to the silence of the defeated specimen. \n\nWith surgical efficiency, you descend upon the carcass. The ingestion process is visceral; the creature\'s biological material is synthesized into your own, repairing the microscopic tears in your own exoskeleton. The metallic tang of the creature\'s blood masks the stagnant, musty odor of the cave floor. Your internal metrics stabilize as the gnawing ache of starvation recedes, replaced by the warmth of restored vitality. The cavern continues to vibrate with the distant, chitinous clicking of others—a reminder that your survival remains a statistical anomaly in this subterranean hell.\n\n (Bonus vitality retained)\n\n\n\n---\n\n**CHOICE GENERATION**', '[\"(Scavenge) Investigate the immediate vicinity for further organic remnants or discarded exoskeleton fragments to fortify your own armor. (Cost: Low SP)\",\"(BEAST) Release a low-frequency hiss and scent-mark the perimeter to deter other Lesser Gloomthreads from encroaching on your territory. (Cost: Med SP, Low Hunger)\",\"(Risky Action) Venture deeper into the central tunnel toward the source of the persistent clicking sound to eliminate potential threats before they locate you. (Cost: High HP Risk)\"]', '2026-04-06 23:22:18', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(97, 10, 'Release a low-frequency hiss and scent-mark the perimeter to deter other Lesser Gloomthreads from encroaching on your territory', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL ANALYSIS:** The air in the *nadir_upper* sector remains saturated with high humidity. The viscous remnants of the previous engagement—a splattering of translucent blue ichor and fragments of calcified chitin—have begun to congeal on the limestone floor, emitting a sharp, pheromonal musk that signals a successful kill.\n\n**ACTION LOG:** The subject expels a series of rhythmic, low-frequency vibrations from its abdomen. This subsonic hiss reverberates through the porous limestone walls, creating a territorial deterrent zone. Simultaneously, the subject deposits glandular secretions along the cave entrance. The scent-marking creates an olfactory boundary; the biological profile of the previous kill serves as a warning to encroaching Lesser Gloomthreads that this sector is occupied and reclaimed.\n\n**BIOLOGICAL STATUS:** The exertion of energy to manipulate territorial glands and vocal organs results in a marginal depletion of energy reserves. The presence of dried ichor on the subject\'s limbs provides a grim reminder of the caloric intake required to maintain its current Level 4 status.\n\n**URGENCY:** Metabolic instability persists. Despite the recent consumption, the hunger gauge is steadily declining. The labyrinth is silent for now, but the distant clicking of arachnid limbs suggests that larger entities may be migrating toward the scent of the struggle.\n\n\n\n***', '[\"(Risky Action) Descend deeper into the vertical shaft to scavenge superior prey remains left by higher-level predators. (Cost: High HP Risk)\",\"(BEAST) Aggressively expand the web-netting perimeter to catch passing cave-swarms for immediate caloric replenishment. (Cost: Med SP, Low Hunger)\",\"(Explore) Scout the immediate vicinity for minor moisture sources or cave moss to supplement fluid intake. (Cost: Low SP)\"]', '2026-04-06 23:22:58', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(98, 10, 'Eat the remains of the dead monster.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL ASSIMILATION:** The chitinous remains of the previous encounter, previously fractured by your own mandibles, are processed. The metallic, bitter taste of the biological matter coats your sensory palps as you ingest the viscous ichor pooling on the limestone floor. The internal chemistry of your vessel shifts; the hunger gnawing at your abdominal cavity recedes as the nutrient density is converted into metabolic stability. \n\n**ENVIRONMENTAL ANALYSIS:** The air within the *Nadir Upper Labyrinth* remains stagnant. The humidity, calculated at 98%, causes the cooling blood on your mandibles to become tacky. The ambient noise—the chittering of distant, unseen organisms—suggests that the scent of the struggle and the act of feeding may have breached the perimeter, potentially attracting larger predators. Your current DEF of 5 remains nominal; should a higher-tier entity arrive, your current physical integrity will be insufficient to withstand significant trauma.\n\n**METABOLIC UPDATE:** Assimilation complete. Your digestive system optimizes the intake, translating the biomass into a moderate recovery of cellular vitality and a significant reduction in caloric deficit.\n\n (Note: Over-cap status achieved)\n\n\n\n---\n\n****\n\n****\n\n****', '[\"(Scout) Scour the immediate vicinity for structural weaknesses or hidden alcoves to minimize exposure. (Cost: Low SP)\",\"(BEAST) Aggressively scent-mark the kill site, reinforcing territorial dominance to deter encroaching predators. (Cost: High SP)\",\"(Risky Action) Attempt to scale the cavern wall toward the high-ceiling webs to monitor potential threats from above. (Cost: High HP Risk)\"]', '2026-04-06 23:23:25', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(99, 10, 'Eat the remains of the dead monster.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL ASSIMILATION:** The remaining chitinous fragments and vestigial tissues of the previous adversary are processed. Your mandibles grind through the hardened exoskeleton, the sound echoing sharply against the limestone walls of the *Nadir* labyrinth. The damp, mineral-heavy air carries the copper tang of biological fluids, grounding your position in the dark. \n\nAs the biomass is broken down, a surge of vitality ripples through your frame, repairing the micro-fractures sustained during your initial emergence. However, the caloric cost of metabolism remains a constant variable; the exertion of digestion subtracts from your current endurance pool. The low-frequency hiss from your perimeter-marking still lingers in the air, a phantom warning to potential encroachers. You are currently isolated, but the sound of clicking appendages resonates from the darkness of the lower tunnel—a reminder that your territory is temporary and your presence is a biological anomaly in this stratum.\n\n**VITAL SIGNS:**\n-  (Bonus recovery from assimilation)\n- \n-  (Overflow capacity achieved)\n\n---\n\n**NEXT SEQUENCE OPTIONS:**', '[\"(BEAST) Release a hunting-chatter to test for nearby prey, heightening your senses to pinpoint movements in the dark. (Cost: Med SP, Low Hunger)\",\"(Scavenge) Scour the immediate vicinity for overlooked organic scraps or moisture deposits to bolster reserves. (Cost: Low SP)\",\"(Risky Action) Venture deeper into the damp, unmapped tunnel to locate a superior food source, risking potential combat with larger predators. (Cost: High HP Risk)\"]', '2026-04-06 23:23:33', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(100, 10, 'Harvest the spider silk and store it.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**RESOURCE ACQUISITION:** The extraction of high-tensile silk from the surrounding limestone environment proceeds with 98% efficiency. Utilizing your multi-faceted appendages, you expertly reel in the sticky filaments, coiling them into a compact, manageable cluster. The tactile feedback confirms a high grade of elasticity; the material is optimal for trap construction or structural reinforcement.\n\n**ENVIRONMENTAL INTEGRATION:** The humidity of the *nadir_upper* tunnels clings to your carapace, cooling the residual heat from your recent consumption of organic matter. The scent-marking performed in the previous cycle remains active, creating a sensory barrier that has effectively discouraged encroachment from smaller, opportunistic predators. The acoustics of the cavern have shifted; the distant, rhythmic clicking of arachnid legs echoes against the damp stone, indicating proximity to other biological entities of similar classification. \n\n**BIOLOGICAL ASSESSMENT:** Your current caloric intake has stabilized, but your metabolism is accelerating to accommodate the conversion of consumed chitin into structural reinforcement. The chitinous remains you previously ingested have been fully processed, and your stamina reserves have reached a peak state of equilibrium. \n\n**URGENCY STATUS:** Your sensory cilia detect a subtle vibration in the ceiling webs—a heavy, rhythmic pulse suggesting an organism of higher mass than a standard Lesser Gloomthread is navigating your perimeter. Stationary survival is no longer statistically optimal.\n\n\n\n\n\n\n---', '[\"(Scout) Ascend the limestone walls to observe the source of the vibrations from a superior elevation. (Cost: Low SP)\",\"(BEAST) Aggressively dismantle the nearby web structure and reinforce your current nest to challenge any intruders. (Cost: Med SP)\",\"(Risky Action) Deploy a Abyssal Cinder into the dark crevices above to flush out the source of the vibrations. (Cost: 25 MP)\"]', '2026-04-06 23:23:56', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(101, 10, 'rest', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Following the recent assimilation of nutrients and the stabilization of metabolic functions, the subject enters a state of dormancy. The limestone cavern, damp and permeated with the scent of stagnant water and decaying organic matter, provides a localized thermal efficiency buffer. \n\nAs the subject curls its chitinous frame, the tension of the harvested silk—stored within the immediate vicinity—serves as a crude sensory perimeter. The rhythmic vibrations of the labyrinth echo through the substratum, suggesting distant, massive movements that contrast with the subject\'s current state of equilibrium. With level advancement processed, the internal mana reservoirs have been optimized; the biological anomaly is now at peak operational capacity. The transition to Level 5 has increased the structural integrity of the carapace, providing a marginal buffer for future kinetic impacts.\n\nResting in the dark, the subject’s breathing slows to a clinical frequency. The cold dampness of the cavern wall against the underbelly does not disturb the recovery cycle.\n\n**URGENCY STATUS:** Caloric reserves are currently sufficient; however, the labyrinthine environment is unpredictable. Proximity to high-density monster traffic necessitates rapid strategic relocation or fortification before the current safety window expires.\n\n\n\n\n\n---', '[\"(BEAST) Engage in territorial marking by weaving a pheromone-laced web trap to deter or detect encroaching predators. (Cost: Medium SP, Low Hunger)\",\"(Scout) Carefully patrol the immediate tunnel network to map potential escape routes or ambush sites. (Cost: Low SP)\",\"(Risky Action) Venture toward the source of the rhythmic vibrations to scavenge high-value resources from a stronger predator\'s kill. (Cost: High HP Risk)\"]', '2026-04-07 00:11:08', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(102, 10, 'I survey my changing body and the path ahead.', '[SYSTEM: EVOLUTION AVAILABLE] Your vessel may undergo metamorphosis. Choose an evolution from the options below, or speak a normal action to continue.\n\n**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL ASSESSMENT:** Integration of recent nutrients has stabilized, resulting in a minor thickening of the exoskeleton. Your field of vision—multi-faceted and twitchy—sweeps across the limestone expanse. You observe the residual chitin fragments from the previous assimilation clinging to your pedipalps, and the stored silk bundles secured against your thorax. \n\nThe cavern environment remains hostile. The temperature is a stagnant, damp cold that leeches heat from your core. Auditory sensors detect a rhythmic, clicking resonance echoing from the deeper tunnels—a vibration frequency consistent with larger, predatory arachnids. Your SPD attribute remains baseline; any rapid encounter with a superior predator would currently result in a failure to evade. The sulfurous, earthy stench of the damp stone fills your spiracles, grounding you in this lightless purgatory.\n\nYour metabolic furnace is currently functioning at 95% efficiency, but the caloric density of your last meal will only sustain movement for a limited window before the \"Hunger\" state triggers a performance drop. You are physically small, a nascent biological anomaly in a labyrinth designed to crush the weak. \n\n**URGENCY:** Your immediate surroundings are quiet, but the vibrations in the floor suggest the path ahead is occupied by unknown entities. Stagnation in this corridor will inevitably lead to territorial challenges.\n\n\n\n***', '[\"Evolve: Gloomthread Weaver\",\"Evolve: Venomthread Gloomling\",\"(Explore) Navigate the cavern walls using your remaining silk to create a stable anchor point. (Cost: Low SP)\",\"(BEAST) Scuttle into the dark, using your heightened vibrations-sensing capabilities to hunt for smaller prey. (Cost: Med SP, Low Hunger)\"]', '2026-04-07 00:34:11', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(103, 10, 'Evolve: Venomthread Gloomling', 'You have become Venomthread Gloomling. Unlocks advanced Poison Synthesis but reduces physical defense.', '[]', '2026-04-07 00:34:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(104, 10, 'Search', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Sensory input processed. You have transitioned into your *Venomthread Gloomling* morphology; your chitinous frame feels lighter, though the trade-off in structural integrity is noted. The atmosphere in this limestone sector is saturated with calcium carbonate dust and the metallic tang of old moisture.\n\n**SURVEY RESULTS:** As you interact with the damp wall, the *Echo Sense L2* mastery activates, sharpening your perception of the local vibration field. The glyph etched into the limestone pulses with a faint, rhythmic frequency that matches the resonance of your own soul. You are not the only entity tethered to this System\'s interference pattern. \n\nBeyond the immediate silence, your auditory receptors pick up the rhythmic, heavy drag of scales against abrasive rock. *Veyra (Vault Dragon)* is navigating this corridor. The creature is currently prioritized on foraging, presenting a high-threat environmental variable rather than an immediate combat antagonist. The sound of its movement is massive, echoing like tectonic plates shifting behind a thin veil of silk. You are currently shielded by the labyrinth\'s architecture, but your presence is a biological anomaly the dragon may eventually classify as a caloric resource.\n\n**VITAL STATUS:** Your hunger remains stable, but the metabolic cost of maintaining your new form—and the mental strain of identifying the resonance—is beginning to deplete your internal reserves.\n\n\n\n\n\n***', '[\"(Study) Analyze the glyph for further insight into the System’s architecture. (Cost: Low SP)\",\"(BEAST) Retreat silently into the crevices of the ceiling and weave a camouflaging web. (Cost: Med SP, Low Hunger)\",\"(Risky Action) Approach the sound of the Vault Dragon to test your Weaver Control against a superior biological entity. (Cost: High HP Risk)\"]', '2026-04-08 02:32:32', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(105, 10, '(Study) Analyze the glyph for further insight into the System’s architecture. (Cost: Low SP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Sensory intake normalized. The damp, sulfurous air of the limestone cavern clings to your chitinous exoskeleton. The ambient temperature remains a steady, chilling 12°C. You shift your eight legs, the motion producing a rhythmic *click-clack* against the porous floor, echoing into the abyssal distance of the labyrinth.\n\n**ANALYSIS: GLYPH INTERACTION**\nYou press your forelimbs against the etched stone, channeling a minor surge of your 15 MAG. The glyph does not merely exist; it pulses with a pale, rhythmic luminescence that mirrors the internal clock of the System. As you focus, your *Echo Sense L2* mastery acts as a conduit. You perceive a stream of metadata leaking from the stone—a fragmented diagnostic log of a former inhabitant. \n\nThe glyph is a remnant of a \"Reincarnator’s Terminal.\" It provides no physical nourishment, but it grants a conceptual blueprint of the Labyrinth’s current mana-density. Your mental faculties struggle to parse the complex syntax, but you confirm one reality: this mark serves as a potential anchor point for dimensional navigation. The process is taxing; your concentration wavers as the sheer volume of data threatens to overload your current cognitive capacity.\n\n**SURVIVAL PRESSURE:** Your metabolic rate is climbing. The limestone environment offers little in the way of immediate nutrients, and the cold begins to dampen your reflexes. You are an isolated biological anomaly in a vast, indifferent architecture.\n\n\n\n\n\n---\n\n**CHOICE GENERATION**', '[\"(Study) Use the remaining glyph data to calibrate your \'Echo Sense\' skill, expanding your sensory radius. (Cost: Low SP, Low MP)\",\"(BEAST) Scour the immediate cavern floor and crevices for small prey or organic waste to satiate your hunger. (Cost: Med SP, Med Hunger)\",\"(Risky Action) Attempt to drain the glyph of its stored residual mana to force a momentary growth spurt. (Cost: High MP Risk, Potential HP Damage)\"]', '2026-04-08 02:34:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(106, 10, '(Study) Use the remaining glyph data to calibrate your \'Echo Sense\' skill, expanding your sensory radius. (Cost: Low SP, Low MP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Sensory integration initiated. The glyph etched into the limestone acts as a catalyst, bridging the gap between your rudimentary instincts and the System’s complex architectural language. As the *Echo Sense* skill (L2) interfaces with the residual data, the internal map of your neural network expands. \n\nThe cavern—once a blurred mess of damp shadows and sulfurous heat—crystallizes. You perceive the high-frequency vibrations of chitinous skittering two chambers over, the thermal decay of stagnant moss, and the subtle shift in air pressure indicating a ventilation shaft thirty meters to the north. Your MAG stat exerts pressure on the environment, filtering the white noise of the labyrinth into actionable data. The glyph beneath your tarsus dims, its energy consumed to fuel the expansion of your cognitive horizon. \n\nHowever, the strain of processing this multidimensional influx is not negligible. Your small, arachnid frame trembles as your brain attempts to map the geometry of the surrounding tunnels simultaneously. The labyrinth is vast, and while your spatial awareness has increased, the physical toll of sustaining such heightened perception in this damp, oxygen-poor environment is beginning to manifest as a dull ache in your primary nerve clusters.\n\n**VITAL SIGNS:**\nHP: 180/180\nMP: 81/90\nSP: 327/360\nHunger: 70/100\n\n**URGENCY:** Your metabolism is rapidly depleting. While your awareness of the labyrinth is superior, your biological need for high-protein sustenance to fuel your rapid growth is reaching a critical threshold. \n\n\n\n\n\n---', '[\"(Risky Action) Attempt to reinforce your nest using Weaver Control (L1) to lure prey into a trap, risking structural instability of the web if poorly anchored. (Cost: High SP)\",\"(BEAST) Scour the limestone crevices for cave crickets or larvae to stabilize hunger levels before the next growth phase. (Cost: Low SP)\",\"(Study) Use the enhanced Echo Sense range to map the local food chain and identify a viable hunting target. (Cost: Low MP)\"]', '2026-04-08 02:35:00', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(107, 10, '(Study) Use the enhanced Echo Sense range to map the local food chain and identify a viable hunting target. (Cost: Low MP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Echo Sense L2 initiated. Sensory input expands beyond the immediate limestone vicinity, filtering through the ambient moisture and sulfurous vapor.\n\n**ANALYSIS:** Your MAG attribute (15) serves as the processor for the sensory data flux. The connection to the glyph’s residual energy acts as a passive amplifier, refining your Echo Sense skill. The damp, cavernous echo shifts; the void resolves into a tactical overlay.\n\n**DATA MAPPING:**\n1. **The Gravefruit Spire:** Located 15 meters vertical. High caloric density detected. Nutritional intake would result in massive SP restoration. \n2. **The Labyrinth Floor:** Multiple thermal signatures identified. A swarm of *Small Rock Crabs* (Level 2) clusters near a shallow subterranean pool. They exhibit low ATK/DEF profiles, making them efficient caloric converters for a *Venomthread Gloomling*.\n3. **The Silent Predator:** A *Giant Bat* (Level 5) hangs dormant 10 meters above the pool. It is currently the apex of the local food chain. \n\nThe cavern temperature is dropping. Your chitin bristles as the Echo Sense sweep concludes, leaving a faint, burning sensation in your ocular nerves due to the MAG expenditure. You are currently situated on a vertical crag, legs locked into the stone, staring down at the scurrying crab swarm while the distant, rhythmic dripping of the cave echoes like a countdown. \n\nYour biological clock is ticking. The hunger suppression is failing; your internal storage indicates a caloric deficit. \n\n\n\n\n---\n\n**CHOICES:**', '[\"(BEAST) Descend the crag using Weaver Control to ambush the *Small Rock Crabs*; hunt and consume for immediate caloric gain. (Cost: Low SP, Low MP)\",\"(Observe) Remain stationary and analyze the *Giant Bat’s* sleep cycle to ensure safety before maneuvering toward the apple tree. (Cost: Low MP)\",\"(Risky Action) Attempt a high-speed vertical ascent toward the Gravefruit Spire; ignore the crab swarm and risk detection by the Giant Bat. (Cost: Medium SP, High Risk of discovery)\"]', '2026-04-08 02:35:43', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(108, 10, '(BEAST) Descend the crag using Weaver Control to ambush the *Small Rock Crabs*; hunt and consume for immediate caloric gain. (Cost: Low SP, Low MP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Execution of *Weaver Control L1* initiated. \n\nThe sensory data provided by the *Echo Sense L2* scan creates a spatial map of the limestone crag. Below, the *Small Rock Crabs* (Level 2-3) move with rhythmic clacking against the damp stone. Utilizing the viscosity of your silk glands, you extrude a primary filament, anchoring it to a jagged outcropping. The descent is characterized by a high degree of fluid efficiency; your SPD 15 attribute allows for a rapid, silent drop. \n\nAs you intersect the path of the nearest crustacean, you initiate a pounce. The *Small Rock Crabs* possess a DEF of 10, but your ATK 15 allows for a clean penetration of their chitinous joints. The target is neutralized with minimal kinetic dispersion. \n\n**COMBAT LOG:** \n- Target acquired. \n- *Weaver Control* successful. \n- *Biological Assimilation* complete. \n- Caloric surplus detected. \n\nThe limestone cavern echoes with the sharp *snap* of a carapace being pried open. You consume the soft, nutrient-rich interior of the target. The lingering taste of mineral-heavy cavern slime is masked by the high protein content of the prey. Your sensory nodes—honed by the previous calibration—pick up the rhythmic dripping of water from the stalactites, a stark, metallic sound that emphasizes the isolation of this environment.\n\n**STATUS UPDATE:**\n (Note: Over-cap absorption normalized to 180/180)\n\n (Note: Excess energy stored as metabolic reserves)\n\n**URGENCY:** While the immediate caloric deficit is resolved, the vibration of the cave suggests a larger entity traversing the upper deep of the limestone network. Your current position is exposed.', '[\"(Study) Deepen the investigation of the nearby glyph to decode its functionality regarding potential mana-channeling. (Cost: Medium MP)\",\"(BEAST) Scour the surrounding crags for more sedentary prey to stockpile biomass for an upcoming evolution phase. (Cost: Low SP, Low Hunger)\",\"(Improve Home Base) Use remaining silk to reinforce the ceiling niche to create a secure, elevated nest for long-term concealment. (Cost: Low SP)\"]', '2026-04-08 02:36:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(109, 10, '(BEAST) Scour the surrounding crags for more sedentary prey to stockpile biomass for an upcoming evolution phase. (Cost: Low SP, Low Hunger)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Efficiency of biomass acquisition optimization in progress. \n\nThe immediate vicinity, purged of the *Small Rock Crabs* during the previous cycle, retains the faint, metallic scent of hemolymph and pulverized chitin. Utilizing the expanded sensory radius provided by *Echo Sense L2*, you traverse the crags. Your movements are fluid, the *Weaver Control L1* allowing you to anchor your delicate limbs into the porous limestone with clinical precision. \n\nYou navigate the shadows of the cavern, where the ambient temperature drops significantly. The damp, mineral-rich atmosphere clings to your carapace. Within a deep fissure, you identify a cluster of *Cave Slugs*—slow, sedentary, and high in moisture-dense biomass. There is no resistance. You harvest them methodically, processing the protein into your biological core to satisfy the surging metabolic demands of your impending growth phase. The internal energy reserves stabilize, though the exertion of scouring the uneven terrain incurs a minor taxation on your total stamina.\n\nThe silence of the cavern is profound, broken only by the rhythmic dripping of mineral water against stone. You are currently positioned on a high ledge, overlooking a massive, unexplored chasm.\n\n\n\n\n\n**CHOICES:**', '[\"(Study) Experiment with \'Abyssal Cinder\' on a piece of inert limestone to calibrate your magical output without the pressure of a live target. (Cost: Med MP, Low SP)\",\"(Improve Home Base) Use your remaining thread reserves to reinforce the structural integrity of your current ledge, creating a sheltered, hidden nest. (Cost: Low SP)\",\"(BEAST) Scout the darker, deeper reaches of the chasm to locate a more substantial predator to consume for rapid evolutionary advancement. (Cost: Med SP, Low Hunger)\"]', '2026-04-08 02:37:15', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(110, 10, '(Study) Experiment with \'Abyssal Cinder\' on a piece of inert limestone to calibrate your magical output without the pressure of a live target. (Cost: Med MP, Low SP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Execution of *Abyssal Cinder* initiated. \n\nThe limestone cavern is thick with the scent of damp minerals and the rhythmic *drip-drip* of condensation. Positioning yourself before a jagged, unmoving slab of rock, you focus your internal mana reserves. The transition from physical webbing to metaphysical combustion requires a shift in biological processing. Your MAG attribute of 15 serves as the catalyst; a flickering, dark sphere coalesces between your mandibles. It is not merely fire; it is a localized gravitational distortion of heat. \n\nAs you release the orb, the sphere impacts the limestone with a sharp, resonant *hiss*. The stone does not shatter—it liquefies. The surface bubbles and turns to molten slag, bathing the immediate vicinity in a harsh, unnatural violet glow that pushes back the oppressive shadows of the cave. The heat is intense, singing the delicate hairs on your legs, but your RES 15 protects you from the backdraft. You observe the reaction with clinical detachment: the material output is efficient, though the cost to your MP reserves is significant. The residue left behind is glass-smooth, a stark contrast to the rough, ancient stone of the Labyrinth.\n\nHowever, the discharge has created a sudden plume of acrid, smoke-filled air that is beginning to displace the oxygen in your immediate tunnel. Your gills twitch. The silence of the cave—broken only by the cooling of the rock—is heavy, and your energy reserves are dipping into the lower thresholds.\n\n\n\n\n---', '[\"(Risky Action) Explore the deeper, smoke-filled tunnel where the \\\"reincarnator\'s glyph\\\" was sighted to see if the heat triggered a secondary reaction. (Cost: Med HP Risk)\",\"(Study) Analyze the residue of the molten rock to understand if your magical output can be modulated for tunnel excavation. (Cost: Low MP)\",\"(BEAST) Scour the ceiling for a high-ground position to rest and recover, utilizing Weaver Control to construct a concealed hammock. (Cost: Low SP)\"]', '2026-04-08 02:37:27', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(111, 10, '(Risky Action) Explore the deeper, smoke-filled tunnel where the \"reincarnator\'s glyph\" was sighted to see if the heat triggered a secondary reaction. (Cost: Med HP Risk)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Exploration of thermal anomaly initiated. \n\nThe descent into the smoke-filled tunnel is marked by a rapid escalation in ambient temperature. The lingering scent of ozone and charred mineral—the byproduct of your previous *Abyssal Cinder* calibration—clings to the humid limestone walls, which are slick with condensation. As you maneuver deeper, the *Echo Sense L2* scan pulses, revealing an unnatural disruption in the mana flow near the glyph. \n\nThe glyph itself has shifted. The heat from your previous experiment has acted as a catalyst; the mark is no longer a static carving but is now pulsating with a faint, rhythmic violet light, vibrating against the stone. As you approach, the floor beneath your abdomen buckles. The thermal energy is not merely heat; it is atmospheric radiation. Your carapace sustains micro-fractures due to the intense localized pressure, and the acidic tang of the surrounding webs begins to liquefy under the extreme environmental stress. \n\n**BIOLOGICAL IMPACT:** Your chitinous exterior absorbs the brunt of the heat-surge. The structural integrity of your legs is tested as you hover near the glyph. You have successfully identified a latent technological residue, but the biological cost is non-trivial. \n\n\n\n\n\nThe glyph remains active, flickering like a dying torch. It pulses with information you cannot yet parse—a sequence of raw data that threatens to overwhelm your processing capacity. You are currently exposed to an environment that accelerates biological degradation.\n\n***', '[\"(Study) Use \'Echo Sense L2\' to analyze the rhythmic pulse of the glyph and attempt to decipher the data flow. (Cost: Med MP)\",\"(Risky Action) Attempt to physically interact with the glyph by injecting silk thread into the crevice to ground the magical discharge. (Cost: Med HP Risk)\",\"(BEAST) Retreat to the upper crags to reinforce your thread-nest with non-flammable debris, distancing yourself from the heat. (Cost: Low SP)\"]', '2026-04-08 02:37:51', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(112, 10, '(BEAST) Retreat to the upper crags to reinforce your thread-nest with non-flammable debris, distancing yourself from the heat. (Cost: Low SP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Retrenchment to high-ground defensive position initiated. Movement efficiency: Optimal.\n\nThe transition from the thermal-saturated, smoke-filled corridor back to the upper limestone crags is marked by a significant drop in ambient temperature. Your multiple limbs, sensitive to the vibration of the labyrinth, register the damp, cool humidity of the upper cave system. Your previous exertion of *Abyssal Cinder* has left the stone around the reincarnator\'s glyph scorched and unstable; distancing yourself from this site decreases the probability of structural collapse.\n\nUsing *Weaver Control L1*, you pull calcified debris and non-flammable mineral fragments into the existing webbing. Your movements, while still developing in precision, allow you to reinforce the foundational silk strands. The tactile sensation of the grit against your chitin is a stark contrast to the slick, organic remnants of your recent biomass consumption. The smell of singed dust fades, replaced by the scent of stagnant cave water and mineral decay.\n\nYour biological status is stabilizing, though the effort of carrying structural material has drained your energy stores. You are currently positioned at the nexus of the ceiling\'s natural cracks—an ideal vantage point to monitor the tunnels below while you recover.\n\n**Vitals:**\nHP 195/180 (Overcapped)\nMP 90/90\nSP 254/360\nHunger 131/100 (Satiated)\n\n\n\n\n---', '[\"(BEAST) Groom your mandibles and legs to remove debris, ensuring the sensory hairs on your appendages are clear for maximum Echo Sense efficiency. (Cost: Low SP)\",\"(Risky Action) Venture back toward the heat-scorched glyph to extract a piece of the strangely reactive rock for closer analysis. (Cost: Med HP Risk)\",\"(Study) Inspect the structural integrity of your reinforced nest using \'Echo Sense\' to identify any hidden micro-fractures in the rock wall. (Cost: Low MP)\"]', '2026-04-08 02:38:00', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(113, 10, '(Study) Inspect the structural integrity of your reinforced nest using \'Echo Sense\' to identify any hidden micro-fractures in the rock wall. (Cost: Low MP)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Execution of *Echo Sense L2* initiated. \n\nThe limestone crags, still radiating residual warmth from the previous thermal discharge, hum with a dull, subterranean vibration. By extending your sensory perception, the damp, mineral-heavy air begins to translate into a monochromatic map of jagged reality. Using your MAG 15 attribute to sharpen the *Echo Sense* pulse, you scan the interface between your reinforced debris and the primary cave wall. \n\nThe analysis reveals the structural reality: the rock is suffering from thermal fatigue. Beneath the layer of non-flammable debris you carefully laid, *Echo Sense* highlights three distinct micro-fractures, likely caused by the sudden temperature fluctuations during your recent *Abyssal Cinder* testing. The limestone is brittle, porous, and prone to flaking under the weight of your own nest. A hairline fissure runs directly behind your central web-anchor; if the ceiling settles or another tremor occurs, the foundation of your temporary home could collapse, trapping you in a localized cavern-in. The pungent scent of wet earth and ancient mold thickens, emphasizing the fragility of your current sanctuary.\n\n****\n\n**URGENCY:** Structural instability detected. Foundation collapse risk: 14%. Your current nest is compromised; repair or relocation is recommended to maintain optimal survival probability.\n\n---', '[\"(Risky Action) Delve deeper into the tunnel to find more durable, igneous rock for a sturdier nest, abandoning the current site. (Cost: Med SP, Med Hunger)\",\"(Study) Carefully patch the detected micro-fractures using refined, hardened silk threads to prevent structural failure. (Cost: Low SP)\",\"(BEAST) Molt slightly to secrete a more viscous, adhesive web-saliva to reinforce the rock wall\'s structural integrity. (Cost: Low HP, Low SP)\"]', '2026-04-08 02:38:40', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(114, 10, '(Risky Action) Delve deeper into the tunnel to find more durable, igneous rock for a sturdier nest, abandoning the current site. (Cost: Med SP, Med Hunger)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Movement toward igneous stratum initiated. \n\nThe descent from the upper crags is fluid, your limbs moving with the efficiency granted by your recent level progression. The ichor from the defeated Gloomthread Hatchling has dried into a tacky, dark patina on your chitin, a lingering reminder of your recent territorial assertion. As you retreat from your abandoned nest, the limestone environment shifts; the air temperature rises, carrying the sharp, metallic tang of sulfur and volcanic glass. \n\nUsing *Echo Sense L2*, you scan the verticality of the tunnel. Your senses are no longer merely reactive; you perceive the subtle density variations in the stone. You find the transition: the soft, porous limestone gives way to jagged, black obsidian-like rock—igneous and heat-resistant. However, the traversal requires significant expenditure of your bodily reserves. The effort of navigating the jagged incline at high speed demands rigorous caloric intake, and your internal metabolism accelerates to compensate for the physical strain of gripping the unforgiving, razor-sharp walls. You are now deeper in the labyrinth, further from your previous safety, but the potential for a superior defensive structure is statistically significant.\n\nYour hunger levels are rising as your body synthesizes the recent XP-based growth, creating a biological demand for replenishment.\n\n**URGENCY STATUS:** Caloric reserves are depleting rapidly; the deeper tunnel is colder and lacks the ambient residual heat of the previous sector, increasing the risk of biological stasis.\n\n\n\n\n\n---', '[\"(Efficiency) Utilize \'Weaver Control L1\' to anchor yourself to the igneous walls and construct a preliminary, heat-resistant scouting point. (Cost: Low MP, Low SP)\",\"(BEAST) Consume the remains of nearby small cave fauna or leftover nutrients to stabilize your rapid growth-induced hunger before nesting. (Cost: Low SP, Low Hunger recovery)\",\"(Risky Action) Venture into the absolute dark of the deeper igneous vents to find the source of the heat, potentially unlocking higher-tier materials for the nest. (Cost: High HP Risk, Med SP)\"]', '2026-04-11 21:25:29', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(115, 10, '(BEAST) Consume the remains of nearby small cave fauna or leftover nutrients to stabilize your rapid growth-induced hunger before nesting. (Cost: Low SP, Low Hunger recovery)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Caloric intake optimization initiated. \n\nThe descent from the upper crags—where the air was thin and the limestone felt brittle—has led you to a humid, lightless fissure. Within this damp limestone pocket, the skeletal remains of a subterranean rodent-equivalent provide the necessary biological input. As you engage your mandibles, the *Corrosion Ward L1* mastery allows you to process the decaying biomass without physiological distress. The harsh, mineral tang of the cavern floor fades as you assimilate the protein, stabilizing your rapid-growth metabolism.\n\nThe echo of the cave is dampened here, the sound of water dripping onto stone rhythmic and cold. Your previous traversal across the igneous strata has left your joints aching, but the influx of biomass mitigates the metabolic debt. Your carapace, currently soft from recent growth, feels slightly sturdier as the nutrients are diverted to structural development. However, the proximity to the carved glyph you discovered earlier continues to emit a faint, anomalous resonance—a pressure against your perception that is neither sound nor physical vibration.\n\n\n\n\n\n**URGENCY:** Metabolic stabilization is currently 78% optimal. Your hunger is receding, but the ambient temperature is dropping as the cavern\'s draft intensifies. Exposure to the damp, cold currents threatens to sap your SPD and impede future movement. \n\n***', '[\"(Risky Action) Deliberately touch the carved glyph to test for a reactive interface, potentially triggering an unknown systemic response. (Cost: Med MP Risk)\",\"(BEAST) Scour the surrounding cracks for soft moss or loose cave-flora to line the interior of your nest, maximizing heat retention and comfort. (Cost: Low SP, Low Hunger)\",\"(Improve Home Base) Use \'Weaver Control L1\' to weave a moisture-wicking barrier around the carved glyph, insulating it from the damp while you study its purpose. (Cost: Low SP)\"]', '2026-04-11 21:25:44', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(116, 10, '(BEAST) Scour the surrounding cracks for soft moss or loose cave-flora to line the interior of your nest, maximizing heat retention and comfort. (Cost: Low SP, Low Hunger)', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Foraging protocol initiated. \n\nThe transition from the upper limestone crags to the igneous stratum has proven efficient. While the previous sector was defined by dry, crumbling mineral deposits, the dark, volcanic stone here retains a subterranean humidity that supports bioluminescent cave-flora. Utilizing *Echo Sense L2*, you scan the periphery of your selected crevice. Your awareness ripples outward, identifying pockets of soft, velvet-textured moss and brittle, fibrous lichens clinging to the moisture-heavy cracks.\n\nMovement is fluid. Your spider-like physiology allows you to traverse the uneven, jagged surfaces with an SPD of 15, ensuring zero tremors as you gather the organic padding. You carefully harvest the material, layering it into the hollow of your nest. The moss acts as a thermal insulator, capturing the ambient warmth of the igneous rock and preventing the rapid heat dissipation common in the upper tunnels. The nest is no longer just a hole in the wall; it is a fortified, climate-controlled habitat. \n\nHowever, the constant dripping of distant water and the shifting of tectonic plates against the labyrinth walls provide a persistent acoustic reminder that this territory is not static. Your digestive tract stabilizes, but the caloric expenditure required to maintain your rapid growth is a non-negligible variable.\n\n****\n Nest insulation optimized. +10 Hunger recovery, -15 SP. \n\n (Recovery from biomass assimilation)\n\n (Oversaturation achieved)\n\n**SURVIVAL PRESSURE:** The nest is secure, but sedentary behavior increases the risk of being discovered by wandering predators.', '[\"(Risky Action) Venture further into the dark, active tunnel to investigate the source of a rhythmic, mechanical-sounding clicking noise. (Cost: Med HP Risk)\",\"(BEAST) Scour the tunnel floor for small, crunchy cave-crustaceans to supplement your mineral intake for chitin hardening. (Cost: Low SP, Low Hunger)\",\"(Improve Home Base) Use \'Weaver Control L1\' to weave the gathered moss into a tight, web-reinforced mattress for the nest floor. (Cost: Low SP)\"]', '2026-04-11 21:36:26', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(117, 10, 'keep looking for food', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Foraging sub-routine active. \n\nThe subterranean descent has transitioned from the damp, porous limestone into a sharper, more unforgiving igneous basalt stratum. The ambient temperature here is marginally higher, a byproduct of deep-earth geothermal activity. Your *Echo Sense L2* pulses at a low frequency, scanning the micro-fissures of the cavern walls for organic heat signatures or mineral deposits.\n\nMovement is efficient. Your *SPD 15* allows you to navigate the jagged obsidian-like outcroppings without snagging your sensitive limbs. While the moss retrieved earlier provides insulation, it does not provide sustenance. Your current caloric deficit is beginning to impact metabolic efficiency. As you traverse a narrow fissure, the *Echo Sense* skill registers a faint, erratic vibration—not a monster, but a cluster of nutrient-rich, translucent cave fungi clinging to a subterranean vein of cooling magma.\n\nThe scent is pungent, mineral-heavy, and cloying. You adjust your stance, using *Weaver Control L1* to anchor yourself against the vertical incline as you reach for the bioluminescent spores. Your hunger is a dull, gnawing pressure against your core, necessitating immediate caloric replenishment to maintain current growth velocity.\n\n**CURRENT STATUS:**\n- HP: 180/180\n- MP: 90/90\n- Hunger: 89/100 (Slight improvement from foraging success)\n- SP: 310/360\n\n\n\n\n\n---', '[\"(Risky Action) Venture further into the heat-vent to see if the fungi\'s origin point contains larger, more nutrient-dense specimens. (Cost: Med HP Risk, Med SP)\",\"(BEAST) Gorging: Devour the fungi and any insects attracted to the spores immediately to maximize energy density. (Cost: Low SP, Low Hunger recovery)\",\"(Efficiency) Harvest the cave fungi and store the excess in your nest for future caloric security. (Cost: Low SP)\"]', '2026-04-11 21:41:22', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(118, 10, 'keep alert', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Vigilance sub-routine active. Sensor-array calibration: 98% efficiency.\n\nThe subterranean environment remains in a state of stagnant stillness. Having secured a caloric baseline in previous iterations, your physiological state is currently stable. The limestone chamber is thick with the scent of damp earth and calcified mineral deposits; the silence is punctuated only by the rhythmic drip of condensation echoing against the uneven cave walls.\n\nYour heightened senses—bolstered by *Echo Sense L2*—trace the vibrations of the cavern. You remain motionlessly coiled within the nest fashioned from scavenged moss and webbing. The faint, alien glyph carved into the stone nearby flickers at the edge of your perception, a nagging biological anomaly in a landscape otherwise governed by primitive instincts. Your carapace remains tight, your *SPD 15* and *RES 15* stats held in a state of high-ready, ready to pivot at the slightest atmospheric shift. \n\nThere is no immediate predatory threat, yet the labyrinthine air carries the faint, metallic tang of shifting shadows deeper in the tunnel network. You are currently positioned as an apex of this small, isolated niche, though the wider cave system remains a variable of high uncertainty.\n\n**URGENCY:** Sustained caloric expenditure is low, but the lack of active stimuli suggests a need for environmental manipulation or skill refinement to ensure long-term viability.\n\n\n\n\n\n---', '[\"(BEAST) Scour the perimeter for larger fauna remains to stockpile nutrients against future periods of low prey density. (Cost: Low SP, Low Hunger)\",\"(Improve Home Base) Reinforce the outer perimeter of the nest with reinforced webbing threads to improve structural integrity and detection radius. (Cost: Low SP)\",\"(Practice Skill) Attempt to channel the \'Abyssal Cinder\' at a low intensity into the stone glyph to test for a latent reaction or interaction. (Cost: Med MP)\"]', '2026-04-11 21:50:11', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(119, 10, 'Open status menu', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**BIOLOGICAL CALIBRATION:** Interface link established. \n\nThe damp, limestone walls of the labyrinth weep with condensation, the air heavy with the scent of stagnant water and ancient sediment. As the focus shifts inward, the HUD flickers into existence, overlaying the dim reality of the cave. The faint, glowing glyph carved into the stone near your nest pulses in rhythmic sync with your own consciousness—a ghostly reflection of the system menu.\n\n**DATA ARCHIVE ACCESS:**\n*   **Identity:** Venomthread Gloomling \n*   **Vitals:** HP 180/180 | MP 90/90 | SP 311/360\n*   **Attributes:** ATK 15 | DEF 15 | MAG 15 | RES 15 | SPD 15\n*   **Active Mastery:** Echo Sense (L2) creates a localized sensory sphere, filtering the distant echoes of shifting stone and skittering legs; Weaver Control (L1) remains latent but ready, the silk glands idling with potential.\n\nThe status window confirms your biological parameters. Your efficiency remains optimal, though the prolonged period of low-calorie intake during the nesting process is beginning to impact metabolic reserves. The distant, erratic movement in the labyrinth suggests a shift in predator migration; your nest, while fortified with soft flora, remains a target if not properly concealed.\n\n**IMMEDIATE SURVIVAL PRESSURE:** Metabolic maintenance (Hunger: 90/100). The necessity for protein-rich intake is rising to sustain the energy requirements of your Level 11 physiology.\n\n---', '[\"(Study) Examine the carved glyph on the cave wall; attempt to synchronize Weaver Control with the stone\'s energy. (Cost: Med MP)\",\"(BEAST) Hunt in the immediate vicinity; utilize Echo Sense L2 to track the rhythmic breathing of nearby small prey. (Cost: Low SP, Med Hunger)\",\"(Improve Home Base) Reinforce the nest entrance with a tripwire-thread array to dampen vibrations from intruders. (Cost: Low SP)\"]', '2026-04-11 21:59:43', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `active_encounters`
--

CREATE TABLE `active_encounters` (
  `encounter_id` int(11) NOT NULL,
  `life_id` int(11) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `dynamic_level` int(11) DEFAULT 1,
  `current_hp` int(11) NOT NULL,
  `max_hp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `active_encounters`
--

INSERT INTO `active_encounters` (`encounter_id`, `life_id`, `npc_id`, `dynamic_level`, `current_hp`, `max_hp`) VALUES
(1, 15, 2, 1, 47, 55);

-- --------------------------------------------------------

--
-- Table structure for table `current_life`
--

CREATE TABLE `current_life` (
  `life_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `vessel_type` varchar(100) DEFAULT 'Beast',
  `current_level` int(11) DEFAULT 1,
  `hp` int(11) DEFAULT 10,
  `max_hp` int(11) DEFAULT 10,
  `mp` int(11) DEFAULT 10,
  `max_mp` int(11) DEFAULT 10,
  `hunger` int(11) DEFAULT 100,
  `sp` int(11) DEFAULT 20,
  `max_sp` int(11) DEFAULT 20,
  `current_location` varchar(50) DEFAULT 'nadir_upper',
  `is_alive` tinyint(1) DEFAULT 1,
  `pos_x` int(11) DEFAULT 0,
  `pos_y` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `next_level_xp` int(11) DEFAULT 100,
  `attribute_points` int(11) DEFAULT 0,
  `offense` int(11) DEFAULT 5,
  `defense` int(11) DEFAULT 5,
  `magic_power` int(11) DEFAULT 5,
  `resistance` int(11) DEFAULT 5,
  `speed` int(11) DEFAULT 5,
  `skill_points` int(11) DEFAULT 0,
  `inventory` text DEFAULT '[]',
  `home_base` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `current_life`
--

INSERT INTO `current_life` (`life_id`, `user_id`, `species`, `vessel_type`, `current_level`, `hp`, `max_hp`, `mp`, `max_mp`, `hunger`, `sp`, `max_sp`, `current_location`, `is_alive`, `pos_x`, `pos_y`, `xp`, `next_level_xp`, `attribute_points`, `offense`, `defense`, `magic_power`, `resistance`, `speed`, `skill_points`, `inventory`, `home_base`) VALUES
(9, 1, 'Cave Centipede', 'Beast', 1, 15, 15, 5, 5, 100, 20, 20, 'nadir_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(10, 1, 'Venomthread Gloomling', 'Beast', 11, 180, 180, 90, 90, 90, 311, 360, 'nadir_upper', 1, 0, 0, 0, 144, 10, 15, 15, 15, 15, 15, 4, '[\"Gloomthread Silk\"]', 'nadir_upper'),
(11, 2, 'Scrap Slime', 'Beast', 1, 14, 20, 20, 20, 100, 20, 20, 'nadir_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(12, 2, 'Cinder Wyrmling', 'Beast', 1, 14, 25, 10, 10, 100, 20, 20, 'magma_layer', 1, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(13, 3, 'Blind Cave Salamander', 'Beast', 1, 27, 30, 10, 10, 100, 20, 20, 'drowned_veins', 0, 0, 0, 0, 100, 0, 6, 12, 4, 15, 5, 0, '[]', NULL),
(14, 3, 'Human', 'Predator', 1, 55, 55, 15, 15, 100, 35, 35, 'crown_citadel', 0, 0, 0, 0, 100, 0, 12, 8, 5, 5, 5, 0, '[]', NULL),
(15, 3, 'Shadow Bat', 'Predator', 1, 0, 18, 15, 15, 33, 0, 20, 'nadir_upper', 0, 0, 0, 15, 100, 0, 7, 4, 5, 5, 18, 0, '[]', NULL),
(16, 3, 'Dwarf', 'Scavenger', 1, 0, 80, 10, 10, 100, 0, 45, 'nadir_upper', 0, 0, 0, 20, 100, 0, 14, 20, 5, 5, 5, 0, '[]', NULL),
(17, 3, 'Scrap Slime', 'Scavenger', 1, 20, 20, 20, 20, 100, 20, 20, 'nadir_upper', 1, 0, 0, 0, 100, 0, 4, 10, 12, 12, 3, 0, '[]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `duel_actions`
--

CREATE TABLE `duel_actions` (
  `action_id` int(11) NOT NULL,
  `duel_id` int(11) DEFAULT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `action_text` text DEFAULT NULL,
  `system_description` text DEFAULT NULL,
  `choices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`choices`)),
  `hp_after_action` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `duel_actions`
--

INSERT INTO `duel_actions` (`action_id`, `duel_id`, `actor_id`, `action_text`, `system_description`, `choices`, `hp_after_action`, `created_at`) VALUES
(2, 1, 1, 'ACCEPTED CHALLENGE', 'Location: nadir_upper\nMode: TO_POINT\n\nThe upper deep of the Nadir Labyrinth are bathed in a dim, bioluminescent glow, the air thick with the scent of damp moss and prehistoric dust. \n\nJoker, a Scrap Slime composed of rusted metal shards and viscous, translucent gel, quivers as it navigates the jagged stone floor. Its metallic core clinks rhythmically against the rock. Suddenly, the cavern floor trembles. From a crevice in the wall, Light—a Cave Centipede—erupts into the corridor. Its segmented chitinous plates shimmer like polished bone under the faint light, and its mandibles click with lethal precision, dripping with a paralyzing digestive enzyme. The centipede coils its massive, multi-legged body, sensing the metallic vibrations emanating from the slime. It locks its multifaceted eyes onto Joker, arching its thorax in preparation for a high-speed lunge.\n\nThe duel begins now.\n\n Use \"Rust Shrapnel\" to launch a cloud of jagged metal bits at the centipede’s sensory antennae to disorient it.]\n\n Retract into a dense, hardened metallic ball and bait the centipede into biting, hoping the sharp shards will lodge in its mandibles.]\n\n Utilize \"Gel-Slide\" to coat the cavern floor in slippery slime, forcing the multi-legged centipede to lose its footing during its charge.]', '[\"[Aggressive\",\"[Defensive\",\"[Evasive\"]', NULL, '2026-04-03 22:34:47'),
(3, 1, 2, 'Evasive', 'Mode: TO_POINT\nActor: joker (Scrap Slime) HP: 20\nTarget: light (Cave Centipede) HP: 15\n\n1. **Narration:**\nThe Scrap Slime collapses its amorphous, metallic frame into a shallow puddle, its jagged obsidian edges flattening against the cavern floor just as the Cave Centipede lunges. The centipede’s mandibles snap shut on empty, pressurized air, its serrated legs skittering harmlessly over the slime\'s shifting, viscous surface. The slime ripples, resetting its density and regaining its composure, having successfully bypassed the lethal strike.\n\n2. **HP Update:**\n (No damage dealt to target; Joker retains 20 HP)\n\n3. **Tactical Options:**', '[\"\\\"Corrosive Puddle\\\" - Joker liquifies further to coat the centipede’s underbelly, dealing 3 acid damage.\",\"\\\"Razor Spike\\\" - Joker hardens into a jagged turret and launches a projectile at the centipede’s weak point, dealing 5 damage.\",\"\\\"Binding Wrap\\\" - Joker lashes out with sticky, metallic pseudopods to restrain the centipede, preventing its next movement/action.\"]', NULL, '2026-04-03 22:39:11'),
(4, 1, 1, 'Binding Wrap', 'The Cave Centipede’s chitinous mandibles lock into position, erupting into a flurry of serrated limbs. The \"Binding Wrap\" maneuver initiates, coiling around the Scrap Slime\'s gelatinous, refuse-strewn mass. Thousands of microscopic hooks pierce the target\'s exterior, exerting constrictive pressure that forces pressurized fluids to rupture from the slime\'s porous hide. The structural integrity of the target sustains significant compromise.', '[\"Acidic Ejection (Release a caustic burst to force the centipede to disengage.)\",\"Recursive Absorption (Pull the centipede into the core mass to degrade its armored plating.)\",\"Dispersive Dash (Violently oscillate form to break the binding and relocate.)\"]', NULL, '2026-04-03 22:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `duel_challenges`
--

CREATE TABLE `duel_challenges` (
  `duel_id` int(11) NOT NULL,
  `challenger_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `duel_type` enum('TO_POINT','TO_DEATH') DEFAULT 'TO_POINT',
  `status` enum('PENDING','ACCEPTED','REJECTED','COMPLETED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_action_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `duel_challenges`
--

INSERT INTO `duel_challenges` (`duel_id`, `challenger_id`, `target_id`, `duel_type`, `status`, `created_at`, `last_action_at`) VALUES
(1, 2, 1, 'TO_POINT', 'ACCEPTED', '2026-04-03 22:05:33', '2026-04-03 22:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `evolution_paths`
--

CREATE TABLE `evolution_paths` (
  `evolution_id` int(11) NOT NULL,
  `from_species` varchar(100) DEFAULT NULL,
  `to_species` varchar(100) DEFAULT NULL,
  `req_level` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evolution_paths`
--

INSERT INTO `evolution_paths` (`evolution_id`, `from_species`, `to_species`, `req_level`, `description`) VALUES
(1, 'Gloomthread Hatchling', 'Gloomthread Weaver', 10, 'A balanced spider body with improved speed and thread production.'),
(2, 'Gloomthread Hatchling', 'Venomthread Gloomling', 10, 'Unlocks advanced Poison Synthesis but reduces physical defense.');

-- --------------------------------------------------------

--
-- Table structure for table `factions`
--

CREATE TABLE `factions` (
  `id` int(11) NOT NULL,
  `name` varchar(180) NOT NULL,
  `faction_type` varchar(80) NOT NULL,
  `ideology` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `leader_entity_id` int(11) DEFAULT NULL,
  `power_rank` int(11) DEFAULT 1,
  `relationship_to_player_default` int(11) DEFAULT 0,
  `status` enum('active','fallen','hidden','sealed') DEFAULT 'hidden',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location_connectors`
--

CREATE TABLE `location_connectors` (
  `connector_id` int(11) NOT NULL,
  `from_location` varchar(50) NOT NULL,
  `to_location` varchar(50) NOT NULL,
  `direction` enum('UP','DOWN','NORTH','SOUTH','EAST','WEST','LEFT','RIGHT') NOT NULL,
  `min_level_req` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_connectors`
--

INSERT INTO `location_connectors` (`connector_id`, `from_location`, `to_location`, `direction`, `min_level_req`) VALUES
(1, 'nadir_upper', 'nadir_middle', 'DOWN', 1),
(2, 'nadir_middle', 'nadir_upper', 'UP', 1),
(3, 'nadir_middle', 'nadir_lower', 'DOWN', 1),
(4, 'nadir_lower', 'nadir_middle', 'UP', 1),
(5, 'nadir_lower', 'magma_layer', 'DOWN', 1),
(6, 'magma_layer', 'nadir_lower', 'UP', 1),
(7, 'magma_layer', 'ash_tunnels', 'DOWN', 1),
(8, 'ash_tunnels', 'magma_layer', 'UP', 1),
(9, 'nadir_upper', 'webbed_hollows', 'LEFT', 1),
(10, 'webbed_hollows', 'nadir_upper', 'RIGHT', 1),
(11, 'nadir_upper', 'fungus_grotto', 'RIGHT', 1),
(12, 'fungus_grotto', 'nadir_upper', 'LEFT', 1),
(13, 'nadir_lower', 'corpse_pit', 'LEFT', 1),
(14, 'corpse_pit', 'nadir_lower', 'RIGHT', 1),
(15, 'nadir_lower', 'dragon_breach', 'RIGHT', 1),
(16, 'dragon_breach', 'nadir_lower', 'LEFT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `location_seeds`
--

CREATE TABLE `location_seeds` (
  `location_id` varchar(50) NOT NULL,
  `description_seed` text DEFAULT NULL,
  `hidden_lore` text DEFAULT NULL,
  `location_image` varchar(255) DEFAULT NULL,
  `danger_level` int(11) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT 'nadir_labyrinth',
  `level_depth` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_seeds`
--

INSERT INTO `location_seeds` (`location_id`, `description_seed`, `hidden_lore`, `location_image`, `danger_level`, `region_name`, `level_depth`) VALUES
('ash_tunnels', 'A suffocating network of tunnels filled with ash and smoke. Visibility is nearly zero, and breathing becomes a challenge. This is near-death territory.', NULL, 'http://localhost:7000/uploads/generic_1775338140044-109446823.png', 10, 'nadir_labyrinth', 4),
('corpse_pit', 'A feeding ground filled with rotting carcasses. Scavengers and predators gather here, creating constant conflict. The smell alone is overwhelming.', NULL, 'http://localhost:7000/uploads/generic_1775337601515-83449986.png', 8, 'nadir_labyrinth', 3),
('crystal_vein', 'A sharp, glowing cavern filled with crystal formations that hum with energy. Sound bends strangely here, and some creatures are drawn to its resonance.', NULL, 'http://localhost:7000/uploads/generic_1775337461034-28743475.png', 5, 'nadir_labyrinth', 2),
('dragon_breach', 'A broken cavern shaped by the movement of ancient dragons. Heat, pressure, and danger fill the air. This is not a place for the weak.', NULL, 'http://localhost:7000/uploads/generic_1775337760634-865578033.png', 9, 'nadir_labyrinth', 3),
('nadir_lower', 'Nadir Lower Labyrinth: A hellish, cavernous landscape teeming with vault dragons and venomous beasts.', NULL, 'http://localhost:7000/uploads/generic_1775337397083-148064841.png', 7, 'nadir_labyrinth', 2),
('nadir_middle', 'A transitional layer where tunnels widen and dangers increase. Echoes travel far, and predators roam between upper and lower layers. This is where survival becomes strategy.', NULL, 'http://localhost:7000/uploads/generic_1775336809832-102049221.png', 4, 'nadir_labyrinth', 1),
('nadir_upper', 'A sprawling network of dark, damp limestone caves. Weak monsters roam here, but survival is not guaranteed. Sticky webs line the ceilings, and the sound of distant movement never stops.', 'Carved into the damp stone: a faint mark that resembles a reincarnator\'s skill menu glyph.', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', 2, 'nadir_labyrinth', 0),
('fungus_grotto', 'A humid cavern glowing with bioluminescent fungi. Spores drift through the air, feeding scavengers and poison-based creatures. Some fungi heal others kill.', NULL, 'http://localhost:7000/uploads/generic_1775336277019-933342202.png', 3, 'nadir_labyrinth', 1),
('magma_layer', 'Rivers of flowing lava cut through this region. The heat is unbearable, and only creatures adapted to extreme environments survive.', NULL, 'http://localhost:7000/uploads/generic_1775337971407-462015717.png', 9, 'nadir_labyrinth', 3),
('drowned_veins', 'A flooded section of the labyrinth filled with underground streams and submerged tunnels. Visibility is low, and movement is slowed. Creatures here rely on vibration and sound.', NULL, 'http://localhost:7000/uploads/generic_1775337006193-800054934.png', 5, 'nadir_labyrinth', 2),
('webbed_hollows', 'A dense cluster of tunnels overtaken by spider colonies. Thick silk webs stretch across entire chambers, and egg sacs hang silently above. Movement is dangerous — and often noticed.', 'A hidden spider-silk nest glimmers between two stalactites — abandoned, but strands still twitch as if something recently passed.', 'http://localhost:7000/uploads/generic_1775336056813-119887663.png', 3, 'nadir_labyrinth', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lore_entries`
--

CREATE TABLE `lore_entries` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_items`
--

CREATE TABLE `master_items` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `effect_value` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_items`
--

INSERT INTO `master_items` (`id`, `name`, `description`, `item_type`, `effect_value`) VALUES
(1, 'Monster Meat', 'Raw, tough meat harvested from a beast. Restores 35 Hunger and 15 HP.', 'CONSUMABLE', 35),
(2, 'Gloomthread Silk', 'Sticky, highly durable spider thread. Useful for crafting or traps.', 'MATERIAL', 0),
(3, 'Scrap Metal', 'A jagged piece of rusted iron. Good for crafting.', 'MATERIAL', 0),
(4, 'Mana Core (Small)', 'A crystallized drop of pure mana. Restores 20 MP.', 'CONSUMABLE', 20);

-- --------------------------------------------------------

--
-- Table structure for table `master_npcs`
--

CREATE TABLE `master_npcs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `species_type` varchar(50) DEFAULT NULL,
  `base_hp` int(11) DEFAULT NULL,
  `base_offense` int(11) NOT NULL DEFAULT 5,
  `base_defense` int(11) NOT NULL DEFAULT 2,
  `base_level` int(11) DEFAULT NULL,
  `danger_rank` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `npc_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_npcs`
--

INSERT INTO `master_npcs` (`id`, `name`, `species_type`, `base_hp`, `base_offense`, `base_defense`, `base_level`, `danger_rank`, `description`, `npc_image`) VALUES
(1, 'Gloomthread Hatchling', 'MONSTER', 20, 5, 2, 1, 'F', 'A weak spider hatchling.', NULL),
(2, 'Mireglass Toad', 'BEAST', 45, 12, 8, 3, 'E', 'Spits acidic venom.', NULL),
(3, 'Craghowler', 'MONSTER', 120, 45, 30, 10, 'B', 'A huge monkey-like creature that hunts in packs.', NULL),
(4, 'Vault Dragon Oryxen', 'DRAGON', 8000, 4500, 4000, 35, 'S', 'The apex predator of the Lower Deep.', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_skills`
--

CREATE TABLE `master_skills` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `karma_cost` int(11) NOT NULL,
  `skill_type` varchar(50) NOT NULL,
  `sp_cost` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_skills`
--

INSERT INTO `master_skills` (`id`, `name`, `description`, `karma_cost`, `skill_type`, `sp_cost`) VALUES
(1, 'Toxin Ward', 'Reduces damage and negates debuffs from acidic and venomous attacks.', 10, 'RESISTANCE', 0),
(2, 'Pain Severance', 'Prevents shock and stat degradation when taking massive damage.', 25, 'PASSIVE', 0),
(3, 'True Sight', 'Reveals exact stats, hidden weaknesses, and precise HP of all entities.', 50, 'PASSIVE', 0),
(4, 'Abyssal Cinder', 'Conjures a concentrated sphere of dark flame that incinerates the target.', 40, 'ACTIVE', 25);

-- --------------------------------------------------------

--
-- Table structure for table `monster_species`
--

CREATE TABLE `monster_species` (
  `id` int(11) NOT NULL,
  `name` varchar(180) NOT NULL,
  `species_type` varchar(80) NOT NULL,
  `habitat_region_id` int(11) DEFAULT NULL,
  `temperament` varchar(180) DEFAULT NULL,
  `rarity` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `evolution_notes` text DEFAULT NULL,
  `canon_status` enum('rumor','confirmed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `npcs`
--

CREATE TABLE `npcs` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `npcs`
--

INSERT INTO `npcs` (`id`, `name`, `role`, `faction_id`, `home_region_id`, `home_place_id`, `personality_archetype`, `description`, `current_emotional_state`, `secret_summary`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Cael Voss', 'Human (Oathmarked Heir)', NULL, NULL, NULL, 'reincarnated anomaly', 'Training at the Ashen Lyceum. Acquired [Sanctum Rite].', 'guarded', 'Iren Vale', 'active', '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(2, 'Veyra', 'Vault Dragon', NULL, NULL, 7, 'reincarnated anomaly', 'Wandering the upper labyrinth looking for food.', 'guarded', 'Mara Venn', 'active', '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(3, 'The Veiled Auditor', 'Unknown', NULL, NULL, NULL, 'reincarnated anomaly', 'Watching the labyrinth with impossible patience.', 'guarded', 'Nocturne Witness', 'active', '2026-04-19 01:12:07', '2026-04-19 01:12:07');

-- --------------------------------------------------------

--
-- Table structure for table `npc_memory_tags`
--

CREATE TABLE `npc_memory_tags` (
  `id` int(11) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `current_life_id` int(11) DEFAULT NULL,
  `memory_tag` varchar(120) NOT NULL,
  `memory_summary` text NOT NULL,
  `emotional_weight` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `npc_relationships`
--

CREATE TABLE `npc_relationships` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `npc_scene_history`
--

CREATE TABLE `npc_scene_history` (
  `id` int(11) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `current_life_id` int(11) DEFAULT NULL,
  `scene_type` varchar(100) NOT NULL,
  `scene_summary` text NOT NULL,
  `emotional_impact` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reincarnated_npcs`
--

CREATE TABLE `reincarnated_npcs` (
  `npc_id` int(11) NOT NULL,
  `original_name` varchar(50) DEFAULT NULL,
  `new_name` varchar(50) DEFAULT NULL,
  `current_species` varchar(50) DEFAULT NULL,
  `current_location` varchar(50) DEFAULT NULL,
  `status_log` text DEFAULT NULL,
  `is_player_event` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reincarnated_npcs`
--

INSERT INTO `reincarnated_npcs` (`npc_id`, `original_name`, `new_name`, `current_species`, `current_location`, `status_log`, `is_player_event`) VALUES
(1, 'Iren Vale', 'Cael Voss', 'Human (Oathmarked Heir)', 'crown_citadel', 'Training at the Ashen Lyceum. Acquired [Sanctum Rite].', 1),
(2, 'Mara Venn', 'Veyra', 'Vault Dragon', 'nadir_upper', 'Wandering the upper labyrinth looking for food.', 1),
(3, 'Nocturne Witness', 'The Veiled Auditor', 'Unknown', 'unknown', 'Watching the labyrinth with impossible patience.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE `relationships` (
  `rel_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `bond_type` enum('FRIEND','RIVAL') NOT NULL,
  `status` enum('PENDING','ACCEPTED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relationships`
--

INSERT INTO `relationships` (`rel_id`, `user_id`, `target_id`, `bond_type`, `status`, `created_at`) VALUES
(1, 1, 2, 'FRIEND', 'ACCEPTED', '2026-04-03 20:49:33'),
(2, 2, 1, 'FRIEND', 'ACCEPTED', '2026-04-03 20:59:50');

-- --------------------------------------------------------

--
-- Table structure for table `soul_library`
--

CREATE TABLE `soul_library` (
  `user_id` int(11) NOT NULL,
  `soul_rank` int(11) DEFAULT 1,
  `accumulated_karma` int(11) DEFAULT 0,
  `skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '[]',
  `death_count` int(11) DEFAULT 0,
  `skill_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soul_library`
--

INSERT INTO `soul_library` (`user_id`, `soul_rank`, `accumulated_karma`, `skills`, `death_count`, `skill_points`) VALUES
(1, 1, 0, '{\"Echo Sense\":2,\"Weaver Control\":1,\"Corrosion Ward\":1}', 0, 0),
(2, 1, 0, '[]', 0, 0),
(3, 1, 55, '[]', 0, 0),
(4, 1, 0, '[]', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `starting_vessels`
--

CREATE TABLE `starting_vessels` (
  `vessel_id` int(11) NOT NULL,
  `soul_path` varchar(50) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `base_hp` int(11) DEFAULT NULL,
  `base_mp` int(11) DEFAULT NULL,
  `starting_location` varchar(50) DEFAULT NULL,
  `vessel_image` varchar(255) DEFAULT NULL,
  `base_offense` int(11) DEFAULT 5,
  `base_defense` int(11) DEFAULT 5,
  `base_magic_power` int(11) DEFAULT 5,
  `base_resistance` int(11) DEFAULT 5,
  `base_speed` int(11) DEFAULT 5,
  `base_hunger` int(11) DEFAULT 100,
  `base_sp` int(11) DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `starting_vessels`
--

INSERT INTO `starting_vessels` (`vessel_id`, `soul_path`, `species`, `base_hp`, `base_mp`, `starting_location`, `vessel_image`, `base_offense`, `base_defense`, `base_magic_power`, `base_resistance`, `base_speed`, `base_hunger`, `base_sp`) VALUES
(1, 'Scavenger', 'Gloomthread Hatchling', 10, 10, 'nadir_upper', 'http://localhost:7000/uploads/generic_007.png', 6, 4, 8, 5, 12, 100, 20),
(2, 'Scavenger', 'Cave Centipede', 15, 5, 'nadir_upper', NULL, 8, 6, 2, 4, 10, 100, 20),
(3, 'Scavenger', 'Scrap Slime', 20, 20, 'nadir_upper', NULL, 4, 10, 12, 12, 3, 100, 20),
(4, 'Scavenger', 'Spectral Mite', 8, 25, 'nadir_upper', NULL, 3, 2, 15, 10, 14, 100, 20),
(5, 'Predator', 'Wolf Pup', 20, 5, 'nadir_upper', NULL, 12, 6, 2, 4, 15, 100, 20),
(6, 'Predator', 'Cinder Wyrmling', 25, 10, 'magma_layer', NULL, 14, 8, 10, 8, 10, 100, 20),
(7, 'Predator', 'Venomous Hatchling', 22, 12, 'nadir_lower', NULL, 11, 5, 6, 5, 13, 100, 20),
(8, 'Predator', 'Shadow Bat', 18, 15, 'nadir_upper', NULL, 7, 4, 9, 6, 18, 100, 20),
(9, 'Prey', 'Weakling Rat', 5, 5, 'nadir_upper', NULL, 3, 2, 1, 2, 8, 100, 20),
(10, 'Prey', 'Crystalline Snail', 40, 30, 'magma_layer', NULL, 5, 25, 10, 20, 1, 100, 20),
(11, 'Prey', 'Cave Bat', 8, 8, 'nadir_upper', NULL, 4, 3, 5, 4, 12, 100, 20),
(12, 'Prey', 'Blind Cave Salamander', 30, 10, 'drowned_veins', NULL, 6, 12, 4, 15, 5, 100, 20),
(13, 'Predator', 'Human', 55, 15, 'crown_citadel', NULL, 12, 8, 5, 5, 5, 100, 35),
(14, 'Prey', 'Human', 45, 30, 'crown_citadel', NULL, 6, 12, 5, 5, 5, 100, 25),
(15, 'Scavenger', 'Dwarf', 80, 10, 'iron_forge', NULL, 14, 20, 5, 5, 5, 120, 45);

-- --------------------------------------------------------

--
-- Table structure for table `story_milestones`
--

CREATE TABLE `story_milestones` (
  `milestone_id` int(11) NOT NULL,
  `code` varchar(64) NOT NULL,
  `min_level` int(11) DEFAULT NULL,
  `location_id` varchar(50) DEFAULT NULL,
  `content` text NOT NULL,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `story_milestones`
--

INSERT INTO `story_milestones` (`milestone_id`, `code`, `min_level`, `location_id`, `content`, `sort_order`) VALUES
(1, 'soul_resonance_lv5', 5, NULL, '[STORY BEAT] The System\'s voice steadies: your soul-resonance has crossed a threshold. Distant threads of other reincarnators tug at the edge of your perception — not as enemies, but as echoes in the same cruel fairytale.', 10),
(2, 'labyrinth_whispers', NULL, 'nadir_upper', '[STORY BEAT] The upper labyrinth hums with more than monsters: somewhere, silk drags across stone, and a name you almost recognize flits through your thoughts.', 20);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `karma` int(11) NOT NULL DEFAULT 0,
  `permanent_skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '[]' CHECK (json_valid(`permanent_skills`)),
  `role` varchar(20) DEFAULT 'player',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `system_voice` varchar(20) DEFAULT 'ADMIN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password_hash`, `karma`, `permanent_skills`, `role`, `created_at`, `system_voice`) VALUES
(1, '8amlight@gmail.com', 'light', '$2b$10$XYlXKzvMUZnO.hYgvGPd8.K/PyBsEkJxR2TxGa3ykjWKPsEeNyQ4G', 0, '[\"Abyssal Cinder\"]', 'player', '2026-04-03 18:11:06', 'ADMIN'),
(2, '8amjoker@gmail.com', 'joker', '$2b$10$KdHV2FZUFHeVTBn.F202Gu5UvetTetwIqXSdJVLV5lUXBMYgK95yW', 0, '[]', 'player', '2026-04-03 20:38:39', 'ADMIN'),
(3, 'admin@admin.com', 'god', '$2b$10$yzahJBWCcGAa76.lFLzvsOquEc3nvk8j/6fw8oWBt5Iq9IVGugExq', 50, '[\"True Sight\"]', 'admin', '2026-04-03 23:13:02', 'ADMIN'),
(4, 'oghenesupersam914@gmail.com', 'sam', '$2b$10$qSORTKmr2y/Fst3sskTeZul1G.bscCXuiEoAUJooCZrqVWSp.yJyy', 0, '[]', 'player', '2026-04-04 01:42:30', 'ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `user_story_milestones`
--

CREATE TABLE `user_story_milestones` (
  `user_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL,
  `triggered_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_story_milestones`
--

INSERT INTO `user_story_milestones` (`user_id`, `milestone_id`, `triggered_at`) VALUES
(1, 1, '2026-04-08 02:32:27'),
(1, 2, '2026-04-08 02:32:27');

-- --------------------------------------------------------

--
-- Table structure for table `world_entities`
--

CREATE TABLE `world_entities` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `world_events`
--

CREATE TABLE `world_events` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `world_generation_queue`
--

CREATE TABLE `world_generation_queue` (
  `id` int(11) NOT NULL,
  `life_id` int(11) DEFAULT NULL,
  `trigger_action` text DEFAULT NULL,
  `proposal_type` varchar(80) DEFAULT NULL,
  `proposal_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`proposal_json`)),
  `status` enum('pending','approved','rejected','merged') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `reviewed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `world_places`
--

CREATE TABLE `world_places` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `world_places`
--

INSERT INTO `world_places` (`id`, `region_id`, `name`, `place_type`, `description`, `lore_summary`, `hidden_lore`, `ruling_faction_id`, `discovery_status`, `first_discovered_by_life_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'ash_tunnels', 'zone_seed', 'A suffocating network of tunnels filled with ash and smoke. Visibility is nearly zero, and breathing becomes a challenge. This is near-death territory.', 'A suffocating network of tunnels filled with ash and smoke. Visibility is nearly zero, and breathing becomes a challenge. This is near-death territory.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(2, 1, 'corpse_pit', 'zone_seed', 'A feeding ground filled with rotting carcasses. Scavengers and predators gather here, creating constant conflict. The smell alone is overwhelming.', 'A feeding ground filled with rotting carcasses. Scavengers and predators gather here, creating constant conflict. The smell alone is overwhelming.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(3, 1, 'crystal_vein', 'zone_seed', 'A sharp, glowing cavern filled with crystal formations that hum with energy. Sound bends strangely here, and some creatures are drawn to its resonance.', 'A sharp, glowing cavern filled with crystal formations that hum with energy. Sound bends strangely here, and some creatures are drawn to its resonance.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(4, 1, 'dragon_breach', 'zone_seed', 'A broken cavern shaped by the movement of ancient dragons. Heat, pressure, and danger fill the air. This is not a place for the weak.', 'A broken cavern shaped by the movement of ancient dragons. Heat, pressure, and danger fill the air. This is not a place for the weak.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(5, 1, 'nadir_lower', 'zone_seed', 'Nadir Lower Labyrinth: A hellish, cavernous landscape teeming with vault dragons and venomous beasts.', 'Nadir Lower Labyrinth: A hellish, cavernous landscape teeming with vault dragons and venomous beasts.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(6, 1, 'nadir_middle', 'zone_seed', 'A transitional layer where tunnels widen and dangers increase. Echoes travel far, and predators roam between upper and lower layers. This is where survival becomes strategy.', 'A transitional layer where tunnels widen and dangers increase. Echoes travel far, and predators roam between upper and lower layers. This is where survival becomes strategy.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(7, 1, 'nadir_upper', 'zone_seed', 'A sprawling network of dark, damp limestone caves. Weak monsters roam here, but survival is not guaranteed. Sticky webs line the ceilings, and the sound of distant movement never stops.', 'A sprawling network of dark, damp limestone caves. Weak monsters roam here, but survival is not guaranteed. Sticky webs line the ceilings, and the sound of distant movement never stops.', 'Carved into the damp stone: a faint mark that resembles a reincarnator\'s skill menu glyph.', NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(8, 1, 'fungus_grotto', 'zone_seed', 'A humid cavern glowing with bioluminescent fungi. Spores drift through the air, feeding scavengers and poison-based creatures. Some fungi heal others kill.', 'A humid cavern glowing with bioluminescent fungi. Spores drift through the air, feeding scavengers and poison-based creatures. Some fungi heal others kill.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(9, 1, 'magma_layer', 'zone_seed', 'Rivers of flowing lava cut through this region. The heat is unbearable, and only creatures adapted to extreme environments survive.', 'Rivers of flowing lava cut through this region. The heat is unbearable, and only creatures adapted to extreme environments survive.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(10, 1, 'drowned_veins', 'zone_seed', 'A flooded section of the labyrinth filled with underground streams and submerged tunnels. Visibility is low, and movement is slowed. Creatures here rely on vibration and sound.', 'A flooded section of the labyrinth filled with underground streams and submerged tunnels. Visibility is low, and movement is slowed. Creatures here rely on vibration and sound.', NULL, NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07'),
(11, 1, 'webbed_hollows', 'zone_seed', 'A dense cluster of tunnels overtaken by spider colonies. Thick silk webs stretch across entire chambers, and egg sacs hang silently above. Movement is dangerous — and often noticed.', 'A dense cluster of tunnels overtaken by spider colonies. Thick silk webs stretch across entire chambers, and egg sacs hang silently above. Movement is dangerous — and often noticed.', 'A hidden spider-silk nest glimmers between two stalactites — abandoned, but strands still twitch as if something recently passed.', NULL, 'discovered', NULL, '2026-04-19 01:12:07', '2026-04-19 01:12:07');

-- --------------------------------------------------------

--
-- Table structure for table `world_powers`
--

CREATE TABLE `world_powers` (
  `id` int(11) NOT NULL,
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `world_regions`
--

CREATE TABLE `world_regions` (
  `id` int(11) NOT NULL,
  `name` varchar(180) NOT NULL,
  `region_type` varchar(80) NOT NULL,
  `parent_region_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `danger_level` int(11) DEFAULT 1,
  `discovery_status` enum('hidden','rumor','discovered','confirmed') DEFAULT 'rumor',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `world_regions`
--

INSERT INTO `world_regions` (`id`, `name`, `region_type`, `parent_region_id`, `description`, `danger_level`, `discovery_status`, `created_at`, `updated_at`) VALUES
(1, 'nadir_labyrinth', 'labyrinth_region', NULL, 'Structured canon seed migrated from location_seeds for nadir_labyrinth.', 10, 'discovered', '2026-04-19 01:12:07', '2026-04-19 01:12:07');

-- --------------------------------------------------------

--
-- Table structure for table `zone_spawns`
--

CREATE TABLE `zone_spawns` (
  `spawn_id` int(11) NOT NULL,
  `zone_name` varchar(50) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `spawn_chance` int(11) DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zone_spawns`
--

INSERT INTO `zone_spawns` (`spawn_id`, `zone_name`, `npc_id`, `spawn_chance`) VALUES
(1, 'nadir_upper', 1, 90),
(2, 'nadir_upper', 2, 25),
(3, 'nadir_upper', 3, 10),
(4, 'magma_layer', 4, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `life_id` (`life_id`);

--
-- Indexes for table `active_encounters`
--
ALTER TABLE `active_encounters`
  ADD PRIMARY KEY (`encounter_id`),
  ADD KEY `life_id` (`life_id`),
  ADD KEY `npc_id` (`npc_id`);

--
-- Indexes for table `current_life`
--
ALTER TABLE `current_life`
  ADD PRIMARY KEY (`life_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `duel_actions`
--
ALTER TABLE `duel_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `duel_id` (`duel_id`);

--
-- Indexes for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  ADD PRIMARY KEY (`duel_id`),
  ADD KEY `challenger_id` (`challenger_id`),
  ADD KEY `target_id` (`target_id`);

--
-- Indexes for table `evolution_paths`
--
ALTER TABLE `evolution_paths`
  ADD PRIMARY KEY (`evolution_id`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_factions_name` (`name`),
  ADD KEY `idx_factions_status` (`status`);

--
-- Indexes for table `location_connectors`
--
ALTER TABLE `location_connectors`
  ADD PRIMARY KEY (`connector_id`);

--
-- Indexes for table `location_seeds`
--
ALTER TABLE `location_seeds`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `lore_entries`
--
ALTER TABLE `lore_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_lore_entries_title` (`title`),
  ADD KEY `idx_lore_region` (`linked_region_id`),
  ADD KEY `idx_lore_place` (`linked_place_id`),
  ADD KEY `idx_lore_entity` (`linked_entity_id`),
  ADD KEY `idx_lore_status` (`canon_status`);

--
-- Indexes for table `master_items`
--
ALTER TABLE `master_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_npcs`
--
ALTER TABLE `master_npcs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_skills`
--
ALTER TABLE `master_skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `monster_species`
--
ALTER TABLE `monster_species`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_monster_species_name` (`name`),
  ADD KEY `idx_monster_species_region` (`habitat_region_id`),
  ADD KEY `idx_monster_species_status` (`canon_status`);

--
-- Indexes for table `npcs`
--
ALTER TABLE `npcs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_npcs_name` (`name`),
  ADD KEY `idx_npcs_faction` (`faction_id`),
  ADD KEY `idx_npcs_home_region` (`home_region_id`),
  ADD KEY `idx_npcs_home_place` (`home_place_id`),
  ADD KEY `idx_npcs_status` (`status`);

--
-- Indexes for table `npc_memory_tags`
--
ALTER TABLE `npc_memory_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_npc_memory_lookup` (`npc_id`,`user_id`),
  ADD KEY `idx_npc_memory_life` (`current_life_id`);

--
-- Indexes for table `npc_relationships`
--
ALTER TABLE `npc_relationships`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_npc_relationship_user` (`npc_id`,`user_id`),
  ADD KEY `idx_npc_relationship_user` (`user_id`);

--
-- Indexes for table `npc_scene_history`
--
ALTER TABLE `npc_scene_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_npc_scene_lookup` (`npc_id`,`user_id`),
  ADD KEY `idx_npc_scene_life` (`current_life_id`);

--
-- Indexes for table `reincarnated_npcs`
--
ALTER TABLE `reincarnated_npcs`
  ADD PRIMARY KEY (`npc_id`);

--
-- Indexes for table `relationships`
--
ALTER TABLE `relationships`
  ADD PRIMARY KEY (`rel_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`target_id`),
  ADD KEY `target_id` (`target_id`);

--
-- Indexes for table `soul_library`
--
ALTER TABLE `soul_library`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `starting_vessels`
--
ALTER TABLE `starting_vessels`
  ADD PRIMARY KEY (`vessel_id`);

--
-- Indexes for table `story_milestones`
--
ALTER TABLE `story_milestones`
  ADD PRIMARY KEY (`milestone_id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `idx_sort` (`sort_order`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_story_milestones`
--
ALTER TABLE `user_story_milestones`
  ADD PRIMARY KEY (`user_id`,`milestone_id`),
  ADD KEY `milestone_id` (`milestone_id`);

--
-- Indexes for table `world_entities`
--
ALTER TABLE `world_entities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_world_entities_name` (`name`),
  ADD KEY `idx_world_entities_region` (`origin_region_id`),
  ADD KEY `idx_world_entities_faction` (`faction_id`),
  ADD KEY `idx_world_entities_status` (`canon_status`);

--
-- Indexes for table `world_events`
--
ALTER TABLE `world_events`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_world_events_name` (`event_name`),
  ADD KEY `idx_world_events_region` (`region_id`),
  ADD KEY `idx_world_events_place` (`place_id`),
  ADD KEY `idx_world_events_status` (`status`);

--
-- Indexes for table `world_generation_queue`
--
ALTER TABLE `world_generation_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_world_generation_life` (`life_id`),
  ADD KEY `idx_world_generation_status` (`status`);

--
-- Indexes for table `world_places`
--
ALTER TABLE `world_places`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_world_places_name` (`name`),
  ADD KEY `idx_world_places_region` (`region_id`),
  ADD KEY `idx_world_places_discovery` (`discovery_status`);

--
-- Indexes for table `world_powers`
--
ALTER TABLE `world_powers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_world_powers_name` (`name`),
  ADD KEY `idx_world_powers_source` (`source_entity_id`),
  ADD KEY `idx_world_powers_status` (`canon_status`);

--
-- Indexes for table `world_regions`
--
ALTER TABLE `world_regions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_world_regions_name` (`name`),
  ADD KEY `idx_world_regions_parent` (`parent_region_id`),
  ADD KEY `idx_world_regions_discovery` (`discovery_status`);

--
-- Indexes for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  ADD PRIMARY KEY (`spawn_id`),
  ADD KEY `npc_id` (`npc_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `active_encounters`
--
ALTER TABLE `active_encounters`
  MODIFY `encounter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `current_life`
--
ALTER TABLE `current_life`
  MODIFY `life_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `duel_actions`
--
ALTER TABLE `duel_actions`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  MODIFY `duel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `evolution_paths`
--
ALTER TABLE `evolution_paths`
  MODIFY `evolution_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `location_connectors`
--
ALTER TABLE `location_connectors`
  MODIFY `connector_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `lore_entries`
--
ALTER TABLE `lore_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_items`
--
ALTER TABLE `master_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_npcs`
--
ALTER TABLE `master_npcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_skills`
--
ALTER TABLE `master_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `monster_species`
--
ALTER TABLE `monster_species`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `npcs`
--
ALTER TABLE `npcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `npc_memory_tags`
--
ALTER TABLE `npc_memory_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `npc_relationships`
--
ALTER TABLE `npc_relationships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `npc_scene_history`
--
ALTER TABLE `npc_scene_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reincarnated_npcs`
--
ALTER TABLE `reincarnated_npcs`
  MODIFY `npc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `relationships`
--
ALTER TABLE `relationships`
  MODIFY `rel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `starting_vessels`
--
ALTER TABLE `starting_vessels`
  MODIFY `vessel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `story_milestones`
--
ALTER TABLE `story_milestones`
  MODIFY `milestone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `world_entities`
--
ALTER TABLE `world_entities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `world_events`
--
ALTER TABLE `world_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `world_generation_queue`
--
ALTER TABLE `world_generation_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `world_places`
--
ALTER TABLE `world_places`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `world_powers`
--
ALTER TABLE `world_powers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `world_regions`
--
ALTER TABLE `world_regions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  MODIFY `spawn_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD CONSTRAINT `action_logs_ibfk_1` FOREIGN KEY (`life_id`) REFERENCES `current_life` (`life_id`) ON DELETE CASCADE;

--
-- Constraints for table `active_encounters`
--
ALTER TABLE `active_encounters`
  ADD CONSTRAINT `active_encounters_ibfk_1` FOREIGN KEY (`life_id`) REFERENCES `current_life` (`life_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `active_encounters_ibfk_2` FOREIGN KEY (`npc_id`) REFERENCES `master_npcs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `current_life`
--
ALTER TABLE `current_life`
  ADD CONSTRAINT `current_life_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `soul_library` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `duel_actions`
--
ALTER TABLE `duel_actions`
  ADD CONSTRAINT `duel_actions_ibfk_1` FOREIGN KEY (`duel_id`) REFERENCES `duel_challenges` (`duel_id`) ON DELETE CASCADE;

--
-- Constraints for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  ADD CONSTRAINT `duel_challenges_ibfk_1` FOREIGN KEY (`challenger_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `duel_challenges_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `relationships`
--
ALTER TABLE `relationships`
  ADD CONSTRAINT `relationships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `relationships_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `soul_library`
--
ALTER TABLE `soul_library`
  ADD CONSTRAINT `soul_library_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  ADD CONSTRAINT `zone_spawns_ibfk_1` FOREIGN KEY (`npc_id`) REFERENCES `master_npcs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
