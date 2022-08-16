dtt = {
    pos = {
        temple_wait = {x = 438, y = 1137, z = 7}, -- sala de espera
        tp_create = {x = 151, y = 43, z = 7} -- onde teleport de entrada sera criado
    },

    --Configurações de abertura
    days_open = {2, 5, 7}, -- dias de semana que vai abrir
    min_players = 10, -- numero minimo de jogadores (SE por 2 = 1 em cada time)
    min_level = 100, -- level minimo permitido para entrar no evento
    wait_time = 1, -- tempo de espera para iniciar o evento, em minutos
    block_mc = true, -- false para permitir mcs no evento

    --Configuraçõe gerais
    delay_time = 10, -- tempo em segundos de delay ao morrer
    townid = {init = 1, blue = 3, red = 3}, -- init = templo da cidade, blue = templo do time azul, red = templo do time vermelho

    --Configuração dos monstros
    monster = {
        pos = {
            --Monstros do time azul
            a1 = {x = 418, y = 1160, z = 6, stackpos=253}, -- Blue supreme tower
            a2 = {x = 420, y = 1136, z = 6, stackpos=253}, -- Blue top tower
            a3 = {x = 419, y = 1125, z = 6, stackpos=253}, -- Blue middle tower
            a4 = {x = 437, y = 1109, z = 6, stackpos=253}, -- Blue bottom tower
            
            -- Monstros do time vermelho
            b1 = {x = 456, y = 1122, z = 6, stackpos=253}, -- Red supreme tower
            b2 = {x = 455, y = 1138, z = 6, stackpos=253}, -- Red top tower 
            b3 = {x = 455, y = 1162, z = 6, stackpos=253}, -- Red middle tower 
            b4 = {x = 437, y = 1166, z = 6, stackpos=253}, -- Red bottom tower
            
            -- Monstros buff na jungle
            mbuff1 = {x = 451, y = 1155, z = 6, stackpos=253}, -- Buff sorecer and paladin 1 + 2
            mbuff2 = {x = 432, y = 1115, z = 6, stackpos=253} -- Buff druid and knight 2 + 2
        },
        ---------------------------------------------------
        --NÃO MEXA DAQUI PRA BAIXO -----
        ------------------------------------------------
        name = {
            -- Azul
            a1 = "blue supreme tower", -- Base Tower
            a2 = "blue top tower", -- Top lane
            a3 = "blue middle tower", -- Middle lane
            a4 = "blue bottom tower", -- Bottom lane
            -- Vermelho
            b1 = "red supreme tower", -- Base Tower
            b2 = "red top tower", -- Top lane
            b3 = "red middle tower", -- Middle lane
            b4 = "red bottom tower", -- Bottom lane

            --Monstros Buff
            buff1 = "serpent of jungle",
            buff2 = "spider of jungle"
        }
    },

    --Storages alocadas
    storage = {
        win = 87771, -- GLOBAL STORAGE VENCEDOR
        kill_blue = 87775, -- GLobal storage frags team blue
        kill_red = 87776, -- GLobal storage frags team red
        tower_blue = 87777, -- GLobal storage towers team blue
        tower_red = 87778, -- GLobal storage towers team red
        team_blue = 9998, -- PLAYER STORAGE TIME A
        team_red = 9999, -- PLAYER STORAGE TIME A
        buffvoc1 = 7001, -- PLAYER STORAGE BUFF
        buffvoc2 = 7002, -- PLAYER STORAGE BUFF
        buffvoc3 = 7003, -- PLAYER STORAGE BUFF
        buffvoc4 = 7004, -- PLAYER STORAGE BUFF
        exp_bonus = 7005, --PLAYER STORAGE EXP BONUS
        delay = 7006 --PLAYER STORAGE DELAY
    },

    msg = {
        win_team_blue = "[Defend The Tower] O time azul acabou de derrotar a Suprema Torre Vermelha e vencer o evento.",
        win_team_red = "[Defend The Tower] O time vermelho acabou de derrotar a Suprema Torre Azul e vencer o evento. ",
        reward = "[Defend The Tower] Venceu!! Desejamos parabéns.",
        no_reward = "[Defend The Tower] Derrota, confira as estatisticas da partida no site, desejamos mais sorte na proxima.",
        warning = "[Defend The Tower] Acabou de abrir, acesse o teleporte do templo principal para participar. Inicia em minutos...",
        start = "[Defend The Tower] Fechou o teleporte de entrada e iniciou o evento boa sorte aos times.",
        cancel = "[Defend The Tower] Fechou o teleporte de entrada e cancelou o evento por falta de jogadores.",
        outfit = "[Defend The Tower] Voce nao pode trocar de outfit durante o evento."
    }
}

