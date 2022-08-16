terra = {351,352,353,354,355,5645,5634,5631,5635,5632,5636,5633,5647,5650,5649,5637,5638}
 levels = {
[-1] = 2229, ---- skull
[0] = 1294, --- small stone
[1] = 3976, --- worm
[10] = 2149, -- Small Emerald
[12] = 2146, -- Small Sapphire
[15] = 2145, -- Small Diamond 
[25] = 2144, -- Black Pearls 
[27] = 2143, -- White Pearls
[30] = 2177, -- Life Crystal
[40] = 2160,  -- crystal coin
[50] = 5904,  -- magic sulphur
[70] = 6527  -- event coin
} 


local config = {
storage = 19333,
chance = 40, --- chance de achar um item ou n�o
k = 0.2, --- constante de level.. quanto maior, mais f�cil � upar. (a f�rmula � level ao quadrado dividido pela constante)
experience = 19334
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(itemEx.uid <= 65535 or itemEx.actionid > 0) and (itemEx.itemid == 354 or itemEx.itemid == 355) then
		doTransformItem(itemEx.uid, 392)
		doDecayItem(itemEx.uid)
		doSendMagicEffect(toPosition, CONST_ME_POFF)
		return TRUE
	end

local drops = {}


function getDrops(cid)
for i= -1,getPlayerStorageValue(cid, config.storage) do
if levels[i] then
table.insert(drops, levels[i])
end
end
return true
end


if isInArray(terra, itemEx.itemid) then
getDrops(cid)
doPlayerSetStorageValue(cid, config.experience, getPlayerStorageValue(cid, config.experience)+1)
local experience = getPlayerStorageValue(cid, config.experience)
if experience >= (8+(getPlayerStorageValue(cid, config.storage)^2))/config.k then
doPlayerSetStorageValue(cid, config.storage, getPlayerStorageValue(cid, config.storage)+1)
doPlayerSendTextMessage(cid, 27, "Congratulations, you have leveled! Your currect level is "..getPlayerStorageValue(cid, config.storage) ..".")
if getPlayerStorageValue(cid, config.storage) == 50 then
doPlayerSendTextMessage(cid, 20, "For reaching level "..getPlayerStorageValue(cid, config.storage) .." you have been awarded with Mining Helmet.")
doPlayerAddItem(cid, 7497, 1)
end
end
if config.chance >= math.random(1,100) then
if #drops >= 1 then
local item = drops[math.random(1,#drops)]
doPlayerSendTextMessage(cid, 27, "You have found a "..getItemNameById(item)..".")
doPlayerAddItem(cid, item, 1)
end
doSendMagicEffect(toPosition, 3)
else
doSendMagicEffect(toPosition, 2)
return true
end
elseif itemEx.itemid == item.itemid then
doPlayerSendTextMessage(cid, 27, "You're currenctly level "..getPlayerStorageValue(cid, config.storage)..".")
else
return false
end
return true
end
