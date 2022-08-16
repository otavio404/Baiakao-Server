function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end

	local playerGuild, p = getPlayerGuildId(cid), string.explode(param,",")
	if param == "" then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Comando inv�lido.")
		return true
	end

	if playerGuild <= 0 then
		doPlayerSendCancel(cid, "[War Anti-Entrosa] Voc� precisa estar em uma Guild para usar eses comando.")
		return true
	end

	if getPlayerLevel(cid) < 50 then
		doPlayerSendCancel(cid, "[War Anti-Entrosa] Voc� precisa ser no m�nimo level 50 para usar esse comando.")
		return true
	end

	local action = p[1]
	if action == "invite" then		
		if getPlayerGuildLevel(cid) < 3 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� precisa ser l�der da Guild para poder enviar um pedido de War.")
			return true
		end

		if AntiEntrosa:warInfo(playerGuild) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] A sua Guild j� est� em uma War no Anti-Entrosa, aguarde ela terminar.")
			return true
		end

		local cityName = p[2]
		if not cityName then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina um nome da cidade para o Anti-Entrosa.")
			return true
		end

		local arenaId = AntiEntrosa:arenaExists(cityName)
		if not arenaId then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] O nome dessa cidade n�o existe.")
			return true
		end

		local cityAvaliable = AntiEntrosa:arenaIsFree(arenaId)
		if not cityAvaliable then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Essa cidade n�o est� dispon�vel atualmente para War.")
			return true
		end

		-- Tempo em minutos da Wars 
		local timeWar = tonumber(p[3])
		if not timeWar then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina a tempo em minutos para cado lado.")
			return true
		elseif not isInArray(AntiEntrosa.timeAvaliable, timeWar) then
			local str = ''
			for i = 1, #AntiEntrosa.timeAvaliable do
				local time = AntiEntrosa.timeAvaliable[i]
				str = string.format('%s %d', str, time)
			end

			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, string.format('[War Anti-Entrosa] As op��es de tempo s�o apenas de %s. Por favor escolha um desses Tempos.', str))
			return true
		end

		-- Level m�nimo para entrar
		local minLevel = p[4]
		if not minLevel then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Por favor defina o level m�ximo dos players para o Anti-Entrosa.")
			return true
		else
			if (type(minLevel) == "string") then
				if minLevel:lower() == "disabled" then
					minLevel = false
				else
					minLevel = tonumber(minLevel)
				end

				if (type(minLevel) == "number") then
					if minLevel <= 0 then
						doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, '[War Anti-Entrosa] O level n�o pode ser negativo. Caso n�o queira limite, coloque "disabled".')
						return true
					end
				end
			else
				return true
			end
		end

		-- UE ativada?
		local ueEnabled = p[5]
		if not ueEnabled then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se UE estar� enabled ou disabled.")
			return true
		else
			ueEnabled = ueEnabled:lower()
			if ueEnabled == "enabled" then
				ueEnabled = true
			elseif ueEnabled == "disabled" then
				ueEnabled = false
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se UE � ou n�o permitido.")
				return true
			end
		end

		-- Runas ativadas? 
		local runesEnabled = p[6]
		if not runesEnabled then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se Runas estar�o enabled ou disabled.")
			return true
		else
			runesEnabled = runesEnabled:lower()
			if runesEnabled == "enabled" then
				runesEnabled = true
			elseif runesEnabled == "disabled" then
				runesEnabled = false
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se Runas s�o ou n�o permitidas.")
				return true
			end
		end

		-- SSA ativado?
		local ssaMightRingBlocked = p[7]
		if not ssaMightRingBlocked then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se SSA e Might Ring estar�o enabled ou disabled.")
			return true
		else
			ssaMightRingBlocked = ssaMightRingBlocked:lower()
			if ssaMightRingBlocked == "enabled" then
				ssaMightRingBlocked = true
			elseif ssaMightRingBlocked == "disabled" then
				ssaMightRingBlocked = false
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se SSA e Might s�o ou n�o permitidos.")
				return true
			end
		end

		-- Summons blockiados?
		local summonsBlocked = p[8]
		if not summonsBlocked then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se os Summons estar�o enabled ou disabled.")
			return true
		else
			summonsBlocked = summonsBlocked:lower()
			if summonsBlocked == "enabled" then
				summonsBlocked = true
			elseif summonsBlocked == "disabled" then
				summonsBlocked = false
			else
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina corretamente se Summons s�o ou n�o permitidos.")
				return true
			end
		end

		-- Definir a quantidade de players
		local maximumPlayers = tonumber(p[9])
		if not maximumPlayers then
			maximumPlayers = 0
		elseif maximumPlayers < AntiEntrosa.minPlayers and maximumPlayers ~= 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] A quantidade de players m�nima � de ".. AntiEntrosa.minPlayers ..".")
			return true
		elseif maximumPlayers > AntiEntrosa.maxPlayers then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] A quantidade m�xima de Players � de ".. AntiEntrosa.maxPlayers .." ou ilimitado.")
			return true
		end

		-- Definir a Guild contra
		local guildEnemy = p[10]
		if not guildEnemy then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Defina o nome da guild inimiga.")
			return true
		end

		local enemyGuildId = getGuildId(guildEnemy)
		if not enemyGuildId or enemyGuildId == 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Essa Guild n�o existe.")
			return true
		end

		if enemyGuildId == playerGuild then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o pode convidar a sua pr�pria Guild para uma War.")
			return true
		end
		
		if AntiEntrosa:warInfo(enemyGuildId) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Essa guild j� foi convidada por outra guild.")
			return true
		end

		local enemyGuildName = getGuildNameById(enemyGuildId)
		if not isInWar(playerGuild, enemyGuildId) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, string.format("[War Anti-Entrosa] Sua Guild precisa estar em WarSystem contra a Guild %s para poder enviar um pedido de War no Anti-Entrosa.", enemyGuildName))
			return true
		end

		local hasInvitation = AntiEntrosa:hasInvitation(playerGuild, enemyGuildId)
		if hasInvitation then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, string.format("[War Anti-Entrosa] J� existe um convite de War contra a Guild %s.", enemyGuildName))
			return true
		end
		
		if getPlayerMoney(cid) >= 350000 then -- gold coin
			if doPlayerRemoveMoney(cid, 350000) then -- gold coin
				AntiEntrosa:sendInvitation(cid, arenaId, playerGuild, enemyGuildId, timeWar, minLevel, ueEnabled, runesEnabled, ssaMightRingBlocked, summonsBlocked, maximumPlayers)
			else
				doPlayerSendCancel(cid, "ERROR! Contact the Administrator.")
				return true
			end
		else
			doPlayerSendCancel(cid, "[War Anti-Entrosa] Taxa para enviar um convite no Anti-Entrosa � de 350k.")
			return true
		end

	elseif action == "accept" then
		local guildEnemy = p[2]
		local enemyGuildId = getGuildId(guildEnemy)
		if not enemyGuildId or enemyGuildId == 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Essa Guild n�o existe.")
			return true
		end

		if enemyGuildId == playerGuild then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o pode executar essa a��o.")
			return true
		end
		
		if getPlayerGuildLevel(cid) < 3 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� precisa ser l�der da Guild para poder enviar um pedido de War.")
			return true
		end

		local enemyGuildName = getGuildNameById(enemyGuildId)
		local hasInvitation = AntiEntrosa:hasInvitation(playerGuild, enemyGuildId)
		if not hasInvitation then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, string.format("[War Anti-Entrosa] N�o existe nenhum convite de War da Guild %s.", enemyGuildName))
			return true
		end
		
		local arenaId = AntiEntrosa:getWarIdByGuild(playerGuild)
		if arenaId then
			if getPlayerMoney(cid) >= 150000 then -- gold coin
				if doPlayerRemoveMoney(cid, 150000) then -- gold coin
					AntiEntrosa:confirmInvitation(cid, arenaId)
				else
					doPlayerSendCancel(cid, "ERROR! Contact the Administrator.")
					return true
				end
			else
				doPlayerSendCancel(cid, "[War Anti-Entrosa] Taxa para aceitar o Anti-Entrosa � de 150k.")
				return true
			end
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] N�o foi poss�vel aceitar o pedido de War no Anti-Entrosa.")
		end
		
	elseif action == "cancel" then
		local guildEnemy = p[2]
		local enemyGuildId = getGuildId(guildEnemy)
		if not enemyGuildId or enemyGuildId == 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Essa Guild n�o existe.")
			return true
		end

		if enemyGuildId == playerGuild then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o pode executar essa a��o.")
			return true
		end
		
		local warInfo = AntiEntrosa:warInfo(playerGuild)
		if not warInfo then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] A sua Guild n�o possui uma War Ativa atualmente.")
			return true
		end
		
		local enemyGuildName = getGuildNameById(enemyGuildId)
		local canCancel = AntiEntrosa:canCancelInvitation(playerGuild)
		if not canCancel then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o pode cancelar o pedido dessa War no Anti-Entrosa.")
			return true
		end

		local arenaId = AntiEntrosa:getWarIdByGuild(playerGuild)
		if arenaId then
			AntiEntrosa:cancelInvitation(cid, arenaId)
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] N�o foi poss�vel aceitar o pedido de War no Anti-Entrosa.")
		end

	elseif action == "go" then
		-- Verifica se a Guild do jogador est� no Anti Entrosa
		local arenaId = AntiEntrosa:getWarIdByGuild(playerGuild)
		if not arenaId then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Sua Guild n�o est� em War no Anti-Entrosa neste momento.")
			return true
		end

		AntiEntrosa:enterPlayer(cid, arenaId)
	elseif action == "exit" then
		if not getTilePzInfo(getPlayerPosition(cid)) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� precisa estar em PZ para sair do Anti-Entrosa.")
			return true
		end
		
		if isPlayerPzLocked(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o pode sair do Anti-Entrosa com PZ Locked.")
			return true
		end
		
		local warInfo = AntiEntrosa:warInfo(playerGuild)
		if not warInfo then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Sua Guild n�o est� em nenhuma War no momento.")
			return true
		end
		
		if getPlayerStorageValue(cid, STORAGE_PLAYER_IN_ARENA) == 1 then
			AntiEntrosa:removePlayersOutside(cid, "Voc� saiu do Anti Entrosa", true)
		else
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "[War Anti-Entrosa] Voc� n�o est� no Anti Entrosa.")
		end
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "[War Anti-Entrosa] Digite o comando corretamente: !citywar invite, cidade, tempo, levelMax, ueMode, runesMode, ssaMode, summonsMode, playersDentro, GuildContra")
	end

	return true
end