local storage_vip = 88889

function onStepIn(cid, item, position, fromPosition)
	if not isPlayer(cid) then
		return false
	end
	
	if (getPlayerStorageValue(cid, storage_vip) >= 1) then
		doSendMagicEffect(getThingPos(cid), 12)
	else
		doTeleportThing(cid, fromPosition)
		doSendMagicEffect(getThingPos(cid), 2)
		doPlayerSendTextMessage(cid, 22, "Voce nao tem acesso a VIP3! Faca a quest para ter acesso a ela.")
		return true
	end
	return true
end