function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
if doPlayerRemoveMoney(cid, 5000) == TRUE then
local bp = doPlayerAddItem(cid, 2420, 1)
doSendMagicEffect(getCreaturePosition(cid),13)
doCreatureSay(cid, "Voce comprou uma machete", TALKTYPE_ORANGE_1)
else
doCreatureSay(cid, "Voce nao tem dinheiro suficiente", TALKTYPE_ORANGE_1)
doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
end
return true
end