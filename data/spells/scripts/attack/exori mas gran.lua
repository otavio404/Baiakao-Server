local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)

local arr = {
{0, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{1, 1, 1, 3, 1, 1, 1},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 0, 1, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, skill, attack, factor)
	local skillTotal, levelTotal = skill + attack * 3, level / 4
	return -(skillTotal * 1.0 + levelTotal), -(skillTotal * 3 + levelTotal)
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")
function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 64857) >= 10 then
    	return doCombat(cid, combat, var)
    else
	doSendMagicEffect(getThingPos(cid), 2)
    doPlayerSendTextMessage(cid, 22, "Primeiro você deve fazer a Quest das Magias para usa-las!")
    end
end