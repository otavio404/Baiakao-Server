function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	if getPlayerStorageValue(cid,22867) >= 1 then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você matou "..getPlayerStorageValue(cid, 34765).." jogadores level 400+.")
	else
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você não possui uma task de morte ativa.")
	end
end