function onSay(cid, words, param)
	if param == '' then
		return doPlayerSendCancel(cid, 'Informe o nome do jogador e o tempo em segundos.')
	end
	
	local default = 600
	local tmp = string.explode(param, ',')
	
	if not isCreature(getCreatureByName(tmp[1])) then
		return doPlayerSendCancel(cid, 'Jogador inexistente ou off-line.')
	end
	
	setPlayerStorageValue(getCreatureByName(tmp[1]), 455010, os.time() + (tonumber(tmp[2]) or default))
	doPlayerSendCancel(cid, 'O jogador ' .. tmp[1] .. ' foi mutado.')
	return true
end