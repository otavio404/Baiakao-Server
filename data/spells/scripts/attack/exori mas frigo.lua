local combat = createCombatObject()

local meteor = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 43)
setAttackFormula(combat, COMBAT_FORMULA_LEVELMAGIC, 5, 5, 6, 12)

local arr = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0}
}
 
local area = createCombatArea(arr)
setCombatArea(combat, area)

local function meteorCast(p)
    doCombat(p.cid, p.combat, positionToVariant(p.pos))
end
local function stunEffect(cid)
    doSendMagicEffect(getThingPos(cid), CONST_ME_STUN)
end

function onTargetTile(cid, pos)
            local newpos = {x = pos.x + 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, CONST_ANI_ICE)
            addEvent(meteorCast, 200, {cid = cid,pos = pos, combat = meteor})
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
local storage = 45670 -- não mecha

if isPlayer(cid) and exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "Aguarde "..(exhaustion.get(cid, storage)).." segundos(s) para usar novamente.")
    return false
end
exhaustion.set(cid, 45671, 60)
    if getPlayerStorageValue(cid, 64854) >= 10 then
        return doCombat(cid, combat, var)
    else
    doSendMagicEffect(getThingPos(cid), 2)
        doPlayerSendTextMessage(cid, 22, "Voce nao possui essa magia pois nao fez a quest das novas magias.")
    end
end