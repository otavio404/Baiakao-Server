function onUse(cid, item, fromPosition, itemEx, toPosition)
	if #getPlayersInArena(Arena_system_easy.area.from,Arena_system_easy.area.to) > 0 then
		doPlayerSendCancel(cid, 'Alguem Ja Esta Na Arena.')
		doSendMagicEffect(getThingPos(cid), 2) return true
	end
	local players = getPlayersOnEasyLevers(Arena_system_easy.levers[1], Arena_system_easy.levers[2])
	if #players == 0 then
		doPlayerSendCancel(cid, 'Um ou mais jogadores precisam estar na posição.')
		doSendMagicEffect(getThingPos(cid), 2) return true 
	end
	if not isInArray(players, cid) then
		doPlayerSendCancel(cid, 'Voce tem que estar posicionado no tile para usar a alavanca.')
		doSendMagicEffect(getThingPos(cid), 2) return true 
	end
	for _, pid in pairs(players) do
		if not isPlayer(pid) or getPlayerStorageValue(pid, Arena_system_easy.storage_ex) - os.time() > 0 then
			doPlayerSendCancel(cid, 'O jogador '..getPlayerName(pid)..' precisa esperar para ir na arena novamente.') return true
		elseif getPlayerLevel(pid) < Arena_system_easy.level.min or getPlayerLevel(pid) > Arena_system_easy.level.max then
			doPlayerSendCancel(cid, 'O jogador '..getPlayerName(pid)..' precisa ter level entre '..Arena_system_easy.level.min..' e '..Arena_system_easy.level.max..' para participar da arena .') return true 
		end
	end
	setGlobalStorageValue(Arena_system_easy.storages[1], 1)
	setGlobalStorageValue(Arena_system_easy.storages[2], os.time()+(120+Arena_system_easy.respawntime))
	setGlobalStorageValue(Arena_system_easy.storages[3], 0)
	addEvent(doKickPlayerArena, (120000+Arena_system_easy.respawntime*1000), 1, Arena_system_easy.area.from,Arena_system_easy.area.to) 
	HaveCreatureArena({Arena_system_easy.area.from,Arena_system_easy.area.to}, true, true)
	addEvent(doSpanwMonster,Arena_system_easy.respawntime*1000, Arena_system_easy.area.from, Arena_system_easy.area.to, Arena_system_easy.easy_waves[getGlobalStorageValue(Arena_system_easy.storages[1])], true)
	for _, cid in pairs(players) do
		doTeleportThing(cid, Arena_system_easy.enter_pos)
		doPlayerSendTextMessage(cid, 21, '{Arena System} A wave N° 1 irá começar em '..Arena_system_easy.respawntime..' Segundos, preparem-se!')
		setPlayerStorageValue(cid, Arena_system_easy.storage_ex, os.time()+Arena_system_easy.hours*3600)
	end 
	return doTransformItem(item.uid, item.itemid % 2 == 1 and item.itemid+1 or item.itemid-1)
end