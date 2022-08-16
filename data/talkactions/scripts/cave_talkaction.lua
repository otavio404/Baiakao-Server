local exhausted = 5 -- Segundos

function onSay(cid, words, param, channel)

	if exhaustion.get(cid, 400) then
		doPlayerSendCancel(cid, "Você poderá usar este comando novamente após ".. exhaustion.get(cid, 400) .." segundos.")
		return true
	end
	exhaustion.set(cid, 400, exhausted)	

	if (string.lower(param) == "time") then
		if getPlayerStorageValue(cid, caveExclusiva.storages.cave) > 0 then
			local timeLeft = getPlayerStorageValue(cid, caveExclusiva.storages.time) - os.time()
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ORANGE, "Você possui ".. getTimeString(timeLeft) .." restantes.")
		else
			doPlayerSendCancel(cid, "Você não é dono de nenhuma cave.")
		end
	elseif (string.lower(param) == "stats") then
		if caveExclusiva.config.caveStats then
			local info = "-----> Cave Exclusiva Stats <-----"
			for _, cave in pairs(caveExclusiva.getCavesID()) do
				local ownerGUID = getGlobalStorageValue(caveExclusiva.caves[cave].gStor) <= 0 and true or getGlobalStorageValue(caveExclusiva.caves[cave].gStor)
				local ownerName = type(ownerGUID) ~= "boolean" and getPlayerNameByGUID(ownerGUID) or "-> Cave Livre <-"
				local timeLeft = nil
				if isPlayerOnline(getPlayerNameByGUID(ownerGUID)) then
					timeLeft = type(ownerGUID) ~= "boolean" and getTimeString(getPlayerStorageValue(getPlayerByGUID(ownerGUID), caveExclusiva.storages.time) - os.time()) or "0 segundo"
				else				
					timeLeft = type(ownerGUID) ~= "boolean" and getTimeString(getOfflinePlayerStorage(ownerGUID, caveExclusiva.storages.time) - os.time()) or "0 segundo"
				end
				info = info .. "\n-----------------------------\n"
				info = info .. "* Cave: ".. caveExclusiva.caves[cave].caveName .. "\n"
				info = info .. "* Dono: ".. ownerName .. "\n"
				info = info .. "* Tempo restante: ".. timeLeft
			end
			doShowTextDialog(cid, 8981, info)
		else
			doPlayerSendCancel(cid, "O stats está desativado.")
		end
	else
		doPlayerSendCancel(cid, "Use o parametro TIME ou STATS.")
	end
	return true
end