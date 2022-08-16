local storage_vip = 88888

function onStepIn(cid, item, position, fromPosition)
	if not isPlayer(cid) then
		return false
	end
	
	if (getPlayerStorageValue(cid, storage_vip) >= 1) then
		doSendMagicEffect(getThingPos(cid), 12)
	else
		doTeleportThing(cid, fromPosition)
		doSendMagicEffect(getThingPos(cid), 2)
		doPlayerSendTextMessage(cid, 22, "Voce nao tem acesso a VIP2! Fale !buyvip2 e compre o acesso dela.")
		return true
	end
	return true
end