local areafrom = {x=1013, y=594, z=9} -- ENTRADA from
local areato = {x=1019, y=598, z=9} -- ENTRADA to
local newpos = {x=1031, y=587, z=9} -- POS ONDE OS PLAYERS VAO

local from = {x=1024, y=581, z=9} -- SALA DO BOSS
local to = {x=1038, y=595, z=9} -- SALA DO BOSS
local kickpos = {x=1016, y=588, z=9} -- PARA ONDE O PLAYER VAI AO SER KIKADO
local timetokick = {11, "min"} -- tempo para ser teleportado para sala de recompensa
local timelever = {15, "min"} -- tempo da LEVER
local nobug = {x=1037, y=594, z=9} -- NÂO MECHA
local leverpos = {x=1016, y=598, z=9}

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

local function kickPlayerFromArea(cid, p)
	for _, pid in ipairs(getPlayersOnline()) do
		if isPlayer(pid) and isInRange(getPlayerPosition(pid), p[1], p[2]) then
			doTeleportThing(pid, p[3])
			doSendMagicEffect(p[3], CONST_ME_TELEPORT)
			doPlayerSendTextMessage(pid, 27, "Parabéns! Você só poderá escolher 1 item. Ao clicar no baú, você será teleportado.")
		end
	end
end

local function getCreaturesFromArea(fromPos, toPos,checkFunction)
    local grwe = {};
    checkFunction = checkFunction or function(arg) return true; end;
    for fx = fromPos.x, toPos.x do
        for fy = fromPos.y, toPos.y do
            for fz = fromPos.z, toPos.z do
                local tmp = getTopCreature({x=fx,y=fy,z=fz}).uid;
                if(checkFunction(tmp))then
                    table.insert(grwe, tmp);
                end
            end
        end
    end
    local tmp = getTopCreature(nobug).uid;
    if(checkFunction(tmp))then
        table.insert(grwe, tmp);
    end
    return grwe;
end

local function getPlayersInArea(fromPos, toPos)
local players = {}
    for _, pid in ipairs(getPlayersOnline()) do
        if isInRange(getPlayerPosition(pid), fromPos, toPos) then
            table.insert(players, pid)
        end
    end
   
	return players
end

local function mathtime(table) -- by dwarfer
local unit = {"sec", "min", "hour", "day"}
	for i, v in pairs(unit) do
		if v == table[2] then
			return table[1]*(60^(v == unit[4] and 2 or i-1))*(v == unit[4] and 24 or 1)
		end
	end
	
	return error("Bad declaration in mathtime function.")
end

local function changeBack(posp)
	doTransformItem(getTileItemById(posp, 1946).uid, 1945)
	return true
end

local function FirstWave(cid)
	doCreateMonster("Daily Dark Torturer", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1031, y=583, z=9}, false, true);
end

local function SecondWave(cid)
	doCreateMonster("Daily Dark Torturer", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Hellspawn", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1031, y=583, z=9}, false, true);
end

local function ThirdWave(cid)
	doCreateMonster("Daily Dark Torturer", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1031, y=583, z=9}, false, true);
end

local function FourthWave(cid)
	doCreateMonster("Daily Destroyer", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Dark Torturer", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1031, y=583, z=9}, false, true);
end

local function FifthWave(cid)
	doCreateMonster("Daily Destroyer", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1031, y=583, z=9}, false, true);
end

local function SixthWave(cid)
	doCreateMonster("Daily Demon", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1031, y=583, z=9}, false, true);
end

local function SeventhWave(cid)
	doCreateMonster("Daily Nightmare", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1031, y=583, z=9}, false, true);
end

local function OctaveWave(cid)
	doCreateMonster("Daily Demon", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1031, y=583, z=9}, false, true);
end

local function NineWave(cid)
	doCreateMonster("Daily Juggernaut", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Destroyer", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Nightmare", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1031, y=583, z=9}, false, true);
end

local function TenWave(cid)
	doCreateMonster("Daily Juggernaut", {x=1026, y=583, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1025, y=586, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1026, y=589, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1026, y=592, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1029, y=593, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1033, y=593, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1036, y=592, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1037, y=589, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1036, y=586, z=9}, false, true);
	doCreateMonster("Daily Demon", {x=1035, y=583, z=9}, false, true);
	doCreateMonster("Daily Juggernaut", {x=1031, y=583, z=9}, false, true);
end

function onUse(cid, item, frompos, item2, topos)
local players = getPlayersInArea(areafrom, areato);
local players_boss = getCreaturesFromArea(from, to, isPlayer);

	if item.itemid == 1945 then
        if #players_boss > 0 then
			doCreatureSay(cid, "Possui jogadores na sala.", TALKTYPE_ORANGE_1)
			return true
        else
			local monsters = getCreaturesFromArea(from,to,isMonster);
			while(#monsters > 0)do
				for _,m in pairs(monsters)do
					doRemoveCreature(m);
				end
				monsters = getCreaturesFromArea(from,to,isMonster);
			end
			for i = 1, #players do
				doTeleportThing(players[i], newpos, false)
				doSendMagicEffect(getCreaturePosition(cid), 10)
			end
			
			doTransformItem(item.uid, item.itemid + 1)
			setGlobalStorageValue(cid, 30072, os.time()+15*60)
			addEvent(changeBack, mathtime(timelever) * 1000, leverpos)
			doCreatureSay(cid, "Você deve sobreviver ou acabar com todas as WAVES(1 minuto por WAVE).", TALKTYPE_ORANGE_1, false, 0, newpos)
			addEvent(valid(doCreatureSay), 5*1000, cid, "WAVE 1 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(FirstWave, 15*1000, 0, true)
			addEvent(valid(doCreatureSay), 60*1000, cid, "WAVE 2 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(SecondWave, 70*1000, 0, true)
			addEvent(valid(doCreatureSay), 120*1000, cid, "WAVE 3 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(ThirdWave, 130*1000, 0, true)
			addEvent(valid(doCreatureSay), 180*1000, cid, "WAVE 4 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(FourthWave, 190*1000, 0, true)
			addEvent(valid(doCreatureSay), 240*1000, cid, "WAVE 5 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(FifthWave, 250*1000, 0, true)
			addEvent(valid(doCreatureSay), 300*1000, cid, "WAVE 6 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(SixthWave, 310*1000, 0, true)
			addEvent(valid(doCreatureSay), 360*1000, cid, "WAVE 7 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(SeventhWave, 370*1000, 0, true)
			addEvent(valid(doCreatureSay), 420*1000, cid, "WAVE 8 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(OctaveWave, 430*1000, 0, true)
			addEvent(valid(doCreatureSay), 480*1000, cid, "WAVE 9 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(NineWave, 490*1000, 0, true)
			addEvent(valid(doCreatureSay), 540*1000, cid, "WAVE 10 EM 10 SEGUNDOS!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(TenWave, 550*1000, 0, true)
			addEvent(valid(doCreatureSay), 600*1000, cid, "TODOS QUE SOBREVIVERAM VÃO SER TELEPORTADOS EM 1 MINUTO!", TALKTYPE_ORANGE_1, false, 0, {x=1031, y=587, z=9})
			addEvent(kickPlayerFromArea, mathtime(timetokick) * 1000, cid, {from, to, kickpos})
		end
		
	elseif item.itemid == 1946 then
		doCreatureSay(cid, "Para usar novamente a alavanca, aguarde ".. convertTime(getGlobalStorageValue(cid, 30072) - os.time()) ..".", TALKTYPE_ORANGE_1, false, 0, {x=297, y=120, z=9})
	end
	return true    
end