function onUse(cid, item, fromPosition, itemEx, toPosition)
	if (getPlayerStorageValue(cid, 42767) == EMPTY_STORAGE) then
		doCreatureSay(cid, "Voce ganhou magia nova dos deuses, se voce é kina use (exevo master gran), pally (exevo master san), druid (exevo master frigo) e sorc (exevo master flam) !", TALKTYPE_ORANGE_1)
		setPlayerStorageValue(cid, 44854, 10)
		setPlayerStorageValue(cid, 44855, 10)
		setPlayerStorageValue(cid, 44856, 10)
		setPlayerStorageValue(cid, 44857, 10)
		setPlayerStorageValue(cid, 42767, 1)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYDAMAGE)
	else
		doPlayerSendTextMessage(cid,22,"Você ja possui a nova spell 500+!")
	end
	return true
end