local exit_daily = {x = 1016, y = 588, z = 9}
local reward = {
	[0] = {id = 12849, amount = 1, chance = 10}, -- Stamina Refiller
	[1] = {id = 12804, amount = 1, chance = 15}, -- Dodge
	[2] = {id = 12805, amount = 1, chance = 20}, -- Critical
	[3] = {id = 12686, amount = 1, chance = 40}, -- Event Coin
	[4] = {id = 12713, amount = 1, chance = 50}, -- Holy Icon (2 charges)
	[5] = {id = 2160, amount = 15, chance = 100}, -- 150k
}

local function convertTime(a)
  if(type(tonumber(a)) == "number" and a > 0) then
    if (a <= 3599) then
      local minute = math.floor(a/60)
      local second = a - (60 * minute)
      if(second == 0) then
        return ((minute)..((minute > 1) and " minutos" or " minuto"))
      else
        return ((minute ~= 0) and ((minute>1) and minute.." minutos e " or minute.." minuto e ").. ((second>1) and second.." segundos" or second.." segundo") or ((second>1) and second.." segundos" or second.. " segundo"))
      end
    else
      local hour = math.floor(a/3600)
      local minute = math.floor((a - (hour * 3600))/60)
      local second = (a - (3600 * hour) - (minute * 60))
      if (minute == 0 and second > 0) then
        return (hour..((hour > 1) and " horas e " or " hora e "))..(second..((second > 1) and " segundos" or " segundo"))
      elseif (second == 0 and minute > 0) then
        return (hour..((hour > 1) and " horas e " or " hora e "))..(minute..((minute > 1) and " minutos" or " minuto"))
      elseif (second == 0 and minute == 0) then
        return (hour..((hour > 1) and " horas" or " hora"))
      end
      return (hour..((hour > 1) and " horas, " or " hora, "))..(minute..((minute > 1) and " minutos e " or " minuto e "))..(second..((second > 1) and " segundos" or " segundo"))
    end
  end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (item.actionid == 45362) then
		if getPlayerFreeCap(cid) < 105.00 then
			return doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "Você precisa ter mais que '105.00 oz' para abrir o baú, por segurança.")
		end
		
		if getPlayerStorageValue(cid, 45358) - os.time() >= 0 then
			doTeleportThing(cid, exit_daily)
			doSendMagicEffect(getCreaturePosition(cid), 12)
			return doPlayerSendTextMessage(cid, 27, "Seu tempo para Daily ainda não expirou! Você não deveria estar nesta SALA!!")
		end
		
		local rand = math.random(1,100)
		for i = 0, #reward do
			if (reward[i].chance > rand) then
				if doPlayerAddItem(cid, reward[i].id, reward[i].amount) then
					doTeleportThing(cid, exit_daily)
					doSendMagicEffect(toPosition, CONST_ME_MAGIC_GREEN)
					setPlayerStorageValue(cid, 45358, os.time()+20*60*60)
					return doPlayerSendTextMessage(cid, 27, "Você finalizou a Daily Quest e recebeu um item. Poderá fazer a Daily novamente em: ".. convertTime(getPlayerStorageValue(cid, 45358) - os.time()) ..".")
				else
					return doPlayerPopupFYI(cid, "                                  [+] Daily Quest [+]\n\nVocê está sem espaço em sua backpack. Libere espaço.\nSe continuar clicando poderá perder sua DAILY!")
				end
			end
		end
	end
    return true
end