--- Lib Cave-Exclusiva 1.0 by WooX --

caveExclusiva = {

	config = {
		rentTime = 180 * 60, -- 180 3 Horas
		buyItemID = 11720,
		caveStats = true,
		buyMessage = "Você comprou a cave de %s por %s.", -- 1° [%s] = Variavel para nome da cave, 2° [%s] = Variavel para duração da cave
		timeLeftMessageInCave = "Seu tempo na cave de %s acabou e você foi teleportado para o templo.", -- Mensagem quando acabar o tempo e o player estiver dentro da cave
		timeLeftMessage = "Seu tempo na cave de %s acabou.", -- Mensagem quando acabar o tempo e o player estiver fora da cave
		signs = {
			useSigns = true,
			signID = 1815,
			signLook = "Esta cave pertence a %s, estará livre novamente as %s."	-- 1° [%s] = Variavel para nome do player, 2° [%s] = Variavel para horário em que estara livre novamente
		}
	},

	caves = {
		[9851] = {
			gStor = 7330,
			caveName = "Spider Fiery",
			enterPos = {x=2493, y=511, z=7},
			signPos = {x=2320, y=480, z=7}
		},
		[9852] = {
			gStor = 7331,
			caveName = "Triple Medusa",
			enterPos = {x=2507, y=423, z=7},
			signPos = {x=2323, y=480, z=7}
		},
		[9853] = {
			gStor = 7332,
			caveName = "Toad Turtle",
			enterPos = {x=2469, y=339, z=7},
			signPos = {x=2326, y=480, z=7}
		},
		[9854] = {
			gStor = 7333,
			caveName = "Sea Serpent Ice",
			enterPos = {x=2482, y=197, z=7},
			signPos = {x=2329, y=480, z=7}
		},
		[9855] = {
			gStor = 7334,
			caveName = "Undead Darkshadow",
			enterPos = {x=2481, y=275, z=6},
			signPos = {x=2332, y=480, z=7}
		},
		[9856] = {
			gStor = 7335,
			caveName = "Spider Fiery",
			enterPos = {x=2642, y=514, z=7},
			signPos = {x=2335, y=480, z=7}
		},
		[9857] = {
			gStor = 7336,
			caveName = "Triple Medusa",
			enterPos = {x=2657, y=423, z=7},
			signPos = {x=2338, y=480, z=7}
		},
		[9858] = {
			gStor = 7337,
			caveName = "Toad Turtle",
			enterPos = {x=2602, y=340, z=7},
			signPos = {x=2341, y=480, z=7}
		},
		[9859] = {
			gStor = 7338,
			caveName = "Sea Serpent Ice",
			enterPos = {x=2473, y=51, z=7},
			signPos = {x=2344, y=480, z=7}
		},
		-- Metade
		[9860] = {
			gStor = 7339,
			caveName = "Mini Serpent Ice",
			enterPos = {x=2063, y=414, z=7},
			signPos = {x=2320, y=490, z=7}
		},
		[9861] = {
			gStor = 7340,
			caveName = "Magician Mage",
			enterPos = {x=2224, y=533, z=6},
			signPos = {x=2323, y=490, z=7}
		},
		[9862] = {
			gStor = 7341,
			caveName = "Baylor",
			enterPos = {x=2102, y=617, z=7},
			signPos = {x=2326, y=490, z=7}
		},
		[9863] = {
			gStor = 7342,
			caveName = "Haunter",
			enterPos = {x=2084, y=483, z=7},
			signPos = {x=2329, y=490, z=7}
		},
		[9864] = {
			gStor = 7343,
			caveName = "Earth Kelpie",
			enterPos = {x=2109, y=394, z=6},
			signPos = {x=2332, y=490, z=7}
		},
		[9865] = {
			gStor = 7344,
			caveName = "Toad Turtle",
			enterPos = {x=2529, y=340, z=7},
			signPos = {x=2335, y=490, z=7}
		},
		[9866] = {
			gStor = 7345,
			caveName = "Sea Serpent Ice",
			enterPos = {x=2327, y=194, z=7},
			signPos = {x=2338, y=490, z=7}
		},
		[9867] = {
			gStor = 7346,
			caveName = "Spider Fiery",
			enterPos = {x=2827, y=517, z=7},
			signPos = {x=2341, y=490, z=7}
		},
		[9868] = {
			gStor = 7347,
			caveName = "Triple Medusa",
			enterPos = {x=2310, y=349, z=7},
			signPos = {x=2344, y=490, z=7}
		},																									
	},
	

	storages = {
		cave = 35070,
		inCave = 35071,
		time = 35072
	}
}

