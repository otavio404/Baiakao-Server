-- lib and functions by Vitor Bertolucci (Killua)

function warnPlayersWithStorage(storage, value, class, message) -- By Killua
    if not value then value = 1 end
    if not class then class = MESSAGE_SATUS_CONSOLE_WARNING end
    if not storage or not message then return end
    if #getPlayersOnline() == 0 then
        return
    end
    for _, pid in pairs(getPlayersOnline()) do
        if getPlayerStorageValue(pid, storage) == value then
            doPlayerSendTextMessage(pid, class, message)
        end
    if getPlayerAccess(pid) >= 4 then   
        doPlayerSendTextMessage(pid, class, "Message to those with storage "..storage..message) -- Gms will always receive the messages
    end
    end
end

function countDownTeleport(position, duration)
    if duration == 0 or getTileItemById(position, 1387).uid == 0 then
        return
    end
    local minute = duration >= 60
    local dateParameter = minute and "%M:%S" or "%S"
    local color = minute and COLOR_WHITE or COLOR_RED
    doSendAnimatedText(position, os.date(dateParameter, duration), color)
    doSendMagicEffect(position, minute and CONST_ME_MAGIC_BLUE or CONST_ME_MAGIC_RED)
    if not minute then
        if duration % 10 == 0 then
            doSendMagicEffect(position, CONST_ME_TUTORIALARROW)
        end
    end
    addEvent(countDownTeleport, 1000, position, duration - 1)
end

function isWalkable(pos, checkCreatures, checkStairs, checkPZ, checkFields)
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then return false end
    if checkCreatures and getTopCreature(pos).uid > 0 then return false end
    if checkPZ and getTilePzInfo(pos) then return false end
    for i = 0, 255 do
        pos.stackpos = i
        local tile = getTileThingByPos(pos)
        if tile.itemid ~= 0 and not isCreature(tile.uid) then
            if hasProperty(tile.uid, CONST_PROP_BLOCKPROJECTILE) or hasProperty(tile.uid, CONST_PROP_IMMOVABLEBLOCKSOLID) or (hasProperty(tile.uid, CONST_PROP_BLOCKPATHFIND) and not((not checkFields and getTileItemByType(pos, ITEM_TYPE_MAGICFIELD).itemid > 0) or hasProperty(tile.uid, CONST_PROP_HASHEIGHT) or hasProperty(tile.uid, CONST_PROP_FLOORCHANGEDOWN) or hasProperty(tile.uid, CONST_PROP_FLOORCHANGEUP))) then
                return false
            elseif checkStairs then
                if hasProperty(tile.uid, CONST_PROP_FLOORCHANGEDOWN) or hasProperty(tile.uid, CONST_PROP_FLOORCHANGEUP) then
                    return false
                end
            end
        else
            break
        end
    end
    return true
end

function isWalkable(cid, pos, considerCreatures) -- By Killua
    if considerCreatures == nil then considerCreatures = true end
    if getTopCreature(pos).uid and getTopCreature(pos).uid > 0 then
        if considerCreatures then return false else return true end
    end 
    pos.stackpos = 0
    if getTileThingByPos(pos).uid ~= 0 then
        if doTileQueryAdd(cid, pos) == RETURNVALUE_NOERROR then
            return true
        end
    end
    return false
end

function getPlayerStorageZero(cid, storage) -- By Killua
    local sto = getPlayerStorageValue(cid, storage)
    return sto > 0 and sto or 0
end

function getStorageZero(storage) -- By Killua
    local sto = getGlobalStorageValue(storage)
    return sto > 0 and sto or 0
end

function countTable(table) -- By Killua
    local y = 0
    if type(table) == "table" then
        for _ in pairs(table) do
            y = y + 1
        end
        return y
    end
    return false
end

