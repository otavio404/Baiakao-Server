local config = {
    life_ative = 1000000,
    life_add = 400000,
    seconds_ative = 15,
    gStorage = 90702,
    monster = "Azazel"
}
function AddHealth(cid)
    setGlobalStorageValue(config.gStorage, 0)
    if not isCreature(cid) then
        return false
    end
    doCreatureAddHealth(cid, config.life_add)
    doCreatureSay(cid, "Fracos de mais!", TALKTYPE_MONSTER)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
end    
function onStatsChange(cid, attacker, type, combat, value)
    if (getGlobalStorageValue(config.gStorage) < 1 and type == STATSCHANGE_HEALTHLOSS and getCreatureName(cid) == config.monster and getCreatureHealth(cid) < config.life_ative) then
        doCreatureSay(cid, "Eu sou o deus do inferno, eh preciso mais do que isso para me matar, HAHAHA!", TALKTYPE_MONSTER)
        addEvent(AddHealth, config.seconds_ative * 1000, cid)
        setGlobalStorageValue(config.gStorage, 1)
    end
   return true
end 