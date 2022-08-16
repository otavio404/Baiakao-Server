local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EARTH)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1499)

function onCastSpell(cid, var)
	ret = doCombat(cid, combat, var)
	if ret then
		local mWall = getTileItemById(variantToPosition(var), 1499).uid
		doItemSetAttribute(mWall, "description", string.format("Wild Growth de: %s.", getCreatureName(cid)))
	end	
	return ret
end