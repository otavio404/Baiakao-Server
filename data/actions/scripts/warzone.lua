function onUse(cid, item, fromPosition, itemEx, toPosition)
timePassed = 24 * 60 * 60

if getPlayerStorageValue(cid, 45699) > 0 then
	if getPlayerStorageValue(cid, 42476) - os.time() <= 0 then
		setPlayerStorageValue(cid, 42476, os.time() + timePassed)
		doPlayerSendTextMessage(cid,22,"Ai esta sua recompensa da Warzone 2!")
		setPlayerStorageValue(cid, 45699, 0)
	wz1 = math.random(1, 7)
	if wz1 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2156, 1)
	elseif wz1 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2156, 1)
	elseif wz1 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 5)
	elseif wz1 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 3)
	elseif wz1 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2155, 1)
	elseif wz1 == 6 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 2)
	elseif wz1 == 7 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2346, 10)
	end

	wz2 = math.random(1, 7)
	if wz2 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 2)
	elseif wz2 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 3)
		wz3 = math.random(1, 4)
		if wz3 == 1 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 5468, 1)
			wz4 = math.random(1, 3)
			if wz4 == 1 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2155, 1)
			elseif wz4 == 2 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2179, 1)
			elseif wz4 == 3 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2155, 1)
			end
		elseif wz3 == 2 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 9693, 1)
		elseif wz3 == 3 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 12575, 2)
		elseif wz3 == 4 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 12396, 3)
		end
	elseif wz2 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9693, 1)
	elseif wz2 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 7443, 1)
	elseif wz2 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 3)
	elseif wz2 == 6 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 2)
	elseif wz2 == 7 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9971, 30)
	end

	wz4 = math.random(1, 5)
	if wz5 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2155, 1)
	elseif wz5 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2343, 1)
	elseif wz5 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 1)
	elseif wz5 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 1)
	elseif wz5 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9971, 20)
	end
	else
		doPlayerSendTextMessage(cid,22,"Você já pegou a recompensa da Warzone 2 nas ultimas 24 horas.")
	end
else
	doPlayerSendTextMessage(cid,22,"Você não concluiu a Warzone 2.")
end

if getPlayerStorageValue(cid, 45698) > 0 then
	if getPlayerStorageValue(cid, 42477) - os.time() <= 0 then
		setPlayerStorageValue(cid, 42477, os.time() + timePassed)
		setPlayerStorageValue(cid, 45698, 0)
		doPlayerSendTextMessage(cid,22,"Ai esta sua recompensa da Warzone 1!")

	wz1 = math.random(1, 7)
	if wz1 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2156, 1)
	elseif wz1 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2156, 1)
	elseif wz1 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 7443, 1)
	elseif wz1 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 3)
	elseif wz1 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2155, 1)
	elseif wz1 == 6 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 2)
	elseif wz1 == 7 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2346, 10)
	end

	wz2 = math.random(1, 7)
	if wz2 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 2)
	elseif wz2 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 3)
		wz3 = math.random(1, 4)
		if wz3 == 1 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 5468, 1)
			wz4 = math.random(1, 3)
			if wz4 == 1 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2155, 1)
			elseif wz4 == 2 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2179, 1)
			elseif wz4 == 3 then
				doSendMagicEffect(fromPosition, CONST_ME_POFF)
				doPlayerAddItem(cid, 2155, 1)
			end
		elseif wz3 == 2 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 9693, 1)
		elseif wz3 == 3 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 2155, 1)
		elseif wz3 == 4 then
			doSendMagicEffect(fromPosition, CONST_ME_POFF)
			doPlayerAddItem(cid, 12396, 3)
		end
	elseif wz2 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9693, 1)
	elseif wz2 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 7443, 1)
	elseif wz2 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 7443, 2)
	elseif wz2 == 6 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9971, 30)
	end

	wz4 = math.random(1, 5)
	if wz5 == 1 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2155, 1)
	elseif wz5 == 2 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 2343, 1)
	elseif wz5 == 3 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12575, 1)
	elseif wz5 == 4 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 12396, 1)
	elseif wz5 == 5 then
		doSendMagicEffect(fromPosition, CONST_ME_POFF)
		doPlayerAddItem(cid, 9971, 20)
	end
	else
		doPlayerSendTextMessage(cid,22,"Você já pegou a recompensa da Warzone 1 nas ultimas 24 horas.")
	end
else
	doPlayerSendTextMessage(cid,22,"Você não concluiu a Warzone 1.")
end
	return TRUE
end