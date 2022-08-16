local storage = 19387
local tempo = 20 * 60
local minutes = 2

local bosses = {
    ["King Insanity"] = {}
}

function onAttack(cid, target)
	local bid = bosses[getCreatureName(target)]
	if isMonster(target) and bid then
        	doPlayerSetStorageValue(cid, storage, getPlayerStorageValue(cid, storage)+1)
		if getPlayerStorageValue(cid, storage) >= tempo then
			doPlayerAddStamina(cid, minutes)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "Você recuperou 5 minutos de sua Stamina.")
			doPlayerSetStorageValue(cid, storage, 0)
		end
    	end
   return true
end