local conditionBlue = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionBlue, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionBlue, {lookType = 128, lookHead = 86, lookBody = 86, lookLegs = 86, lookFeet = 86})
local conditionRed = createConditionObject(CONDITION_OUTFIT)
setConditionParam(conditionRed, CONDITION_PARAM_TICKS, -1)
addOutfitCondition(conditionRed, {lookType = 128, lookHead = 94, lookBody = 94, lookLegs = 94, lookFeet = 94})


--Metodos set
function dtt.setDelay(cid)
    doPlayerSetStorageValue(cid, dtt.storage.delay, os.time()+(60*dtt.delay_time))
    return true
end

function dtt.setBuff(storTeam, voc1, voc2)
    local storBuff1
    local storBuff2
    if (voc1 == 1) and (voc2 == 3) then
        storBuff1 = dtt.storage.buffvoc1
        storBuff2 = dtt.storage.buffvoc3
    end
    if (voc1 == 2) and (voc2 == 4) then
        storBuff1 = dtt.storage.buffvoc2
        storBuff2 = dtt.storage.buffvoc4
    end
    for _, index in ipairs(dtt.getPlayersInEvent()) do
        if getPlayerStorageValue(index.pid, storTeam) == 1 then
            if (isInArray({voc1, (voc1+4), (voc1+8)}, getPlayerVocation(index.pid))) then    
                doPlayerSetStorageValue(index.pid, storBuff1, 1)
            end
            if (isInArray({voc2, (voc2+4), (voc2+8)}, getPlayerVocation(index.pid))) then  
                doPlayerSetStorageValue(index.pid, storBuff2, 1)
            end
        end
    end
    return true
end

--function dtt.setBonusExp(cid)
    --doPlayerSetStorageValue(cid, dtt.storage.exp_bonus, os.time()+(60*dtt.bonus_time))
--    return true
--end

function dtt.setTeam()
    local tmp = 1
    local result = db.getResult("SELECT * FROM `dtt_players`;")
    if result:getID() ~= -1 then
        repeat
            pid = tonumber(result:getDataInt("pid"))
            if(tmp % 2 == 0) then
                db.query("UPDATE `dtt_players` SET `team` = '0' WHERE `pid` = "..pid..";")
                tmp = (tmp+1)
            else
                db.query("UPDATE `dtt_players` SET `team` = '1' WHERE `pid` = "..pid..";")
                tmp = (tmp+1)
            end
        until(not result:next())
    end
    result:free()
end

--Metodos GET
function dtt.getPlayersInEvent()
    local result = db.getResult("SELECT * FROM `dtt_players`;")
    CACHE_PLAYERS = {}
    if result:getID() ~= -1 then
        repeat
            pid  = tonumber(result:getDataInt("pid"))
            team  = tonumber(result:getDataInt("team")) -- 0 = blue, 1 = red
            ip  = tonumber(result:getDataInt("ip"))
            table.insert(CACHE_PLAYERS, {["pid"]=pid,["team"]=team,["ip"]=ip }) 
        until(not result:next())
        result:free()
        return CACHE_PLAYERS
    end
    return false 
end


function dtt.getDelay(cid)
    local statsDelay = getPlayerStorageValue(cid, dtt.storage.delay)
    if (statsDelay - os.time() > 0) then
        local delay = 0
        local times = dtt.delay_time
        doCreatureSetNoMove(cid, true)
        for i = times, 0, -1 do
            if isPlayer(cid) then
                addEvent(doPlayerSendCancel, delay, cid, "[Defend The Tower] Volte para a arena em "..i..".")
            end
            delay = 2000 + delay                 
            if (i == 0) and (isPlayer(cid)) then
                addEvent(dtt.enableMove, (delay+1000), cid)
            end
         end
    else
        return false
    end
    return true
end

--function dtt.getBonusExp(cid)
--    local statsBonus = getPlayerStorageValue(cid, dtt.storage.exp_bonus)
--    return statsBonus - os.time() > 0
--end

--Outros métodos

