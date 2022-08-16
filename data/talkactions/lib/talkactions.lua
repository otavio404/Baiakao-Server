dofile('data/talkactions/lib/instance.lua')
dofile('data/talkactions/lib/war.lua')

-- Prevent spamm commands --
function checkExhausted(cid, storage, seconds)
	local v = exhaustion.get(cid, storage)
	if(not v) then
		exhaustion.set(cid, storage, seconds)
	else
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Espere " .. v .. " segundos para usar o comando novamente.")
		return false
	end

	return true
end
