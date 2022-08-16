local config = {
    life_ative = 1000000,
    life_add = 350000,
    seconds_ative = 15,
    gStorage = 90703,
    monster = "The Triangle Of Terror"
}
function AddHealth(cid)
    setGlobalStorageValue(config.gStorage, 0)
    if not isCreature(cid) then
        return false
    end
    doCreatureAddHealth(cid, config.life_add)
    doCreatureSay(cid, "Forcaa pessoal!", TALKTYPE_MONSTER)
    doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
end    
function onStatsChange(cid, attacker, type, combat, value)
    if (getGlobalStorageValue(config.gStorage) < 1 and type == STATSCHANGE_HEALTHLOSS and getCreatureName(cid) == config.monster and getCreatureHealth(cid) < config.life_ative) then
        doCreatureSay(cid, "HAHAHAHA! Eu vou destruir tudo que voce conhece!", TALKTYPE_MONSTER)
        addEvent(AddHealth, config.seconds_ative * 1000, cid)
        setGlobalStorageValue(config.gStorage, 1)
    end
   return true
end 