function getTimeString(self)
    local format = {
        {'dia', self / 60 / 60 / 24},
        {'hora', self / 60 / 60 % 24},
        {'minuto', self / 60 % 60},
        {'segundo', self % 60}
    }
    
    local out = {}
    for k, t in ipairs(format) do
        local v = math.floor(t[2])
        if(v > 0) then
            table.insert(out, (k < #format and (#out > 0 and ', ' or '') or ' e ') .. v .. ' ' .. t[1] .. (v ~= 1 and 's' or ''))
        end
    end
    local ret = table.concat(out)
    if ret:len() < 16 and ret:find('segundo') then
        local a, b = ret:find(' e ')
        ret = ret:sub(b+1)
    end
    return ret
end

function isPlayerOnline(name)
    local queryResult = db.storeQuery("SELECT `online` FROM `players` WHERE `name` = '"..name.."'")
    local result = result.getDataInt(queryResult, "online") > 0 and true or false
    return result
end

function getItemNameByCount(itemID, count)
    if tonumber(count) and count > 1 and isItemStackable(itemID) then
        return getItemInfo(itemID).plural
    end
    return getItemNameById(itemID)
end

function getOfflinePlayerStorage(guid, storage)
    if not isPlayerOnline(getPlayerNameByGUID(guid)) then
        local queryResult = db.storeQuery("SELECT `value` FROM `player_storage` WHERE `key` = '"..storage.."' and `player_id` = "..guid.."")
        local result = queryResult and result.getDataInt(queryResult, "value") or -1
        return result
    end
end

function setOfflinePlayerStorage(guid, storage, value)
    if not isPlayerOnline(getPlayerNameByGUID(guid)) then
        db.query("UPDATE `player_storage` SET `value` = '"..value.."' WHERE `key` = '"..storage.."' and `player_id` = "..guid.."")
    end
end



function timeString(timeDiff,english)
    local dateFormat = {}

    if english then

        dateFormat = {
            {"day", timeDiff / 60 / 60 / 24},
            {"hour", timeDiff / 60 / 60 % 24},
            {"minute", timeDiff / 60 % 60},
            {"second", timeDiff % 60}
        }

    else

        dateFormat = {
            {"dia", timeDiff / 60 / 60 / 24},
            {"hora", timeDiff / 60 / 60 % 24},
            {"minuto", timeDiff / 60 % 60},
            {"segundo", timeDiff % 60}
        }
        
    end

    local out = {}
    for k, t in ipairs(dateFormat) do
        local v = math.floor(t[2])
        if(v > 0) then
            table.insert(out, (k < #dateFormat and (#out > 0 and ', ' or '') or ' e ') .. v .. ' ' .. t[1] .. (v ~= 1 and 's' or ''))
        end
    end
    
    return table.concat(out)
end

function getPlayersInArea(frompos, topos) -- By Killua
    local players_ = {}
    local count = 1
    for _, pid in pairs(getPlayersOnline()) do
        if isInArea(getCreaturePosition(pid), frompos, topos) then
            players_[count] = pid
            count = count + 1
        end
    end
    return countTable(players_) > 0 and players_ or false
end

function getGuildNameById(gid) -- By Killua
    local query = db.getResult("SELECT `name` FROM `guilds` WHERE `id` = '"..gid.."'")
    if query:getID() == -1 then
        return ""
    end
    local name = query:getDataString("name")
    query:free()
    return name
end

function getContainerItemsInfo(containerUid) -- By Killua
    local table = {}
    if containerUid and containerUid > 0 then
        local a = 0   
        for i = 0, getContainerSize(containerUid) - 1 do
            local item = getContainerItem(containerUid,i)
            a = a + 1
            table[a] = {uid = item.uid, itemid = item.itemid, quant = item.type}
        end
        return table
    end
    return false
end

function getTableEqualValues(table) -- By Killua
    local ck = {}
    local eq = {}
    if type(table) == "table" then
        if countTable(table) and countTable(table) > 0 then
            for i = 1, countTable(table) do
                if not isInArray(ck, table[i]) then
                    ck[i] = table[i]
                else
                    eq[i] = table[i]
                end
            end
            return countTable(eq) > 0 and eq or 0
        end
    end
    return false
end

function killuaGetItemLevel(uid) -- By Killua
    local name = getItemName(uid)
    local pos = 0
    for i = 1, #name do
        if string.byte(name:sub(i,i)) == string.byte('+') then
            pos = i + 1
            break
        end
    end
    return tonumber(name:sub(pos,pos))
end

k_table_storage_lib = {
    filtrateString = function(str) -- By Killua
        local tb, x, old, last = {}, 0, 0, 0
        local first, second, final = 0, 0, 0
        if type(str) ~= "string" then
            return tb
        end
        for i = 2, #str-1 do
            if string.byte(str:sub(i,i)) == string.byte(':') then
                x, second, last = x+1, i-1, i+2
                for t = last,#str-1 do
                    if string.byte(str:sub(t,t)) == string.byte(',') then
                        first = x == 1 and 2 or old
                        old, final = t+2, t-1
                        local index, var = str:sub(first,second), str:sub(last,final)
                        tb[tonumber(index) or tostring(index)] = tonumber(var) or tostring(var)
                        break
                    end
                end
            end
        end
        return tb
    end,

    translateIntoString = function(tb) -- By Killua
        local str = ""
        if type(tb) ~= "table" then
            return str
        end
        for i, t in pairs(tb) do
            str = str..i..": "..t..", "
        end
        str = "a"..str.."a"
        return tostring(str)
    end
}

function setPlayerTableStorage(cid, key, value) -- By Killua
    return doPlayerSetStorageValue(cid, key, k_table_storage_lib.translateIntoString(value))
end

function getPlayerTableStorage(cid, key) -- By Killua
    return k_table_storage_lib.filtrateString(getPlayerStorageValue(cid, key))
end

function setGlobalTableStorage(key, value) -- By Killua
    return setGlobalStorageValue(key, k_table_storage_lib.translateIntoString(value))
end

function getGlobalTableStorage(key) -- By Killua
    return k_table_storage_lib.filtrateString(getGlobalStorageValue(key))
end

function printTable(_table)
    local function getTable(_table, expand, tabs)
        
        local aux = ""
        if not type(_table) == "table" then
            return _table
        else
            for key,value in pairs(_table) do
                if type(value) == "table" then
                
                    for i = 1, tabs -1 do
                        aux = aux.."\t"
                    end
                    
                    if type(key)  == "string" then
                        aux = aux.. '["'..key..'"] =\t{ \n'..getTable(value, true, tabs +1)
                    else
                        aux = aux.. "["..key.."] =\t{ \n"..getTable(value, true, tabs +1)
                    end
                    
                    for i = 1, tabs do
                        aux = aux.. "\t"
                    end
                    
                    aux = aux.."},\n"               
                else
                    if expand then
                        for i = 1, tabs -1 do
                            aux = aux.. "\t"
                        end
                    end
                    if type(key)  == "string" then
                        aux = aux.. '["'..key..'"] = '..(type(value) == "string" and '"'..value..'"' or tostring(value))..",\n"
                    else
                        aux = aux.. '['..key..'] = '..(type(value) == "string" and '"'..value..'"' or tostring(value))..",\n"
                    end
                end
            end
        end

        return aux
    end
    if type(_table) == "table" then
        print(getTable(_table, false, 1))
        return true
    else
        error("Parameter is not a table!")
        return false
    end
end

function printTable(table, includeIndices,prnt) -- By Killua
    if includeIndices == nil then includeIndices = true end
    if prnt == nil then prnt = true end
    if type(table) ~= "table" then
        error("Argument must be a table")
        return
    end
    local str, c = "{", ""
    for v, b in pairs(table) do
        if type(b) == "table" then
            str = includeIndices and str..c.."["..v.."]".." = "..printTable(b,true,false) or str..c..printTable(b,false,false)
        else
            str = includeIndices and str..c.."["..v.."]".." = "..b or str..c..b
        end
        c = ", "
    end
    str = str.."}"
    if prnt then print(str) end
    return str
 end
 
function hasPokemon_two(cid, poke, ammount) -- By Killua
    local ammount, balls = ammount or 1, 0
    local items = getContainerItemsInfo(getPlayerSlotItem(cid, 10).uid)
    local slot = getPlayerSlotItem(cid,8).uid
    local slot_name = slot > 0 and getItemAttribute(slot, "name") or "nao tem"
    if string.find(string.lower(slot_name), string.lower(poke)) then
        balls = balls + 1
    end
    for _, item in pairs(items) do
        if isInArray({2557, 2653, 2532, 2652, 2654, 2195, 2531, 2557, 2524, 2525, 2523, 11751, 11752, 2533, 2534}, item.itemid) then
            local name = getItemAttribute(item.uid, "name")
            if string.find(string.lower(name),string.lower(poke)) then
                balls = balls + 1
            end
        end
    end
    if balls >= ammount then
        return true
    end
    return false
end

function agreeNPC(msg) -- By Killua
    return isInArray({"sim","yes","si"},msg)
end

function disagreeNPC(msg) -- By Killua
    return isInArray({"não","nao","no"},msg)
end

agreeNpc = agreeNPC
disagreeNpc = disagreeNPC

function isInBike(cid) -- By Killua
    local bike = getPlayerSlotItem(cid, 9)
    if bike and bike.itemid > 0 then
        if isInArray({2565, 12628, 12629, 12630, 12631}, bike.itemid) then return true end
    end
    return false
end

function existMonsterByName(name) -- By Vodkart
    if type(name) ~= "string" then error("argument must be a string!") end
       local monsters = io.open("data/monster/monsters.xml","r")
       local str = monsters:read("*all")
       monsters:close();
       if string.find(str:lower(),name:lower()) then return true end
    return false
end

function getTomorrowsDate(today) -- By Killua
    today = today or tonumber(os.date("%d"))
    months = {[1] = 31,[2] = 29,[3] = 31,[4] = 30,[5] = 31,[6] = 30,[7] = 31,[8] = 31,[9] = 30,[10] = 31,[11] = 30,[12] = 31}
    
    local month = tonumber(os.date("%m"))
    local max = months[month]
    local tomorrow = today + 1
    if tomorrow > max then
        tomorrow = 1
        month = month + 1
    end
    if month > 12 then month = 1 end
    local year = tonumber(os.date("%Y"))
    return {tomorrow,month,year}
end

function getAccountStorageValue(accid, key)
    local value = db.getResult("SELECT `value` FROM `account_storage` WHERE `account_id` = " .. accid .. " and `key` = " .. key .. " LIMIT 1;")
    if(value:getID() ~= -1) then
        return tonumber(value:getDataInt("value"))
    end
    return tonumber(-1)
end

function setAccountStorageValue(accid, key, value)
    local getvalue = db.getResult("SELECT `value` FROM `account_storage` WHERE `account_id` = " .. accid .. " and `key` = " .. key .. " LIMIT 1;")
    if(getvalue:getID() ~= -1) then
        db.executeQuery("UPDATE `account_storage` SET `value` = '" .. value .. "' WHERE `key`= '" .. key .. "' AND `account_id` = '" .. accid .. "'")
        return true
    else
        db.executeQuery("INSERT INTO `account_storage` (`account_id`, `key`, `value`) VALUES ('" .. accid .. "', '" .. key .. "', '"..value.."');")
        return true
    end
end

function getPlayerBuggedSkills(cid)
    return getPlayerStorageValue(cid,722601) > -1 or getPlayerStorageValue(cid,722651) > -1 -- Bomberman e Kamikaze
    --[[local bug, skill = false, 0
    if getPlayerMagLevel(cid) >= 400 then
        skill = 7
        bug = true
    end
    for i = 0,5 do
        if getPlayerSkillLevel(cid,i) >= 400 then
            skill = i
            bug = true
            break;
        end
    end
    if bug then
        local arquivo = io.open("bug.txt",'a+')
        arquivo:write("Player "..getCreatureName(cid).." bugou o skill de número "..skill..". A vocação dele no momento era "..getPlayerVocation(cid).."\n")
        arquivo:flush()
        arquivo:close()
    end
    return bug]]

end

function startAura(cid) -- By Killua
    if not isPlayer(cid) then return end
    local strings = {", ` ´",". ´ ` ,",", ´ `","´ ` ,",", `"}
    doSendAnimatedText(getThingPos(cid),strings[math.random(1,#strings)],19)
    addEvent(startAura,1250,cid)
end

function getOnlineGuildMembersByRank(guildId, rank, selectLowerRanks) -- By Omega
    if not rank then
        rank = 3
        selectLowerRanks = true
    end
    local list = {}
    for _, pid in pairs(getPlayersOnline()) do
        if getPlayerGuildId(pid) == guildId then
            local playerRank = getPlayerGuildLevel(pid)
            if playerRank == rank or (selectLowerRanks and playerRank <= rank) then
                table.insert(list, pid)
            end
        end
    end
    return list
end

function startSpiritualAura(cid) -- By Killua
    if not isPlayer(cid) then return end
    local pos = getThingPos(cid)
    doSendMagicEffect(pos, 60)
    doSendMagicEffect(pos, 59)
    addEvent(startSpiritualAura,1250,cid)
end

-------------------------------------
-- Retorna um horário completo como segundos
-- @param str string de hora ("11:45:10")
-- @return valor em segundos das horas + minutos + segundos
-------------------------------------  
function hourToNumber(str) -- By Killua
    local hour = (tonumber(str:sub(1,2))*3600) + (tonumber(str:sub(4,5)) * 60)
    if #str > 5 then
        hour = hour + tonumber(str:sub(7,8))
    end
    return hour
end
-------------------------------------
-- Remove um elemento de uma tabela a partir do valor e não do índice
-- @param table tabela
-- @param value valor a ser removido
-- @return index que foi removido
-------------------------------------   
function killuaTableRemove(table, value)
    for index, key in next, table do
        if key == value then
            table[index] = nil
            return index
        end
    end
end

-------------------------------------
-- Conta quantos slots vazios tem em um container
-- @param container uid do container
-- @return número de slots
------------------------------------- 
function getContainerFreeSlots(container)
    local size = getContainerSize(container)
    local slots = getContainerCap(container) - size
    for i = 0, size - 1 do
        local item = getContainerItem(container, i)
        if isContainer(item.uid) then
            slots = slots + getContainerFreeSlots(item.uid)
        end
    end
    return slots
end
-------------------------------------
-- Verifica se um jogador pode receber determinada quantia de um item
-- @param cid do jogador
-- @param itemId id do item
-- @param ammount quantidade do item a ser adicionado
-- @return true ou false
------------------------------------- 
function canPlayerReceiveItem(cid, itemId, ammount)
    local weight = getItemWeightById(itemId, ammount, true)
    if isItemStackable(itemId) then
        ammount = math.ceil(ammount / 100)
    end
    local freeCap = getPlayerFreeCap(cid)
    local freeSlots = 0
    if weight <= freeCap then
        local backpack = getPlayerSlotItem(cid, CONST_SLOT_BACKPACK)
        if backpack.uid > 0 and isContainer(backpack.uid) then
            return getContainerFreeSlots(backpack.uid) >= ammount
        end
    end
    return false
end

-------------------------------------
-- Busca por uma string dentro da outra e retorna a posição de seu último caractere
-- @str string a ser vasculhada
-- @sequence string que deve ser encontrada
-- @return posição do último caractere da string encontrada
-------------------------------------
local function findSequence(str, sequence)
    local lastChar, check = 0, false
    for i = 1, #str do
        for o = 1, #sequence do
            if string.byte(str:sub(i + o, i + o)) == string.byte(sequence:sub(o, o)) then
                check = true
                lastChar = o
            else
                check = false
                break
            end
        end
        if check then
            return (i + lastChar + 1)
        end
    end
    return false
end
-------------------------------------
-- Retorna o worldId do servidor
-- @return valor da variável worldId no config.lua
-------------------------------------
function getWorldId()
    return getConfigValue('worldId')
end

function executeSpell(cid, combat, var, nome, time, storage) -- By Killua

    local value = getPlayerStorageValue(cid,storage)
    if value >= os.time() then
        return false --doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, nome.." está em cooldown por ".. value - os.time().." segundos")
    else
        doPlayerSetStorageValue(cid, storage, time + os.time())
        --[[addEvent(function()
            if isPlayer(cid) then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, nome.." está pronta para ser usada")
            end
        end,time * 1000)]]
        return doCombat(cid,combat,var)
    end
end

function checkString(str) -- By Killua
    local check = true
    for i = 1, #str do
        local letra = string.byte(str:sub(i,i))
        if letra >= string.byte('a') and letra <= string.byte('z') or letra >= string.byte('A') and letra <= string.byte('Z') or letra >= string.byte('0') and letra <= string.byte('9') then
            check = true
        else
            check = false
            break
        end
    end
    return check
end

function isArmor(itemid) -- By Killua
    return getItemInfo(itemid).armor > 0
end

function isWeapon(uid) -- By Killua
    return getItemWeaponType(uid) ~= 0
end

function isShield(uid) -- By Killua
    return getItemWeaponType(uid) == 5
end

function isSword(uid) -- By Killua
    return getItemWeaponType(uid) == 1
end

function isClub(uid) -- By Killua
    return getItemWeaponType(uid) == 2
end

function isAxe(uid) -- By Killua
    return getItemWeaponType(uid) == 3
end

function isBow(uid) -- By Killua
    return getItemWeaponType(uid) == 4
end

function isWand(uid) -- By Killua
    return getItemWeaponType(uid) == 7
end