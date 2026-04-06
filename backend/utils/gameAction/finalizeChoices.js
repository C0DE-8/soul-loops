// backend/utils/gameAction/finalizeChoices.js

function shuffleArray(arr = []) {
    const copy = [...arr];
    for (let i = copy.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [copy[i], copy[j]] = [copy[j], copy[i]];
    }
    return copy;
}

function finalizeChoicesAndStatus({ aiResponse, monsterButtons, player }) {
    let finalHp = Math.max(0, Number(player.hp || 0));
    let isAlive = true;

    // 1. Parse HP from AI Response
    const hpM = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
    if (hpM) finalHp = parseInt(hpM[1], 10);

    // 2. Determine Life Status
    if (finalHp <= 0 || aiResponse.includes("[STATUS: DECEASED]")) {
        isAlive = false;
        finalHp = 0;
    }

    // 3. Clean the story text early
    const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();

    // ==========================================
    // 4. DEATH OVERRIDE (THE "ZOMBIE" FIX)
    // ==========================================
    if (!isAlive) {
        return {
            finalHp,
            isAlive,
            finalChoices: ["[SYSTEM] Accept Death and Enter the Soul Stream"],
            cleanStory
        };
    }

    // ==========================================
    // 5. LIVING PLAYER CHOICE LOGIC
    // ==========================================
    const aiChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
        .map(m => m[1])
        .filter(Boolean)
        .map(choice => String(choice).trim());

    let allChoices = [];

    // If we are in a fight, filter out non-combat AI choices
    if (monsterButtons && monsterButtons.length > 0) {
        const combatAiChoices = aiChoices.filter(c => 
            c.toLowerCase().includes("attack") || 
            c.toLowerCase().includes("defend") || 
            c.toLowerCase().includes("risk") ||
            c.toLowerCase().includes("skill") ||
            c.toLowerCase().includes("beast")
        );
        allChoices = [...monsterButtons, ...combatAiChoices];
    } else {
        allChoices = [...aiChoices];
    }

    // 6. Clean, deduplicate, shuffle, and slice
    const uniqueChoices = [...new Set(allChoices.filter(Boolean).map(c => String(c).trim()))];
    const shuffledChoices = shuffleArray(uniqueChoices);
    const finalChoices = shuffledChoices.slice(0, 4);

    return {
        finalHp,
        isAlive,
        finalChoices,
        cleanStory
    };
}

module.exports = { finalizeChoicesAndStatus };