function dtt.enableMove(cid)
    doCreatureSetNoMove(cid, false)
    doPlayerSendCancel(cid, "[Defend The Tower] GO GO GO! seu time o aguarda.")         
    setPlayerStorageValue(cid, dtt.storage.delay, 0)
    return true
end

function dtt.resetGlobalStorages()
    setGlobalStorageValue(dtt.storage.win, -1)
    setGlobalStorageValue(dtt.storage.kill_blue, 0)
    setGlobalStorageValue(dtt.storage.kill_red, 0)
    setGlobalStorageValue(dtt.storage.tower_blue, 0)
    setGlobalStorageValue(dtt.storage.tower_red, 0)
    print("[Defend The Tower] Todos os globais storages foram resetados...")
    return true
end

function dtt.resetPlayerStorages()
    if dtt.getPlayersInEvent() then
        for _, index in ipairs(dtt.getPlayersInEvent()) do
            doPlayerSetStorageValue(index.pid, dtt.storage.team_blue, 0)
            doPlayerSetStorageValue(index.pid, dtt.storage.team_red, 0)
            doPlayerSetStorageValue(index.pid, dtt.storage.buffvoc1, 0)
            doPlayerSetStorageValue(index.pid, dtt.storage.buffvoc2, 0)
            doPlayerSetStorageValue(index.pid, dtt.storage.buffvoc3, 0)
            doPlayerSetStorageValue(index.pid, dtt.storage.buffvoc4, 0)
        end
        print("[Defend The Tower] Todos os players storages foram resetados...")  
        return true
    else
        print("[Defend The Tower] Tabela vazia...")  
    end
    return true
end

function dtt.createMonsters()
    doSummonCreature(dtt.monster.name.a1, dtt.monster.pos.a1)
    doSummonCreature(dtt.monster.name.a2, dtt.monster.pos.a2)
    doSummonCreature(dtt.monster.name.a3, dtt.monster.pos.a3)
    doSummonCreature(dtt.monster.name.a4, dtt.monster.pos.a4)
    doSummonCreature(dtt.monster.name.b1, dtt.monster.pos.b1)
    doSummonCreature(dtt.monster.name.b2, dtt.monster.pos.b2)
    doSummonCreature(dtt.monster.name.b3, dtt.monster.pos.b3)
    doSummonCreature(dtt.monster.name.b4, dtt.monster.pos.b4)
    doSummonCreature(dtt.monster.name.buff1, dtt.monster.pos.mbuff1)
    doSummonCreature(dtt.monster.name.buff2, dtt.monster.pos.mbuff2)
    print("[Defend The Tower] Os monstros da arena battle foram sumonados...")  
    return true
end

function dtt.countPlayers()
    local result = db.getResult("SELECT * FROM `dtt_players`;")
    local qntPlayers = 0
    if result:getID() ~= -1 then
        repeat
            qntPlayers = (qntPlayers+1)
        until(not result:next())
    end
    return qntPlayers
end

function dtt.trucatePlayersInEvent()
    local result = db.getResult("SELECT * FROM `dtt_players`;")
    if result:getID() ~= -1 then
        db.query("TRUNCATE TABLE `dtt_players`;")  
        print("[Defend The Tower] Todos dados da tabela 'dtt_players' foram apagados...")
    end
    return true
end
    
function dtt.pegarPlayersNaArea(fromPos, toPos)
local players = {}
    for _, pid in ipairs(getPlayersOnline()) do
        if isInRange(getPlayerPosition(pid), fromPos, toPos) then
            table.insert(players, pid)
        end
    end
   
    return players
end
    
