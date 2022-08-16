function onKill(cid, target)
if isPlayer(cid) and isMonster(target) then
if getPlayerStorageValue(cid, 1013120) >= 1 then
local exp = getExperienceStage(getPlayerLevel(cid), getVocationInfo(getPlayerVocation(cid)).experienceMultiplier)
local count = ((getMonsterInfo(string.lower(getCreatureName(target))).experience*1.02*exp)/2) -- 1.02 = 2%
doPlayerAddExperience(cid, count)
addEvent(doSendAnimatedText, 500, getCreaturePosition(cid), '+'..count, math.random(50,60))
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você ganhou 2% a mais de exp por estar com cast ligado.")
end
return true
end
return true
end