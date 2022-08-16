function onLogin(cid)
	if getPlayerStorageValue(cid, _config_npc_shop.WithDraw_storage) == -1 then
		setPlayerStorageValue(cid, _config_npc_shop.WithDraw_storage , 0)
	end
	local query = db.getResult("SELECT `id`, `item_id`, `count` FROM `shop_npc` WHERE `date` < ".. os.time() - _config_npc_shop.days_limit*24*60*60 .." and `player_id` = "..getPlayerGUID(cid))
	if (query:getID() ~= -1) then
		repeat
			local item,amount,name = query:getDataInt("item_id"),query:getDataInt("count"), getPlayerName(cid)
			local parcel = doCreateItemEx(ITEM_PARCEL)
			if isItemStackable(item) or amount == 1 then
				doAddContainerItem(parcel, item, amount)
			else
				for i = 1, amount do
					doAddContainerItem(parcel, item, 1)
				end
			end
			doPlayerSendMailByName(name, parcel)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE,"[Npc Auction] Foram devolvidos "..amount.." "..getItemNameById(item).." para seu depósito.")
			doDeleteShopItem(query:getDataInt("id")) 
		until not query:next()
		query:free()
end
local file = io.open(OfflineMessagesConfig.messageSavingDirectory .. getCreatureName(cid) .. '.Gandhi', 'r')
		if(not file) then
			return true
		end
		if(not OfflineMessagesConfig.delayBeetwenShowMessageOnLogin) then
			for line in file:lines() do
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, line)
			end
		else
			local function sendLine(cid, msgType, filename)
				if(not isPlayer(cid)) then -- check player is still online
					return 
				end
				local file = io.open(filename, 'r')
				if(not file) then
					return 
				end
				local first, str = true, ''
				for line in file:lines() do
					if(first) then
						doPlayerSendTextMessage(cid, msgType, line)
						first = false
					else
						str = str .. line .. '\n'
					end
				end
				file:close()
				if(str ~= '') then
					file = io.open(filename, 'w')
					file:write(str)
					file:close()
 
					addEvent(sendLine, OfflineMessagesConfig.delayBeetwenShowMessageOnLogin, cid, msgType, filename)
				else
					os.remove(filename)
				end
			end
			addEvent(sendLine, OfflineMessagesConfig.delayBeetwenShowMessageOnLogin, cid, MESSAGE_STATUS_CONSOLE_ORANGE, OfflineMessagesConfig.messageSavingDirectory .. getCreatureName(cid) .. '.Gandhi')
		end
		file:close()
return true
end