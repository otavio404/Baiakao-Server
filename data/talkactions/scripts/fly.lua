local time = 5	
local premium_teleport_houses = true

local block_area = {
	{{x=2163, y=2030, z=7}, {x=2226, y=2080, z=7}}, -- Firestorm Evento
	{{x=203, y=1194, z=7}, {x=1260, y=1251, z=7}}, -- Snowball Evento 1
	{{x=1228, y=1219, z=6}, {x=1236, y=1227, z=6}}, -- Snowball Evento 2
	{{x=474, y=616, z=7}, {x=508, y=649, z=7}}, -- Campo Minado
	{{x=1170, y=421, z=6}, {x=1238, y=467, z=6}}, -- CTF 1
	{{x=1176, y=423, z=7}, {x=1238, y=467, z=7}}, -- CTF 2
	{{x=432, y=1131, z=7}, {x=444, y=1143, z=7}}, -- DTT 1
	{{x=381, y=1104, z=6}, {x=492, y=1174, z=6}}, -- DTT 2
	{{x=549, y=5311, z=5}, {x=571, y=5340, z=5}}, -- Prisão
	 -- {{x=588, y=781, z = 7}, {x=1236, y=1227, z=6}}, -- RealTeamBattle
	 -- {{x=588, y=781, z = 7}, {x=1236, y=1227, z=6}}, -- Battlefild 1
	 -- {{x=588, y=781, z = 7}, {x=1236, y=1227, z=6}}, -- Battlefild 2
	 -- {{x=588, y=781, z = 7}, {x=1236, y=1227, z=6}}, -- Zombie
	{{x=3532, y=235, z=13}, {x=3549, y=252, z=13}}, -- Castle 24h 1
	{{x=3530, y=241, z =15}, {x =3580, y=298, z=15}}, -- Castle 24h 2	 
	{{x=3318, y=300, z=9}, {x=3401, y=365, z=9}}, -- Castle 48h	 
	{{x=1296, y=1843, z=7}, {x=1302, y=1852, z=7}} -- Castle 48h	
	}

local teleports = {
		["depot"] = {pos = {x=123, y=51, z=7}, premium = false},
		["templo"] = {pos = {x=152, y=53, z=7}, premium = false},
		["treiner"] = {pos = {x=2925, y=1457, z=12}, premium = false},
		["donate"] = {pos = {x=4904, y=662, z=6}, premium = true}		
}

function doTeleportWithDelay(cid, pos, delay) -- by vodkart
	if not isCreature(cid) then return LUA_ERROR end
	if delay > 0 then
		if getCreatureCondition(cid, CONDITION_INFIGHT) then
			setPlayerStorageValue(cid, 548745, 0) 
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} O teletransporte foi desativado pois voce entrou em estado de combate.") return true
		end
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} "..delay.." segundos para se teletransportar.")
		addEvent(doTeleportWithDelay, 1000, cid, pos, delay-1)
	else
		doTeleportThing(cid, pos)
		doSendMagicEffect(getPlayerPosition(cid), 10)
	end
end
function getHouseInvite(cid)
	local t = {}
	local qry = db.getResult("SELECT `house_id`,`list` FROM `house_lists`;")
	if (qry:getID() ~= -1) then
		repeat
			local lista = qry:getDataString("list")
			if string.find(lista, getCreatureName(cid)) then
				local id = qry:getDataInt("house_id")
				if not isInArray(t, id) then
					t[#t+1] = id
				end
				
			end
		until not qry:next()
		qry:free() 
	end
	return t
end	
function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	local z = string.explode(param:lower(), ",")
	if getCreatureCondition(cid, CONDITION_INFIGHT) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Este comando so pode ser usado fora de combate.") return true
	elseif getPlayerStorageValue(cid, 548745) - os.time() > 0 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} aguarde, voce esta em processo de teletransporte.") return true
	end
	for _, var in ipairs(block_area) do
		if isInRange(getCreaturePosition(cid), var[1], var[2]) then
			doPlayerSendCancel(cid, "Voce nao pode teleportar nesta area..") return true
		end
	end
	if z[1] == "casa" or z[1] == "house" then
		local t,invite,str = {},getHouseInvite(cid),'{Teleport} As casas disponiveis para voce se teletransportar sao:\n'
		if premium_teleport_houses == true and not isPremium(cid) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} voce precisa ser premium account para teleportar para houses.") return true
		end
		if getHouseByPlayerGUID(getPlayerGUID(cid)) ~= nil then
			t[#t+1] = getHouseByPlayerGUID(getPlayerGUID(cid))
		end
		if #invite ~= 0 then
			for i = 1,#invite do
				t[#t+1] = invite[i]	
			end
		end	
		if #t == 0 then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} voce nao tem nenhuma house para ir.") return true
		end	
		if not tonumber(z[2]) or tonumber(z[2]) > #t then 
			for i = 1, table.maxn(t) do
				local h = getHouseInfo(t[i])
				local hname, htown = getHouseName(t[i]),getTownName(h.town)
				
				str = str .. i .. ') '..hname..' [' .. htown..']'
				str = i ~= table.maxn(t) and str .. ', ' or str .. '.'
			end
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Voce deve especificar uma das casas para se teletransportar usando !tp house,numeroDoIndice")
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, str) return true
		end
		setPlayerStorageValue(cid, 548745, os.time()+time)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Ativado.") 
		doTeleportWithDelay(cid, getHouseEntry(t[tonumber(z[2])]), time) return true
	end 
	if not teleports[z[1]] then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Desculpe, este lugar nao existe, lugares disponiveis: depot, templo, house, trainer, donate.") return true
	elseif teleports[z[1]].premium == true and not isPremium(cid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Desculpe, voce precisa ser premium para ir para este lugar.") return true 	
	end	
	setPlayerStorageValue(cid, 548745, os.time()+time)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "{Teleport} Ativado.") 
	doTeleportWithDelay(cid, teleports[z[1]].pos, time) return true
end