function isWalkable(pos) -- by Nord / editado por Omega
	if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then
		return false
	elseif isCreature(getTopCreature(pos).uid) then
		return false
	elseif getTileInfo(pos).protection then
		return false
	elseif hasProperty(getThingFromPos(pos).uid, 3) or hasProperty(getThingFromPos(pos).uid, 7) then
		return false
	end
	return true
end
local positions = {
	[1] = {x=164,y=57,z=7},
	[2] = {x=176,y=39,z=7},
	[3] = {x=169,y=40,z=7},
	[4] = {x=156,y=57,z=7},
	[5] = {x=139,y=41,z=7},
	[6] = {x=173,y=57,z=7},
	[7] = {x=161,y=32,z=7},
	[8] = {x=138,y=60,z=7},
	[9] = {x=179,y=59,z=7},
	[10] = {x=132,y=23,z=7},
	[11] = {x=173,y=33,z=7},
	[12] = {x=178,y=27,z=7},
	[13] = {x=181,y=22,z=7},
	[14] = {x=197,y=39,z=7},
	[15] = {x=208,y=40,z=7},
	[16] = {x=208,y=50,z=7},
	[17] = {x=204,y=62,z=7},
	[18] = {x=194,y=57,z=7},
	[19] = {x=178,y=67,z=7},
	[20] = {x=104,y=61,z=7},
	[21] = {x=102,y=54,z=7},
	[22] = {x=103,y=46,z=7},
	[23] = {x=153,y=61,z=7},
	[24] = {x=96,y=41,z=7},
	[25] = {x=83,y=39,z=7},
	[26] = {x=110,y=34,z=7},
	[27] = {x=132,y=47,z=7},
	[28] = {x=138,y=54,z=7}
}
function onUse(cid, item, frompos, item2, topos)
  print("itemUID:" .. item.uid)
	doBroadcastMessage("[AVISO] A cidade foi invadida por Monstros, venha proteger a cidade!")
	local monsterName
	if item.uid == 19000 then
		monsterName = 'Phantom Lord'
	elseif item.uid == 19001 then
		monsterName = 'Finger Killer'
	elseif item.uid == 19002 then
		monsterName = 'Brimstone Bug'
	elseif item.uid == 19003 then
		monsterName = 'Green Phantom'
	end	
  print("creature Name:" .. monsterName)
	for i = 1, #positions do
	    if isWalkable(positions[i]) then
		   doCreateMonster(monsterName, positions[i])
      end
	end
	return true
end