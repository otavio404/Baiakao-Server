function onThink(cid, interval, lastExecution)
	local query = db.getResult("SELECT `id`, `player_id`, `item_id`, `count` FROM `shop_npc` WHERE `date` < "..os.time() - _config_npc_shop.days_limit*24*60*60)
	if (query:getID() ~= -1) then
		repeat
			local item,amount, name = query:getDataInt("item_id"),query:getDataInt("count"), getPlayerByShopID(query:getDataInt("id"))
			local player = getPlayerByNameWildcard(name)
			if player then
			local parcel = doCreateItemEx(ITEM_PARCEL)
			if isItemStackable(item) or amount == 1 then
				doAddContainerItem(parcel, item, amount)
			else
				for i = 1, amount do
					doAddContainerItem(parcel, item, 1)
				end
			end
			doPlayerSendMailByName(name, parcel)
			doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_ORANGE,"[Npc Auction] Foram devolvidos "..amount.." "..getItemNameById(item).." para seu depot.")
			doDeleteShopItem(query:getDataInt("id")) 
			end
		until not query:next()
		query:free()
	end
	return true
end