function onLogout(cid)
    if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) == 1 then
		AntiEntrosa:removePlayersOutside(cid, nil, true)
    end
    return true
end

function onDeath(cid, corpse)
	if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) == 1 then
		AntiEntrosa:removePlayersOutside(cid, nil, true)
	end
	return true
end