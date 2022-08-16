function onSay(cid, words, param)
    if doPlayerRemoveMoney(cid, 20000) then
        doPlayerAddItem(cid, 2173, 1)
        local efeitos = math.random(34, 54)
        doSendMagicEffect(getCreaturePosition(cid), efeitos)
        doCreatureSay(cid, "Voce comprou um Amulet of Loss!", TALKTYPE_ORANGE_1)
    else
        doPlayerSendTextMessage(cid, 22, "Voce nao possui dinheiro o suficiente.")
        doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
    end
    return true
end