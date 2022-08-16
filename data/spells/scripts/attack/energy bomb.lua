local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_ENERGYHIT)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1495)

local area = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	ret = doCombat(cid, combat, var)
	if ret then
		local mWall = getTileItemById(variantToPosition(var), 1495).uid
		doItemSetAttribute(mWall, "description", string.format("Energy Bomb de: %s.", getCreatureName(cid)))
	end	
	return ret
end
