Arena_system_easy = {
	levers = {{x = 522, y = 110, z = 14},{x = 522, y = 114, z = 14}},
	storages = {753540,753541,753542}, -- wave,timer,kick
	storage_ex = 548754, -- n mexa
	hours = 24, -- que vai voltar a usar a alavanca
	level = {min = 8, max = 500}, -- level para participar
    str = "{Arena System} Iniciando wave: %d Dificuldade: Fácil, Números de monstros desta Wave: %d.",
	area = {from = {x = 2919, y = 1079, z = 7}, to = {x = 2940, y = 1098, z = 7}},
	global_storage = 487576, -- n mexa
	rewards_per_waves = {exp = 100, money = 10000}, -- aqui caso eles morram antes da ultima wave
	respawntime = 10, -- entre o termino de um respawn vai nascer depois de quanto tempo?
	gem_pos = {x = 523, y = 115, z = 14}, -- qndo n tiver ngm na area fica verde e depois vermelho se tiver
	enter_pos = {x = 2929, y = 1088, z = 7}, -- onde os jogadores vao ao puxar a alavanca
	rewards = {{7443,1}, {8981,1}, {9971,50}}, -- itens que ganharao ao terminar todas as waves
	easy_waves = {
		[1] = {{"snake",2},{"ghoul",4},{"rotworm",6}},
		[2] = {{"cyclops",6},{"rat",4},{"rotworm queen",4}},
		[3] = {{"dragon",4},{"behemoth",20},{"medusa",12}},
		[4] = {{"ghastly dragon",6},{"fury",2}},
		[5] = {{"demon",6},{"dragon lord",8},{"hellgorak",2}},
		[6] = {{"infernatil",1},{"morgaroth",2},{"Ferumbras",4}},
		[7] = {{"warlock",8},{"ghazbaran",4},{"grim reaper vip",6}},
		[8] = {{"draken elite",6},{"Mago Negro",4},{"Ferumbras",2}},
		[9] = {{"warlock vip iii",2},{"dragon lord vip iii",6},{"grim reaper vip iii",8}},
		[10] = {{"demon vip iii",8},{"morgaroth",10},{"Ferumbras",22}},
		[11] = {{"snake god essence",12},{"donate hydra",18},{"donate demon",22}},
		[12] = {{"donate dragon lord",26},{"donate frost dragon",24},{"donate warlock",22}},
		[13] = {{"brimstone bug",16},{"spider fiery",12},{"undead darkshadow",8}},
		[14] = {{"ghazbaran",8},{"morgaroth",6},{"Ferumbras",4}},
		[15] = {{"warlock vip",1},{"bossing of baiak",1},{"frost dragon vip",2}},
		[16] = {{"chupa cabra",1},{"morgaroth",2},{"Ferumbras",2}} ,
		[17] = {{"champion warlock",1},{"champion undead dragon",1},{"champion sea serpent",4}},
		[18] = {{"champion plaguesmith",4},{"infernalist",1},{"Ferumbras",2}},
		[19] = {{"champion massive elemental",2},{"champion defiler",4},{"Ferumbras",2}},
		[20] = {{"balghordan",1}}
	}
}
function doCountWaveMobs(wave)
	local c = 0
	for _, ret in pairs(Arena_system_easy.easy_waves[wave]) do
		c = c + ret[2]
	end
	return c
end
function TransformArenaTile(pos, from, to)
	if #getPlayersInArena(from, to) > 0 then
		local t = getTileItemById(pos, 9565).uid
		return t > 0 and doTransformItem(t, 9562)
	elseif #getPlayersInArena(from, to) == 0 then
		local t = getTileItemById(pos, 9562).uid
		return t > 0 and doTransformItem(t, 9565)
	end
end
function doStartNextEasyWave(wave, from, to)
	setGlobalStorageValue(753540, wave)
	setGlobalStorageValue(753541, os.time()+120)
	setGlobalStorageValue(753542, 0)
	addEvent(doKickPlayerArena, 120000, wave, from,to) 
	HaveCreatureArena({from,to}, true, true)
	doSpanwMonster(from,to, Arena_system_easy.easy_waves[wave], true)
end
function getItemsFromList(items)
	local str = ''
	if table.maxn(items) > 0 then
		for i = 1, table.maxn(items) do
			str = str .. items[i][2] .. ' ' .. getItemNameById(items[i][1])
			if i ~= table.maxn(items) then str = str .. ', ' 
			end 
		end 
	end
	return str
end
function GiveRewardsArena(cid, items)
	local backpack = doPlayerAddItem(cid, 1999, 1) -- backpackID
	for _, i_i in ipairs(items) do
		local item, amount = i_i[1],i_i[2]
		if isItemStackable(item) or amount == 1 then
			doAddContainerItem(backpack, item, amount)
		else
			for i = 1, amount do
				doAddContainerItem(backpack, item, 1)
			end
		end
	end
