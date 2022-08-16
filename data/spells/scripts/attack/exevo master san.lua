local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 15, 18, 21, 25)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_HOLY)

combat_arr = {
{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0},
{0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 0},
{0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0},
{1, 1, 1, 0, 1, 3, 1, 1, 0, 1, 1},
{0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0},
{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0},
{0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0}
}

local combat_area = createCombatArea(combat_arr)
setCombatArea(combat, combat_area)

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 44856) >= 10 then
    	return doCombat(cid, combat, var)
    else
	doSendMagicEffect(getThingPos(cid), 2)
        doPlayerSendTextMessage(cid, 22, "Você não possui essa magia pois nao fez a quest das novas magias 500+!")
    end
end