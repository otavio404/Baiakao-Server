function onTimer()
    if #getPlayersOnline() > 0 then
        for _, cid in ipairs(getPlayersOnline()) do
            if isPremium(cid) and getPlayerStorageValue(cid, 78945) <= 0 then
                setPlayerStorageValue(cid,78945, 1)
            elseif not isPremium(cid) and getPlayerStorageValue(cid, 78945) > 0 then
                doPlayerSetTown(cid, 1)
                doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
                setPlayerStorageValue(cid, 78945, -1)
                doRemoveCreature(cid)
            end
        end
    end
    return true
end