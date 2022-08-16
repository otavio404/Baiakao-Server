function onUse(cid, item, fromPosition, itemEx, toPosition)
    if itemEx.itemid == caveExclusiva.config.buyItemID then
      if getPlayerLevel(cid) > 550 then
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você não pode mais usar este item. O level permitido para o uso do item é até 550.")
           doSendAnimatedText(getPlayerPosition(cid), "Failed!", 180)
           doTeleportThing(cid,{x=152, y=53,z=7})
    return false
    end
        if getPlayerStorageValue(cid, caveExclusiva.storages.cave) > 0 then
            local caveName = caveExclusiva.caves[getPlayerStorageValue(cid, caveExclusiva.storages.cave)].caveName
            local timeLeft = getPlayerStorageValue(cid, caveExclusiva.storages.time) - os.time()
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você já é dono da cave de ".. caveName ..", aguarde ".. getTimeString(timeLeft) .." para comprar uma cave novamente.")
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        elseif getGlobalStorageValue(caveExclusiva.caves[itemEx.aid].gStor) > 0 then
            local ownerGUID = getGlobalStorageValue(caveExclusiva.caves[itemEx.aid].gStor)
            local ownerTimeLeft = nil
            if isPlayerOnline(getPlayerNameByGUID(ownerGUID)) then
                ownerTimeLeft = getPlayerStorageValue(getPlayerByGUID(ownerGUID), caveExclusiva.storages.time) - os.time()
            else
                ownerTimeLeft = getOfflinePlayerStorage(ownerGUID, caveExclusiva.storages.time) - os.time()
            end
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Esta cave já pertence ao player ".. getPlayerNameByGUID(ownerGUID) ..", restam ".. getTimeString(ownerTimeLeft) .." para a cave estar livre novamente.")
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
        else
            caveExclusiva.setCaveTo(cid, itemEx.aid)
            doSendMagicEffect(getThingPos(cid), CONST_ME_FIREWORK_BLUE)
            doRemoveItem(item.uid)      
        end
    end
    return true
end