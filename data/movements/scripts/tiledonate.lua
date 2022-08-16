function onStepIn(cid, item, position, fromPosition)

local tileConfig = {
	kickPos = fromPosition, kickEffect = CONST_ME_POFF,
	kickMsg = "Você não é Premium Account, para virar acesse: www.baiak-insanity.com",
	enterEffect = CONST_ME_MAGIC_RED,
}

if isPlayer(cid) == true then
if isPremium(cid) == FALSE then
		doTeleportThing(cid, tileConfig.kickPos)
		doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
		doPlayerSendCancel(cid, tileConfig.kickMsg)
		return
	end
		doSendMagicEffect(position, tileConfig.enterEffect)
		return true
end
end