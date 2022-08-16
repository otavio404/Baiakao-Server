function onLogin(cid)
local rate = 1.10 -- 10%
local config = {
vip = "[Premium Account] Você tem "..((rate - 1)*100).."% a mais de experiencia do que um Jogador Free Account.",
notvip = "[Free Account] Ganhe "..((rate - 1)*100).."% a mais de experiencia se tornando Premium Account.",
}

if not isPlayer(cid) then return true end
if isPremium(cid) == FALSE then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, config.notvip)
else
doPlayerSetExperienceRate(cid, rate)	
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, config.vip)
end
return TRUE
end