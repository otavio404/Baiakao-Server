function ExistItemByName(name) -- by vodka
    local items = io.open("data/items/items.xml", "r"):read("*all")
    local get = items:match('name="' .. name ..'"')
    if get == nil or get == "" then
        return false
    end
    return true
end

local function getPlayerList(cid)
    local tab = {}
    if getPlayerStorageValue(cid, 04420021) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420021))
    end
    if getPlayerStorageValue(cid, 04420031) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420031))
    end
    if getPlayerStorageValue(cid, 04420041) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420041))
    end
    if getPlayerStorageValue(cid, 04420051) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420051))
    end
    if #tab > 0 then
        return tab
    end
    return false
end

local function addToList(cid, name)
    local itemid = getItemIdByName(name)
    if getPlayerList(cid) and isInArray(getPlayerList(cid), itemid) then
        return false
    end
    if getPlayerStorageValue(cid, 04420021) == -1 then
        return doPlayerSetStorageValue(cid, 04420021, itemid)
    elseif getPlayerStorageValue(cid, 04420031) == -1 then
        return doPlayerSetStorageValue(cid, 04420031, itemid)
    elseif getPlayerStorageValue(cid, 04420041) == -1 then    
        return doPlayerSetStorageValue(cid, 04420041, itemid)
    elseif getPlayerStorageValue(cid, 04420051) == -1 then
        return doPlayerSetStorageValue(cid, 04420051, itemid)
    end
end

local function removeFromList(cid, name)
    local itemid = getItemIdByName(name)
    if getPlayerStorageValue(cid, 04420021) == itemid then
        return doPlayerSetStorageValue(cid, 04420021, -1)
    elseif getPlayerStorageValue(cid, 04420031) == itemid then
        return doPlayerSetStorageValue(cid, 04420031, -1)
    elseif getPlayerStorageValue(cid, 04420041) == itemid then
        return doPlayerSetStorageValue(cid, 04420041, -1)
    elseif getPlayerStorageValue(cid, 04420051) == itemid then
        return doPlayerSetStorageValue(cid, 04420051, -1)
    end
    return false
end

