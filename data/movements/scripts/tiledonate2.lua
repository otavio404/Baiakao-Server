function onStepIn(cid, item, position, fromPosition, toPosition)

local config ={
tp = {x=4904, y=662, z=6},
msg = "Bem Vindo a area donate!",
}

	if isPremium(cid) then
		doTeleportThing(cid, config.tp)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, config.msg)
	else
		doTeleportThing(cid, fromPosition)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Somente players Premium Account podem descer está escada.")
	end
	return true
end