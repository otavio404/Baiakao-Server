local config = {
max = 3, -- N�mero de players permitido com o mesmo IP.
group_id = 1 -- Kikar apenas player com o group id 1.
}

local accepted_ip_list = {"127.0.0.1"} -- Lista dos players permitidos a usar MC, exemplo: {"200.85.3.60", "201.36.5.222"}

local function antiMC(p)
if #getPlayersByIp(getPlayerIp(p.pid)) >= p.max then
doRemoveCreature(p.pid)
end
return true
end

function onLogin(cid)
	if not isPlayer(cid) then return true end
	if getPlayerGroupId(cid) <= config.group_id then
		if isInArray(accepted_ip_list,doConvertIntegerToIp(getPlayerIp(cid))) == false then
			addEvent(antiMC, 1000, {pid = cid, max = config.max+1})
		end
	end
	return true
end