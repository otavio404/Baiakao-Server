function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Seu level atual de mineração é: "..getPlayerStorageValue(cid, 19333).." ")
return true
end