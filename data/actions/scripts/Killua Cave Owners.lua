local storage = 71201

local function filtrateString(str)
    if type(str) ~= "string" then
        return false
    end
    local first, last = 0, 0
    local second, final = 0, #str
    for i = 1, #str do
        if string.byte(str:sub(i,i)) == string.byte('a') then
            first = i + 2
            for t = first, #str do
                if string.byte(str:sub(t,t)) == string.byte(' ') then
                    last = t - 1
                    break
                end
            end
        end
        if string.byte(str:sub(i,i)) == string.byte('b') then
            second = i + 2
        end
    end
    return {str:sub(first, last), str:sub(second, final)}
end


function onUse(cid, item, fromPosition, itemEx, toPosition)
    if getPlayerLevel(cid) > 550 then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você é maior que level 550, porém não pode usar a cave exclusiva.")
        return false
    end
    if getPlayerStorageValue(cid, storage) - os.time() >= 0 then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você já é dono de uma Cave!")
        return false
    end
    -- 
    for i = 1, 18 do
        if tonumber(filtrateString(getGlobalStorageValue(822080 + i))[2]) < os.time() then
            doRemoveItem(item.uid)
            setGlobalStorageValue(822080 + i, "a "..getPlayerGUID(cid).." b ".. os.time() + (3600 * 3))
            doPlayerSendTextMessage(cid, 25, "Agora você é o dono da cave ".. i .." e pode upar lá por 3 horas.")
            setPlayerStorageValue(cid, storage, os.time() + (3600 * 3))
            return true
        end
    end
    doPlayerSendCancel(cid, "Todas as caves já estão com dono no momento. Tente mais tarde.")
    return true
end