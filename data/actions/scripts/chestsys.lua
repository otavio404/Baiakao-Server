local chests = {
[6000] = {storage = 8000, item = 7458, amount = 1}, -- Insanity Mage Hat
[6001] = {storage = 8001, item = 7463, amount = 1}, -- Insanity Mage Robe
[6002] = {storage = 8002, item = 7464, amount = 1}, -- Insanity Mage Legs

[6003] = {storage = 8000, item = 2474, amount = 1}, -- Insanity Knight Helmet
[6004] = {storage = 8001, item = 12647, amount = 1}, -- Insanity Knight Armor
[6005] = {storage = 8002, item = 12648, amount = 1}, -- Insanity Knight Legs

[6006] = {storage = 8000, item = 12636, amount = 1}, -- Insanity Paladin Helmet
[6007] = {storage = 8001, item = 12637, amount = 1}, -- Insanity Paladin Armor
[6008] = {storage = 8002, item = 12638, amount = 1}, -- Insanity Paladin Legs

[6009] = {storage = 8003, item = 12612, amount = 1}, -- Blessed Cursed 
[6010] = {storage = 8003, item = 12399, amount = 1}, -- Magician Cursed
[6011] = {storage = 8003, item = 12611, amount = 1}, -- Ranger Cursed

[6012] = {storage = 8004, item = 2390, amount = 1}, -- Assault Sword
[6013] = {storage = 8004, item = 2444, amount = 1}, -- Assault Club
[6014] = {storage = 8004, item = 8925, amount = 1}, -- Assault Axe
[6015] = {storage = 8004, item = 7438, amount = 1}, -- Assault Bow
[6016] = {storage = 8004, item = 2453, amount = 1}, -- Assault Staff

[6017] = {storage = 8005, item = 2179, amount = 1}, -- Gold Ring

[6018] = {storage = 8006, item = 2471, amount = 1}, -- Golden Helmet
[6019] = {storage = 8007, item = 2523, amount = 1}, -- Blessed Shield

[6020] = {storage = 8008, item = 2155, amount = 1}, -- Green Gem
[6021] = {storage = 8008, item = 2154, amount = 1}, -- Yellow Gem
[6022] = {storage = 8008, item = 2156, amount = 1}, -- Red Gem

[6023] = {storage = 8009, item = 8918, amount = 1}, -- Spellbook Of Dark Mysteries
[6024] = {storage = 8009, item = 8888, amount = 1}, -- Master Archer's Armor
[6025] = {storage = 8009, item = 8890, amount = 1}, -- Robe Of The Underworld
[6026] = {storage = 8009, item = 8881, amount = 1}, -- Fireborn Giant Armor
[6027] = {storage = 8009, item = 8928, amount = 1}, -- Obsidian Truncheon
[6028] = {storage = 8009, item = 8851, amount = 1}, -- Royal Crossbow
[6029] = {storage = 8009, item = 8856, amount = 1}, -- Yol's Bow

[6030] = {storage = 8010, item = 12396, amount = 5}, -- Critical Stone
[6031] = {storage = 8011, item = 7697, amount = 1}, -- Promote Ring

[6032] = {storage = 8012, item = 7443, amount = 1}, -- Double Exp
[6033] = {storage = 8013, item = 2346, amount = 1}, -- Stamina Potion

[6034] = {storage = 8014, item = 9693, amount = 1}, -- Addon Doll
[6035] = {storage = 8015, item = 12575, amount = 5}, -- Dodge Stone

[6036] = {storage = 8016, item = 12644, amount = 1}, -- Donate Mage's Shoes
[6037] = {storage = 8016, item = 5462, amount = 1}, -- Donate Paladin Boots
[6038] = {storage = 8016, item = 12649, amount = 1}, -- Donate Knight Boots

[6039] = {storage = 8017, item = 8907, amount = 1}, -- Donate Mage's Shield
[6040] = {storage = 8017, item = 2527, amount = 1}, -- Donate Paladin Shield
[6041] = {storage = 8017, item = 8906, amount = 1}, -- Donate Knight Shield

[6042] = {storage = 8018, item = 7697, amount = 1}, -- Promote Ring
[6043] = {storage = 8019, item = 9693, amount = 1}, -- Addon Doll

[6044] = {storage = 8020, item = 8981, amount = 1}, -- Cave Exclusiva

[6045] = {storage = 8021, item = 11253, amount = 1}, -- Aura

[6046] = {storage = 8022, item = 11249, amount = 1}, -- Autoloot Boost

[6047] = {storage = 8023, item = 5801, amount = 1}, -- Super Backpack

[6048] = {storage = 8024, item = 6574, amount = 1}, -- Chocolate dos Deuses
[6049] = {storage = 8025, item = 2218, amount = 1}, -- Paw Amulet

[6050] = {storage = 8026, item = 2160, amount = 100}, -- Crystal Coin

[6051] = {storage = 8027, item = 7460, amount = 1}, -- Ultra Spellbook
[6052] = {storage = 8027, item = 2517, amount = 1}, -- Ultra Shield

[6053] = {storage = 8028, item = 9933, amount = 1}, -- Ultra Shield

--[6060] = {storage = 88889, item = 0, amount = 0}, -- VIP3
--[6061] = {storage = 88890, item = 0, amount = 0}, -- VIP4
--[6062] = {storage = 88891, item = 0, amount = 0}, -- Warmaster Addon
}

function onUse(cid,item,fromPosition,itemEx,toPosition)
local v = chests[item.uid]
if getPlayerStorageValue(cid, v.storage) ~= -1 then
return doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Voce ja pegou a recompensa.")
elseif getPlayerFreeCap(cid) < (getItemWeightById(v.item)*v.amount) then
return doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Voce precisa de " .. (getItemWeightById(v.item)*v.amount) .. " cap ou de espaço na bp para pegar a recompensa.")
end
if isItemStackable(v.item) or v.amount == 1 then
doPlayerAddItem(cid, v.item, v.amount) 
else
for i = 1, v.amount do 
doPlayerAddItem(cid, v.item, 1)  
end
end
setPlayerStorageValue(cid,v.storage,1)
return doPlayerSendTextMessage(cid,22,"Voce acabou de pegar um " .. getItemNameById(v.item) .. " nesse bau")
end