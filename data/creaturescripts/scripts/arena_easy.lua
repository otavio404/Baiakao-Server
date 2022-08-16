function onLogin(cid)
	registerCreatureEvent(cid, "EasyArenaDeath")
	registerCreatureEvent(cid, "EasyArenaCombat")
	if isInRange(getPlayerPosition(cid),Arena_system_easy.area.from,Arena_system_easy.area.to) then
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
	end
	return true
end
function onCombat(cid, target)
	if isPlayer(cid) and isPlayer(target) and isInRange(getPlayerPosition(cid), Arena_system_easy.area.from, Arena_system_easy.area.to) then
		doPlayerSendCancel(cid, "You may not attack this player.") return false	
	end
	return true
end
function onPrepareDeath(cid, killers)
	if isInRange(getPlayerPosition(cid),Arena_system_easy.area.from,Arena_system_easy.area.to) then
		doCreatureAddHealth(cid, getCreatureMaxHealth(cid), 65535, 256, true)
		doRemoveConditions(cid, false)
		doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
		local wave = getGlobalStorageValue(Arena_system_easy.storages[1])
		doPlayerSendTextMessage(cid, 21, 'Parabéns! Você sobreviviu até a '..wave..'° wave!.')
		if Arena_system_easy.rewards_per_waves.exp > 0 then doPlayerAddExp(cid, Arena_system_easy.rewards_per_waves.exp*wave) end
		if Arena_system_easy.rewards_per_waves.money > 0 then doPlayerAddMoney(cid, Arena_system_easy.rewards_per_waves.money*wave) end 
		return false
	end
	return true
end