local combat = createCombatObject()

local meteor = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 40)
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
            local newpos = {x = pos.x - 7, y = pos.y - 6, z = pos.z}
            doSendDistanceShoot(newpos, pos, CONST_ANI_ENERGY)
            addEvent(meteorCast, 200, {cid = cid,pos = pos, combat = meteor})
end

setCombatCallback(combat, CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(cid, var)
local storage = 45673 -- não mecha

if isPlayer(cid) and exhaustion.check(cid, storage) then
    doPlayerSendCancel(cid, "Este feitiço está em recarga elementar, espere "..(exhaustion.get(cid, storage)).." sem usar nenhum outro feitiço de elemento especial antes de lançar esse feitiço.")
    return false
end
exhaustion.set(cid, 45672, 120)
    if getPlayerStorageValue(cid, 64855) >= 10 then
        return doCombat(cid, combat, var)
    else
    doSendMagicEffect(getThingPos(cid), 2)
        doPlayerSendTextMessage(cid, 22, "Voce nao possui essa magia pois nao fez a quest das novas magias.")
    end
end