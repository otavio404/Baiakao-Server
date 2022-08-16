function onUse(cid, item, frompos, item2, topos)
    local skull = getCreatureSkullType(cid)
    local bad_skulls = {SKULL_RED,SKULL_BLACK}    
    if getTileInfo(getThingPos(cid)).protection == false then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Voce nao pode remover seu skull nesta area.")
    return false
            elseif isInArray(bad_skulls, skull) == true then
                doPlayerSetSkullEnd(cid, 0, skull)
                doRemoveItem(item.uid, 1)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Seu skull foi removido com sucesso.")
            else
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce nao tem black/red skull para ser removido.")
            end
    return true
end