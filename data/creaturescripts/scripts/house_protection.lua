function onThrow(cid, item, fromPosition, toPosition)
	if fromPosition.x ~= 65535 and getHouseFromPos(fromPosition) then
		if getHouseOwner(getHouseFromPos(fromPosition)) ~= getPlayerGUID(cid) then
			doPlayerSendCancel(cid, "Voce nao pode levar, nem mover as coisas de outra pessoa para sua casa.")
			return false
		end
	elseif toPosition.x ~= 65535 and getHouseFromPos(toPosition) then
		if getHouseOwner(getHouseFromPos(toPosition)) ~= getPlayerGUID(cid) then
			doPlayerSendCancel(cid, "Voce nao pode jogar coisas na casa de outra pessoa.")
			return false
		end
	end
	return true
end


function onLogin(cid)
	registerCreatureEvent(cid, "HouseProtection")
	return true
end