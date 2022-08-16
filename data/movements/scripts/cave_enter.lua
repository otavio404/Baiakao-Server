function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
	local caves = caveExclusiva.getCavesID()
	if isInArray(caves, item.aid) then
		if getGlobalStorageValue(caveExclusiva.caves[item.aid].gStor) ~= getPlayerGUID(cid) then
			doPlayerSendCancel(cid, "Você não é dono desta cave, compre para entrar.")
			doSendMagicEffect(position, CONST_ME_MAGIC_RED)
			doTeleportThing(cid, fromPosition)
		else
			doSendMagicEffect(position, CONST_ME_TELEPORT)
			doSendMagicEffect(toPosition, CONST_ME_TELEPORT)
			doTeleportThing(cid, caveExclusiva.caves[item.aid].enterPos)
			setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 1)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você entrou na sua cave de ".. caveExclusiva.caves[item.aid].caveName ..".")
		end
	end
	return true
end

