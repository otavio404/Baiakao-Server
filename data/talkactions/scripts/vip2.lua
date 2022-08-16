local storage_vip = 88888
local price_vip = 5
local money_id = 9971

function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end	
	if (getPlayerItemCount(cid, money_id) >= price_vip) then
		doPlayerRemoveItem(cid, money_id, price_vip)
		setPlayerStorageValue(cid, storage_vip, 1)
		doPlayerSendTextMessage(cid, 18, "Voce comprou o acesso da VIP2.")
	else
		doPlayerSendTextMessage(cid, 18, "Voce precisa de 5kk para comprar o acesso da VIP2.")
		return true
	end

	return true
end