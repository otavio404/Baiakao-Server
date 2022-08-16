local items = {
[1]=2160,
[2]=2157,
[3]=2121}

local stor = (11401+os.date("%Y"))

function onUse(cid)
if getPlayerStorageValue(cid, stor) ~= 1 then
a = math.random(1, #items)
doPlayerAddItem(cid, items[a], 1)
setPlayerStorageValue(cid, stor, 1)
else
doPlayerSendCancel(cid, "Voce ja pegou seu presente.")
end
doPlayerRemoveItem(cid, 11401, 1)
return true
end