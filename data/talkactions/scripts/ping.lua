function onSay(cid, words, param, channel)
local ms = ping.CheckPing(cid)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Ping aproximado: ["..ms.."].")
    return true
end