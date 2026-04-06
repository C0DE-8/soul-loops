-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 06, 2026 at 11:19 PM
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
(2, 9, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[SCANNED ENVIRONMENT: ELROE_UPPER_STRATUM]\n[BIOLOGICAL ANCHOR DETECTED: CAVE CENTIPEDE (JUVENILE)]\n[SOUL RESONANCE: SCAVENGER]\n\n...\n...\n\n**[ERROR: SENSORY INPUT OVERLOAD]**\n\nA jagged, segmented existence replaces the abstraction of thought. You do not wake up; you *click* into being. The world is a cacophony of vibrations scraping against your chitinous plating. You are not breathing—you are respiring through spiracles that taste the metallic, damp air of the labyrinth. \n\nYour vision is a mosaic of flickering, low-resolution heat signatures. You possess forty legs, and for a terrifying moment, your consciousness fails to coordinate them, resulting in a frantic, uncoordinated thrashing against the cold, damp stone. You are hungry—a hollow, corrosive ache that pulses in rhythm with your frantic, multiple hearts. You are a predator that feeds on carrion, a scavenger of the deep, and your instincts are screaming for sustenance.\n\nYou are small. You are vulnerable. The ceiling above you drips with bioluminescent moss, casting long, sickening shadows that pulse like a warning.\n\n***\n\n[SYSTEM QUERY: MANDATORY DIRECTIVE]\n[PATH: SCAVENGER]\n[ACTION REQUIRED]\n\n**CHOICE 1: [THE HUNGRY VIGIL]**\nRemain perfectly still, pressing your segmented body into a crevice in the stone. Use your vibration-sensing antennae to map the surroundings. Wait for the tell-tale scent of decay from a larger creature’s kill, rather than risking a confrontation in your current, uncoordinated state.\n\n**CHOICE 2: [THE CHAOTIC SCURRY]**\nPanic-reflex triggers. Force your legs into motion, bolting blindly into the dark labyrinth. Trust in your natural speed to outrun whatever nightmare inhabits this chamber, hoping to stumble upon a discarded carcass or a softer, less-guarded creature to consume.\n\n**CHOICE 3: [THE PREDATORY AMBUSH]**\nAnalyze the immediate vicinity for movement. Locate a tunnel junction and wedge yourself into the shadows above the path. Prepare to drop upon the first small insect or subterranean crawler that passes beneath you, attempting to establish dominance and satisfy the gnawing void in your core immediately.', NULL, '2026-04-03 18:39:12', NULL, NULL),
(3, 10, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE.]\n[SOUL INTEGRATION: SUCCESSFUL.]\n[PATH DETERMINED: SCAVENGER.]\n\n[ALERT: SENSORY INPUT OVERLOAD DETECTED.]\n[VISION: MULTI-FACETED ARRAY DETECTED. MAPPING SPATIAL COORDINATES...]\n[ENVIRONMENT: ELROE_UPPER_STRATA. AMBIENT TEMPERATURE: 12°C. HUMIDITY: 45%.]\n[PHYSICAL STATUS: 8 LEGS DETECTED. CHITINOUS EXOSKELETON: FRAGILE. MANA RESERVES: NEGLIGIBLE.]\n\n[ERROR: BIOLOGICAL UNIT UNSTABLE. HUNGER DETECTED: 88%.]\n[PROMPTING FOR IMMEDIATE DIRECTIVE.]\n\n***\n\n**[CHOOSE YOUR PRIMARY INSTINCT]**\n\n**1. [AGGRESSIVE SCAVENGING]**\n*   Prioritize mobility and combat readiness. Use the environment to stalk small prey, regardless of the caloric risk. Focus on physical growth and predatory efficiency.\n\n**2. [CAUTIOUS CONSUMPTION]**\n*   Prioritize survival and stealth. Retreat into the labyrinthine shadows of the Elroe upper levels. Seek out carrion or weakened organisms to minimize energy expenditure while mapping the local ecosystem.\n\n**3. [ENVIRONMENTAL ADAPTATION]**\n*   Prioritize structural integrity. Begin spinning silk immediately to create a defensive web-nest. Focus on defensive utility and securing a stationary perimeter to observe the dangers of the upper strata before moving.', NULL, '2026-04-03 18:40:16', NULL, NULL),
(4, 10, 'I cautiously explore the dark cave, not knowing what do because i dont even knw what i am ', 'The darkness is absolute. Your multifaceted eyes struggle to adjust to the oppressive gloom of the limestone cavern. You move on eight chitinous limbs, the clicking of your joints echoing sharply against the damp walls. Your instincts are nascent, a flicker of hungry confusion in a fragile body. \n\nAs you navigate a narrow crevice, a sticky, silken strand brushes against your thorax. The texture is familiar—it is your own thread. You are a Small Lesser Taratect, a creature woven from malice and silk.\n\nHigh above the labyrinth, a detached consciousness observes your clumsy gait. A digital ripple echoes through your mind, a faint, mocking transmission from the System: *[SYSTEM INTERCEPT]: Subject \'D\' has adjusted the gaze. A new variable has been introduced to the floor. The game continues.*\n\nYou feel a sudden spike of adrenaline as you realize the shadows ahead hold the faint, rhythmic breathing of something larger.\n\n\n\n\n**Choices:**\n1. Advance toward the source of the breathing to investigate.\n2. Retreat and find a high crevice to weave a protective web-nest.\n3. Remain perfectly still and attempt to sense the movements in the dark.', NULL, '2026-04-03 18:45:25', NULL, NULL),
(5, 10, 'how about i saw a dark like oil and use my web and use it to mask my self', 'The damp limestone walls of the Upper Elroe Labyrinth weep a viscous, pitch-black secretion. You approach a pool of this dark, oil-like substance, dipping your silk strands into the sludge. As you coat your body in the mire, the sticky threads bind the dark liquid to your exoskeleton, effectively camouflaging your presence against the cavern shadows.\n\n\n\n\n\n[SYSTEM INTERCEPT]: A low-frequency vibration tremors through the stone floor nearby. Intelligence reports suggest an Earth Dragon, Feirune, is roaming a neighboring tunnel, hungry and oblivious to your presence. The air grows heavy with the scent of predatory intent.', NULL, '2026-04-03 19:15:54', NULL, NULL),
(6, 10, 'Anchor silk above and slowly ascend into the upper crevice, moving against gravity to avoid ground vibrations.', 'The silk strands adhere to the jagged limestone ceiling with a faint, sticky snap. Utilizing Thread Manipulation, you pull your small, arachnid frame upward, defying gravity as you ascend into the dark, moisture-slicked crevice. The ground below—a hotbed of territorial predators and shifting debris—recedes into the gloom. You remain suspended, motionless, an observer in the labyrinthine shadows.\n\n[SYSTEM INTERCEPT]: A flicker of data pulses through the void. Subject \'D\' adjusts the viewport. The Labyrinth remains a game board, and the pieces are moving.\n\nYour movements are precise, though the physical exertion takes a toll on your limited stamina. You are learning the architecture of the dungeon; the way the silk catches the ambient humidity provides a sense of security against the prowling threats of the lower strata.', '[\"Scout the ceiling passage for a hidden nest or potential prey.\",\"Remain suspended in the crevice and wait for a passing monster to ambush from above.\",\"Carefully traverse the ceiling toward the sound of trickling water in the distance.\"]', '2026-04-03 19:25:55', NULL, NULL),
(7, 11, 'System Awakening', '**SYSTEM INITIALIZATION: COMPLETE.**\n**UNIT DESIGNATION:** SCRAP SLIME.\n**LOCATION:** ELROE_UPPER, SUB-LEVEL 7.\n**PATH ALIGNMENT:** SCAVENGER.\n\n**[CORE LOG]:** Awakening detected. Sensory input: fragmented. Neural pathways: re-routing.\n**[WARNING]:** Biological structural integrity is… amorphous. The concept of ‘limbs’ is missing. You are a cohesive mass of semi-viscous, metallic-infused protoplasm. You exist in the shadows of the Elroe Great Labyrinth. Around you, the refuse of forgotten adventurers—rusted iron, shattered glass, and calcified bone—pulsates with the faint, residual mana of the Upper Strata. \n\nYou do not have lungs, yet you \'breathe\' the stagnant, mineral-heavy air. You do not have eyes, yet you \'perceive\' the molecular weight of the debris surrounding your gelatinous form. \n\n**[SYSTEM QUERY]:** How shall the Scavenger manifest?\n\n**CHOICE 1: Assimilate the Immediate.** \nAbsorb the rusted iron shards littering your spawn point. Integrate the metal into your slime-structure to increase density and defense, sacrificing mobility for durability.\n\n**CHOICE 2: Hunt the Residue.** \nExtend sensory pseudopods into the cracks of the stone floor to detect lingering mana signatures. Search for a discarded adventurer’s pouch or an abandoned potion flask. Prioritize rapid growth through consumption of magical waste.\n\n**CHOICE 3: Instinctual Evasion.** \nSense the vibrations of the environment. Something large is moving through the tunnels nearby. Mimic the texture and color of the surrounding stone to avoid early-stage predation. Prioritize survival over immediate expansion.\n\n**[AWAITING INPUT...]**', NULL, '2026-04-03 20:40:13', NULL, NULL),
(8, 12, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE]\n[SUBJECT STATUS: AWAKENED]\n[BIOLOGICAL CLASSIFICATION: LESSER FIRE WYRM (JUVENILE)]\n[LOCATION: MAGMA_LAYER_SECTOR_04]\n[ENVIRONMENTAL HAZARD: EXTREME THERMAL DENSITY DETECTED]\n\n[ERROR: NEURAL MAPPING INCOMPLETE]\n[WARNING: INSTINCTUAL OVERRIDE DETECTED]\n[LOG: CONSCIOUSNESS DETECTED WITHIN ORGANIC VESSEL. MOTOR FUNCTIONS RESPONDING TO PREDATORY PRIMAL DRIVES. ANALYTICAL PROCESSING IS CURRENTLY INTERFERING WITH BIOLOGICAL IMPULSES.]\n\nYou are curled within a cradle of cooling basalt and liquid rock. Your scales—obsidian-black and searing to the touch—clatter against the stone as you shift. The air tastes of sulfur and raw kinetic energy. Your vision is split: one input registers the physical world through heat-vision, flickering in shades of blinding white and deep violet; the other input is a scrolling, sterile stream of data reporting your own hunger, your internal temperature, and the proximity of potential biomass. \n\nA primal roar bubbles in your throat, but it is accompanied by a text-prompt in your mind. The system demands an immediate calibration of your predatory instincts.\n\n**CHOOSE YOUR PRIMARY EVOLUTIONARY FOCUS:**\n\n**[A] CONSUME THE CRUST:** Direct all sensory input toward the magma flow. Digest the surrounding rock and thermal energy to rapidly expand your physical frame. *Trade-off: High growth potential, low immediate mobility.*\n\n**[B] SEEK THE VIBRATION:** Ignore the hunger and focus on the tremors in the distance. Hunt for the entity producing rhythmic vibrations in the rock. *Trade-off: High lethality/tactical experience, risk of environmental exposure.*\n\n**[C] RECALIBRATE INSTINCTS:** Attempt to bypass the mechanical interface and synchronize your soul with the Wyrm’s biological mind. *Trade-off: Slow initialization, potential to stabilize the mental dissonance and unlock hidden draconic capabilities.*', NULL, '2026-04-03 20:40:30', NULL, NULL),
(9, 13, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[PATH IDENTIFIED: PREY]\n[ENTITY DESIGNATION: BLIND CAVE SALAMANDER]\n[BIOME: WATER_STRATUM]\n\nAwakening sequence initiated. Sensory input: Null (Ocular atrophy detected). Tactile input: High-velocity mineral-rich current. Chemical input: Nutrient-dense biofilm, predatory pheromones detected in proximity. The vessel is frail, translucent, and prone to rapid dehydration. Integration of biological instincts: Active. Survival probability: Negligible.', '[\"Anchor to the submerged limestone crevice to minimize metabolic expenditure.\",\"Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.\",\"Initiate passive filter-feeding along the cave floor to restore internal energy reserves.\"]', '2026-04-04 15:27:32', NULL, NULL),
(10, 13, 'Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.', 'The sensory organs ripple, pushing through the stagnant, mineral-rich water of the stratum. Silence reigns, save for the rhythmic dripping of stalactites. \n\nThe vibrations return. A low-frequency pulsing emanates from the northern corridor—a rhythmic, dragging motion indicating a Cave Creeper, blind and starving. Your whiskers register the ripple of its displacement in the water. Far above the stone ceiling, a faint, phantom resonance of a  broadcast hums through the rock—a report of a soul at the Royal Academy unlocking . The disparity is vast. You are mud and instinct; they are light and ambition. The Creeper shifts closer, hungry.', '[\"Challenge light to a Duel\",\"Remain motionless to avoid detection and let the creature pass.\",\"Use the newly acquired skill to track the creature\'s path and ambush it.\",\"Flee into the deeper, uncharted fissures of the water_stratum.\"]', '2026-04-04 15:41:14', NULL, NULL),
(11, 13, 'Remain motionless to avoid detection and let the creature pass.', 'The water in the stratum ripples with a heavy, rhythmic turbulence. A massive, bioluminescent predator glides inches above your submerged form, its jagged scales scraping against the cavern floor. You hold your breath, your damp skin blending into the mineral-rich sediment. The scent of ozone and ancient magic lingers in the water—a faint, lingering byproduct of a soul elsewhere in the world tapping into the  recently reported in the Royal Academy broadcasts. The predator senses nothing but cold stone. It drifts onward, disappearing into the dark throat of the abyss.\n\nSafety is achieved, but the stillness drains your vitality. You are small, fragile, and utterly alone in the deep.', '[\"Challenge light to a Duel\",\"Search the immediate sediment for bioluminescent fungi to consume.\",\"Swim toward the faint light emanating from a distant, upward-sloping tunnel.\",\"Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.\"]', '2026-04-04 15:46:02', NULL, NULL),
(12, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The water in the stratum remains stagnant, clinging to your translucent, sightless skin like a shroud. You channel your internal essence toward your lateral line and nasal receptors, pushing past the threshold of mere instinct. The world does not brighten, but it clarifies; the oppressive silence fractures into a complex map of tectonic tremors and the rhythmic drip of calcified stalactites.\n\nAs your senses bloom, a jagged psychic resonance ripples through the cavern—a stray signal from the Surface. *.]* The triviality of their achievements feels distant, a flare of warmth in a world of absolute zero. The strain of sensory expansion causes your fragile tissues to throb, leaving you slightly drained.', '[\"Challenge light to a Duel\",\"Follow a faint, rhythmic vibration echoing from the deeper, darker reaches of the tunnel.\",\"Remain stationary and attempt to conserve energy, waiting for potential prey to drift into range.\",\"Navigate toward the surface of the pool, seeking to investigate the air-breathing alcoves above.\"]', '2026-04-04 15:47:19', NULL, NULL),
(13, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The lightless expanse of the water stratum shudders. You push your internal essence outward, straining your damp, pale nerves against the stagnant stillness of the cavern. The water ripples, carrying the whispers of the earth. You feel the heavy, rhythmic thrum of distant crushing stone and the erratic, high-frequency agitation of something skittering along the cavern roof.\n\nA broadcast flickers across your consciousness, cold and detached: ** \n\nAs your senses bloom, the vibrations coalesce into a mental map of the nearby currents. You have evolved beyond mere instinct.', '[\"Challenge light to a Duel\",\"Follow the skittering vibrations toward the cavern ceiling to hunt.\",\"Remain still in the water, conserving energy while monitoring the nearby tunnel junction.\",\"Dive deeper into the submerged crevice to avoid whatever entity just broadcasted its presence.\"]', '2026-04-04 15:48:11', NULL, NULL),
(14, 13, 'Remain still in the water, conserving energy while monitoring the nearby tunnel junction.', 'The water of the subterranean pool is still, mirroring the oppressive darkness of the cavern. You anchor yourself against a jagged limestone formation, your translucent skin cooling as you wait. Above the water\'s surface, the air grows thin and humid. \n\nFaint vibrations ripple through the cavern floor—the rhythmic, tectonic shifting of a creature far more massive than yourself. From the nearby tunnel junction, a flick of heat emanates, signaling the proximity of the Lesser Fire Wyrm known as \'joker.\' The System broadcasts a silent, mocking vibration into your primitive sensory organs: *“Two sparks in the dark, yet only one shall illuminate the path to evolution.”* You remain undetected, your stillness granting you a reprieve from the predator\'s gaze.', '[\"Threaten joker\",\"Slowly creep toward the tunnel junction to ambush the Fire Wyrm while it is distracted.\",\"Ignore joker for now\",\"Swim deeper into the subterranean lake to avoid the proximity of the Fire Wyrm.\"]', '2026-04-04 15:55:06', NULL, NULL),
(15, 13, 'Ignore joker for now', 'The icy currents of the water_stratum offer a sanctuary of silence. You glide through the mineral-rich darkness, distancing yourself from the heat signature radiating from the cavern above. The Lesser Fire Wyrm, Joker, remains oblivious to your path, his hunger currently focused on the cavern floor miles away. A telepathic tremor vibrates through the stone; the System broadcasts a whisper of his violent descent into the upper labyrinth, but you press deeper into the subterranean pools, preserving your vitality.', '[\"Search the submerged floor for nutrient-dense moss to recover HP.\",\"Ignore joker for now\",\"Navigate deeper into the uncharted tunnels of the water_stratum.\",\"Surface slightly to listen for the movements of other souls.\"]', '2026-04-04 15:55:31', NULL, NULL),
(16, 14, 'System Judgment Awakening', 'Identity synchronization verified. The ambient mana of the royal capital brushes against your physical vessel, cold and indifferent. You stand amidst the sprawling white stone architecture of the central plaza, a drop of water in an ocean of unfamiliar souls.\n\nA discordant pulse ripples through the air—a system-wide broadcast vibrates in your mind: *“Data anomaly detected in sector 4. Another soul from the void has manifested.”* The local populace continues their transit, entirely oblivious to the predatory resonance emanating from your core. You are a ghost inhabiting a mannequin, and the world is beginning to notice the displacement.', '[\"Attempt to blend into the passing crowd to observe the capital\'s social structure.\",\"Seek a secluded alleyway to test the limits of your new physical form.\",\"Approach a nearby merchant to gather information regarding your current location and status.\"]', '2026-04-05 15:38:31', NULL, NULL),
(17, 15, 'System Judgment Awakening', 'The jagged, light-starved labyrinth of the Elroe Upper Stratum stretches infinitely in all directions. Your consciousness flickers into existence, anchored to the fragile, leathery frame of a Shadow Bat. The air here is stagnant, thick with the scent of subterranean decay and the distant skittering of predatory chitin on stone. \n\nSystem broadcast intercepted: *Anomalous soul-signature detected in the lower sector. Correlation with \'Reincarnator\' status confirmed. The weave of causality tightens.*\n\nYou hang inverted from a stalactite, your sensitive ears twitching at the sound of fluid dripping into a dark pool far below. Hunger gnaws at your core; your existence is a momentary spark in the crushing dark.', '[\"Drop from the ceiling and scout the immediate vicinity for sustenance.\",\"Remain suspended in silence to observe the movement patterns of nearby entities.\",\"Take flight into the deeper tunnels to map the local geography.\"]', '2026-04-05 15:39:41', NULL, NULL),
(18, 15, 'Take flight into the deeper tunnels to map the local geography..', 'The Shadow Bat unfurls its translucent, ink-stained wings, catching a draft of stale, dungeon air. As you bank away from the Small Lesser Taratect—which snaps its mandibles at empty air where you once hung—you ascend into the jagged, upper reaches of the Elroe Labyrinth. \n\nThe darkness here is thick, a velvet shroud that your kin find comforting. Below, the distant skittering of arachnid legs echoes against the stone. A flicker of data pulses in your mind: ** You navigate a series of narrow crevices, your sonar pinging off walls of raw ore and ancient sediment. The effort of sustained flight consumes your reserves.\n\n\n\n\n---', '[\"Challenge light to a Duel\",\"Attack the Small Lesser Taratect\",\"Continue mapping the tunnels, searching for a water source.\",\"Observe light carefully\"]', '2026-04-05 15:49:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(19, 15, 'Attack the Small Lesser Taratect.', 'The shadow cast by your wings flickers against the cavern walls of Elroe Upper. You dive, talons extended, latching onto the carapace of the Small Lesser Taratect. It hisses, a chittering sound that vibrates through your hollow bones. A brief struggle ensues; you tear into its chitinous hide, and the creature goes limp.\n\n: A distant, distorted broadcast echoes in the frequency of the labyrinth: *“The favored of the gods hone their craft in white marble halls, wielding holy light. You remain in the dark.”* \n\nThe effort leaves you winded, your own life-force thinned by the skirmish.', '[\"Threaten light\",\"Scan the surroundings\",\"Consume the carcass to restore vitality.\",\"Scout the immediate area for the source of the PVP detection.\"]', '2026-04-05 15:50:43', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(20, 15, 'Consume the carcass to restore vitality.', 'The jagged, obsidian landscape of the Elroe Labyrinth reflects a cold, uncaring light. You descend upon the remains of the frog, your claws tearing into the acidic, rubbery flesh. The consumption is swift, a desperate act of survival that numbs your senses as the creature\'s essence permeates your own.\n\nAs you feed, the system hums—a distant, distorted broadcast echoing through the cavern walls: *“Observation of the subterranean struggle continues. An anomaly—a soul from another world—lingers in the light nearby, oblivious to the predator currently feasting in the shadows.”*\n\nYour vitality stabilizes, though the chemical burn of the prey leaves a foul taste.', '[\"Threaten light\",\"Stay alert and do nothing\",\"Investigate the nearby light source to confront the other soul.\",\"Deepen your concealment within the shadows to avoid detection.\"]', '2026-04-05 15:51:34', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(21, 15, 'Stay alert and do nothing', 'Attention: A biological anomaly of note has been registered. Within the Royal Academy, a subject has successfully integrated . The System classifies this development as high-priority; monitor evolution paths accordingly.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nStatus: Stationary/Alert.\n\nSubject has opted for a period of quiescence. Efficiency of energy expenditure is high; however, metabolic processes continue to deplete resources. With SPD at 18, the subject remains primed for rapid kinetic response, though minimal movement prevents the replenishment of SP. Current Hunger levels are within optimal parameters for continued predation; however, prolonged stasis will induce a net negative in caloric storage. Environment remains hostile; vigilance is maintained, but no developmental progress is observed.\n\n\n\n---', '[\"Attempt to manipulate ambient mana to stimulate MAG development.\",\"Relocate to a higher-elevation cavern wall to conserve SP.\",\"(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.\"]', '2026-04-06 03:04:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(22, 15, '(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.', '- Labyrinth Observation Status: ACTIVE. The System notes an increase in biological volatility within Elroe Upper. Entities are currently being monitored for entertainment value. Efficiency remains the primary metric for continued survival.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nAction: Perimeter Sweep initiated.\n\nAnalysis: Subject utilized base SPD attribute of 18 to navigate the immediate environment with high-frequency velocity. This mobility resulted in an effective scanning radius of 15 meters. While SPD metrics allow for rapid displacement, the current SP level (10/20) indicates moderate fatigue, limiting the duration of this high-speed output.\n\nBiological Anomaly Detected: Subject’s Hunger level (78/100) is currently optimal for metabolic maintenance. No debuffs detected. Subject successfully tracked a small cavern rodent behind a quartz formation. Success probability of intercept: 84%.\n\n\n\n\n---', '[\"(SCOUT) Conserve remaining SP by maintaining a stealth-based observation of the surrounding tunnels.\",\"(ADAPT) Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.\",\"(PREDATOR) Execute a high-speed ambush on the detected rodent to secure caloric intake.\"]', '2026-04-06 03:15:01', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(23, 15, 'Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.', 'The upper strata of Elroe are characterized by cold, damp mineral walls and the faint, rhythmic dripping of condensation. The air smells of stagnant ozone and pulverized limestone. You descend from your perch, your claws clicking against the jagged cavern ceiling before you land silently amidst the blue-tinged, bio-luminescent moss. The temperature here is a biting 8°C.\n\nYou ingest a portion of the flora. Its texture is fibrous and rubbery, emitting a bitter, metallic taste that coats your tongue. Your MAG stat of 5 fails to register any magical properties, and your resistance proves sufficient to neutralize the mild toxins within the plant. Nutritional yield is minimal.\n\n\n\nThe silence of the upper labyrinth is deceptive; deep within the stone, the chittering of larger, chitinous predators vibrates through the floor. Your Stamina is critically depleted, and the cold is accelerating your caloric burn.', '[\"(PREDATOR) Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal. (Cost: High SP, Med Hunger)\",\"(Explore) Scout deeper into the tunnel to locate a more substantial water source. (Cost: Low SP)\",\"(Risky Action) Scale the unstable, wet wall to reach a higher, warmer thermal vent. (Cost: High HP Risk)\"]', '2026-04-06 03:38:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(24, 15, 'Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal.', 'The air in the Elroe Upper is thick with the scent of damp fungi and decaying organic matter. You launch yourself from the shadow of a stalagmite, utilizing your high SPD stat to close the distance before the insectoid’s primitive compound eyes can process the threat. Your talons pin the glowing organism against the bioluminescent moss. The crunch of the carapace is audible, followed by the fluid intake of essential nutrients. The prey is consumed in seconds, providing a momentary abatement of your metabolic deficit.\n\nHowever, the rapid movement in your current state of exhaustion has triggered a system warning. Your lack of stamina is hindering further potential. Nearby, the rhythmic clicking of a Small Lesser Taratect echoes against the stone walls—the predator is hunting, and it is closer than calculated.\n\n\n\n\n---', '[\"(Risky Action) Dash across the open cavern floor to reach a higher, safer altitude. (Cost: High SP, Risk of Detection)\",\"(Rest) Conserve energy by hunkering down in the shadows of the mossy crevice. (Cost: Low SP recovery)\",\"Attack the Small Lesser Taratect\",\"(PREDATOR) Stalk the source of the nearby clicking to secure a more substantial kill. (Cost: High SP, Low Hunger)\"]', '2026-04-06 03:39:22', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(25, 15, 'Attack the Small Lesser Taratect', 'The damp, frigid air of the Elroe Upper Labyrinth clings to your fur as you lunge. Your SPD attribute of 18 gives you the advantage, allowing you to bypass the Small Lesser Taratect’s clumsy defensive posture. You strike with your ATK, tearing through its chittering mandibles before the creature can solidify its web. The metallic tang of hemolymph fills the narrow, stone-walled corridor. You have secured the kill, but your own reserves are rapidly depleting.\n\n\n\n\n\n\n**Survival Status:** Your metabolic deficit is reaching critical thresholds. The exhaustion penalty to your SPD is hindering your ability to navigate the labyrinth’s vertical terrain.', '[\"(PREDATOR) Hunt for a larger target to satisfy your ravenous hunger. (Cost: High SP, Med Hunger)\",\"(Consume) Eat the defeated Taratect to stabilize your biological state. (Cost: Low Time)\",\"(Forage) Scour the cavern walls for edible moss or insects. (Cost: High HP Risk - Ambush Potential)\"]', '2026-04-06 03:40:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(26, 15, 'Eat the defeated Taratect to stabilize your biological state', '---\n\n**NARRATION**\nThe damp, stagnant air of the Elroe Upper Labyrinth clings to your fur, thick with the scent of chitin and subterranean decay. You descend upon the mangled carapace of the Taratect. Your SPD attribute, hampered by systemic exhaustion, makes the movement sluggish, but your ATK stat is sufficient to tear through the cooling exoskeleton. \n\nAs you consume the biological matter, the caustic, metallic taste of Taratect ichor floods your senses. It is inefficient, difficult to digest, but the raw caloric intake stabilizes your crashing vitals. Your biological anomaly of a body registers the caloric shift. However, the labyrinth is vast, cold, and indifferent; the sound of skittering legs echoing in the distance suggests that a carcass—and the scavenger feeding upon it—does not remain unobserved for long.\n\n\n\n\n\n**CURRENT SURVIVAL STATUS:** The immediate caloric crisis is averted, but the exhaustion remains. Your SPD is compromised, making you a target for larger predators within the Upper Labyrinth.\n\n---', '[\"(PREDATOR) Drag the remaining carcass into the shadows to continue feeding and regain full stamina. (Cost: Med SP, Low Hunger)\",\"(Rest) Find a crevice in the wall and enter a torpor state to recover SP. (Cost: Low Hunger)\",\"(Risky Action) Navigate deeper into the maze while weakened, searching for a water source. (Cost: High HP Risk)\"]', '2026-04-06 03:40:44', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(27, 15, 'Drag the remaining carcass into the shadows to continue feeding and regain full stamina', 'The Elroe Upper Labyrinth is humid, the air heavy with the scent of damp moss and the metallic tang of dried insectoid ichor. The cavern walls, slick with condensation, offer little traction, yet your high SPD (18) allows for fluid, silent movement through the shadows. \n\n\nThe hatchling spider remains oblivious near a fissure in the rock, its mandibles clicking rhythmically. Its presence registers as a biological anomaly to be processed.\n\n---\n\n\nYou clamp your jaws firmly into the sinew of the remaining carcass. The act of dragging it is hindered by your current state of exhaustion; your wings feel like leaden weights, and your muscles spasm as your SP sits at a critical 0. You retreat into the deepest shroud of the labyrinth, where the light of the phosphorescent fungi barely reaches. \n\nTearing into the flesh, the caloric intake is immediate. The biological efficiency of your consumption is high, though your movement is sluggish. Each bite provides a momentary reprieve from the metabolic collapse threatening your system. However, the scent of the blood attracts unwanted attention; the Lesser Taratect nearby pauses, its multi-faceted eyes turning toward your position. The humidity of the cave clings to your fur as you feed, the silence broken only by your ragged breathing and the rhythmic chewing of your prey.\n\n\n\n\n\n---', '[\"(PREDATOR) Launch a surprise aerial ambush on the Lesser Taratect to secure a secondary food source before the exhaustion fully locks your joints. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to intimidate the hatchling with a screech to drive it away before it identifies you as a threat. (Cost: High HP Risk)\",\"(Hide) Cease feeding and press yourself against the rock face to wait for the spider to wander off. (Cost: Low SP)\",\"Attack the Small Lesser Taratect\"]', '2026-04-06 04:03:50', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(28, 15, 'Attack the Small Lesser Taratect', '.]\n\n\nThe humidity of Elroe Upper clings to your wings, a thick, stagnant warmth that smells of damp minerals and decay. Ahead, a Small Lesser Taratect skitters across the uneven cavern floor, its multi-faceted eyes reflecting the faint, bioluminescent moss clinging to the walls. \n\nYou lunged. Relying on your SPD of 18, you banked off the slick stone, your form a blur in the dim light. The Taratect reacted, its legs twitching as it attempted to weave a web, but your agility proved superior. Your fangs, driven by an ATK of 7, bypassed the creature\'s meager DEF of 4. You slammed into its thorax, the sound of chitin cracking resonating through the chamber. Green ichor erupted, spraying the cold floor as the creature collapsed, its defensive maneuvers failing against your predatory precision. The threat is neutralized.\n\n\n\nThe exertion of the strike has left you panting; the air in the upper stratum is thin, and your stomach churns with a hollow ache. Every second spent in this cavern accelerates your biological degradation.\n\n\n\n\n\n---', '[\"(Risky Action) Venture deeper into the nest to find higher-quality sustenance, risking potential detection by an adult variant. (Cost: High HP Risk)\",\"(PREDATOR) Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses. (Cost: High SP, Med Hunger)\",\"(Scavenge) Consume the remains of the Lesser Taratect to replenish essential proteins. (Cost: Low SP)\"]', '2026-04-06 04:04:57', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(29, 15, 'Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses.', '. Metabolic efficiency in the Elroe Labyrinth regions is currently skewed; environment temperature rising. SYSTEM ALERT: EXHAUSTION DETECTED. SPEED DEBUFF ACTIVE.]\n\nThe air in the upper reaches of Elroe is thick with the scent of stagnant humidity and mineral dust. Your leathery wings beat against the stale currents, your SPD attribute compensating for the creeping fatigue of the . \n\nYou initiate the dive. Gravity accelerates your descent, your body a blur of shadow against the jagged, limestone ceiling. The spider cluster below—tiny, skittering chitinous horrors—is unaware of the predatory arc until it is too late. You strike with the full force of your ATK, a concentrated impact against the center of the formation. The sound is a sickening *crack* of chitin failing under pressure. A spray of viscous, iridescent ichor coats your wings, momentarily blinding one of the targets as it spasms in its death throes. Your momentum carries you through the center of the cluster, scattering them like dry leaves, but your frame feels the strain; the impact sends a jolt of recoil through your meager DEF.\n\nYou hover, panting. The exertion of the maneuver, combined with the lingering debuff, burns through your already depleted reserves. You are a predator, but an exhausted one. The remaining spiders are turning, their multiple eyes glinting in the dark, sensing your vulnerability. \n\n\n\n\n\n---', '[\"(PREDATOR) Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism. (Cost: Med SP, Low Hunger)\",\"(Risky Action) Execute a localized aerial screech to disorient the cluster before diving into a head-on collision. (Cost: Low MP, High HP Risk)\",\"(Retreat) Use the remaining verticality of the cavern to climb out of sight and recover energy. (Cost: Low SP)\"]', '2026-04-06 04:21:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(30, 15, 'Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism.', '*   **ENCOUNTER:** WILD Lvl 1 Elroe Frog (E) | HP: 55/55 | STATUS: ACTIVE.\n*   **THREAT LEVEL:** Moderate. Environmental hazard: Acidic secretions detected.\n*   **GLOBAL OBSERVERS:** The ceiling of the Labyrinth hums with unseen attention. Your struggle is being indexed for entertainment.\n*   **SYSTEM WARNING:** SP depletion reached critical threshold. Motor functions compromised. SPEED DEBUFF active.\n\n---\n\n### NARRATION\nThe air in the Elroe Labyrinth is thick with the scent of damp moss and stagnant subterranean water. You lunge, your wings twitching—a clumsy, desperate arc that betrays your lack of stamina. The Elroe Frog, a bloated mass of emerald sludge, tracks your movement with dull, pulsating eyes. \n\nYour SPD (18) is hampered by the 0/20 SP floor, turning your strike into a jagged, sluggish blur. You dive into the cluster, teeth bared, aiming for the soft, pulsating membrane beneath its jaw. The Frog reacts, its throat swelling, and sprays a globule of acidic venom. You jerk your head, the acidic mist searing the air inches from your ear—your RES (5) barely mitigating the localized heat. \n\nYour jaws clamp down, your ATK (7) tearing through the amphibian\'s thick, rubbery hide. It lets out a guttural, wet croak, thrashing against your weight. The metallic tang of ichor fills your mouth, but the kill is not yet confirmed. You are the predator, but the labyrinth is a cage, and you are starving. \n\n---\n\n\n\n\n\n---', '[\"Attack the Elroe Frog\",\"(Withdraw) Retreat to the upper ceiling to regain energy and observe the target\'s patterns. (Cost: Low SP)\",\"(PREDATOR) Maintain a death-grip on the throat and tear, prioritizing high-protein consumption to stabilize metabolism. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit. (Cost: High HP Risk)\"]', '2026-04-06 04:22:31', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(31, 15, 'Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit.', 'The air in the Elroe Labyrinth is heavy with the scent of damp moss and the metallic tang of subterranean rot. Your wings twitch, hampered by the lethargy of a malnourished state. The Elroe Frog sits upon a slick, moss-covered crag, its throat sac pulsating with a rhythmic, wet sound. \n\nYou launch yourself, your SPD 18 allowing for a blur of movement through the cavern’s gloom. As you close the distance, the frog’s neck coils—a warning of impending acidic discharge. You compensate, your path erratic, and strike. Your talons rake across the creature’s moist, protuberant ocular organs. A viscous, caustic fluid sprays—green ichor splattering against the stone floor. The creature lets out a high-pitched, guttural croak of agony, reeling backward and thrashing its tongue in a blind, desperate arc. You have successfully blinded the target, but the strain of the rapid movement sends a jolt of fatigue through your undernourished wings.\n\n\n\nThe cavern wall is slick against your claws. The frog is disoriented, but its next strike will be a blind, wide-range acidic sweep. The metabolic demand is becoming critical; your body is beginning to cannibalize its own resources.\n\n\n\n\n***', '[\"(PREDATOR) Launch a follow-up pounce to secure the kill while the creature’s vision is compromised, aiming for the soft underbelly. (Cost: High SP, Med Hunger)\",\"Attack the Elroe Frog\",\"(Retreat) Use the remaining momentum to cling to the high cave wall and wait for the creature to exhaust itself. (Cost: Low SP)\",\"(Risky Action) Descend directly into the frog’s striking range to deliver a killing blow to the throat, risking exposure to acidic venom. (Cost: High HP Risk)\"]', '2026-04-06 04:23:53', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(32, 15, 'take a hit from the frog', 'The Elroe Labyrinth, Upper Stratum. Atmospheric conditions: Humid, stagnant air, smell of decay and damp limestone. Temperature: 22°C. \n\n\n---\n\nThe Shadow Bat descends into the muck, its wings folding tight. The Elroe Frog, a bloated, warty biological anomaly, senses the intrusion. Its throat sac expands, pulsating with a rhythmic, wet vibration. It doesn\'t wait; the creature snaps its jaw, releasing a globule of caustic venom.\n\nYou forgo evasion. The acid strikes your left wing membrane—a searing, localized thermal spike. Your RES attribute mitigates a portion of the chemical burn, but the acidic property bypasses your physical DEF of 4. The tissue sizzles, emitting a foul odor. Your SPD of 18 is severely compromised by the searing pain, dragging your flight capability into the red. The frog lets out a guttural croak, sensing your vulnerability as you reel from the chemical assault. Your HP is failing; every heartbeat sends a throbbing tremor through your damaged membrane.\n\n\n\n\n---', '[\"(PREDATOR) Launch a desperate aerial dive, ignoring the wing pain to clamp your fangs into the frog’s exposed throat sac. (Cost: High SP, Med Hunger)\",\"(Retreat) Flap your wings aggressively to create a cloud of cave dust and gain distance for a tactical withdrawal. (Cost: Low SP)\",\"(Risky Action) Remain stationary and attempt to use your remaining MAG to shield your body, hoping to bait the frog into a melee range error. (Cost: High HP Risk)\",\"Attack the Elroe Frog\"]', '2026-04-06 04:25:23', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(33, 15, 'Attack the Elroe Frog', '*Attention: Global update. Training cycles at the Royal Academy have resulted in the acquisition of  by external entities. Analysis suggests a shift in the hierarchy of power. Simultaneously, local biological anomaly  is currently engaged in high-risk combat within the Elroe Upper Strata.*\n\n---\n\n****\n\nThe cavern air is thick with the scent of damp moss and the stagnant humidity of the Elroe Upper Strata. Slick, condensation-slicked limestone presses in from all sides. \n\nYour instincts drive you forward, your SPD attribute allowing you to weave through the murky gloom with a flickering, unnatural grace. You lunge at the Elroe Frog, claws extended. Your ATK of 7 connects, tearing through the creature\'s rubbery, cyan-tinted hide. A viscous, neon-green ichor sprays across the cave floor, sizzling slightly where it hits the damp rock. The frog emits a pained, guttural croak that echoes painfully against the cavern walls.\n\nHowever, the exchange is not one-sided. Your SP is depleted—your movements are sluggish, betraying the exhaustion that grips your wings. The frog, despite its wounds, reacts with primitive fury. Its long, sticky tongue lashes out like a whip, catching you mid-maneuver. You are slammed against the jagged wall; the impact registers sharply against your DEF of 4. Your internal vitals pulse with the warning of sustained damage.\n\n**Current Status:**\n*   **HP:** 6/18\n*   **MP:** 15/15\n*   **Hunger:** 45/100\n*   **SP:** 0/20 (FATIGUE: SEVERE)\n\n---', '[\"Attack the Elroe Frog\",\"Attempt to Flee from the Elroe Frog\",\"(PREDATOR) Launch a desperate, all-or-nothing aerial strike at the frog\'s throat, aiming to finish the kill and consume the biomass. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to entangle the frog in a grapple, utilizing your proximity to force a struggle despite your current lack of stamina. (Cost: High HP Risk)\"]', '2026-04-06 04:30:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(34, 15, 'Attack the Elroe Frog', 'at the Academy, a biological anomaly struggles for base survival in the depths of Elroe_Upper.]\n\nThe cavern air is thick with the scent of stagnant moisture and volcanic sulfur. Your wings, translucent and fragile, beat sluggishly against the humid, oppressive atmosphere. You lunged with a burst of desperate speed, your talons carving into the Elroe Frog’s rubbery hide. The strike was clean, yet lacking the force to puncture the creature\'s thick dermis—a mere 4 DMG dealt. Green ichor welled from the shallow laceration, but the beast only shrieked, a wet, guttural sound that echoed off the slick cave walls.\n\nYour SP reserves are depleted. The exhaustion debuff is no longer a warning; it is a weight pulling at your membranes. \n\nAs you recoiled, the frog retaliated with terrifying, low-intelligence precision. A slimy, muscular limb whipped out, impacting your frail frame with blunt force. You were slammed against the jagged, damp rock face—3 HP lost. Your vision flickers. The cold, analytical truth is clear: you are losing the metabolic race.\n\n\n\n\n\n\n***\n\n\n\nThe hunt has concluded. You lacked the stamina to sustain the engagement, and your physical integrity fell below the threshold for continued operation. The Elroe Frog remains standing, its hunger overriding any fear of your species.', '[\"(Reincarnate) Accept the cycle of life and death, attempting a new manifestation in the Labyrinth. (Cost: Loss of current data)\",\"Attack the Elroe Frog\",\"(Escape) Utilize your remaining SPD to flee into the deeper, darker crevices of the cavern, abandoning the fight to survive. (Cost: Low SP)\",\"Attempt to Flee from the Elroe Frog\"]', '2026-04-06 04:39:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(35, 16, 'System Judgment Awakening', 'Processing… \nIdentity confirmed: Dwarf (Scavenger). \nAwakening sequence finalized in sector: iron_forge. \nThe System has cataloged your biological signature. You are now tethered to the local resource cycle. Proceed with caution.\n\n---\n\nThe air in the iron_forge is thick, tasting of oxidized iron and the sulfuric tang of cooling magma deep beneath the floor grates. The heat is a dry, oppressive blanket that clings to your dwarven beard, smelling faintly of coal dust and ancient, dormant industry. You stand in the center of a rusted, circular landing pad, the metal groaning under your boots—a sound that echoes far too loudly in the cavernous, soot-stained hall.\n\n\"Soul Scan Completed. Identity Confirmed.\"\n\nThe hum of the terminal fades into a discordant whine. Your internal diagnostics blink with clinical precision. Your SPD is currently uncalibrated, resulting in a lethargic, heavy-footed gait as you shift your weight. Your DEF is minimal, leaving your physical frame exposed to the abrasive, jagged edges of the surrounding scrap piles. As a scavenger, your sensory perception is currently hyper-focused on the rhythmic clicking of nearby machinery—sounds that dictate the flow of the forge’s ventilation.\n\nThe immediate pressure is mounting. Your biological frame is calibrated for heavy labor, yet your metabolic baseline is dwindling. The faint scent of stale oil and charred bone drifts from the dark corridors ahead. If you do not source sustenance or salvageable material soon, your internal vitals will cascade into a critical failure state.\n\n  \n\n---', '[\"(Investigate) Search the nearby rusted canisters for basic tools or rations. (Cost: Low SP)\",\"(SCAVENGER) Gut the derelict cooling unit for copper wiring and leftover lubricant. (Cost: High SP, Med Hunger)\",\"(Risky Action) Venture into the dark, active ventilation shaft where the heat is intense enough to cause burns. (Cost: High HP Risk)\"]', '2026-04-06 05:06:19', NULL, NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(36, 16, 'Venture into the dark, active ventilation shaft where the heat is intense enough to cause burn', '***\n\nThe heat within the iron_forge ventilation shaft is not merely warmth; it is a physical weight, a convective furnace designed to incinerate impurities. As you crawl into the narrow duct, the air carries the metallic tang of oxidized copper and scorched soot. Your thick, dwarven hide—optimized for subterranean environments—grants you a base resistance, but the extreme temperature pushes your thermal threshold to its limit. \n\nSweat evaporates from your pores before it can even bead, and the lack of moisture in the recycled, superheated air makes every breath feel like inhaling dry sand. You navigate the cramped, labyrinthine pipes with a sluggishness dictated by your low SPD, your movements hindered by the oppressive atmosphere. The intense heat causes your SP to drain rapidly as you fight the fatigue of thermal exhaustion. You are a biological anomaly surviving in an industrial kiln, but your core temperature is climbing toward critical levels.\n\n\n\n\n\nSurvival pressure: Your internal regulation is failing. Continued exposure to this thermal environment will result in heatstroke. You must either exit the ventilation shaft or find an intake coolant flow.', '[\"(SCAVENGER) Utilize your dwarven intuition to identify and pry open a concealed maintenance hatch, hoping to find a hidden cache of scavengeable coolant supplies. (Cost: High SP, Med Hunger)\",\"(Risky Action) Force yourself deeper into the core of the shaft to reach the primary exhaust vent, ignoring the increasing heat for a chance at finding salvage in the high-heat sector. (Cost: High HP Risk)\",\"(Approach) Carefully backtrack out of the shaft to return to the relative coolness of the forge floor. (Cost: Low SP)\"]', '2026-04-06 05:09:32', NULL, NULL),
(37, 16, 'I want to hurt and find food', 'Attention: Current planetary data indicates a mass displacement of biological entities into the Upper Labyrinth. Resource scarcity is calculated at 84% critical. Proceed with optimized efficiency.\n\n---\n\nThe iron_forge is a cavernous throat of soot and dormant basalt. The air is thick with the metallic tang of oxidized ore and the stagnant heat radiating from cooling slag heaps. Your dwarf physiology, stocky and built for subterranean pressure, feels the vibration of the forge’s cooling bellows—a rhythmic, hollow thrumming that masks your approach.\n\nYou spot a *Scrap-Crab*—a fusion of rusted iron plating and calcified chitin—scuttling over a pile of discard. Its sensory stalks swivel toward your heat signature. With a low growl, you close the distance. Your ATK 14 provides sufficient kinetic force to bypass its natural plating; you swing a discarded iron lever, catching the creature squarely against its soft underbelly. \n\nChitin fractures with a sound like snapping dry kindling. Green, acidic ichor sprays across your boots, hissing as it meets the hot slag. The creature convulses once, its defensive posture collapsing as it is pinned to the floor by your sheer DEF 20 bulk. It is neutralized. You tear into the exposed tissue—it is stringy and tastes of ozone, but it is caloric intake.\n\n\n\n\n\nYour stomach churns as the biological fuel hits your system, but the hunger remains a dull ache in your marrow. The forge is silent now, save for the rhythmic dripping of condensation from the ceiling. You are exposed; the scent of the creature’s fluids may attract larger, more efficient predators.\n\n---', '[\"(Scout) Move deeper into the forge to locate additional caches of scrap ore. (Cost: Low SP)\",\"(SCAVENGER) Gut the remaining shell for useful plating to reinforce your current defensive equipment. (Cost: High SP, Med Hunger)\",\"(Risky Action) Hammer on the forge’s anvil to lure any nearby organisms into an ambush. (Cost: High HP Risk)\"]', '2026-04-06 05:33:23', NULL, NULL),
(38, 16, 'Hammer on the forge’s anvil to lure any nearby organisms into an ambush.', 'The iron forge is a cavern of suffocating stillness, the air thick with the metallic tang of oxidized ore and the stagnant heat radiating from the cooling lava veins in the walls. You bring your hammer down upon the anvil—*CLANG*. The sound ripples through the chamber, a dissonant, echoing frequency designed to exploit the territorial instincts of local fauna.\n\nSeconds later, a Skittering Cave-Crab emerges from the shadows, its chitinous plating clicking against the stone floor. It is attracted by the auditory stimulus, its pincers snapping with predatory intent. With a SPD of 5, your reaction time is sluggish, yet your defensive posture holds; as the creature lunges, you pivot, your DEF 20 armor absorbing the glancing blow of a serrated claw. You counter with a precise strike of your hammer. The weight of your ATK 14 impacts the creature\'s cranial shell with a wet crunch, sending shards of grey chitin and iridescent fluid splattering across the forge floor. The creature collapses, twitching as its life functions cease.\n\nThe exhaustion is immediate. Your muscles ache from the exertion, and the hollow sensation in your gut serves as a reminder that your biological demand for fuel is reaching a critical threshold.', '[\"(Approach) Inspect the surrounding forge walls for abandoned scrap metal to reinforce your gear. (Cost: Low SP)\",\"(SCAVENGER) Harvest the creature’s nutrient-rich biological matter to alleviate your hunger. (Cost: High SP, Med Hunger)\",\"(Risky Action) Follow the creature’s scent trail into the deeper, darker tunnels to find the source of the infestation. (Cost: High HP Risk)\"]', '2026-04-06 05:33:57', NULL, NULL),
(39, 16, 'Inspect the surrounding forge walls for abandoned scrap metal to reinforce your gear.', '***\n\nThe air within the *iron_forge* is a thick, stagnant soup of metallic particulate and ancient, cooling soot. It clings to your beard and irritates your lungs. Your boots scrape against the uneven, slag-encrusted floor, the sound echoing hollowly against walls that radiate a residual, phantom heat. \n\nAs you press your calloused hands against the forge’s flank, your fingers trace the jagged seams of dark iron. Your base SPD of 5 makes your movements deliberate and labored, but your focus is clinical. You locate a series of rusted, discarded bracing plates fused to the wall by centuries of oxidation. With a sharp grunt, you lever your weight against the metal. The material yields with a shrill, screeching groan of protesting iron. Your ATK of 14 is sufficient to pry the brittle, oxidized steel free, though the exertion sends a spike of fatigue through your core. You now possess enough scrap to reinforce your gear, though your joints ache from the resistance of the stubborn masonry. \n\nThe heat of the forge is deceptive; it offers no warmth, only the crushing weight of a dead industry. Your stomach tightens, a biological reminder of the caloric deficit growing within your frame.\n\n\n\n\n***', '[\"(Risky Action) Attempt to pry a heavy, embedded furnace core from the wall, risking structural collapse for potentially high-value materials. (Cost: High HP Risk)\",\"(Reinforce) Use the scrap to weld/bind patches onto your existing armor to increase DEF. (Cost: Low SP)\",\"(SCAVENGER) Scour the floor debris for residual smelting flux or leftover coal remnants to fuel a small, restorative fire. (Cost: Med SP, Med Hunger)\"]', '2026-04-06 05:34:32', NULL, NULL),
(40, 16, 'hurt and find a prey', 'The eyes of the Labyrinth are dilated. Higher dimensional entities are observing the Iron Forge. Probability of chaotic environmental intervention: 42%.\n\n---\n\n**NARRATION**\nThe Iron Forge is a graveyard of cooling slag and screeching bellows. You drag your boots through iron-dust, your lungs burning from the sulfurous, metallic air. Your intent to wound yourself serves a grim, tactical purpose: the copper-tinged scent of your own blood drifts through the heat-shimmer, acting as an olfactory lure for the local scavengers.\n\nYou slice your own forearm—a shallow, calculated strike to entice a target. Your SPD of 5 is abysmal; you are heavy, lethargic, and anchored to the floor. The heat is stifling, but the gamble pays off. From the rusted piping above, a *Cog-Rat*—a mechanical-organic amalgam—drops down. It smells your desperation. It lunges with serrated teeth, but your DEF of 20 allows you to brace, absorbing the initial snap with your armored vambraces. You counter, swinging your blunt scavenger-tool with an ATK of 14. The impact is visceral; the creature’s chassis cracks like dry wood, spilling sparking, oily ichor onto the obsidian floor. It collapses, twitching. The biological anomaly is neutralized, but your pulse is erratic, and your reserves are dangerously thin.\n\n\n\n\n---\n\n**CHOICES**', '[\"(Risky Action) Smear your own blood on the wall to lure a larger, more dangerous predator to the location for a high-reward kill. (Cost: High HP Risk)\",\"(SCAVENGER) Search the nearby slag heaps for discarded scrap while the scent of blood masks your own trail. (Cost: High SP, Med Hunger)\",\"(Butcher) Harvest the metallic organs and synth-meat from the Cog-Rat for consumption. (Cost: Low SP)\"]', '2026-04-06 05:36:01', NULL, NULL),
(41, 16, 'Smear your own blood on the wall to lure a larger, more dangerous predator to the location for a high-reward kill.', '*Alert: Anomalous shift in atmospheric energy detected. The Royal Academy has successfully synthesized . The geopolitical landscape is recalibrating.*\n\n---\n\n\nThe atmosphere of the Iron Forge is thick with the scent of oxidized iron and stagnant, sulfurous soot. Your lungs, accustomed to the subterranean air, pull in the suffocating heat as you press your palm against the jagged, soot-stained wall. The cold metal bites into your skin, but you override the pain, drawing a jagged line of crimson across the masonry.\n\nThe result is instantaneous. The metallic tang of fresh blood cuts through the sulfur, acting as an olfactory beacon. Minutes later, the rhythm of the forge changes; the steady drip of cooling magma is interrupted by the heavy, rhythmic thrum of chitinous legs. From the shadows emerges a Scourge-Crawler, a chitin-clad predator evolved for tunneling.\n\nYour SPD of 5 is insufficient for a clean escape; you are forced to commit to the engagement. As the beast lunges, its mandibles snapping with the force of a hydraulic press, you tuck your shoulder—relying on your DEF of 20 to absorb the grazing impact—and drive your rusted scavenger blade upward. Your ATK of 14 finds the soft, pulsating membrane beneath its thoracic plating. A spray of viscous, black ichor coats your armor. The creature screeches, a sound that vibrates against your very marrow, before collapsing into a twitching heap. You have secured the kill, but your metabolic output has surged to compensate for the sudden trauma.\n\n\n\n\n---', '[\"(Loot) Harvest the creature’s chitin plates to reinforce your armor. (Cost: Low SP)\",\"(SCAVENGER) Gut the carcass and consume the raw viscera to replenish your energy stores immediately. (Cost: Low SP, Low Hunger)\",\"(Risky Action) Wait in the shadows to see if the predator’s death-shriek drew something even larger to the forge. (Cost: High HP Risk)\"]', '2026-04-06 05:36:34', NULL, NULL),
(42, 16, 'Harvest the creature’s chitin plates to reinforce your armor.', '. Statistical variance detected in global distribution.]\n\n\n***\n\nThe air in the *iron_forge* is thick with the scent of ozone and cooling slag. The cavern walls hum with residual thermal energy, vibrating against your calloused palms as you kneel over the carcass of the chittering beast. \n\nWith a calculated strike—utilizing your base ATK of 14—you drive your crude blade into the creature\'s joint. The sound of rending cartilage fills the chamber, followed by a sickening crunch as the hardened plates give way. Your low SPD of 5 makes the work laborious, forcing you to leverage your entire body weight against the beast’s rigid thorax. As the chitin snaps, a viscous, bioluminescent ichor coats your forearms, cooling rapidly in the forge’s ambient draft. You successfully strip three jagged, overlapping plates. Positioning them over your existing pauldrons, you secure the crude reinforcement with wire. \n\nThe task is complete, but your physical vessel is failing. The exertion has sent your heart rate into a painful flutter, and the lack of caloric intake is causing your vision to pulse at the edges. The forge offers tools, but it offers no sustenance.\n\n\n\n\n\n***', '[\"(SCAVENGER) Gut the remaining carcass for any edible organs, ignoring the high probability of parasitic infection. (Cost: Low SP, Low Hunger)\",\"(Explore) Search the perimeter of the iron_forge for discarded scrap metal to trade later. (Cost: Low SP)\",\"(Rest) Attempt to enter a meditative state to recover SP, leaving yourself vulnerable to any patrolling threats. (Cost: High HP Risk)\"]', '2026-04-06 05:37:03', NULL, NULL),
(43, 16, 'Rest', '> A sudden surge in localized mana density detected. : Royal Academy initiates intensive curriculum.  trait successfully manifested in candidate pool. Efficiency of reality manipulation increasing by 0.04%. \n> : Rest cycle complete. Biological homeostasis stabilized. SP reserves at 100% capacity.\n\n***\n\nThe air in the *iron_forge* is thick with the scent of oxidized copper and lingering sulfur. Despite the damp chill bleeding through the cavern walls, your rest has provided a necessary buffer for your biological functions. The forge\'s furnace is cold, but the ambient vibration of the mountain against your sturdy frame confirms that the structure remains stable. \n\nYou wake with a lingering ache in your joints, though your stamina is fully restored. The dim bioluminescence of hanging moss provides just enough light to illuminate the scrap metal scattered across the floor—a scavenger\'s gold. However, the system detects a drop in your caloric efficiency. Your metabolism is demanding fuel. The biological reality of your form dictates that without immediate intake, your performance metrics will inevitably decline.\n\n\n\n***', '[\"(SCAVENGER) Forage through the refuse heaps for lingering heat-retaining iron-root or edible lichen. (Cost: Med SP, Med Hunger)\",\"(Risky Action) Venture deeper into the forge’s smelting pits to search for high-value ores, ignoring structural instability. (Cost: High HP Risk)\",\"(Approach) Inspect the nearby anvil for usable steel scraps. (Cost: Low SP)\"]', '2026-04-06 05:37:26', NULL, NULL),
(44, 16, 'hurt', 'The iron_forge is suffocating, a heavy, metallic humidity clinging to your beard as the scent of rust and damp soot fills your lungs. You spot the Blind Cave Rat scurrying along a jagged protrusion of volcanic rock. With your SPD stat of 5, your movements are deliberate and heavy; you close the distance with a grunt, your boots scraping against the slick floor.\n\nAs you lunge, the creature’s twitchy instincts flare. It attempts to dart into a crevice, but your ATK of 14 proves superior to its meager evasion. Your fist connects with a sickening thud, bone meeting cartilage. The rat squeals, a high-pitched, discordant sound that echoes against the furnace walls, before it is sent tumbling into the shadows, incapacitated by the sheer force of your strike. Green ichor stains the black iron, evidence of biological damage. \n\nYou stand panting, the adrenaline spike barely masking the hollow ache in your gut. Your Hunger is beginning to manifest as a sharp, gnawing pain in your abdomen. You must secure calories, or the efficiency of your biological vessel will plummet.\n\n\n\n\n\n---', '[\"(Risky Action) Kick the crate next to the rat to see if more emerge, risking an ambush for potential loot. (Cost: High HP Risk)\",\"(Approach) Inspect the creature for further threats before deciding how to proceed. (Cost: Low SP)\",\"(SCAVENGER) Gut the creature and scavenge for any usable viscera or salvageable parts. (Cost: High SP, Med Hunger)\"]', '2026-04-06 05:51:04', NULL, NULL),
(45, 16, 'Action) Kick the crate next to the rat to see if more emerge, risking an ambush for potential loot.', '***\n\nThe air in the *iron_forge* is thick with the scent of oxidized metal and stale, stagnant heat radiating from cooling magma channels. Your boots scrape against the soot-caked floor as you drive your heavy boot into the wooden crate. The timber, brittle from centuries of neglect, splinters with a resonant *CRACK* that echoes off the iron walls.\n\nThere is no ambush. As the crate collapses, the rat—a biological anomaly of enlarged, jagged incisors—merely startles, skittering into the darkness with a frantic squeal. You find nothing but a handful of rusted iron shavings and a useless, calcified gear. Your aggressive maneuver yielded zero efficiency; the expenditure of kinetic energy has only served to accelerate your exhaustion.\n\nYour stomach gives a sharp, hollow cramp. The physical toll of the labyrinth is beginning to weigh on your frame; your SPD of 5 remains insufficient for swift recovery, and your muscles ache from the sudden exertion. You are alone, hungry, and the ambient temperature is beginning to fatigue your dwarven constitution.\n\n\n\n\n***', '[\"(Risky Action) Follow the rat into the dark ventilation shaft, ignoring potential structural hazards to track down a potential food source. (Cost: High HP Risk)\",\"(Cautious) Slowly survey the perimeter of the forge for signs of structural instability or salvageable metal. (Cost: Low SP)\",\"(SCAVENGER) Sift through the debris of the smashed crate and the surrounding soot to extract any trace of usable materials for trade. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 05:51:35', NULL, NULL),
(46, 16, 'Follow the rat into the dark ventilation shaft, ignoring potential structural hazards to track down a potential food source..', 'Detection of biological anomaly in the upper labyrinth: Unit  has initiated tracking protocols targeting caloric resources within prohibited structural zones. Probability of structural failure: 14%. Probability of caloric acquisition: 68%.\n\n---\n\nThe ventilation shaft is a claustrophobic arterial of rusted iron and ancient, caked soot. As you force your frame into the conduit, the air turns stagnant, thick with the metallic tang of oxidized iron and the pervasive, humid heat radiating from the distant magma vents. You crawl on calloused hands, the jagged edges of the grating tearing at your tunics. Your SPD attribute is insufficient for stealth; the rhythmic scraping of your heavy boots against the iron bellows through the shaft like a warning bell.\n\nAhead, the rat—a twitching, vermin-like biological anomaly—pauses near a junction of leaking pressure pipes. It senses your movement, eyes glinting in the dark. You lunge, your ATK 14 force colliding with the shaft floor as the creature scurries deeper into a labyrinthine collapse of venting pipes. You have successfully tracked the target, but the physical exertion of navigating the confined, heated space has taxed your reserves. The heat here is oppressive, accelerating your metabolic rate.\n\n\n\n\nYou remain wedged in the ventilation shaft. The sound of distant, grinding gears suggests the upper labyrinth is shifting. You must secure your caloric intake or suffer further decline.', '[\"(Risky Action) Smash through the weakened floor grating to corner the creature in the utility sub-chamber, risking a fall into the lower maintenance ducts. (Cost: High HP Risk)\",\"(Approach) Slowly advance through the piping, using your knowledge of metallurgy to identify stable load-bearing sections. (Cost: Low SP)\",\"(SCAVENGER) Abandon the chase and pry open the ventilation grate to scavenge for loose mineral deposits or discarded scraps nearby. (Cost: High SP, Med Hunger)\"]', '2026-04-06 05:53:51', NULL, NULL),
(47, 16, 'hurt', 'Current Date: Post-Initiation. Royal Academy graduates report successful manifestation of . Statistical variance in high-caste demographics is increasing. \n\n\nProximity Alert: \'Lesser Frog\' identified. Aggression threshold: Low. Survival instinct: Twitchy.\n\n---\n\nThe iron_forge is a tomb of stale heat and metallic tang. The ambient temperature fluctuates near the cooling bellows, smelling of oxidized copper and recycled air. You close the distance with a lumbering, deliberate gait—your SPD of 5 makes swift movements a significant metabolic challenge. \n\nThe Lesser Frog sits atop a rusted anvil, its skin a mottled, sickly green. As you lash out with a heavy, calloused fist (ATK 14), the creature attempts a desperate hop. It is too slow. Your strike connects with a wet, sickening thud against the creature’s soft midsection. You feel the crunch of cartilage under the force of your impact, sending a spray of viscous, iridescent ichor across the soot-stained floor. The creature lets out a high-pitched, harmonic croak before collapsing, its form going slack. The threat is neutralized, though the effort leaves your joints aching.\n\n\n\nYour metabolic demand is rising. The exertion has left your chest heaving, the air of the forge feeling thinner with every breath you take. You need to stabilize your vitals before your stamina reserves bottom out.\n\n\n\n\n\n---', '[\"(Search) Delve deeper into the forge’s dark, smoke-choked corridors to find a safer position. (Cost: High HP Risk)\",\"(SCAVENGER) Gut the Lesser Frog to extract its internal organs for emergency calorie consumption. (Cost: High SP, Med Hunger)\",\"(Loot) Search the immediate vicinity of the forge for usable scrap metal or salvageable parts. (Cost: Low SP)\"]', '2026-04-06 14:24:45', NULL, NULL),
(48, 16, 'Delve deeper into the forge’s dark, smoke-choked corridors to find a safer position', ': The Royal Academy has concluded a new training cycle. Subject entities have successfully integrated  into their core parameters. The gap between current biological efficiency and elite combat standards is statistically widening.\n\n---\n\n\nYou abandon the relative safety of the main entrance, pulling your heavy, soot-stained frame deeper into the subterranean bowels of the Iron Forge. The air here is a lethal cocktail of sulfur and particulate iron, coating your lungs with a gritty film that burns with every inhalation. \n\nThe heat is localized—the humidity spikes as you transition into the narrow, smoke-choked corridors. The slickness of the stone walls, dampened by condensation and leaked hydraulic oil, tests your meager SPD (5). You navigate the jagged shadows, your movement hampered by the physical toll of the environment. The temperature fluctuations are extreme; your DEF (20) shields you from the ambient heat, but your biological integrity is flagging. You require a stable anchor point, as the structural integrity of these tunnels is compromised by unstable seismic echoes. \n\nYour stomach cramps. The scarcity of resources in this sector is becoming an active threat to your survival. The forge’s heart hums with a low-frequency vibration that rattles your bones—you are not alone, and the shadows ahead possess a mass that defies current sensory input.\n\n---\n\n\n- HP: 80/80\n- MP: 10/10\n- SP: 18/45 (-2)\n- Hunger: 86/100 (-3)', '[\"(Risky Action) Sprint through the central steam-vent path to bypass the corridor\'s congestion and reach the core. (Cost: High HP Risk)\",\"(SCAVENGER) Sift through the discarded slag heaps and oxidized metal scraps for any usable energy cells or food. (Cost: High SP, Med Hunger)\",\"(Approach) Secure a tactical position behind the rusted blast-gate to monitor the corridor. (Cost: Low SP)\"]', '2026-04-06 14:25:15', NULL, NULL),
(49, 16, 'Secure a tactical position behind the rusted blast-gate to monitor the corridor.', 'The iron_forge is a stifling expanse of oxidized metal and stale, sulfurous air. Your lungs, accustomed to the deep, dense oxygen of the lower strata, burn as you move behind the rusted blast-gate. The structure groans—a low-frequency metal fatigue that vibrates through your boots. Your SPD of 5 makes the maneuver sluggish; you are a heavy, grounded creature, and the clanking of your gear against the frame of the gate echoes with punishing clarity in the silent, magma-heated corridor.\n\nYou press your back against the jagged, rusted iron. The surface is cold, contrasting sharply with the residual heat of the forge, and the smell of ozone and ancient decay fills your nostrils. You are positioned, but your physical exertion has taxed your waning stamina. The hunger gnawing at your gut is a constant, rhythmic pulse, reminding you that your biological efficiency is declining. From your vantage point, you observe the corridor: it is empty for now, but the ambient temperature suggests that something large, something fueled by the same heat that powers this forge, is pacing just beyond the threshold of your vision.\n\nYour reserves are flagging. The lack of nourishment is beginning to dull your reflexes, and the heavy plating of your armor feels less like protection and more like a tomb.\n\n\n\n\n\n---', '[\"(Observe) Remain perfectly still and monitor the corridor for emerging hostiles while catching your breath. (Cost: Low SP)\",\"(Risky Action) Abandon the cover to scout the intersection ahead, increasing your visibility to potential threats. (Cost: High HP Risk)\",\"(SCAVENGER) Forage through the discarded scrap piles near the gate to find potentially useful salvaged components or sustenance. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 14:26:00', NULL, NULL),
(50, 16, 'travel down to elroe_upper', 'The transition from the sweltering, metallic lungs of the iron_forge to the expansive, frigid mouth of the elroe_upper is characterized by a rapid atmospheric shift. The constant, rhythmic drumming of bellows is replaced by an oppressive, cavernous silence. Your dwarf physiology—sturdy and built for subterranean pressure—registers the drop in temperature as a distinct biological inefficiency. The air here tastes of limestone dust and stagnant moisture, clinging to your beard like a damp shroud.\n\nYour SPD stat of 5 proves barely adequate for the descent. Your boots slip on the slick, calcified sediment of the labyrinth floor, forcing you to utilize your DEF of 20 to absorb the impact of the uneven rock. Every muscle in your frame protests the migration; your internal caloric reserves are flickering. The labyrinth is a vast, predatory stomach, and you are currently descending into its gullet. The path ahead is shrouded in gloom, illuminated only by the faint, bioluminescent lichen pulsing rhythmically against the stone, mimicking the heartbeat of a creature far larger than yourself.\n\n\n\n\nSurvival efficiency is declining. You are currently exposed in a wide-open transit corridor with limited cover. Your metabolic furnace demands fuel to maintain optimal combat readiness.', '[\"(Approach) Carefully scout the perimeter for stable footing and potential hazards. (Cost: Low SP)\",\"(SCAVENGER) Utilize your keen dwarven senses to sift through the rock debris for forgotten scraps or discarded minerals. (Cost: High SP, Med Hunger)\",\"(Risky Action) Sprint toward the flickering light deeper in the chasm to find a defensible position quickly. (Cost: High HP Risk)\"]', '2026-04-06 14:32:47', NULL, NULL),
(51, 16, 'System, report current coordinates and environmental status. Where am I?', '*Attention: Wandering the upper labyrinth looking for food. Biological units within this sector are advised that caloric depletion will lead to inevitable systemic failure.*\n\n\nLocation: Iron_Forge, Sector 4-B.\nTemperature: 48°C. Atmospheric composition: High sulfur particulates. \nAuditory profile: Distant rhythmic hammering of automated hydraulic presses against cooling basalt. \n\nYou stand at the center of the Iron Forge. The floor is comprised of jagged, soot-stained iron plates that conduct heat directly through your boots. The air tastes of oxidized metal and stale ash, a familiar, acrid bouquet for your dwarven physiology. Your current SPD: 5 is insufficient for rapid navigation of these shifting, mechanical hazards; your movement is sluggish, labored by the weight of your own fatigue. \n\nThe forge is vast, filled with the shadows of silent anvils. You are currently located at the primary smelting hub. To the north, a ventilation shaft glows with a dull, ambient heat—a potential source of sustenance or further environmental damage.\n\n\nYour SP is critical (5/45). Your muscles tremble from the metabolic deficit. The hunger pangs (83/100) are beginning to override cognitive processing, urging you toward immediate resource acquisition.', '[\"(Risky Action) Attempt to pry open the maintenance panel on the main boiler for a faster, albeit dangerous, shortcut through the forge. (Cost: High HP Risk)\",\"(SCAVENGER) Sift through the central grease pits to locate organic waste left by previous occupants. (Cost: High SP, Med Hunger)\",\"(Scout) Carefully examine the smelting refuse piles for usable scrap or forgotten rations. (Cost: Low SP)\"]', '2026-04-06 14:39:44', NULL, NULL),
(52, 16, 'Travel to elroe_upper', '.]\n\n\n\nThe transition to the Elroe Upper Stratum is sensory violence. The air is stagnant, thick with the scent of damp moss and the metallic tang of distant, subterranean minerals. Your dwarven frame, sturdy and built for stone-work, struggles against the uneven, slick terrain. The temperature here is deceptive—cool to the touch, yet humid enough to make the condensation on the cavern walls drip with a rhythmic, maddening *plink-plink-plink*. \n\nYou are navigating a maze of limestone pillars and jagged stalagmites. Your low SPD (5) makes every step a deliberate, heavy affair; you lack the grace of a mountain goat, forced instead to rely on your DEF (20) as your shoulder brushes against razor-sharp rock outcroppings. \n\nYou are currently isolated. The silence of the labyrinth is absolute, save for the dragging of your own boots. Your internal metabolic clock is ticking. The biological imperative to replenish energy reserves is becoming the primary driver of your consciousness. The lack of SP is hindering your traversal speed, and the damp, oppressive atmosphere of the Upper Stratum is beginning to sap your remaining vitality.\n\n\n\n***', '[\"(SCAVENGER) Utilize your dwarven keen-sight to sift through the debris of previous travelers’ remains, seeking scraps of dried rations or discarded gear. (Cost: High SP, Med Hunger)\",\"(Approach) Carefully scout the immediate perimeter for natural caverns or shallow alcoves to establish a temporary perimeter. (Cost: Low SP)\",\"(Risky Action) Scale the nearest rock formation to gain a tactical vantage point and identify a path toward the middle stratum. (Cost: High HP Risk)\"]', '2026-04-06 14:44:55', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(53, 16, 'rest afterward go and hurt', '.]\n\nThe air in the Elroe Upper Stratum is heavy, smelling of damp earth and ancient, pressurized dust. You collapse against the slick, uneven wall of the cavern, the cold stone leaching heat from your frame. You spend the interim period in a state of semi-torpor, allowing your stamina to regenerate. As your vitals stabilize, your instincts pull you toward the scuttling movement in the periphery.\n\nA Lvl 1 Small Lesser Taratect—a translucent, spindly arachnid—is perched upon a jagged rock protrusion. It detects your shift in position and hisses, mandibles clacking. \n\nYou lunged with a burst of movement. Your SPD is negligible, making the advance clumsy, but your ATK 14 proves sufficient for the creature\'s low DEF. You bring your heavy scavenger’s tool down in a singular, crushing arc. The strike connects with the arachnid\'s soft thorax, emitting a sickening crunch as the carapace shatters. Green ichor sprays across the stone floor; the creature\'s legs twitch sporadically before it goes still. You have neutralized the immediate threat, but the physical exertion of the hunt has spiked your caloric requirement. \n\nYour stomach gnaws at you, a reminder that your biology demands fuel to sustain this form.\n\n\n\n\n\n---', '[\"Attempt to Flee from the Small Lesser Taratect\",\"(SCAVENGER) Consume the nutrient-rich moss and the spider’s remains to address immediate hunger. (Cost: Low SP, Low Hunger)\",\"Attack the Small Lesser Taratect\",\"(Approach) Inspect the area for any secondary threats or hidden crevices. (Cost: Low SP)\"]', '2026-04-06 14:53:55', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(54, 16, 'Attack the Small Lesser Taratect', 'The air in the upper stratum of the Elroe Labyrinth is thick with the scent of damp moss and the metallic tang of distant magma flows. You lunge forward, your dwarven frame shifting with the lethargic grace of your low SPD stat. Your strike lands with a dull thud against the creature’s chitin, but the damage remains uncalculated—the Small Lesser Taratect is a biological anomaly, its tiny, multi-faceted eyes tracking your movement with terrifying efficiency. \n\nAs you pull back, the Taratect surges. Its movements are erratic, clicking sounds echoing against the slick, damp cave walls. You are too slow to evade entirely; a jagged pincer glances off your shoulder. The impact is minor, but it confirms the threat profile: the creature is testing your vulnerabilities. Your muscles ache from the exertion, and your stomach gives a sharp, hollow cramp. Your stamina is failing.\n\n\n\n***', '[\"(Risky Action) Force a close-quarters grapple to pin the Taratect against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. (Cost: High HP Risk)\",\"Attack the Small Lesser Taratect\",\"(SCAVENGER) Ignore the pain and perform a frantic, wide-arc search of the nearby debris for a makeshift tool to increase your reach. (Cost: High SP, Med Hunger)\",\"(Retreat) Use the labyrinth\'s uneven terrain to break line-of-sight and stabilize your vitals. (Cost: Low SP)\"]', '2026-04-06 14:54:56', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(55, 16, 'Force a close-quarters grapple to pin the Taratect against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. t', 'The air in the Elroe Upper Stratum is thick with the scent of ozone and damp, mineral-crusted moss. You ignore the searing pain where the Taratect’s mandibles grazed your shoulder, forcing your 5 SPD frame into a desperate, heavy-footed dash. You slam your weight against the spider, pinning its segmented thorax against the jagged, slick-wet limestone of the cave wall. \n\nThe creature screeches—a wet, chitinous rasp—as your ATK 14 force compresses its fragile abdomen. Green, caustic ichor sprays onto your knuckles, hissing against your skin. You feel the creature’s legs franticly scrabbling against your chest, trying to find a gap in your DEF 20 armor to deliver a lethal, venomous payload. Your muscles burn with the strain of holding it static. The wall is freezing, but the heat of the creature’s biological fury is blinding.\n\n\n\n\n\n\n\n***', '[\"(Risky Action) Release the grapple and attempt a neck-break, risking a point-blank injection of neurotoxin. (Cost: High HP Risk)\",\"Attack the Small Lesser Taratect\",\"Attempt to Flee from the Small Lesser Taratect\",\"(SCAVENGER) Gut the creature quickly and harvest the freshest silk glands before the scent of blood draws larger predators. (Cost: Med SP, Low Hunger)\"]', '2026-04-06 15:06:35', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(56, 10, 'Force a close-quarters grapple to pin the Taratect against the cave wall, risking a venomous bite to ensure a lethal follow-up strike. t', 'The Elroe Labyrinth watches with detached amusement. The duel between  and  escalates. The System records the  impact: Player sustains 3 damage from the defensive retaliation.\n\n---\n\nThe air in the Elroe Upper Stratum is thick with the scent of damp moss and the metallic tang of drying ichor. The cave walls, slick with subterranean condensation, offer no traction. \n\nYou lunge. Your SPD attribute barely allows you to bypass the arc of the enemy’s serrated foreleg, but the maneuver is imperfect. As you slam your body into the opposing Taratect, pinning it against the jagged granite wall, a searing pain erupts in your abdomen. The enemy’s mandibles have found purchase. You feel the cold sting of venom—a biological anomaly—infiltrating your bloodstream. Despite the visceral horror of the bite, you press your weight forward, using your ATK to crush the opponent’s thorax against the unforgiving stone. A sickening crack echoes through the chamber; green ichor spatters your chitinous plating. The enemy twitches, its movements stuttering under the pressure of your hold, but your own vision begins to swim as the toxin takes hold.\n\n\n\n\n---', '[\"[DEFEND] Brace for Small Lesser Taratect\'s next move\",\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\",\"(BEAST) Release a high-density web wrap at point-blank range to solidify the pin and prevent the opponent\'s thrashing. (Cost: High MP, High SP)\",\"(Execute) Tighten your mandibles around the opponent\'s throat to finish the kill quickly. (Cost: Low SP)\"]', '2026-04-06 15:22:38', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(57, 10, 'Brace for Small Lesser Taratect\'s next move', 'Hostility detected. The opposing Small Lesser Taratect (Lvl 5) is maneuvering for a lethal strike. Environmental dampness of the Elroe Labyrinth is inhibiting traction. The smell of sulfur and damp stone permeates the sensory organs.\n\n\n\nThe rival arachnid lunges, mandibles snapping with the force of a rusted guillotine. You contract your core, utilizing your SPD to pivot just as the pincers graze your chitin. The friction against the slick cave wall sends a tremor through your nervous system. A minor abrasion on your thorax signifies the narrow margin of your survival. The creature screeches—a high-frequency vibration that rattles your internal organs—and resets for another strike.\n\nYour physical state is deteriorating. Metabolic reserves are dangerously low, and the exhaustion manifesting from the recent skirmish is reducing your kinetic efficiency. Every movement burns through your remaining stamina; you are hovering on the brink of collapse.\n\n\n\n\n\n---', '[\"[SKILL] Counter-strike Small Lesser Taratect\",\"(Risky Action) Attempt to scale the vertical rock face to initiate a drop-attack from above. (Cost: High HP Risk)\",\"Attack the Small Lesser Taratect\",\"(Thread Manipulation) Weave a web barrier between you and the enemy to force a reposition. (Cost: Low SP)\"]', '2026-04-06 15:23:46', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(58, 10, 'Counter-strike Small Lesser Taratect also the stats of what am fighting', 'The humid, stagnant air of the Elroe Upper Stratum clings to your chitin like a shroud. The walls, slick with bioluminescent moss, offer little traction. Before you, the rival Small Lesser Taratect skitters across the rock face, its multiple eyes glistening with predatory intent.\n\n**Target Analysis: **\n*   **Attributes:** ATK 8 | DEF 6 | MAG 5 | RES 5 | SPD 8\n*   **Status:** Hostile. Superior speed detected. \n\nYour attempt to initiate a counter-strike is met with a blur of motion. Your SPD of 5 proves insufficient against the target’s superior agility. As you lunge forward, threads snap and spray, but your attack glances off the target’s defensive plating. In the same motion, the rival strikes; a sharp, hooked leg pierces your guard, dealing 3 damage to your vitals. Your HP drops; the metallic tang of your own hemolymph fills the air. You are outclassed in this exchange, and your internal reserves are critically low.\n\n\n\n\n\nThe heat of the labyrinth begins to induce lethargy. Every movement costs a significant portion of your remaining stamina. You are currently in a state of biological deficit.\n\n---', '[\"(Retreat) Use Thread Manipulation to create a barrier and flee into the dark crevices of the cavern. (Cost: Low SP)\",\"(BEAST) Abandon defensive posture. Engage in a feral, suicidal rush to pin the opponent against the cavern wall using all remaining strength. (Cost: High SP, Med Hunger)\",\"Attempt to Flee from the Small Lesser Taratect\",\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\"]', '2026-04-06 15:25:35', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(59, 10, 'Unleash Heavy Strike on Small Lesser Taratect', 'The damp limestone walls of the Elroe Labyrinth vibrate with the resonance of your Heavy Strike. You channel your limited kinetic reserves into a singular, forceful lunge, intending to shatter the enemy\'s chitinous exterior. Your ATK stat, though base-level, meets the opponent’s guard at the moment of impact. The clash produces a shrill, metallic screech—the sound of scraping mandibles against obsidian rock.\n\nHowever, your efficiency is compromised. The previous combat fatigue—evidenced by the  notification—dampens the force of your blow. You strike true, but the Lvl 5 Taratect’s SPD attribute allows it to pivot just enough to turn a lethal blow into a glancing one. Green ichor sprays across the mossy floor, bioluminescent fluids mixing with the stagnant humidity of the cave. \n\nThe retaliation is instantaneous. Sensing your momentary overextension, the Lvl 5 Taratect lunges, sinking its fangs into your joint. The pain is a sharp, electrical surge that bypasses your RES, triggering a warning in your biological feedback loop. The smell of ozone and wet rot fills your olfactory sensors. You are pinned, bleeding, and rapidly losing the tactical advantage of the high ground.\n\n\n\n\n\n---', '[\"(Risky Action) Attempt to collapse a section of the stalactite ceiling onto both combatants to end the deadlock. (Cost: High HP Risk)\",\"Attempt to Flee from the Small Lesser Taratect\",\"(BEAST) Abandon defensive posture and enter a feral frenzy, biting the opponent’s thorax to drain its vital fluids. (Cost: High Hunger, Med SP)\",\"[DEFEND] Brace for Small Lesser Taratect\'s next move\"]', '2026-04-06 16:06:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(60, 10, 'Counter-strike Small Lesser Taratect also the stats of what am fighting', '**ANALYSIS: COMBAT LOG**\nThe resonance of your previous Heavy Strike still echoes against the damp limestone, yet the biological anomaly persists. Your counter-strike connects, but the opponent\'s superior level and chitin density mitigate the impact. The opponent’s retaliatory strike—a precise mandibular puncture—has breached your carapace, resulting in a loss of structural integrity.\n\n**NARRATIVE:**\nThe stagnant, ammonia-scented air of the Elroe Labyrinth grows heavy as you recoil. Your mandibles clatter against the limestone wall, dislodging a patch of bioluminescent moss that flares with a sickly blue hue. The sensation of the opponent\'s strike—a sharp, piercing agony—triggers a feedback loop in your central nervous system. A small droplet of green ichor leaks from the crack in your primary chitin plate, pooling on the slick floor. \n\nThe Lvl 5 Taratect vibrates its legs, producing a chittering sound that reverberates through the cave, masking the distant, rhythmic dripping of subterranean water. Your HP has dipped significantly, and your current defensive parameters are failing to account for the speed differential between your Level 4 status and the enemy’s Level 5.\n\n**STATISTICS OF TARGET:**\n*   **Identity:** Small Lesser Taratect (Lvl 5)\n*   **Status:** Hostile\n*   **Attributes:** Estimated ATK 7 / DEF 6 / SPD 6\n*   **Observed Skills:** Thread Manipulation, Night Vision, Poison Fang (Suspected)\n\n**SYSTEM STATUS:**\n\n\n\n---\n\n\n\n while remaining in melee range to force a critical counter. (Cost: High HP Risk)]', '[\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\",\"(Evasive Maneuver) Sidestep the incoming follow-up strike by retreating into the webbing on the ceiling. (Cost: Low SP)\",\"(BEAST) Abandon defensive posturing and lunge forward with a wild, frenzied bite to sever the enemy\'s sensory antennae. (Cost: High SP, Med Hunger)\",\"Attack the Small Lesser Taratect\"]', '2026-04-06 16:13:16', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(61, 10, 'Counter-strike Small Lesser Taratect also the stats of what am fighting', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The damp, claustrophobic chill of the Elroe Labyrinth is stifling. The air carries the metallic tang of ichor and the scent of rotting, damp limestone. The bioluminescent moss lining the cavern walls flickers with your rapid, erratic movements.\n\n**COMBAT FEED:**\nYour counter-strike connects with a sickening crunch, your appendages clashing against the enemy\'s chitin. You manage to bypass its guard, sending a spray of viscous, pale fluid onto the cavern floor. However, your kinetic output is hindered by internal system failure. The  is a creature of high efficiency; its level 5 status indicates superior  and  scaling compared to your current vessel. Despite the  registering a successful hit, your own defense failed to mitigate the velocity of its follow-up strike. Three points of vitality have been shorn from your core. \n\nThe enemy\'s HP remains erratic—a symptom of your  reading error. You are currently fighting a biological anomaly that ignores standard diagnostic parameters.\n\n**STATISTICS:**\nEnemy Stats:  | Lvl: 5 | Primary Attribute: SPD | Threat Level: High.\n\n\n\n\n\n**URGENCY:** Your vitals are flickering. The enemy is positioning its mandibles for a piercing attack. The narrow geometry of the cave walls prevents a full retreat.\n\n---', '[\"Attempt to Flee from the Small Lesser Taratect\",\"(Risky Action) Dash blindly into the dark crevices of the cave wall, hoping to use Camouflage to reset the combat encounter. (Cost: Med SP)\",\"Attack the Small Lesser Taratect\",\"(BEAST) Abandon all defensive posturing. Attempt to bite into the Taratect’s main joint to cripple its mobility, accepting the risk of a counter-grapple. (Cost: High Hunger, Med HP)\"]', '2026-04-06 16:21:41', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(62, 10, 'Dash blindly into the dark crevices of the cave wall, hoping to use Camouflage to reset the combat encounter.', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** The maneuver was executed with sub-optimal precision. As you pivoted to retreat, your foot slipped on a patch of slick, calcified moss. The Small Lesser Taratect exploited the exposure, its serrated mandibles clicking with rhythmic efficiency. A sharp, stinging laceration manifested along your flank. Chitin fragments scattered against the cold limestone as the creature’s strike connected.\n\n**ENVIRONMENTAL ANALYSIS:** The air in this sector of the Elroe Labyrinth is thick with the scent of stagnant water and decaying organic matter. The temperature is dropping, a direct byproduct of the deepening cavern shadows. Your attempt at camouflage is hampered by the persistent, echoing vibration of the earlier Heavy Strike, which acts as a beacon for any nearby predator tracking movement via seismic sensitivity.\n\n**BIOLOGICAL STATUS:** \nThe 3 DMG sustained has reduced your structural integrity. Your SPD attribute is currently struggling to compensate for the jarring impact of the creature\'s counter. The darkness of the crevices offers a temporary visual buffer, but your biological signature remains highly audible to a creature capable of Thread Manipulation. \n\n\n\n\n***\n\n**CURRENT SURVIVAL PRESSURE:** The Small Lesser Taratect is closing the distance, its multiple eyes glistening with predatory focus in the subterranean gloom. You are currently pinned against a jagged rock face with no clear exit route.', '[\"[DEFEND] Brace for Small Lesser Taratect\'s next move\",\"(BEAST) Aggressively lunge at the creature’s throat, abandoning defense to end the threat through raw primal ferocity. (Cost: High SP, Med Hunger)\",\"(Risky Action) Scale the vertical limestone wall toward the ceiling, hoping to outmaneuver the arachnid in the vertical space. (Cost: High SP, High HP Risk)\",\"Attempt to Flee from the Small Lesser Taratect\"]', '2026-04-06 16:23:41', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(63, 10, 'Brace for Small Lesser Taratect\'s next move', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The damp, stagnant air of the Elroe Labyrinth clings to your chitinous exterior like a wet shroud. The limestone walls weep moisture, creating a rhythmic *drip-drop* that masks the scuttling of your adversary. Your vision, augmented by Night Vision, registers the creature’s trajectory with clinical coldness; it is an instinct-driven predator, and you are currently its primary caloric objective.\n\n**COMBAT LOG:** You adopt a braced stance, channeling your internal energy to reinforce your exoskeleton. Your low RES stat is a vulnerability, yet you optimize your posture to distribute the kinetic force of the impact. The Lesser Taratect lunges, its fangs scraping against your shoulder plates. The sound is a sickening, shrill grinding of serrated mandibles against hardened cuticle. Your DEF holds, but the sheer force of the collision knocks you back into the damp stone wall. You take 1 DMG. The ichor beneath your plating pulses with the sting of the impact. \n\nYour efficiency remains at 98%, but the metabolic strain of maintaining this posture is depleting your reserves.\n\n\n\n\n\n---', '[\"Attempt to Flee from the Small Lesser Taratect\",\"(BEAST) Abandon defensive caution and lunge with a predatory frenzy, aiming to sever the opponent\'s sensory organs with your mandibles. (Cost: High SP, Med Hunger)\",\"Attack the Small Lesser Taratect\",\"[SKILL] Counter-strike Small Lesser Taratect\"]', '2026-04-06 16:27:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(64, 10, 'Attack the Small Lesser Taratect i saw another one', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling drips with cold, viscous condensation, echoing the rhythmic tapping of chitin against stone. You have shifted focus from your current assailant to a secondary biological anomaly emerging from the shadows—a second Lesser Taratect, smaller, yet no less lethal.\n\n**COMBAT LOG:** Your attempt to strike the second target is marred by your current physiological degradation. As you lunge, your SPD attribute fails to compensate for the exhaustion weighting your limbs. You slash at the newcomer, but your ATK value is insufficient to pierce its reinforced carapace, merely scraping against the calcified shell with a high-pitched, abrasive screech. \n\nSimultaneously, the first Taratect capitalizes on your exposed flank. Its mandibles snap shut with a sickening *crunch* against your thoracic plate. The force of the impact sends you skittering across the uneven cavern floor; green ichor—your own—leaks from the hairline fracture in your chitin. Your DEF and RES are insufficient to mitigate this kinetic energy. You are now bracketed by two hostile entities within the suffocating, humid confines of the labyrinth.\n\n**VITAL STATUS:** The proximity of dual predators, combined with your internal metabolic crash, places your survival probability at 12%. The damp air smells of ozone and rot. Your movement is sluggish.\n\n\n\n\n\n---', '[\"Attack the Small Lesser Taratect\",\"(BEAST) Release a concentrated burst of Thread to bind both targets, ignoring injury to secure a predatory advantage. (Cost: High SP, Med Hunger)\",\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\",\"[DEFEND] Brace for Small Lesser Taratect\'s next move\"]', '2026-04-06 16:28:25', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(65, 10, 'Attack the Small Lesser Taratect i saw another one', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**COMBAT LOG:** Your mandibles lock onto the creature’s thorax, the sound of chitin shearing echoing sharply against the limestone walls. Your attack connects for 19 damage. However, your focus on the offensive leaves your lateral guard exposed. The enemy retaliates with a frantic, serrated leg sweep, carving a deep furrow into your abdomen. You lose 3 HP.\n\nThe damp, metallic scent of spilled ichor permeates the stagnant cave air, mixing with the pervasive musk of the labyrinth’s rot. As you recoil, the rhythmic *drip-drip* of condensation from the ceiling above seems to accelerate, mimicking the frantic thrum of your own core. The creature you struck—a Small Lesser Taratect—hissing in high-pitched agitation, remains a persistent biological anomaly in your immediate field of vision. The proximity of the second hostile entity remains a tactical complication; your spatial awareness confirms a shift in the shadows to your left. Your SPD attribute is currently struggling to compensate for the weight of your own fatigue.\n\n**IMMEDIATE THREAT:** You are wounded and boxed in. The second Taratect is closing the distance while the first recovers its posture. Survival probability is currently trending downward.', '[\"(Risky Action) Attempt to wrap the wounded Taratect in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second. (Cost: High HP Risk)\",\"Attempt to Flee from the Small Lesser Taratect\",\"[DEFEND] Brace for Small Lesser Taratect\'s next move\",\"Attack the Small Lesser Taratect\"]', '2026-04-06 16:48:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(66, 10, 'AAttempt to wrap the wounded Taratect in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling drips with cold, viscous condensation, echoing the rhythmic tapping of your eight limbs against the cavern floor. The air is heavy with the metallic tang of drying ichor from your previous skirmish, mixing with the damp, earthy scent of the Elroe Labyrinth.\n\n**COMBAT LOG:** You lash out with , weaving a frenzied, sticky shroud around the wounded Taratect. The silk anchors to its thrashing legs, binding its thorax in a suffocating web. However, your focus on containment creates a critical opening in your own defense. The second Small Lesser Taratect lunges, its sharpened forelimbs driving into your side. Your chitin plates fracture under the impact, a hairline crack spider-webbing across your carapace as a spurt of bioluminescent green ichor stains the cold cave floor. The efficiency of your defensive maneuvering failed to account for the speed of the second assailant.\n\n**BIOLOGICAL STATUS:** The metabolic cost of simultaneous construction and combat has surged. Your hunger is nearing a critical threshold. The wounded Taratect is immobilized, but the second attacker stands poised for a lethal follow-up.\n\n\n\n\n---\n\n**CHOICE GENERATION:**', '[\"Attack the Small Lesser Taratect\",\"(BEAST) Abandon defensive tactics and initiate a frenzied bite attack to consume the immobilized target, prioritizing caloric intake over tactical safety. (Cost: Low SP, High Hunger)\",\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\",\"(Risky Action) Counter-strike the second assailant with a point-blank thread tether to the face, forcing a blinded state at the risk of further physical trauma. (Cost: Med HP Risk)\"]', '2026-04-06 17:10:58', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(67, 10, 'AAttempt to wrap the wounded Taratect in a silk cocoon mid-combat to neutralize one threat while taking a guaranteed strike from the second', '**SYSTEM STATUS: ANALYTICAL REPORT**\n\n**ENVIRONMENTAL OVERRIDE:** The limestone ceiling reeks of stagnant rot and damp mineral deposits. The sound of clicking mandibles from the second Lesser Taratect nearby is erratic, indicating high agitation. The condensation dripping from above creates a rhythmic, nerve-wracking cadence that masks your precise movements.\n\n**COMBAT LOG:** You lash out with your abdomen-gland, spinning a sticky, high-tensile silk thread. You bypass the wounded creature\'s erratic thrashing, binding its limbs to the cave wall. The maneuver is efficient, but your SPD attribute is taxed by the sudden shift in momentum. As you anchor the cocoon, the second creature lunges—a blur of pale chitin. Its serrated foreleg pierces your carapace, a sharp, white-hot sting radiating from your side. Green ichor leaks from the puncture, staining the damp floor. \n\n**BIOLOGICAL STATUS:** The wounded target is successfully incapacitated, but your internal integrity has been compromised. The hunger pangs are becoming a physiological distraction; your system is signaling critical need for nutrient ingestion.\n\n\n\n\n---\n\n**CHOICES**\n\n and wait for the second attacker to lose your silhouette. (Cost: Low SP)]\n\n\n\n burst aimed at the second creature’s eyes to blind it, exposing yourself to a potential follow-up strike. (Cost: High HP Risk)]', '[\"(BEAST) Abandon all caution, lunge forward and tear into the trapped, wounded Taratect to satisfy your biological hunger mid-combat. (Cost: High Hunger/Low SP)\",\"(Risky Action) Attempt a desperate, point-blank [Thread Manipulation\",\"Attempt to Flee from the Small Lesser Taratect\",\"[SKILL] Unleash Heavy Strike on Small Lesser Taratect\"]', '2026-04-06 17:11:48', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL);

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
(1, 15, 2, 1, 47, 55),
(2, 16, 1, 1, 0, 30),
(4, 10, 1, 5, 13, 70);

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
  `current_location` varchar(50) DEFAULT 'elroe_upper',
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
(9, 1, 'Cave Centipede', 'Beast', 1, 15, 15, 5, 5, 100, 20, 20, 'elroe_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(10, 1, 'Small Lesser Taratect', 'Beast', 4, 114, 120, 90, 90, 100, 0, 240, 'elroe_upper', 1, 0, 0, 40, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(11, 2, 'Scrap Slime', 'Beast', 1, 14, 20, 20, 20, 100, 20, 20, 'elroe_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(12, 2, 'Lesser Fire Wyrm', 'Beast', 1, 14, 25, 10, 10, 100, 20, 20, 'magma_layer', 1, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0, '[]', NULL),
(13, 3, 'Blind Cave Salamander', 'Beast', 1, 27, 30, 10, 10, 100, 20, 20, 'water_stratum', 0, 0, 0, 0, 100, 0, 6, 12, 4, 15, 5, 0, '[]', NULL),
(14, 3, 'Human', 'Predator', 1, 55, 55, 15, 15, 100, 35, 35, 'royal_capital', 0, 0, 0, 0, 100, 0, 12, 8, 5, 5, 5, 0, '[]', NULL),
(15, 3, 'Shadow Bat', 'Predator', 1, 0, 18, 15, 15, 33, 0, 20, 'elroe_upper', 0, 0, 0, 15, 100, 0, 7, 4, 5, 5, 18, 0, '[]', NULL),
(16, 3, 'Dwarf', 'Scavenger', 1, 78, 80, 10, 10, 61, 0, 45, 'elroe_upper', 1, 0, 0, 10, 100, 0, 14, 20, 5, 5, 5, 0, '[]', NULL);

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
(2, 1, 1, 'ACCEPTED CHALLENGE', 'Location: elroe_upper\nMode: TO_POINT\n\nThe upper strata of the Great Elroe Labyrinth are bathed in a dim, bioluminescent glow, the air thick with the scent of damp moss and prehistoric dust. \n\nJoker, a Scrap Slime composed of rusted metal shards and viscous, translucent gel, quivers as it navigates the jagged stone floor. Its metallic core clinks rhythmically against the rock. Suddenly, the cavern floor trembles. From a crevice in the wall, Light—a Cave Centipede—erupts into the corridor. Its segmented chitinous plates shimmer like polished bone under the faint light, and its mandibles click with lethal precision, dripping with a paralyzing digestive enzyme. The centipede coils its massive, multi-legged body, sensing the metallic vibrations emanating from the slime. It locks its multifaceted eyes onto Joker, arching its thorax in preparation for a high-speed lunge.\n\nThe duel begins now.\n\n Use \"Rust Shrapnel\" to launch a cloud of jagged metal bits at the centipede’s sensory antennae to disorient it.]\n\n Retract into a dense, hardened metallic ball and bait the centipede into biting, hoping the sharp shards will lodge in its mandibles.]\n\n Utilize \"Gel-Slide\" to coat the cavern floor in slippery slime, forcing the multi-legged centipede to lose its footing during its charge.]', '[\"[Aggressive\",\"[Defensive\",\"[Evasive\"]', NULL, '2026-04-03 22:34:47'),
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
(1, 'Small Lesser Taratect', 'Small Taratect', 10, 'A balanced spider body with improved speed and thread production.'),
(2, 'Small Lesser Taratect', 'Small Poison Taratect', 10, 'Unlocks advanced Poison Synthesis but reduces physical defense.');

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
(1, 'elroe_upper', 'elroe_middle', 'DOWN', 1),
(2, 'elroe_middle', 'elroe_upper', 'UP', 1),
(3, 'elroe_middle', 'elroe_lower', 'DOWN', 1),
(4, 'elroe_lower', 'elroe_middle', 'UP', 1),
(5, 'elroe_lower', 'magma_layer', 'DOWN', 1),
(6, 'magma_layer', 'elroe_lower', 'UP', 1),
(7, 'magma_layer', 'ash_tunnels', 'DOWN', 1),
(8, 'ash_tunnels', 'magma_layer', 'UP', 1),
(9, 'elroe_upper', 'webbed_hollows', 'LEFT', 1),
(10, 'webbed_hollows', 'elroe_upper', 'RIGHT', 1),
(11, 'elroe_upper', 'fungus_grotto', 'RIGHT', 1),
(12, 'fungus_grotto', 'elroe_upper', 'LEFT', 1),
(13, 'elroe_lower', 'corpse_pit', 'LEFT', 1),
(14, 'corpse_pit', 'elroe_lower', 'RIGHT', 1),
(15, 'elroe_lower', 'dragon_breach', 'RIGHT', 1),
(16, 'dragon_breach', 'elroe_lower', 'LEFT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `location_seeds`
--

CREATE TABLE `location_seeds` (
  `location_id` varchar(50) NOT NULL,
  `description_seed` text DEFAULT NULL,
  `location_image` varchar(255) DEFAULT NULL,
  `danger_level` int(11) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT 'elroe_labyrinth',
  `level_depth` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_seeds`
--

INSERT INTO `location_seeds` (`location_id`, `description_seed`, `location_image`, `danger_level`, `region_name`, `level_depth`) VALUES
('ash_tunnels', 'A suffocating network of tunnels filled with ash and smoke. Visibility is nearly zero, and breathing becomes a challenge. This is near-death territory.', 'http://localhost:7000/uploads/generic_1775338140044-109446823.png', 10, 'elroe_labyrinth', 4),
('corpse_pit', 'A feeding ground filled with rotting carcasses. Scavengers and predators gather here, creating constant conflict. The smell alone is overwhelming.', 'http://localhost:7000/uploads/generic_1775337601515-83449986.png', 8, 'elroe_labyrinth', 3),
('crystal_vein', 'A sharp, glowing cavern filled with crystal formations that hum with energy. Sound bends strangely here, and some creatures are drawn to its resonance.', 'http://localhost:7000/uploads/generic_1775337461034-28743475.png', 5, 'elroe_labyrinth', 2),
('dragon_breach', 'A broken cavern shaped by the movement of ancient dragons. Heat, pressure, and danger fill the air. This is not a place for the weak.', 'http://localhost:7000/uploads/generic_1775337760634-865578033.png', 9, 'elroe_labyrinth', 3),
('elroe_lower', 'Lower Elroe Labyrinth: A hellish, cavernous landscape teeming with earth dragons and venomous beasts.', 'http://localhost:7000/uploads/generic_1775337397083-148064841.png', 7, 'elroe_labyrinth', 2),
('elroe_middle', 'A transitional layer where tunnels widen and dangers increase. Echoes travel far, and predators roam between upper and lower layers. This is where survival becomes strategy.', 'http://localhost:7000/uploads/generic_1775336809832-102049221.png', 4, 'elroe_labyrinth', 1),
('elroe_upper', 'A sprawling network of dark, damp limestone caves. Weak monsters roam here, but survival is not guaranteed. Sticky webs line the ceilings, and the sound of distant movement never stops.', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', 2, 'elroe_labyrinth', 0),
('fungus_grotto', 'A humid cavern glowing with bioluminescent fungi. Spores drift through the air, feeding scavengers and poison-based creatures. Some fungi heal others kill.', 'http://localhost:7000/uploads/generic_1775336277019-933342202.png', 3, 'elroe_labyrinth', 1),
('magma_layer', 'Rivers of flowing lava cut through this region. The heat is unbearable, and only creatures adapted to extreme environments survive.', 'http://localhost:7000/uploads/generic_1775337971407-462015717.png', 9, 'elroe_labyrinth', 3),
('water_stratum', 'A flooded section of the labyrinth filled with underground streams and submerged tunnels. Visibility is low, and movement is slowed. Creatures here rely on vibration and sound.', 'http://localhost:7000/uploads/generic_1775337006193-800054934.png', 5, 'elroe_labyrinth', 2),
('webbed_hollows', 'A dense cluster of tunnels overtaken by spider colonies. Thick silk webs stretch across entire chambers, and egg sacs hang silently above. Movement is dangerous — and often noticed.', 'http://localhost:7000/uploads/generic_1775336056813-119887663.png', 3, 'elroe_labyrinth', 1);

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
(1, 'Small Lesser Taratect', 'MONSTER', 20, 5, 2, 1, 'F', 'A weak spider hatchling.', NULL),
(2, 'Elroe Frog', 'BEAST', 45, 12, 8, 3, 'E', 'Spits acidic venom.', NULL),
(3, 'Anogatch', 'MONSTER', 120, 45, 30, 10, 'B', 'A huge monkey-like creature that hunts in packs.', NULL),
(4, 'Earth Dragon Araba', 'DRAGON', 8000, 4500, 4000, 35, 'S', 'The apex predator of the Lower Stratum.', NULL);

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
(1, 'Shun', 'Schlain', 'Human (Hero Title)', 'royal_capital', 'Training at the Royal Academy. Acquired [Divine Magic].', 1),
(2, 'Shinohara', 'Feirune', 'Earth Dragon', 'elroe_upper', 'Wandering the upper labyrinth looking for food.', 1),
(3, 'Wakaba', 'D', 'Unknown', 'unknown', 'Watching the labyrinth with amusement.', 1);

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
  `permanent_skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permanent_skills`)),
  `death_count` int(11) DEFAULT 0,
  `skill_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soul_library`
--

INSERT INTO `soul_library` (`user_id`, `soul_rank`, `accumulated_karma`, `permanent_skills`, `death_count`, `skill_points`) VALUES
(1, 1, 0, '[\"Night Vision\",\"Thread Manipulation\",\"Camouflage\",\"Thread Craft\"]', 0, 0),
(2, 1, 0, '[]', 0, 0),
(3, 1, 0, '[]', 0, 0),
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
(1, 'Scavenger', 'Small Lesser Taratect', 10, 10, 'elroe_upper', NULL, 6, 4, 8, 5, 12, 100, 20),
(2, 'Scavenger', 'Cave Centipede', 15, 5, 'elroe_upper', NULL, 8, 6, 2, 4, 10, 100, 20),
(3, 'Scavenger', 'Scrap Slime', 20, 20, 'elroe_upper', NULL, 4, 10, 12, 12, 3, 100, 20),
(4, 'Scavenger', 'Spectral Mite', 8, 25, 'elroe_upper', NULL, 3, 2, 15, 10, 14, 100, 20),
(5, 'Predator', 'Wolf Pup', 20, 5, 'elroe_upper', NULL, 12, 6, 2, 4, 15, 100, 20),
(6, 'Predator', 'Lesser Fire Wyrm', 25, 10, 'magma_layer', NULL, 14, 8, 10, 8, 10, 100, 20),
(7, 'Predator', 'Venomous Hatchling', 22, 12, 'elroe_lower', NULL, 11, 5, 6, 5, 13, 100, 20),
(8, 'Predator', 'Shadow Bat', 18, 15, 'elroe_upper', NULL, 7, 4, 9, 6, 18, 100, 20),
(9, 'Prey', 'Weakling Rat', 5, 5, 'elroe_upper', NULL, 3, 2, 1, 2, 8, 100, 20),
(10, 'Prey', 'Crystalline Snail', 40, 30, 'magma_layer', NULL, 5, 25, 10, 20, 1, 100, 20),
(11, 'Prey', 'Cave Bat', 8, 8, 'elroe_upper', NULL, 4, 3, 5, 4, 12, 100, 20),
(12, 'Prey', 'Blind Cave Salamander', 30, 10, 'water_stratum', NULL, 6, 12, 4, 15, 5, 100, 20),
(13, 'Predator', 'Human', 55, 15, 'royal_capital', NULL, 12, 8, 5, 5, 5, 100, 35),
(14, 'Prey', 'Human', 45, 30, 'royal_capital', NULL, 6, 12, 5, 5, 5, 100, 25),
(15, 'Scavenger', 'Dwarf', 80, 10, 'iron_forge', NULL, 14, 20, 5, 5, 5, 120, 45);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'player',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `system_voice` varchar(20) DEFAULT 'ADMIN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password_hash`, `role`, `created_at`, `system_voice`) VALUES
(1, '8amlight@gmail.com', 'light', '$2b$10$XYlXKzvMUZnO.hYgvGPd8.K/PyBsEkJxR2TxGa3ykjWKPsEeNyQ4G', 'player', '2026-04-03 18:11:06', 'ADMIN'),
(2, '8amjoker@gmail.com', 'joker', '$2b$10$KdHV2FZUFHeVTBn.F202Gu5UvetTetwIqXSdJVLV5lUXBMYgK95yW', 'player', '2026-04-03 20:38:39', 'ADMIN'),
(3, 'admin@admin.com', 'god', '$2b$10$yzahJBWCcGAa76.lFLzvsOquEc3nvk8j/6fw8oWBt5Iq9IVGugExq', 'admin', '2026-04-03 23:13:02', 'ADMIN'),
(4, 'oghenesupersam914@gmail.com', 'sam', '$2b$10$qSORTKmr2y/Fst3sskTeZul1G.bscCXuiEoAUJooCZrqVWSp.yJyy', 'player', '2026-04-04 01:42:30', 'ADMIN');

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
(1, 'elroe_upper', 1, 90),
(2, 'elroe_upper', 2, 25),
(3, 'elroe_upper', 3, 10),
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
-- Indexes for table `master_npcs`
--
ALTER TABLE `master_npcs`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

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
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `active_encounters`
--
ALTER TABLE `active_encounters`
  MODIFY `encounter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `current_life`
--
ALTER TABLE `current_life`
  MODIFY `life_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
-- AUTO_INCREMENT for table `location_connectors`
--
ALTER TABLE `location_connectors`
  MODIFY `connector_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `master_npcs`
--
ALTER TABLE `master_npcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
