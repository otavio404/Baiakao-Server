local water = {490, 491, 492, 493}

local combat = createCombatObject()

local meteor = createCombatObject()
setCombatParam(meteor, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(meteor, COMBAT_PARAM_EFFECT, 36)
setAttackFormula(meteor, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 6, 12)

local meteor_water = createCombatObject()
setCombatParam(meteor_water, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(meteor_water, COMBAT_PARAM_EFFECT, CONST_ME_LOSEENERGY)
setAttackFormula(meteor_water, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 6, 12)

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

local function meteorCast(p)
    doCombat(p.cid, p.combat, positionToVariant(p.pos))
end

function onTargetTile(cid, pos)
    if (math.random(0, 0) == 0) then
        local ground = getThingfromPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0})
        if (isInArray(water, ground.itemid) == TRUE) then
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, CONST_ANI_FIRE)
            addEvent(meteorCast, 200, {cid = cid, pos = pos, combat = meteor_water})
        else
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, CONST_ANI_FIRE)
            addEvent(meteorCast, 200, {cid = cid,pos = pos, combat = meteor})
        end
    end
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, 44855) >= 10 then
    	return doCombat(cid, combat, var)
    else
	doSendMagicEffect(getThingPos(cid), 2)
        doPlayerSendTextMessage(cid, 22, "Você não possui essa magia pois nao fez a quest das novas magias 500+!")
    end
end