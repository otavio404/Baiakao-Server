local combat_values = {
	["none"] = -1,
	["ice"] = 1,
	["fire"] = 2,
	["earth"] = 3,
	["energy"] = 4,
	["holy"] = 5,
	["death"] = 6,
}

local config = {
	storage = 101010,
	time_storage = 101011,

	price = 1000000,
	delay = 0,

	msg = {
		help = "Use o comando exemplo: !wand holy Efeitos dispon�veis: ice, fire, earth, energy, holy, death, e none para desabilitar. A troca para outro elemento custa 1kk.",
		invalid = "Por favor, digite um tipo valido.",
		changed = "O elemento da wand foi trocado para %s.",
		nomoney = "Voc� n�o possui dinheiro.",
		delayed = "Voc� precisa esperar para trocar o efeito.",
	}
}

-- /////////////////////Requerimentos///////////////////--
local req_itemid = 12661                                  -- ID do item requerido
local req_text = "You cannot use this command."           -- Mensagem caso nao possua o item
--/////////////////////////////////////////////////////--

function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
	local param = param:lower()
	local value = combat_values[param]
if getPlayerItemCount(cid, req_itemid) > 0 then
	if param == "help" or param == "" then
		doShowTextDialog(cid, 12661, string.format(config.msg.help, config.price))
		return true
	end

	if not value then
		doPlayerSendCancel(cid, config.msg.invalid)
		return true
	end

	if getPlayerMoney(cid) < config.price then
		doPlayerSendCancel(cid, config.msg.nomoney)
		return true
	end

	if getPlayerMoney(cid) < config.price then
		doPlayerSendCancel(cid, config.msg.nomoney)
		return true
	end

	if getCreatureStorage(cid, config.time_storage) + config.delay > os.time() then
		doPlayerSendCancel(cid, config.msg.delayed)
		return true
	end

	doCreatureSetStorage(cid, config.storage, value)
	doCreatureSetStorage(cid, config.time_storage, os.time())
	doPlayerRemoveMoney(cid, config.price)
	doPlayerSendCancel(cid, string.format(config.msg.changed, param))
else
   doPlayerSendCancel(cid,req_text)
end
	return true
end