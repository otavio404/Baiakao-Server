function onLogin(cid)

local rate = 1.1 -- 10%
local config = {
domi = "[Insanity Castle] Sua Guild tem "..((rate - 1)*100).."% a mais de experiencia.",
no_domi = "[Insanity Castle] Domine o Castle e ganhe "..((rate - 1)*100).."% a mais de experiencia!",
}

if realCastle.isDominating(cid) then
doPlayerSetExperienceRate(cid, rate)
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, config.domi)
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, config.no_domi)
end
return TRUE
end