local t = {kick = false, temple = true,
areas = {
[1] = {{x = 1308, y = 1688, z = 7}, {x = 1336, y = 1717, z = 7}},
[2] = {{x = 1318, y = 1698, z = 6}, {x = 1335, y = 1715, z = 6}},
[3] = {{x = 1316, y = 1705, z = 8}, {x = 1368, y = 1764, z = 8}},
[4] = {{x = 3154, y = 278, z = 7}, {x = 3223, y = 331, z = 7}}
}}

function onThink(interval, lastExecution)
local total = 0 
for _, v in pairs(t.areas) do
    total = total + removeAllMcInArea(v[1], v[2], t.kick, t.temple)
end
return true
end

function removeAllMcInArea(fromPosition, toPosition, kick, toTemple) -- by dwarfer
    local players, check, freq, remove, removeall = {}, {}, {}, {}, {}
    for _, pid in ipairs(getPlayersOnline()) do
        local f = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z}
        local t = {x = toPosition.x, y = toPosition.y, z = toPosition.z}
        local min = (fromPosition.z > toPosition.z and toPosition.z or fromPosition.z)
        for index = 0, math.abs(toPosition.z - fromPosition.z) do
            f.z = min + index
            t.z = min + index
            if isInRange(getPlayerPosition(pid), f, t) then
                table.insert(players, pid)
            end
        end    
    end
    if #players > 0 then
        for _, player in pairs(players) do
            table.insert(check, getPlayerIp(player))
        end
    end
    for _, v in pairs(check) do
        freq[v] = (freq[v] or 0) + 1
    end
    for ip, ip_freq in pairs(freq) do 
        if ip_freq > 1 then
           local text = ""
            local mc = getPlayersByIp(ip)
           for i = 1, #mc do
                if isInArray(players, mc[i]) and getPlayerAccess(mc[i]) < 3 then
                    text = text .. "" .. mc[i] .. ","
                end
            end
            remove[ip] = text
        end
    end
    for ip, players in pairs(remove) do
        ret = string.explode(players, ",")
        for i = 1, (#ret-2) do
            removeall[#removeall + 1] = ret[i]
        end
    end
    for _, tid in pairs(removeall) do
        if kick then
            if toTemple == false then
                doRemoveCreature(tid)
            else
                doTeleportThing(tid, getTownTemplePosition(getPlayerTown(tid)))
                doRemoveCreature(tid)
            end
        else
            doTeleportThing(tid, getTownTemplePosition(getPlayerTown(tid)))
        end
    end
    return #removeall
end