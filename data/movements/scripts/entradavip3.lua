function onStepIn(cid, item, position, fromPosition)

local config = {
msgDenied = "Voc� n�o e vip III, fa�a a quest!.",
msgWelcome = "Seja Bem Vindo a Area vip III."
}

if getPlayerStorageValue(cid, 55491) - os.time() <= 0 then
doTeleportThing(cid, fromPosition, true)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, config.msgDenied)
return TRUE
end
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, config.msgWelcome)
return TRUE
end