function onStepIn(cid, item, position, fromPosition)

	nomep = getCreatureName(cid)
	getFirstPlayer = function()
		for x = 475, 506 do
			for y = 617, 647 do
				local area = {x = x, y = y, z = 7}
				if getTopCreature(area) and getTopCreature(area).uid > 0 and isPlayer(getTopCreature(area).uid) then
					return getTopCreature(area).uid
				end
			end
		end
	end

	if getGlobalStorageValue(27381) == 1 then
		doTeleportThing(cid, _Lib_CampoMinado_Info.ExitPos)
		doBroadcastMessage("{CampoMinado} O jogador "..nomep.." foi o 2º a chegar no final do labirinto!")
		doPlayerAddItem(cid, _Lib_CampoMinado_Info.RewardSegundo[1], _Lib_CampoMinado_Info.RewardSegundo[2])
		setGlobalStorageValue(27381, getGlobalStorageValue(27381)+1)
	elseif getGlobalStorageValue(27381) == 2 then
		doTeleportThing(cid, _Lib_CampoMinado_Info.ExitPos)
		doBroadcastMessage("{CampoMinado} O jogador "..nomep.." foi o 3º a chegar no final do labirinto!")
		setGlobalStorageValue(27381, 0)
		doPlayerAddItem(cid, _Lib_CampoMinado_Info.RewardTerceiro[1], _Lib_CampoMinado_Info.RewardTerceiro[2])
		OpenWallCampoMinado()
		doCreateTeleport(1387, _Lib_CampoMinado_Info.DestinoPos, _Lib_CampoMinado_Info.PerdeuPos)
		local player = getFirstPlayer()
		doTeleportThing(player, getTownTemplePosition(getPlayerTown(player)))
	else
		doTeleportThing(cid, _Lib_CampoMinado_Info.ExitPos)
		doBroadcastMessage("{CampoMinado} O jogador "..nomep.." foi o 1º a chegar no final do labirinto!")
		doPlayerAddItem(cid, _Lib_CampoMinado_Info.RewardPrimeiro[1], _Lib_CampoMinado_Info.RewardPrimeiro[2])
		setGlobalStorageValue(27381, 1)
	end
	return TRUE
end
























