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

    const hpM = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
    if (hpM) finalHp = parseInt(hpM[1], 10);

    if (finalHp <= 0 || aiResponse.includes("[STATUS: DECEASED]")) {
        isAlive = false;
        finalHp = 0;
    }

    const aiChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
        .map(m => m[1])
        .filter(Boolean)
        .map(choice => String(choice).trim());

    const allChoices = [...monsterButtons, ...aiChoices]
        .filter(Boolean)
        .map(choice => String(choice).trim());

    const uniqueChoices = [...new Set(allChoices)];
    const shuffledChoices = shuffleArray(uniqueChoices);
    const finalChoices = shuffledChoices.slice(0, 4);

    const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();

    return {
        finalHp,
        isAlive,
        finalChoices,
        cleanStory
    };
}

module.exports = { finalizeChoicesAndStatus };