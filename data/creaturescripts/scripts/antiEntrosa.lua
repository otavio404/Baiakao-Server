function onLogin(cid)
	if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) == 1 then
		AntiEntrosa:removePlayersOutside(cid, "[War Anti-Entrosa] Você foi removido do Anti-Entrosa.", true)
	end

	local playerGuild = getPlayerGuildId(cid)
	local warInfo = AntiEntrosa:warInfo(playerGuild)
	if warInfo then
		local arenaId = AntiEntrosa:getWarIdByGuild(playerGuild)
		if arenaId then
			local warArea = AntiEntrosa:warInfoById(arenaId)
			if warArea and warArea.warUntil ~= 0 and warArea.warUntil > os.time() then
				local cityName = warArea.cityName
				local enemyGuild = warArea.invitedGuild == playerGuild and warArea.enemyGuild  or warArea.invitedGuild

				local enemyGuildName = getGuildNameById(enemyGuild) 
				doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string.format("[War Anti-Entrosa] Sua guild está em guerra contra a Guild %s em %s. Utilize o comando: !citywar go", enemyGuildName, cityName))
			end
		end
	end

	return true
end

function onDeath(cid, corpse, deathList)
	if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) ~= 1 then
		return true
	end

	AntiEntrosa:removePlayersOutside(cid)
	return true
end

function onMoveItem(moveItem, frompos, position, cid)
	if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) ~= 1 then
		return true
	end

	if getPlayerStorageValue(cid, ANTIENTROSA_BLOCK_SSAMIGHTRING) ~= 1 then
		return true
	end

	if moveItem.itemid == 2164 or moveItem.itemid == 2197 then
		doPlayerSendCancel(cid, "[War Anti-Entrosa] Você não pode mover esse item dentro do Anti-Entrosa.")
		return false
	end

	return true
end