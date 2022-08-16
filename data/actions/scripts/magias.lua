function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (getPlayerStorageValue(cid, 22467) == EMPTY_STORAGE) then
		doCreatureSay(cid, "Voce ganhou magia nova dos deuses, se voce é kina use (exori mas gran), pally (exori mas san), druid (exori mas frigo) e sorc (exori mas flam) !", TALKTYPE_ORANGE_1)
		setPlayerStorageValue(cid, 64854, 10)
		setPlayerStorageValue(cid, 64855, 10)
		setPlayerStorageValue(cid, 64856, 10)
		setPlayerStorageValue(cid, 64857, 10)
		setPlayerStorageValue(cid, 22467, 1)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYDAMAGE)
	else
		doPlayerSendTextMessage(cid,22,"Você ja possui a nova spell!")
	end
	return true
end