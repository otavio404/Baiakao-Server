local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_BIGCLOUDS)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 5, 12)

function onGetFormulaValues(cid, level, maglevel)
    local min = level / 5 + maglevel * 5.5 + 32         
    local max = level / 5 + maglevel * 7.7 + 48
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end