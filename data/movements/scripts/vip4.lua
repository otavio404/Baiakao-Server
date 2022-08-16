local storage_vip = 88890

function onStepIn(cid, item, position, fromPosition)
local tileConfig = {
    teleport = {x=1221, y=273, z=7},
    kickPos = fromPosition, kickEffect = CONST_ME_POFF,
    kickMsg = "Voce nao tem acesso a VIP4! Faca a quest para ter acesso a ela.",
    enterEffect = 10,
}
	if not isPlayer(cid) then
		return false
	end	
	if (getPlayerStorageValue(cid, storage_vip) >= 1) then
  doTeleportThing(cid, tileConfig.teleport)
  doSendMagicEffect(tileConfig.teleport, tileConfig.enterEffect)
    else
      doTeleportThing(cid, tileConfig.kickPos)
      doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
      doPlayerSendTextMessage(cid, 22, tileConfig.kickMsg)
    end
  return true
end