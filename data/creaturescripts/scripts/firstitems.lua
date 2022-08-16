function onLogin(cid)
	if not isPlayer(cid) then return true end
	if getPlayerGroupId(cid) == 1 and getPlayerStorageValue(cid, 30001) == -1 then
		if isSorcerer(cid) then
			local bag = doPlayerAddItem(cid, 10521, 1)	
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 9693, 1) -- Addon Doll			
			doAddContainerItem(bag, 2160, 15) -- Crystal Coin
			doAddContainerItem(bag, 2789, 50) -- Food
			
			doPlayerAddItem(cid, 2534, 1) -- Shield
			doPlayerAddItem(cid, 7424, 1) -- Wand
			doPlayerAddItem(cid, 7899, 1) -- Armor
			doPlayerAddItem(cid, 7900, 1) -- Helmet
			doPlayerAddItem(cid, 7894, 1) -- Legs
			doPlayerAddItem(cid, 2641, 1) -- Boots
			doPlayerAddItem(cid, 2173, 1) -- Colar
			doPlayerAddItem(cid, 7590, 1) -- Great Mana Potion
			doPlayerAddItem(cid, 2124, 1) -- Ring
		setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isDruid(cid) then
			local bag = doPlayerAddItem(cid, 10521, 1)
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 9693, 1) -- Addon Doll			
			doAddContainerItem(bag, 2160, 15) -- Crystal Coin
			doAddContainerItem(bag, 2789, 50) -- Food
			
			doPlayerAddItem(cid, 2534, 1) -- Shield
			doPlayerAddItem(cid, 7424, 1) -- Wand
			doPlayerAddItem(cid, 7899, 1) -- Armor
			doPlayerAddItem(cid, 7900, 1) -- Helmet
			doPlayerAddItem(cid, 7894, 1) -- Legs
			doPlayerAddItem(cid, 2641, 1) -- Boots
			doPlayerAddItem(cid, 2173, 1) -- Colar
			doPlayerAddItem(cid, 7590, 1) -- Great Mana Potion
			doPlayerAddItem(cid, 2124, 1) -- Ring
			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isPaladin(cid) then
			local bag = doPlayerAddItem(cid, 3940, 1)
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 9693, 1) -- Addon Doll			
			doAddContainerItem(bag, 2160, 15) -- Crystal Coin
			doAddContainerItem(bag, 2789, 50) -- Food
			
			doPlayerAddItem(cid, 8854, 1) -- Bow
			doPlayerAddItem(cid, 2519, 1) -- Shield
			doPlayerAddItem(cid, 2641, 1) -- Boots
			doPlayerAddItem(cid, 8923, 1) -- Legs
            doPlayerAddItem(cid, 8886, 1) -- Armor
			doPlayerAddItem(cid, 2506, 1) -- Helmet
			doPlayerAddItem(cid, 2173, 1) -- Colar
			doPlayerAddItem(cid, 8472, 1) -- Great Spirit Mana
			doPlayerAddItem(cid, 2124, 1) -- Ring			
			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa

		elseif isKnight(cid) then
			local bag = doPlayerAddItem(cid, 10522, 1)
			doAddContainerItem(bag, 2120, 1) -- Rope
			doAddContainerItem(bag, 2554, 1) -- Shovel
			doAddContainerItem(bag, 9693, 1) -- Addon Doll			
			doAddContainerItem(bag, 2160, 15) -- Crystal Coin
			doAddContainerItem(bag, 2789, 50) -- Food
			doAddContainerItem(bag, 7620, 1) -- Mana Potion
			doAddContainerItem(bag, 7417, 1) -- Sword
			doAddContainerItem(bag, 7450, 1) -- Club
			
		    doPlayerAddItem(cid, 7420, 1) -- Axe
	        doPlayerAddItem(cid, 2519, 1) -- Shield
			doPlayerAddItem(cid, 2641, 1) -- Boots
			doPlayerAddItem(cid, 2477, 1) -- Legs
            doPlayerAddItem(cid, 8883, 1) -- Armor
			doPlayerAddItem(cid, 2496, 1) -- Helmet
			doPlayerAddItem(cid, 2173, 1) -- Colar
			doPlayerAddItem(cid, 8473, 1) -- Ultimate Health Potion
			doPlayerAddItem(cid, 2124, 1) -- Ring
			setPlayerStorageValue(cid, 30001, 1) -- Não Mexa
			
		end
	end
 	return TRUE
end