local rnd = {"VIP"}

function onLogin(cid)
    if not isPlayer(cid) then return true end
    sendEffect(cid)
    registerCreatureEvent(cid, "AdvEffect")
   return true
end

function sendEffect(cid)
    if isCreature(cid) then
        if isPremium(cid) == true then
        pos = getThingPos(cid)
        doSendAnimatedText(pos, rnd[math.random(#rnd)], 251)
        addEvent(sendEffect, 2200,cid)
        end
    end
end