--local min, max = 840, 900
local storage = 722656

local function getMinDamage(level, magLevel)
	local min = ((level * 1.05) + (magLevel * 1.26))
	local naturalDamage = math.random(-30,45)
	min = min + naturalDamage
	if min < 390 then
		min = 390
	end
	return math.floor(min)
end

local function getMaxDamage(level, magLevel)
	local max = ((level * 1.32) + (magLevel * 2.29))
	local naturalDamage = math.random(-20,45)
	max = max + naturalDamage
	if max < 900 then
		max = 900
	end
	return math.ceil(max)
end

local effects = {
	
	[10] = {dist = CONST_ANI_ICE, hit = CONST_ME_ICEATTACK},
	[11] = {dist = CONST_ANI_EARTH, hit = CONST_ME_CARNIPHILA},
	[12] = {dist = CONST_ANI_HOLY, hit = CONST_ME_HOLYDAMAGE},
	[13] = {dist = CONST_ANI_ENERGYBALL, hit = CONST_ME_PURPLEENERGY},
	[14] = {dist = CONST_ANI_CAKE, hit = CONST_ME_CAKE},
	[15] = {dist = CONST_ANI_FIRE, hit = CONST_ME_FIREATTACK}

}

function onUseWeapon(cid, var)
	local level, magLevel = getPlayerLevel(cid), getPlayerMagLevel(cid)
	local min, max = getMinDamage(level, magLevel), getMaxDamage(level, magLevel)

	local sto = getCreatureStorage(cid, storage)
	if not effects[sto] then
		sto = 14;
	end
	
	local target = variantToNumber(var)
	if isCreature(target) then
		doSendDistanceShoot(getThingPos(cid), getThingPos(target), effects[sto].dist)
		doAreaCombatHealth(cid, COMBAT_PHYSICALDAMAGE, getThingPos(target), 0, -min, -max, effects[sto].hit)
	end
	return true
end
