function onMoveItem(cid, item, count, toContainer, fromContainer, fromPos, toPos)
    local item = 2160
    if item.itemid == item and getPlayerAccess(cid) < 5 then
        return doPlayerSendCancel(cid, 'You are not allowed to move this item.') and false
    end
    
    return true
end