local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
setCombatParam(combat, COMBAT_PARAM_CREATEITEM, 1497)

function onCastSpell(cid, var)
	ret = doCombat(cid, combat, var)
	if ret then
		local mWall = getTileItemById(variantToPosition(var), 1497).uid
		doItemSetAttribute(mWall, "description", string.format("Magic Wall de: %s.", getCreatureName(cid)))
	end	
	return ret
end