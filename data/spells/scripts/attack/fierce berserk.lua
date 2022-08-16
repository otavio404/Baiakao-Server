local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 0)
setCombatParam(combat, COMBAT_PARAM_USECHARGES, true)

local area = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack * 2, level / 2
	return -(skillTotal * 0.5 + levelTotal), -(skillTotal * 2 + levelTotal)
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onCastSpell(cid, var)
if isMonster(cid) then
        doCreatureSay(cid, "exori gran", TALKTYPE_MONSTER)
    end
	return doCombat(cid, combat, var)
end