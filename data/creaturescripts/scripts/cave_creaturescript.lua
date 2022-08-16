function onLogin(cid)
	registerCreatureEvent(cid, "caveExclusivaDeath")
	if getPlayerStorageValue(cid, caveExclusiva.storages.cave) > 0 then
		local cave = getPlayerStorageValue(cid, caveExclusiva.storages.cave)
		local timeLeft = getPlayerStorageValue(cid, caveExclusiva.storages.time) - os.time()
		
		if getGlobalStorageValue(caveExclusiva.caves[cave].gStor) ~= getPlayerGUID(cid) or timeLeft <= 0 then
			setPlayerStorageValue(cid, caveExclusiva.storages.cave, 0)
			setPlayerStorageValue(cid, caveExclusiva.storages.time, 0)
			
			if getPlayerStorageValue(cid, caveExclusiva.storages.inCave) > 0 then	
				setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
				doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, caveExclusiva.config.timeLeftMessageInCave:format(caveExclusiva.caves[cave].caveName))
			end	
		end
	end
	return true
end

function onDeath(cid, corpse, deathList)
	if getPlayerStorageValue(cid, caveExclusiva.storages.inCave) > 0 then
		setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
	end
	return true
end