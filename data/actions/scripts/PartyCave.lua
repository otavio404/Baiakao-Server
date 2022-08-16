local config = {
    items = { -- {position = posição_do_item, itemid = id_do_item},
        {position = {x = 561, y = 63, z = 14}, itemid = 8601}, -- Paladin Party
        {position = {x = 561, y = 73, z = 14}, itemid = 5803}, -- Knight Party
        {position = {x = 556, y = 68, z = 14}, itemid = 2349}, -- Druid Party
		{position = {x = 566, y = 68, z = 14}, itemid = 2112}  -- Sorcerer Party
        --etc
    },
    players = {
        {position = {x = 561, y = 72, z = 14}, toPos = {x = 2284, y = 1137, z = 6}, vocation = {3, 7}},  -- Paladin {position = posi?_do_jogador, toPos = posi?_final, vocation = ID_das_voca?s},
        {position = {x = 561, y = 64, z = 14}, toPos = {x = 2285, y = 1138, z = 6}, vocation = {4, 8}},  -- Knight 
        {position = {x = 557, y = 68, z = 14}, toPos = {x = 2284, y = 1138, z = 6}, vocation = {2, 6}},  -- Druid
		{position = {x = 565, y = 68, z = 14}, toPos = {x = 2285, y = 1137, z = 6}, vocation = {1, 5}}	  -- Sorcerer
        --etc
    }
}
 
function onUse(cid)
    local items, quest_players = {}, {}
    for _, item in pairs(config.items) do
        local position_item = getTileItemById(item.position, item.itemid).uid
        if position_item > 0 then
            table.insert(items, position_item)
        else
            return doPlayerSendCancel(cid, "Certifique-se de que todos os itens estão posicionados corretamente.")
        end
    end
    for _, player in pairs(config.players) do
        local pid = getTopCreature(player.position).uid
        if isPlayer(pid) and isInArray(player.vocation, getPlayerVocation(pid)) then
            table.insert(quest_players, pid)
        else
            return doPlayerSendCancel(cid, "Estão faltando jogadores ou estão em suas posições erradas.")
        end
    end
    for i = 1, #items do
        doRemoveItem(items[i])
    end
    for i = 1, #quest_players do
        doPlayerSendTextMessage(quest_players[i], MESSAGE_INFO_DESCR, "Congratulations!!")
        doTeleportThing(quest_players[i], config.players[i].toPos)
		doSendMagicEffect(config.players[i].toPos,CONST_ME_TELEPORT)
    end
    return true
end
 