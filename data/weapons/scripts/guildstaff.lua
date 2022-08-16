local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 36)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EXPLOSION)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 0, -620, 0, -620)

function onUseWeapon(cid, var)
return doCombat(cid, combat, var)
end