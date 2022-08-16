local config = {
	idleWarning = getConfigValue('idleWarningTime'),
	idleKick = getConfigValue('idleKickTime')
}

function onThink(cid, interval)
	if(not isCreature(cid)) then
		return
	end

	local skull, skullEnd = getCreatureSkull(cid), getPlayerSkullEnd(cid)
	if(skullEnd > 0 and skull > SKULL_WHITE and os.time() > skullEnd and not getCreatureCondition(cid, CONDITION_INFIGHT)) then
		doPlayerSetSkullEnd(cid, 0, skull)
	end
	
	local gemid = getPlayerStorageValue(cid, 71473)
    if (getPlayerStorageValue(cid, 45783) > 0) and (checkGemTimeFinish(cid, gemid)) then
        deAtiveGem(cid, gemid)
        doRemoveCondition(cid, CONDITION_ATTRIBUTES)         
    end      
	
	if(getTileInfo(getCreaturePosition(cid)).noLogout or getCreatureNoMove(cid) or
		getPlayerCustomFlagValue(cid, PLAYERCUSTOMFLAG_ALLOWIDLE)) then
		return true
	end

	local idleTime = getPlayerIdleTime(cid) + interval
	doPlayerSetIdleTime(cid, idleTime)
	if(config.idleKick > 0 and idleTime > config.idleKick) then
		doRemoveCreature(cid)
	elseif(config.idleWarning > 0 and idleTime == config.idleWarning) then
		local message = "There was no variation in your behaviour for " .. math.ceil(config.idleWarning / 60000) .. " minutes"
		if(config.idleKick > 0) then
			message = message .. ". You will be disconnected in "
			local diff = math.ceil((config.idleWarning - config.idleKick) / 60000)
			if(diff > 1) then
				message = message .. diff .. " minutes"
			else
				message = message .. "one minute"
			end

			message = message .. " if there is no change in your actions until then."
		end

		doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, message .. ".")
	end

	return true
end
