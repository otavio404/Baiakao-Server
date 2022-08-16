function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
local storage = 6707
local delaytime = 180
local a = "data/logs/bugs.txt"

local f = io.open(a, "a+")
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Digite !bugreport e o comentario do bug.")
		return true
	end

	local exhaust = exhaustion.get(cid, storage)
	if(not exhaust) then
		exhaustion.set(cid, storage, delaytime)
			doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Seu relatorio foi recebido com sucesso!")
			f:write(""..getPlayerName(cid).." relatou um bug em " .. os.date("%d %B %Y - %X ", os.time()) .."\n"..param.." [x="..getPlayerPosition(cid).x..", y="..getPlayerPosition(cid).y..", z="..getPlayerPosition(cid).z.."].\n\n----------------------------------------------------------\n")
		f:close()
	else
		doPlayerSendCancel(cid, "Espere 3 minutos para reportar outro bug.")
	end

	return true
end