-- Funções --
caveExclusiva.getCavesID = function()
	local caves = {}
	for k, v in pairs(caveExclusiva.caves) do
		table.insert(caves, k)
	end
	table.sort(caves, function(a,b) return b > a end)
	return caves
end

caveExclusiva.setSign = function(guid, cave, time)
	if caveExclusiva.config.signs.useSigns then
		local sign = getTileItemById(caveExclusiva.caves[cave].signPos, caveExclusiva.config.signs.signID).uid
		doSetItemText(sign, caveExclusiva.config.signs.signLook:format(getPlayerNameByGUID(guid), os.date("%X", os.time() + time)))
	end
end

caveExclusiva.resetSign = function(cave)
	if caveExclusiva.config.signs.useSigns then
		local sign = getTileItemById(caveExclusiva.caves[cave].signPos, caveExclusiva.config.signs.signID).uid
		doSetItemText(sign, "Esta cave está livre!")
	end
end

caveExclusiva.setCaveTo = function(cid, cave)
	setGlobalStorageValue(caveExclusiva.caves[cave].gStor, getPlayerGUID(cid))
	setPlayerStorageValue(cid, caveExclusiva.storages.cave, cave)
	setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
	setPlayerStorageValue(cid, caveExclusiva.storages.time, os.time() + caveExclusiva.config.rentTime)
	doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, caveExclusiva.config.buyMessage:format(caveExclusiva.caves[cave].caveName, getTimeString(caveExclusiva.config.rentTime)))
  
	addEvent(caveExclusiva.doRemoveCave, caveExclusiva.config.rentTime*1000, getPlayerGUID(cid), cave)
	caveExclusiva.setSign(getPlayerGUID(cid), cave, caveExclusiva.config.rentTime)
	return true
end

caveExclusiva.doRemoveCave = function(guid, cave)
	setGlobalStorageValue(caveExclusiva.caves[cave].gStor, 0)
	caveExclusiva.resetSign(cave)
	if isPlayerOnline(getPlayerNameByGUID(guid)) then
		local cid = getPlayerByGUID(guid)
		setPlayerStorageValue(cid, caveExclusiva.storages.cave, 0)
		if getPlayerStorageValue(cid, caveExclusiva.storages.inCave) > 0 then	
			setPlayerStorageValue(cid, caveExclusiva.storages.inCave, 0)
			doTeleportThing(cid, getTownTemplePosition(getPlayerTown(cid)))
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, caveExclusiva.config.timeLeftMessageInCave:format(caveExclusiva.caves[cave].caveName))
		else
			doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, caveExclusiva.config.timeLeftMessage:format(caveExclusiva.caves[cave].caveName))
		end
		setPlayerStorageValue(cid, caveExclusiva.storages.time, 0)
	end
end

caveExclusiva.onStartup = function()
	io.write(">> Setting Exclusive-Cave descriptions... ")
	for _, cave in pairs(caveExclusiva.getCavesID()) do
		local ownerGUID = getGlobalStorageValue(caveExclusiva.caves[cave].gStor) > 0 and getGlobalStorageValue(caveExclusiva.caves[cave].gStor) or false
		local timeLeft = ownerGUID and getOfflinePlayerStorage(ownerGUID, caveExclusiva.storages.time) - os.time() or false
		if ownerGUID then
			if timeLeft > 0 then
				addEvent(caveExclusiva.doRemoveCave, timeLeft*1000, ownerGUID, cave)
				caveExclusiva.setSign(ownerGUID, cave, timeLeft)
			else
				setGlobalStorageValue(caveExclusiva.caves[cave].gStor, 0)
				caveExclusiva.resetSign(cave)
			end
		end
	end
	io.write("done.", "\n")
end