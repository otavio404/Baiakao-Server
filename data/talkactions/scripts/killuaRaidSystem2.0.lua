function onSay(cid,words,param,channel)

	if not param or param == "" then
		local str = ""
		for a,b in next, killuaRaids.raids do
			str = str..b.name.."\n"
		end
		str = "Monstros dispon�veis para invas�o:\n\n"..str
		doShowTextDialog(cid,2553,str)
		return true
	end

	for a, b in next, killuaRaids.raids do
		if b.name:lower() == param:lower() then
			killuaRaids.start(killuaRaids.raids[a])
			return true
		end
	end

	doPlayerSendTextMessage(cid,MESSAGE_STATUS_CONSOLE_ORANGE,"Esta invas�o n�o est� dispon�vel. Usa /raid para ver as invas�es dispon�veis.")
	return true
end
