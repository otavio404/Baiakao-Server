Labia_System = {
             DiffPremiumAndFree = true, -- se o premium e free vao ter diferença no ganho de exp 
             Skill_Limit = {free = 90, premium = 120},
             storage = 181150,
             storagetry = 181151       
}

--[[ FUNCTTION TO LABIA SYSTEM // DON'T CHANGE]]--

function getLabiaLevel(cid)
	return getPlayerStorageValue(cid, Labia_System.storage) < 0 and 0 or getPlayerStorageValue(cid, Labia_System.storage)

end
function setPlayerLabiaLevel(cid, n)
	return setPlayerStorageValue(cid, Labia_System.storage, n)

end
function addLabiaLevel(cid, n)
	setPlayerLabiaLevel(cid, getLabiaLevel(cid) + (isNumber(n) and n or 1))
	setLabiaTry(cid, 0)
end
function getLabiaTries(cid)
	return getPlayerStorageValue(cid, Labia_System.storagetry) < 0 and 0 or getPlayerStorageValue(cid, Labia_System.storagetry)

end
function setLabiaTry(cid, n)
	return setPlayerStorageValue(cid, Labia_System.storagetry, n)

end
function addLabiaTry(cid, amount)
local limit = isPremium(cid) and Labia_System.Skill_Limit.premium or Labia_System.Skill_Limit.free
if getLabiaLevel(cid) == limit then return true end
	setLabiaTry(cid, getLabiaTries(cid) + 1 + (amount))
	if (getLabiaTries(cid) >= getLabiaExpTo(getLabiaLevel(cid))) then
		doPlayerSendTextMessage(cid, 22, "You advanced from level " .. getLabiaLevel(cid) .. " to level ".. (getLabiaLevel(cid)+1) .." in Labia.")
		if ((getLabiaLevel(cid)+1) == limit) then
			doPlayerSendTextMessage(cid, 22, "Max level reached in Labia.")
		end
		addLabiaLevel(cid)
		doSendMagicEffect(getCreaturePosition(cid), math.random(28,30))
		setLabiaTry(cid, 0)
	end
end
function getLabiaExpTo(level)
	return ((level*5.5)+((level+1)*50)) -- dificuldade
end
function getItemExpLabia(item)
	return Labia_System.DiffPremiumAndFree == false and Labia_Items[item].exp.equal or isPremium(cid) and Labia_Items[item].exp.premium or Labia_Items[item].exp.equal
end
function getPriceLabiaLevel(cid, price)
	local l = getLabiaLevel(cid) % 2 ~= 0 and (getLabiaLevel(cid)-1) or getLabiaLevel(cid)
		return price + price * 0.025*(l/2)
end


--[[ ITEMS config TO SELL WITH EXP BUY FOR LABIA SYSTEM]]--

Labia_Items = {
--[[abyss hammer]]              [7414] = {price = 20000, exp = {equal = 8, premium = 10}}, -- igualdade, se for premium ganha a mais
--[[amber staff]]               [7426] = {price = 8000, exp = {equal = 5, premium = 7}},
--[[ancient amulet]]            [2142] = {price = 200, exp = {equal = 1, premium = 2}},
--[[assassin daggerf]]          [7404] = {price = 20000, exp = {equal = 8, premium = 10}},
--[[bandana]]                   [5917] = {price = 150, exp = {equal = 1, premium = 2}},
--[[beastslayer axe]]           [3962] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[berserker]]                 [7403] = {price = 40000, exp = {equal = 14, premium = 15}},
--[[bone shield]]               [2541] = {price = 80, exp = {equal = 1, premium = 2}},
--[[bonelord helmet]]           [3972] = {price = 7500, exp = {equal = 5, premium = 7}},
--[[brutetamer's staff]]        [7379] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[castle shield]]             [2535] = {price = 5000, exp = {equal = 5, premium = 7}},
--[[chain bolter]]              [8850] = {price = 40000, exp = {equal = 14, premium = 15}},
--[[chaos mace]]                [7427] = {price = 9000, exp = {equal = 5, premium = 7}},
--[[coconut shoes]]             [9931] = {price = 500, exp = {equal = 1, premium = 2}},
--[[composite hornbow]]         [8855] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[cranial basher]]            [7415] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[crocodile boots]]           [3982] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[crystal mace]]              [2445] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[crystal necklace]]          [2125] = {price = 400, exp = {equal = 1, premium = 2}},
--[[crystal ring]]              [2124] = {price = 250, exp = {equal = 1, premium = 2}},
--[[crystal sword]]             [7449] = {price = 600, exp = {equal = 1, premium = 2}},
--[[crystalline armor]]         [8878] = {price = 16000, exp = {equal = 8, premium = 10}}, 
--[[daramanian mace]]           [2439] = {price = 110, exp = {equal = 1, premium = 2}},
--[[daramanian waraxe]]         [2440] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[dark shield]]               [2521] = {price = 400, exp = {equal = 1, premium = 2}},
--[[death ring]]                [6300] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[demon shield]]              [2520] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[demonbone amulet]]          [2136] = {price = 32000, exp = {equal = 11, premium = 13}},
--[[demonrage sword]]           [7382] = {price = 36000, exp = {equal = 11, premium = 13}},
--[[devil helmet]]              [2462] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[diamond sceptre]]           [7387] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[djinn blade]]               [2451] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[doll]]                      [2110] = {price = 200, exp = {equal = 1, premium = 2}},
--[[dragon scale mail]]         [2492] = {price = 40000, exp = {equal = 11, premium = 13}},
--[[dragon slayer]]             [7402] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[dragonbone staff]]          [7430] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[dreaded cleaver]]           [7419] = {price = 10000, exp = {equal = 5, premium = 7}},
--[[dwarven armor]]             [2503] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[earth cranial basher]]      [7866] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[earth dragon slayer]]       [7858] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[earth heroic axe]]          [7861] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[earth mystic blade]]        [7856] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[earth relic sword]]         [7855] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[earth war axe]]             [7863] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[emerald bangle]]            [2127] = {price = 800, exp = {equal = 1, premium = 2}},
--[[energy cranial basher]]     [7881] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[energy dragon slayer]]      [7873] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[energy heroic axe]]         [7876] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[energy mystic blade]]       [7871] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[energy relic sword]]        [7870] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[energy war axe]]            [7878] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[epee]]                      [2438] = {price = 8000, exp = {equal = 5, premium = 7}},
--[[fiery cranial basher]]      [7756] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[fiery dragon slayer]]       [7748] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[fiery heroic axe]]          [7751] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[fiery mystic blade]]        [7746] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[fiery relic sword]]         [7745] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[fiery war axe]]             [7753] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[flower wreath]]             [9927] = {price = 500, exp = {equal = 1, premium = 2}},
--[[fur boots]]                 [7457] = {price = 2000, exp = {equal = 3, premium = 4}},
--[[furry club]]                [7432] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[glacier amulet]]            [7888] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[glacier kilt]]              [7896] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[glacier mask]]              [7902] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[glacier robe]]              [7897] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[glacier shoes]]             [7892] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[gold ring]]                 [2179] = {price = 8000, exp = {equal = 5, premium = 7}},
--[[golden armor]]              [2466] = {price = 20000, exp = {equal = 8, premium = 10}}, 
--[[golden legs]]               [2470] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[guardian halberd]]          [2427] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[hammer of wrath]]           [2444] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[heavy mace]]                [2452] = {price = 50000, exp = {equal = 14, premium = 16}}, 
--[[heavy machete]]             [2442] = {price = 90, exp = {equal = 1, premium = 2}},
--[[heroic axe]]                [7389] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[hibiscus dress]]            [8873] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[icy cranial basher]]        [7775] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[icy dragon slayer]]         [7767] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[icy heroic axe]]            [7770] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[icy mystic blade]]          [7765] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[icy relic sword]]           [7764] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[icy war axe]]               [7772] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[jade hammer]]               [7422] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[krimhorn helmet]]           [7461] = {price = 200, exp = {equal = 1, premium = 2}},
--[[lavos armor]]               [8877] = {price = 16000, exp = {equal = 8, premium = 10}}, 
--[[leaf legs]]                 [9928] = {price = 500, exp = {equal = 1, premium = 2}},
--[[leopard armor]]             [3968] = {price = 1000, exp = {equal = 1, premium = 2}}, 
--[[light shovel]]              [5710] = {price = 300, exp = {equal = 1, premium = 2}},
--[[lightning boots]]           [7893] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[lightning headband]]        [7901] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[lightning legs]]            [7895] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[lightning pendant]]         [7889] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[lightning robe]]            [7898] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[lunar staff]]               [7424] = {price = 5000, exp = {equal = 3, premium = 4}},
--[[magic plate armor]]         [2472] = {price = 90000, exp = {equal = 17, premium = 19}}, 
--[[magma amulet]]              [7890] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[magma boots]]               [7891] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[magma coat]]                [7899] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[magma legs]]                [7894] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[magma monocle]]             [7900] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[mammoth fur cape]]          [7463] = {price = 6000, exp = {equal = 5, premium = 7}},
--[[mammoth fur shorts]]        [7464] = {price = 850, exp = {equal = 1, premium = 2}},
--[[mammoth whopper]]           [7381] = {price = 300, exp = {equal = 1, premium = 2}},
--[[mastermind shield]]         [2514] = {price = 50000, exp = {equal = 14, premium = 16}}, 
--[[medusa shield]]             [2536] = {price = 9000, exp = {equal = 5, premium = 7}},
--[[mercenary sword]]           [7386] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[mystic blade]]              [7384] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[naginata]]                  [2426] = {price = 2000, exp = {equal = 3, premium = 4}},
--[[nightmare blade]]           [7418] = {price = 35000, exp = {equal = 11, premium = 13}},
--[[noble axe]]                 [7456] = {price = 10000, exp = {equal = 5, premium = 7}},
--[[norse shield]]              [7460] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[paladin armor]]             [8891] = {price = 15000, exp = {equal = 8, premium = 10}}, 
--[[patched boots]]             [2641] = {price = 2000, exp = {equal = 3, premium = 4}},
--[[pharaoh sword]]             [2446] = {price = 23000, exp = {equal = 11, premium = 13}},
--[[pirate boots]]              [5462] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[pirate hat]]                [6096] = {price = 1000, exp = {equal = 1, premium = 2}},
--[[pirate knee breeches]]      [5918] = {price = 200, exp = {equal = 1, premium = 2}},
--[[pirate shirt]]              [6095] = {price = 500, exp = {equal = 1, premium = 2}},
--[[pirate voodoo doll]]        [5810] = {price = 500, exp = {equal = 1, premium = 2}},
--[[platinum amulet]]           [2171] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[ragnir helmet]]             [7462] = {price = 400, exp = {equal = 1, premium = 2}},
--[[relic sword]]               [7383] = {price = 25000, exp = {equal = 11, premium = 13}},
--[[ring of the sky]]           [2123] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[ruby necklace]]             [2133] = {price = 2000, exp = {equal = 3, premium = 4}},
--[[ruthless axe]]              [6553] = {price = 45000, exp = {equal = 14, premium = 16}}, 
--[[sacred tree amulet]]        [10219] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[sapphire hammer]]           [7437] = {price = 7000, exp = {equal = 5, premium = 7}},
--[[scarab amulet]]             [2135] = {price = 200, exp = {equal = 1, premium = 2}},
--[[scarab shield]]             [2540] = {price = 2000, exp = {equal = 3, premium = 4}},
--[[shockwave amulet]]          [10221] = {price = 3000, exp = {equal = 3, premium = 4}},
--[[silver brooch]]             [2134] = {price = 150, exp = {equal = 1, premium = 2}},
--[[silver dagger]]             [2402] = {price = 500, exp = {equal = 1, premium = 2}},
--[[skull helmet]]              [5741] = {price = 40000, exp = {equal = 14, premium = 16}}, 
--[[skullcracker armor]]        [8889] = {price = 18000, exp = {equal = 8, premium = 10}}, 
--[[spiked squelcher]]          [7452] = {price = 5000, exp = {equal = 3, premium = 4}},
--[[steel boots]]               [2645] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[swamplair armor]]           [8880] = {price = 16000, exp = {equal = 8, premium = 10}}, 
--[[taurus mace]]               [7425] = {price = 500, exp = {equal = 1, premium = 2}},
--[[tempest shield]]            [2542] = {price = 35000, exp = {equal = 11, premium = 13}},
--[[terra amulet]]              [7887] = {price = 1500, exp = {equal = 3, premium = 4}},
--[[terra boots]]               [7886] = {price = 2500, exp = {equal = 3, premium = 4}},   
--[[terra hood]]                [7903] = {price = 2500, exp = {equal = 3, premium = 4}},
--[[terra legs]]                [7885] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[terra mantle]]              [7884] = {price = 11000, exp = {equal = 8, premium = 10}}, 
--[[tortoise shield]]           [6131] = {price = 150, exp = {equal = 1, premium = 2}},
--[[vile axe]]                  [7388] = {price = 30000, exp = {equal = 11, premium = 13}},
--[[voodoo doll]]               [3955] = {price = 400, exp = {equal = 1, premium = 2}},
--[[war axe]]                   [2454] = {price = 12000, exp = {equal = 8, premium = 10}}, 
--[[wyvern fang]]               [7408] = {price = 1500, exp = {equal = 3, premium = 4}}
}