-- FUNÇÕES PRINCIPAIS
-- ABERTURA DO EVENTO
function dtt.open()
    local time = os.date("*t")
    local timeopen1 = math.ceil(dtt.wait_time / 4)
    local timeopen2 = math.ceil(dtt.wait_time / 2)
    if (isInArray(dtt.days_open, time.wday)) then
        local players_tp_dtt = dtt.pegarPlayersNaArea({x=289,y=114,z=8}, {x=289,y=114,z=8})
        if players_tp_dtt then
            for _, vdtt in next, players_tp_dtt do
                doTeleportThing(vdtt, getTownTemplePosition(1))
                doPlayerSendTextMessage(vdtt, MESSAGE_STATUS_CONSOLE_BLUE, "Não pode ficar no local onde o TP abriu. Você foi teleportado para o templo.")
            end
        end
    
        local tp = doCreateItem(1387, dtt.pos.tp_create)
        doItemSetAttribute(tp, "aid", 9801)
        dtt.resetGlobalStorages()
        dtt.trucatePlayersInEvent()
        dtt.removeItemsTower()
        doBroadcastMessage(dtt.msg.warning)
        addEvent(doBroadcastMessage, timeopen1*1000*60, "[Defend The Tower] - Resta(m) ".. timeopen2 .." minuto(s) para iniciar o evento!")
        if (timeopen2 ~= timeopen1) then
            addEvent(doBroadcastMessage, timeopen2*1000*60, "[Defend The Tower] - Resta(m) ".. timeopen1 .." minuto(s) para iniciar o evento!")
        end
        addEvent(dtt.start, dtt.wait_time*1000*60,nil)
    end
    return true
end

-- COMEÇO DO EVENTO
function dtt.start()
    local tp = getTileItemById(dtt.pos.tp_create, 1387).uid 
    doRemoveItem(tp) 
    if (dtt.min_players <= dtt.countPlayers()) then
        dtt.createMonsters()
        dtt.sendPlayersToEvent()
        doBroadcastMessage(dtt.msg.start)
    else
        doBroadcastMessage(dtt.msg.cancel)
        if dtt.getPlayersInEvent() then
            for _, index in ipairs(dtt.getPlayersInEvent()) do
                doRemoveCondition(index.pid, CONDITION_OUTFIT)
                doRemoveCondition(index.pid, CONDITION_INFIGHT)
                doPlayerSetPzLocked(index.pid, false)
                doPlayerSetTown(index.pid, dtt.townid.init) 
                doTeleportThing(index.pid, getTownTemplePosition(dtt.townid.init))
             end
        end
         dtt.resetPlayerStorages()
    end
    return true
end

-- FECHANDO O EVENTO
function dtt.close()
    for _, index in ipairs(dtt.getPlayersInEvent()) do
        doRemoveCondition(index.pid, CONDITION_OUTFIT)
        doRemoveCondition(index.pid, CONDITION_INFIGHT)
        doPlayerSetPzLocked(index.pid, false)
        if ((getGlobalStorageValue(dtt.storage.win) == "blue") and index.team == 0) or ((getGlobalStorageValue(dtt.storage.win) == "red") and index.team == 1) then
            doPlayerSetTown(index.pid, dtt.townid.init)
            doTeleportThing(index.pid, getTownTemplePosition(dtt.townid.init))
            dtt.reward(index.pid)
        else
            doPlayerSetTown(index.pid, dtt.townid.init)   
            doTeleportThing(index.pid, getTownTemplePosition(dtt.townid.init))
            doPlayerSendTextMessage(index.pid, 25, dtt.msg.no_reward)
        end
    end
    --- limpando storage dos jogadores
    dtt.resetPlayerStorages()
    return true
end

function dtt.sendPlayersToEvent()
    dtt.setTeam()
    dtt.resetPlayerStorages()
    if dtt.getPlayersInEvent() then
        for _, index in ipairs(dtt.getPlayersInEvent()) do
            if (index.team == 0) then
                doAddCondition(index.pid, conditionBlue)
                doPlayerSetTown(index.pid, dtt.townid.blue)
                doTeleportThing(index.pid, getTownTemplePosition(dtt.townid.blue))
                doPlayerSetStorageValue(index.pid, dtt.storage.team_blue, 1)
            end
            if (index.team == 1) then
                doAddCondition(index.pid, conditionRed)
                doPlayerSetTown(index.pid, dtt.townid.red)
                doTeleportThing(index.pid, getTownTemplePosition(dtt.townid.red))
                doPlayerSetStorageValue(index.pid, dtt.storage.team_red, 1)
            end
        end
    end 
    return true
end

function dtt.reward(pid)
    local pot_xp_ran = math.random(1, 100)
    local money_ran = math.random(2,6)
    if pot_xp_ran < 20 then
        doPlayerAddItem(pid, 12698, 1)
    end
    doPlayerAddItem(pid, 12686, 2)
    doPlayerAddItem(pid, 2160, money_ran)
    doPlayerSendTextMessage(pid, 25, dtt.msg.reward)   
    return true
end

