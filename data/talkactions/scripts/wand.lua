local nme = "wand"
local storage = 722656

local storages = {
	
	["ice"] = 10,
	["earth"] = 11,
	["holy"] = 12,
	["energy"] = 13,
	["cake"] = 14,
	["fire"] = 15

}

local effects = {
	
	[10] = {dist = CONST_ANI_ICE, hit = CONST_ME_ICEATTACK},
	[11] = {dist = CONST_ANI_EARTH, hit = CONST_ME_CARNIPHILA},
	[12] = {dist = CONST_ANI_HOLY, hit = CONST_ME_HOLYDAMAGE},
	[13] = {dist = CONST_ANI_ENERGYBALL, hit = CONST_ME_PURPLEENERGY},
	[14] = {dist = CONST_ANI_CAKE, hit = CONST_ME_CAKE},
	[15] = {dist = CONST_ANI_FIRE, hit = CONST_ME_FIREATTACK}

}

function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	if not param or param == "" then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[Wand Effect] "..gTm(cid,nme,1).."\n\n!wand ice\n!wand holy\n!wand energy\n!wand fire\n!wand cake\n!wand earth")
		return true
	end

	local value = storages[param:lower()]
	if value then
		if (isSorcerer(cid) or isDruid(cid)) and getPlayerItemCount(cid, 2433) > 0 then
			if value ~= getCreatureStorage(cid, storage) then
				if getCreatureStorage(cid, 722657) < os.time() then
					doCreatureSetStorage(cid, storage, value)
					doSendMagicEffect(getThingPos(cid), effects[value].hit)
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[Wand Effect] "..gTm(cid,nme,2).." "..param:lower().."!")
					doCreatureSetStorage(cid, 722657, os.time() + 10)
				else
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Wand Effect] "..gTm(cid,nme,3))
					doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
				end
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Wand Effect] "..gTm(cid,nme,4).." "..param:lower()..".")
				doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Wand Effect] "..gTm(cid,nme,6))
			doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "[Wand Effect] "..gTm(cid,nme,5))
		doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
	end
	return true
end