end
function doCheckKillArea(from, to)
	if #getPlayersInArena(Arena_system_easy.area.from,Arena_system_easy.area.to) == 0 then return true end
	if HaveCreatureArena({from,to}, false, false) == 0 then
		local next = (getGlobalStorageValue(Arena_system_easy.storages[1])+1)
		if Arena_system_easy.easy_waves[next] then
			setGlobalStorageValue(753540, next)
			for _, cid in pairs(getPlayersOnline()) do
				if isInRange(getPlayerPosition(cid), from, to) then 
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,string.format(Arena_system_easy.str, next, doCountWaveMobs(next)))
				end
			end
			addEvent(doStartNextEasyWave,Arena_system_easy.respawntime*1000, next, from, to)
		else
			for _, cid in pairs(getPlayersOnline()) do
				if isInRange(getPlayerPosition(cid), from, to) then
					GiveRewardsArena(cid, Arena_system_easy.rewards)
					doRemoveConditions(cid, false)
					doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
					doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT) 
					doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"Parabéns, você derrotou todas as waves da arena. Suas recompensas: "..getItemsFromList(Arena_system_easy.rewards))
				end
			end
		end 
	else
		addEvent(doCheckKillArea, 10000, from, to) -- vai fzr loop a cada 10 segundos na sala pra saber se matou o monstros
	end
end
function getPlayersOnEasyLevers(from, to)
	local t = {}
	for _, cid in pairs(getPlayersOnline()) do
		if isInRange(getPlayerPosition(cid), from, to) then
			t[#t+1] = cid
		end
	end
	return t
end
function getPlayersInArena(from, to)
	local t = {}
	for _, pid in pairs(getPlayersOnline()) do
		if isInRange(getPlayerPosition(pid), from, to) then 
			t[#t+1] = pid
		end
	end
	return t
end
function isWalkable(pos) -- by Nord / editado por Omega
	if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then
		return false
	elseif isCreature(getTopCreature(pos).uid) then
		return false
	elseif getTileInfo(pos).protection then
		return false
	elseif hasProperty(getThingFromPos(pos).uid, 3) or hasProperty(getThingFromPos(pos).uid, 7) then
		return false
	end
	return true
end
function doSpanwMonster(from, to, tab, time)
	for _, ret in pairs(tab) do
		local c = 0
		if time and ret[2] % 2 == 0 then
			c = (ret[2]/2)
		elseif not time and ret[2] % 2 == 0 then
			c = (ret[2]/2) 
		elseif time and ret[2] % 2 ~= 0 then
			c = ret[2]
		end
		if c > 0 then
			repeat
				local pos = {x=math.random(from.x, to.x), y=math.random(from.y,to.y), z=from.z}
				if isWalkable(pos) then
					doCreateMonster(ret[1], pos)
					doSendDistanceShoot({x = pos.x - math.random(4, 6), y = pos.y - 5, z = pos.z}, pos, CONST_ANI_FIRE)
					addEvent(doSendMagicEffect, 150, pos, CONST_ME_HITBYFIRE)
					addEvent(doSendMagicEffect, 150, pos, CONST_ME_FIREAREA)
					doSendMagicEffect(pos, CONST_ME_MORTAREA)
					c = c-1 
				end
			until c == 0
		end
	end
	if time then 
		addEvent(doSpanwMonster, 10000, from, to, tab, false) -- segunda leva de monstro 10 segundos 
		addEvent(doCheckKillArea, 10000, from, to)
	end
end
function HaveCreatureArena(area, remove, clean)
	local var = 0
	for x = area[1].x - 1, area[2].x + 1 do
		for y = area[1].y - 1, area[2].y + 1 do
			local pos = {x=x, y=y, z=area[1].z}
			local m = getTopCreature(pos).uid
			if m ~= 0 and isMonster(m) then 
				var = var +1 
			end
			if remove ~= false and m ~= 0 and isMonster(m) then 
				doRemoveCreature(m) 
			end
			if clean ~= false then 
				doCleanTile(pos,false)
			end
		end
	end
	return var
end
function doKickPlayerArena(wave, from, to)
	if getGlobalStorageValue(Arena_system_easy.storages[1]) ~= wave then return true end
	local players = getPlayersInArena(Arena_system_easy.area.from,Arena_system_easy.area.to) 
	if #players == 0 then return true end
	if getGlobalStorageValue(Arena_system_easy.storages[2]) <= os.time() then
		if getGlobalStorageValue(Arena_system_easy.storages[3]) <= 0 then
			for _, cid in pairs(players) do
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"Vocês serão kikados em 5 minutos se não terminarem está Wave.")
			end
			setGlobalStorageValue(Arena_system_easy.storages[3], 1)
			addEvent(doKickPlayerArena, 5*60000, wave, from, to) -- 5 minutos
		else
			for _, cid in pairs(players) do
				doRemoveConditions(cid, false)
				doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
				doSendMagicEffect(getPlayerPosition(cid), CONST_ME_TELEPORT)
				doPlayerSendTextMessage(cid, 21, 'Parabéns! Você sobreviviu até a '..wave..'° Wave.')
				if Arena_system_easy.rewards_per_waves.exp > 0 then doPlayerAddExp(cid, Arena_system_easy.rewards_per_waves.exp*wave) end
				if Arena_system_easy.rewards_per_waves.money > 0 then doPlayerAddMoney(cid, Arena_system_easy.rewards_per_waves.money*wave) end 
			end
			setGlobalStorageValue(Arena_system_easy.storages[1], 0)
			setGlobalStorageValue(Arena_system_easy.storages[2], 0)
			setGlobalStorageValue(Arena_system_easy.storages[3], 0)
		end
	end
end