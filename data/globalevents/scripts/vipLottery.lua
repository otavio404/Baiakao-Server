function onThink()
	local players = getPlayersOnline()
	local cid = players[math.random(1,#players)]
	if isPlayer(cid) then
		local q = db.getResult("SELECT premium_points FROM accounts WHERE id = '"..getPlayerAccountId(cid).."'")
		local a = q:getDataInt("premium_points")
		q:free()
		local points = tonumber(a) + 2
		doBroadcastMessage("[Loteria VIP] O jogador "..getCreatureName(cid).." foi sorteado e recebeu 2 premium points no site para comprar itens na shop! Próximo sorteio em 4 horas.")
		db.query("UPDATE accounts SET premium_points = '"..points.."' WHERE id = '"..getPlayerAccountId(cid).."'")
	end
	return true
end
