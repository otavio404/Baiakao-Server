function onUse(cid, item, fromPosition, itemEx, toPosition)
	if getPlayerStorageValue(cid, 26730) <= 0 then
                setPlayerStorageValue(cid, 26730, 1)
		doPlayerSendTextMessage(cid, 25, "Agora você foi abençoado com o poder da troca de elementos.")
		doRemoveItem(item.uid,1)
        else
                doPlayerSendTextMessage(cid, 25, "Você já possui o encanto de trocar elementos.")
        end
   return true
end