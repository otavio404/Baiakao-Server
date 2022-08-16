bomberman = {
	inGameStorage = 722601,
	bombStorage = 722602,
	radiusStorage = 722603,
	imuneStorage = 722604,
	bombLimitStorage = 722605,
	bombDelayStorage = 722606,
	oldSpeedStorage = 722607,

	bombId = 9469,
	stoneId = 9419,
	blockId = 10755,

	bonuses = {9931, 8304, 11361, 11251},
	ips = {},
	tpPos = {x = 141,y = 45,z = 7}
}

bomberman.arenas = {
	[1] = {
		storage = 722608,
		
		fromPosLeaver = {x = 642, y = 187, z = 12},
		toPosLeaver = {x = 644, y = 188, z = 12},

		fromPos = {x = 592, y = 123, z = 12},
		toPos = {x = 614, y = 143, z = 12},
		rightTopCorner = {x = 614, y = 123, z = 12},
		leftBottomCorner = {x = 592, y = 143, z = 12},

		exit = {x = 643, y = 191, z = 12}
	},

	[2] = {	
		storage = 7226010,

		fromPosLeaver = {x = 647, y = 187, z = 12},
		toPosLeaver = {x = 649, y = 188, z = 12},

		fromPos = {x = 626, y = 123, z = 12},
		toPos = {x = 648, y = 143, z = 12},
		rightTopCorner = {x = 648, y = 123, z = 12},
		leftBottomCorner = {x = 626, y = 143, z = 12},

		exit = {x = 648, y = 191, z = 12}
	},

	[3] = {
		storage = 722610,

		fromPosLeaver = {x = 652, y = 187, z = 12},
		toPosLeaver = {x = 654, y = 188, z = 12},

		fromPos = {x = 661, y = 123, z = 12},
		toPos = {x = 683, y = 143, z = 12},
		rightTopCorner = {x = 683, y = 123, z = 12},
		leftBottomCorner = {x = 661, y = 143, z = 12},

		exit = {x = 653, y = 191, z = 12}
	},

	[4] = {
		storage = 722611,

		fromPosLeaver = {x = 657, y = 187, z = 12},
		toPosLeaver = {x = 659, y = 188, z = 12},

		fromPos = {x = 695, y = 123, z = 12},
		toPos = {x = 717, y = 143, z = 12},
		rightTopCorner = {x = 717, y = 123, z = 12},
		leftBottomCorner = {x = 695, y = 143, z = 12},

		exit = {x = 658, y = 191, z = 12}
	},

	[5] = {
		storage = 722612,

		fromPosLeaver = {x = 642, y = 195, z = 12},
		toPosLeaver = {x = 644, y = 196, z = 12},

		fromPos = {x = 592, y = 155, z = 12},
		toPos = {x = 614, y = 175, z = 12},
		rightTopCorner = {x = 614, y = 155, z = 12},
		leftBottomCorner = {x = 592, y = 175, z = 12},

		exit = {x = 643, y = 192, z = 12}
	},

	[6] = {
		storage = 722613,

		fromPosLeaver = {x = 647, y = 195, z = 12},
		toPosLeaver = {x = 649, y = 196, z = 12},

		fromPos = {x = 626, y = 155, z = 12},
		toPos = {x = 648, y = 175, z = 12},
		rightTopCorner = {x = 648, y = 155, z = 12},
		leftBottomCorner = {x = 626, y = 175, z = 12},

		exit = {x = 648, y = 192, z = 12}
	},

	[7] = {
		storage = 722614,

		fromPosLeaver = {x = 652, y = 195, z = 12},
		toPosLeaver = {x = 654, y = 196, z = 12},

		fromPos = {x = 661, y = 155, z = 12},
		toPos = {x = 683, y = 175, z = 12},
		rightTopCorner = {x = 683, y = 155, z = 12},
		leftBottomCorner = {x = 661, y = 175, z = 12},

		exit = {x = 653, y = 192, z = 12}
	},

	[8] = {
		storage = 722615,

		fromPosLeaver = {x = 657, y = 195, z = 12},
		toPosLeaver = {x = 659, y = 196, z = 12},

		fromPos = {x = 695, y = 155, z = 12},
		toPos = {x = 717, y = 175, z = 12},
		rightTopCorner = {x = 717, y = 155, z = 12},
		leftBottomCorner = {x = 695, y = 175, z = 12},

		exit = {x = 658, y = 192, z = 12}
	},
}

bomberman.isArenaFree = function(arenaNumber)
	return getGlobalStorageValue(bomberman.arenas[arenaNumber].storage) == -1
end