function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "You have " .. doNumberFormat(getPlayerMoney(cid)) .. " gold.")
	return true
end
