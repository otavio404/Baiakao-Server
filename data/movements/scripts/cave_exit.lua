function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	if getPlayerStorageValue(cid, caveExclusiva.storages.inCave) > 0 then
		setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
	end
	return true
end