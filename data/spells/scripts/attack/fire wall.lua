local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1492)

local area = createCombatArea(AREA_WALLFIELD, AREADIAGONAL_WALLFIELD)
setCombatArea(combat, area)

function onCastSpell(cid, var)
	ret = doCombat(cid, combat, var)
	if ret then
		local mWall = getTileItemById(variantToPosition(var), 1492).uid
		doItemSetAttribute(mWall, "description", string.format("Fire Wall de: %s.", getCreatureName(cid)))
	end	
	return ret
end
