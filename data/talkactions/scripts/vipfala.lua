local config = {
	storage = 19400, -- storage em que será salvo o tempo
	cor = "advance", -- de acordo com o constant.lua da lib
	tempo = 2, -- em minutos
	price = 1000, -- preço pra usar o broadcast
	level = 250, -- level pra poder utilizar o broadcast
	premium = true -- true ou false apenas, se necessario ser premium
}


function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	if(param == '') then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		return true
	end
	
	if (not isPremium(cid)) and config.premium then
		doPlayerSendCancel(cid, "Voce precisa ser um jogador vip donate para poder usar esse comando.")
	        return true
	end	
	
	if getPlayerLevel(cid) >= config.level then
		if getPlayerStorageValue(cid, config.storage) - os.time() <= 0 then
			if doPlayerRemoveMoney(cid, config.price) then
				setPlayerStorageValue(cid, config.storage, os.time() + (config.tempo*60)) 
				doBroadcastMessage("[BROADCAST] "..getCreatureName(cid)..": "..param.."", config.cor)
				doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Voce enviou uma mensagem para o servidor com sucesso, agora voce tera que esperar " ..config.tempo.. " minuto(s) ate que voce possa enviar outra mensagem novamente.")
			else
				doPlayerSendCancel(cid, "Voce nao tem " ..config.price.. " GPS para mandar uma mensagem para o servidor.")
				return true
			end
		else
			doPlayerSendCancel(cid, "Voce tem que esperar " ..(getPlayerStorageValue(cid, config.storage) - os.time()).. " segundos ate que voce possa enviar outra mensagem novamente.")
			return true
		end
	else
		doPlayerSendCancel(cid, "Voce precisa ser level " ..config.level.. " para mandar uma mensagem para o servidor.")
	return true
	end	
end