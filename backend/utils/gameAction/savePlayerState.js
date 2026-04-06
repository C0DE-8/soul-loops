// backend/utils/gameAction/savePlayerState.js
async function saveUpdatedPlayerState({ db, player, finalHp, isAlive }) {
    const updateLifeParams = [
        finalHp,
        Number(player.xp || 0),
        Number(player.current_level || 1),
        Number(player.max_hp || finalHp),
        Number(player.next_level_xp || 100),
        Number(player.offense || 1),
        Number(player.defense || 1),
        Number(player.hunger || 0),
        Number(player.sp || 0),
        player.current_location,
        isAlive ? 1 : 0,
        player.inventory,
        player.home_base,
        player.life_id
    ];

    await db.execute(
        `UPDATE current_life
         SET hp = ?, xp = ?, current_level = ?, max_hp = ?, next_level_xp = ?,
             offense = ?, defense = ?, hunger = ?, sp = ?,
             current_location = ?, is_alive = ?,
             inventory = ?, home_base = ?
         WHERE life_id = ?`,
        updateLifeParams
    );
}

module.exports = { saveUpdatedPlayerState };