function onTradeAccept(cid, target, item, targetItem)
	if isPlayer(cid) and isPlayer(target) then
		if item.itemid == Points_Trade.Document_ItemID then
			local var = DocumentPoints(item)
			if getPlayerPoints(cid) >= var then
				doPlayerSendTextMessage(target, MESSAGE_STATUS_WARNING, "Voce recebeu ".. var .." premium points.")
				doPlayerAddPoints(target, var)
				doPlayerRemovePoints(cid, var)
				addEvent(doPlayerRemoveItem, 1, target, Points_Trade.Document_ItemID, 1)
			end
		end
		if targetItem.itemid == Points_Trade.Document_ItemID then
			local var = DocumentPoints(targetItem)
			if getPlayerPoints(target) >= var then
				doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce recebeu ".. var .." premium points.")
				doPlayerAddPoints(cid, var)
				doPlayerRemovePoints(target, var)
				addEvent(doPlayerRemoveItem, 1, cid, Points_Trade.Document_ItemID, 1)
			end
		end
	end
	return true
end 
function onTradeRequest(cid, target, item)
	if item.itemid == Points_Trade.Document_ItemID then
		if getPlayerPoints(cid) < DocumentPoints(item) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce nao tem ".. DocumentPoints(item) .." para realizar uma troca.")
			return false
		end
	end
	return true
end