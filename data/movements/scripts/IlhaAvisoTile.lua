function onStepIn(cid, item, position, fromPosition)
	if getPlayerStorageValue(cid, 46937) < 1 then
		setPlayerStorageValue(cid, 46937, 1)
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Estes s�o os melhores SETs do server, n�o possui e nunca possuir� SETs pagos por points donates, melhores armas e shields voc� pode obter em quest!")
	end
   return true
end