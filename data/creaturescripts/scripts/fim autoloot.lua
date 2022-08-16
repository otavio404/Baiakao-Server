function onLogin(cid)
    if not isPremium(cid) then
        local active_slots = getPlayerStorageValue(cid, 04420011)
        if active_slots >= 1 then
            for i = 1, active_slots do
                doPlayerSetStorageValue(cid, (04420031 + (i * 10)), -1)
                doPlayerSetStorageValue(cid, 04420011, active_slots - 1)
            end
        end
    end
    return true
end