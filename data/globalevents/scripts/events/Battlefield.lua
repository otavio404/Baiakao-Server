function onTime ()
	doItemSetAttribute(doCreateItem(1387, 1, {x = 151, y = 43, z = 7, stackpos = 1}), "aid", 2138)
	doBroadcastMessage("[BattleField] starting in 3 minutes! The teleport will be closed when the event start!", MESSAGE_EVENT_ADVANCE)
	setGlobalStorageValue(414, 0)
	setGlobalStorageValue(415, 0)
	addEvent(startBattlefield, 3 * 60 * 1000)
	return true
end

function startBattlefield()
	doRemoveItem(getTileItemById({x = 151, y = 43, z = 7}, 1387).uid, 1)
	if getGlobalStorageValue(414) > 0 and getGlobalStorageValue(415) > 0 then
		doBroadcastMessage("[BattleField] has started! The teleport has closed!", MESSAGE_EVENT_ADVANCE)		
		for _, cid in ipairs(getPlayersOnline()) do
			if getPlayerStorageValue(cid, 501) > 0 or getPlayerStorageValue(cid, 502) > 0 then
				doCreatureSetNoMove(cid, false)
			end
		end
	else
		doBroadcastMessage("[BattleField] hasn\'t started beacuse there were not enough players.", MESSAGE_EVENT_ADVANCE)
		for _, cid in ipairs(getPlayersOnline()) do
			if getPlayerStorageValue(cid, 501) > 0 or getPlayerStorageValue(cid, 502) > 0 then
				doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
				doCreatureSetNoMove(cid, false)
			end
		end
	end
	return true
end