function onSay(cid, words, param)
if(not checkExhausted(cid, 664, 5)) then
return false
end
    if param == "" then
        local fi = getPlayerStorageValue(cid, 04420021) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420021)) or ""
        local se = getPlayerStorageValue(cid, 04420031) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420031)) or ""
        local th = not isPremium(cid) and "N�o dispon�vel para free account" or getPlayerStorageValue(cid, 04420041) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420041)) or ""
        local fo = not isPremium(cid) and "N�o dispon�vel para free account" or getPlayerStorageValue(cid, 04420051) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420051)) or ""
        local stt = getPlayerStorageValue(cid, 04421011) == 1 and "sim" or "n�o"
        local str = getPlayerStorageValue(cid, 04421001) == 1 and "sim" or "n�o"
        doPlayerPopupFYI(cid, "                                                          <--- Informa��es Do Auto Loot --->\n{Auto-Loot} ---Coletar dinheiro,  Ligado? ("..stt.."). Para ligar ou desligar, digite: !autoloot gold \n{Auto-Loot} ---Coletar itens, Ligado? ("..str.."). Para ligar ou desligar, digite: !autoloot power\n\n{Auto-Loot} --Configura��o Dos Slots:\n{Auto-Loot} ---Slot 1: "..fi.."\n{Auto-Loot} ---Slot 2: "..se.."\n{Auto-Loot} ---Slot 3: "..th.."\n{Auto-Loot} ---Slot 4: "..fo.."\n\n{Auto-Loot} ---Para adicionar um novo item no autoloot, digite: !autoloot add, <nome do item>\n{Auto-Loot} ---Para retirar um item do autoloot, digite: !autoloot remove, <nome do item>\n{Auto-Loot} ---Para limpar todos os slots, digite: !autoloot clear\n{Auto-Loot} ---Para informa��es de quanto voc� j� fez utilizando a coleta de dinheiro, use: !autoloot goldinfo\n\nSe seu autoloot bugar use !autoloot desbug.")
        return true
    end
    
    local t = string.explode(param, ",")
    
    if t[1] == "power" then
        local check = getPlayerStorageValue(cid, 04421001) == -1 and "ligou" or "desligou"
        doPlayerSetStorageValue(cid, 04421001, getPlayerStorageValue(cid, 04421001) == -1 and 1 or -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Voc� "..check.." o auto loot.")
    elseif t[1] == "gold" then
        local check = getPlayerStorageValue(cid, 04421011) == -1 and "ligou" or "desligou"
        doPlayerSetStorageValue(cid, 04421011, getPlayerStorageValue(cid, 04421011) == -1 and 1 or -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Voc� "..check.." a coleta de dinheiro.")
        doPlayerSetStorageValue(cid, 04421021, 0)
    elseif t[1] == "goldinfo" then
        local str = getPlayerStorageValue(cid, 04421011) == -1 and "O sistema de coleta de dinheiro est� desligado" or "O sistema j� coletou "..getPlayerStorageZero(cid, 04421021).." gold coins"
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, str)
    elseif t[1] == "add" then
        if ExistItemByName(t[2]) then
            local item = getItemIdByName(t[2])
            if isInArray({2160, 2148, 2152, 2157, 9971}, item) then
                return doPlayerSendCancel(cid, "Voc� n�o pode adicionar moedas no autoloot. Para coletar dinheiro use !autoloot gold")
            end
            if isPremium(cid) then
                if getPlayerStorageValue(cid, 04420011) < 3 then
                    if addToList(cid, t[2]) then
                        doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) + 1)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." adicionado � sua lista do auto loot! Para ver sua lista diga !autoloot list")
                    else
                        doPlayerSendCancel(cid, t[2].." j� est� em sua lista!")
                    end
                else
                    doPlayerSendCancel(cid, "Sua lista j� est� cheia! Voc� deve remover algum antes de adicionar outro.")
                end
            else
                if getPlayerStorageValue(cid, 04420011) < 3 then
                    if addToList(cid, t[2]) then
                        doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) + 1)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." adicionado � sua lista do auto loot! Para ver sua lista diga !autoloot")
                    else
                        doPlayerSendCancel(cid, t[2].." j� est� em sua lista!")
                    end
                else
                    doPlayerSendCancel(cid, "Sua lista j� est� cheia! Voc� deve remover algum antes de adicionar outro.")
                end
            end
        else
            doPlayerSendCancel(cid, "Este item n�o existe!")
        end
    elseif t[1] == "remove" then
        if ExistItemByName(t[2]) then
            if removeFromList(cid, t[2]) then
                doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) - 1)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." removido da sua lista do auto loot!")
            else
                doPlayerSendCancel(cid, "Este item n�o est� na sua lista!")
            end
        else
            doPlayerSendCancel(cid, "Este item n�o existe!")
        end
    elseif t[1] == "clear" then
        if getPlayerStorageValue(cid, 04420011) > -1 then
            doPlayerSetStorageValue(cid, 04420011, -1)
            doPlayerSetStorageValue(cid, 04420021, -1)
            doPlayerSetStorageValue(cid, 04420031, -1)
            doPlayerSetStorageValue(cid, 04420041, -1)
            doPlayerSetStorageValue(cid, 04420051, -1)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Lista limpa!")
        else
            doPlayerSendCancel(cid, "Sua lista ja esta limpa!")
        end
    elseif t[1] == "desbug" or t[1] == "desbugar" then
        doPlayerSetStorageValue(cid, 04420011, -1)
        doPlayerSetStorageValue(cid, 04420021, -1)
        doPlayerSetStorageValue(cid, 04420031, -1)
        doPlayerSetStorageValue(cid, 04420041, -1)
        doPlayerSetStorageValue(cid, 04420051, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Desbugado!")
    elseif t[1] == "list" then
        local fi = getPlayerStorageValue(cid, 04420021) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420021)).."\n" or ""
        local se = getPlayerStorageValue(cid, 04420031) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420031)).."\n" or ""
        local th = getPlayerStorageValue(cid, 04420041) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420041)).."\n" or ""
        local fo = getPlayerStorageValue(cid, 04420051) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420051)).."\n" or ""
        doPlayerPopupFYI(cid, "O sistema auto loot est� coletando:\n "..fi..""..se..""..th..""..fo)
    end
    return true
end 