function dtt.removeItemsTower()
    local a = getTileItemById(dtt.monster.pos.a2, 9596)
    if a and a.uid and a.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.a2, 9596).uid)
    end
    local b = getTileItemById(dtt.monster.pos.a3, 9596)
    if b and b.uid and b.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.a3, 9596).uid)
    end
    local c = getTileItemById(dtt.monster.pos.a4, 9596)
    if c and c.uid and c.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.a4, 9596).uid)
    end
    local d = getTileItemById(dtt.monster.pos.b2, 9596)
    if d and d.uid and d.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.b2, 9596).uid)
    end
    local e = getTileItemById(dtt.monster.pos.b3, 9596)
    if e and e.uid and e.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.b3, 9596).uid)
    end
    local f = getTileItemById(dtt.monster.pos.b4, 9596)
    if f and f.uid and f.uid > 0 then
        doRemoveItem(getTileItemById(dtt.monster.pos.b4, 9596).uid)
    end
    print("[DEFEND THE TOWERS] Items torre limpos da arena de batalha...")
    return true
end


function dtt.resultBattle()
    local frags_blue = getGlobalStorageValue(dtt.storage.kill_blue)
    local frags_red = getGlobalStorageValue(dtt.storage.kill_red)
    local towers_blue = getGlobalStorageValue(dtt.storage.tower_blue)
    local towers_red = getGlobalStorageValue(dtt.storage.tower_red)
    local hora = os.date("%X")
    local data = os.date("%d/%m/%y")
    db.query("INSERT INTO `dtt_results`  VALUES ('', ".. frags_blue ..  ",".. frags_red ..", ".. towers_blue ..", ".. towers_red ..", ".. db.escapeString(data) ..", ".. db.escapeString(hora) ..");")  
    return true
end

function dtt.warningAttack(cid, msg, storTeam)
    local lifePercent = 100 / (getCreatureMaxHealth(cid) / getCreatureHealth(cid))
    if (lifePercent <= 100) and (lifePercent >= 99.9) then
        for _, index in ipairs(dtt.getPlayersInEvent()) do
            if getPlayerStorageValue(index.pid, storTeam) == 1 then
                doPlayerSendTextMessage(index.pid, 25, "[DEFEND THE TOWER] A torre "..msg.." esta sob ataque. Corra para defender!")  
            end
        end
    end
    if (lifePercent <= 50) and (lifePercent >= 49.9) then
        for _, index in ipairs(dtt.getPlayersInEvent()) do
            if getPlayerStorageValue(index.pid, storTeam) == 1 then
                doPlayerSendTextMessage(index.pid, 25, "[DEFEND THE TOWER] A torre "..msg.." esta com metade da vida. Corra para defender!")  
            end
        end
    end
    if (lifePercent <= 20) and (lifePercent >= 19.9) then
        for _, index in ipairs(dtt.getPlayersInEvent()) do
            if getPlayerStorageValue(index.pid, storTeam) == 1 then
                doPlayerSendTextMessage(index.pid, 25, "[DEFEND THE TOWER] A torre "..msg.." esta quase caindo. Corra para defender!")  
            end
        end
    end
    return true
end

function dtt.removeMonsters()
    if isMonster(getTopCreature(dtt.monster.pos.a1).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.a1).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.a2).uid) then       
        doRemoveCreature(getTopCreature(dtt.monster.pos.a2).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.a3).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.a3).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.a4).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.a4).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.b1).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.b1).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.b2).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.b2).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.b3).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.b3).uid)
    end
    if isMonster(getTopCreature(dtt.monster.pos.b4).uid) then
        doRemoveCreature(getTopCreature(dtt.monster.pos.b4).uid)
    end
    return true
end

function dtt.cleanPlayer(cid)
    doPlayerSetTown(cid, dtt.townid.init)   
    doTeleportThing(cid, getTownTemplePosition(dtt.townid.init))
    doPlayerSetStorageValue(cid, dtt.storage.team_blue, 0)
    doPlayerSetStorageValue(cid, dtt.storage.team_red, 0)
    doPlayerSetStorageValue(cid, dtt.storage.buffvoc1, 0)
    doPlayerSetStorageValue(cid, dtt.storage.buffvoc2, 0)
    doPlayerSetStorageValue(cid, dtt.storage.buffvoc3, 0)
    doPlayerSetStorageValue(cid, dtt.storage.buffvoc4, 0)
    return true
end