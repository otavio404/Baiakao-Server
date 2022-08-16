local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser,msg = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid,string.lower(msg)
	local weaponsTypes = {"head", "armor", "legs", "feet", "shield", "sword", "wand", "rod", "club", "axe", "distance", "ammunition", "others", "all"}
	if isInArray({'apprise', 'check', 'items', 'item', 'list'}, msg) then
		local qry,k,str = db.getResult("SELECT `item_id`, `count`, `price` FROM `shop_npc` WHERE `player_id` = "..getPlayerGUID(cid)),0,"Meus Itens Depositados:\n\n"
		if(qry:getID() ~= -1) then
			repeat
				k = k + 1
				str = str..""..qry:getDataInt("count").." "..getItemNameById(qry:getDataInt("item_id")).." - "..qry:getDataInt("price").." Gps "..(tonumber(qry:getDataInt("count")) > 1 and "Each" or "").."\n"
			until not (qry:next()) or k >= _config_npc_shop.items_limit
			qry:free()
			doPlayerPopupFYI(cid, str)
		else
			selfSay("Atualmente Voce Nao Tem Itens Depositados Na Loja", cid)
		end
	elseif isInArray({ 'retirar'}, msg) then
		if getDepositNpc(cid) <= 0 then
			selfSay("Voce Ainda Nao Conseguiu Vender Nenhum Item, E Por Isso Voce Nao Tem Nenhum Dinheiro Depositado.", cid)
		else
			selfSay("Voce Tem "..getDepositNpc(cid).." GPS Depositado, Quanto GPS Voce Gostaria De Remover?", cid)
			talkState[talkUser] = 8
		end
	elseif talkState[talkUser] == 8 then
		if tonumber(msg) and tonumber(msg) > 0 and tonumber(msg) <= getDepositNpc(cid) then
			setPlayerStorageValue(cid, _config_npc_shop.WithDraw_storage, (getDepositNpc(cid)-tonumber(msg)))
			doPlayerAddMoney(cid, tonumber(msg))
			selfSay("Voce Retirou "..msg.." GPS, Agora Voce Tem "..getDepositNpc(cid).." Depositado.", cid)
			talkState[talkUser] = 0
		else
			selfSay("Voce Nao Pode Remover Essa Quantia.", cid)
			talkState[talkUser] = 0
		end
	elseif isInArray({'depositar'}, msg) then
		if getRowsShopByPlayer(getPlayerGUID(cid)) < _config_npc_shop.items_limit then
			selfSay('Qual Item Voce Deseja Colocar A Venda?', cid)
			talkState[talkUser] = 2
		else
			selfSay('Voce So Pode Adicionar '.._config_npc_shop.items_limit..' Itens Por Hora.', cid)
			talkState[talkUser] = 0 
		end 
	elseif talkState[talkUser] == 2 then
		name,item = msg,getItemByName(msg)
		if msg == '' or tonumber(msg) or not item then
			talkState[talkUser] = 0 
			selfSay("Este Item Nao Exite.", cid) return true
		elseif not isItemMovable(item) or isInArray(_config_npc_shop.items_block, getItemIdByName(name)) then
			talkState[talkUser] = 0 
			selfSay("Voce Nao Pode Adicionar Este Item.", cid) return true
		end
		item = getItemIdByName(name)
		selfSay('Quantos Desse Item Voce Deseja Colocar A Venda?', cid)
		talkState[talkUser] = 3
	elseif talkState[talkUser] == 3 then
		if tonumber(msg) and tonumber(msg) > 0 and tonumber(msg) <= 100 and getPlayerItemCount(cid, item) >= tonumber(msg) then
			count = tonumber(msg)
			selfSay('Certo, E Quanto Vai Custar Cada Item Desse?', cid)
			talkState[talkUser] = 4
		else
			selfSay(getPlayerItemCount(cid, item) < tonumber(msg) and 'Voce Nao Tem '..msg..' Itens Desse Para Depositar' or 'Insira Um Numeo Valido De 1 A 100.', cid)
		end
	elseif talkState[talkUser] == 4 then
		if tonumber(msg) and tonumber(msg) > 0 and tonumber(msg) < 9999999 then
			price = msg
			selfSay('Voce Realmente Quer Colocar {'..count..' '..name..'} Por {'..price..'} GPS '..(count > 1 and 'each' or '')..' A Venda? Vai Custar '.. _config_npc_shop.each_deposit ..' Por Deposito, OK? {yes}', cid)
			talkState[talkUser] = 6
		else
			selfSay('Escolha Um Numero Valido.', cid)
		end
	elseif msgcontains(msg, "yes") and talkState[talkUser] == 6 then
		if doPlayerRemoveMoney(cid, _config_npc_shop.each_deposit) then
			item,price = getItemIdByName(name),price
			if doPlayerRemoveItem(cid, item, count) then
				doAddItemShop(cid, item, count, getItemType(item), tonumber(price))
				selfSay('Parabens, O Item Foi Adicionado Com Sucesso A Lista E Sera Vendido Ate: '..os.date("%d %B %Y %X ", (os.time() + _config_npc_shop.days_limit*24*60*60))..'.', cid)
				talkState[talkUser] = 0
			else
				selfSay('Não Foi Possivel Realizar Esta Ação, Pois Voce Nao Tem Os Itens.', cid)
					talkState[talkUser] = 0
				end
			else
				selfSay('Voce Nao Tem GPS Suficiente Para Depositar Este Item.', cid)
					talkState[talkUser] = 0
				end
			elseif isInArray({'trade'}, msg) then
				selfSay('Escolha O Tipo De Item  Que Voce Deseja Comprar: {head}, {armor}, {legs}, {feet}, {shield}, {sword}, {wand}, {rod}, {club}, {axe}, {distance}, {ammunition}, {others} or {all}.', cid)
				talkState[talkUser] = 7 
			elseif talkState[talkUser] == 7 then
				if isInArray(weaponsTypes, msg) then
					if msg == "rod" then msg = "wand" end
					local qry = msg == "all" and db.getResult("SELECT `id`, `player_id`, `item_id`, `count`, `price` FROM `shop_npc`;") or  db.getResult("SELECT `id`, `player_id`, `item_id`, `count`, `price` FROM `shop_npc` WHERE `type` = "..db.escapeString(msg))
					local trade,show = {},true
					if(qry:getID() ~= -1) then
						repeat
							if not _config_npc_shop.ShowMyItems_shop and qry:getDataInt("player_id") == getPlayerGUID(cid) then
								show = false
							end
							if show == true then
								table.insert(trade,{id= qry:getDataInt("item_id"), buy= qry:getDataInt("price"), db= qry:getDataInt("id"), name= getItemNameById(qry:getDataInt("item_id")), amount = qry:getDataInt("count")})
							end
						until not(qry:next())
						qry:free()
					else
						selfSay('Nao Tem Nenhum Item Depositado Em Minha Loja Nesta Categoria, Escolha Outra.', cid) return true
					end
					local items = {} 
					for _, item in ipairs(trade) do
						items[item.id] = {item_id = item.id, buyPrice = item.buy, changeDb = item.db, subType = item.amount, realName = item.name}
					end 
					local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks) 
						if items[item].buyPrice ~= 0 and amount <= items[item].subType then
							if isItemInShop(items[item].changeDb, amount) then
								doPlayerRemoveMoney(cid, amount * items[item].buyPrice)
								if isItemStackable(items[item].item_id) then
									doPlayerAddItem(cid, items[item].item_id, amount) 
								else
									for i = 1, amount do 
										doPlayerAddItem(cid, items[item].item_id, 1) 
									end
								end
								local player,sell_price = getPlayerByNameWildcard(getPlayerByShopID(items[item].changeDb)),amount*items[item].buyPrice
								if(not player) then
									doSetDepositNpc(getPlayerGUIDByName(getPlayerByShopID(items[item].changeDb)), sell_price, "add")
									local file = io.open(OfflineMessagesConfig.messageSavingDirectory .. getPlayerByShopID(items[item].changeDb) .. '.Gandhi', 'a+')
									if(not file) then return true end
									local msgfrom, msgoff = "[Npc Auction]",{"Foram Vendidos "..amount.." "..getItemNameById(items[item].item_id).." E Voce Recebeu "..sell_price.." GPS Por Itens."}
									file:write(OfflineMessagesConfig.messageFormatString:format(os.date(OfflineMessagesConfig.dateFormatString), msgfrom, table.concat(msgoff, OfflineMessagesConfig.separatorAfterNickname)) .. '\n')
									file:close()
								else
									setPlayerStorageValue(player,_config_npc_shop.WithDraw_storage, getDepositNpc(player)+sell_price)
									doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_ORANGE,"[Npc Auction] Foram Vendidos "..amount.." "..getItemNameById(items[item].item_id).." E Voce Recebeu "..sell_price.." GPS Por Itens.") 
								end
								if amount == items[item].subType then
									doDeleteShopItem(items[item].changeDb)
								else
									doRemoveShopItem(items[item].changeDb, amount)
								end
								selfSay('Aqui Esta O Seu Item, Obrigado!', cid)
								closeShopWindow(cid)
							else
								selfSay('Este Item Acabou De Ser Comprado.', cid)
								closeShopWindow(cid)
							end 
						else
							selfSay('Voce So Pode Comprar '..items[item].subType..'x De Itens.', cid)
						end 
					end 
					openShopWindow(cid, trade, onBuy, onSell) 
				else
					selfSay('Nao Venda Este Tipo De Item.', cid)
					end
				elseif isInArray({'remover'}, msg) then
					selfSay('Qual Item Voce Deseja Remover Da Minha Loja? Lembrando Que Eu Devolvo O Valor Total Do Item!', cid)
						talkState[talkUser] = 15
					elseif talkState[talkUser] == 15 then
						name,item = msg,getItemByName(msg)
						if msg == '' or tonumber(msg) or not item then
							selfSay("Este Item Nao Esta Adicionado Em Minha Loja.", cid) return true
						end
						local qry = db.getResult("SELECT `id`, `item_id`, `count` FROM `shop_npc` WHERE `player_id` = "..getPlayerGUID(cid).." and `item_id` = "..getItemIdByName(name))
						if(qry:getID() ~= -1) then
							local id, item, amount = qry:getDataInt("id"), qry:getDataInt("item_id"), qry:getDataInt("count")
							if isItemStackable(item) then
								doPlayerAddItem(cid, item, amount) 
							else
								for i = 1, amount do 
									doPlayerAddItem(cid, item, 1) 
								end
							end
							doDeleteShopItem(id)
							selfSay("Certo, Foi Removido "..amount.." "..name.." Da Minha Loja, Obrigado!", cid)
							talkState[talkUser] = 0
						else
							selfSay("Voce Nao Tem Este Item Depositado Em Minha Loja!", cid)
						end
					elseif msg == "no" and talkState[talkUser] >= 1 then
						selfSay("Beleza Entao...", cid)
						talkState[talkUser] = 0
						npcHandler:releaseFocus(cid)
					end 
					return true
				end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())