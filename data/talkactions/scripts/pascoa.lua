local frompos, topos = {x=73,y=8,z=7},{x=225,y=70,z=7}

local function isWalkable(pos)-- by Nord / editado por Omega
    if getTileThingByPos({x = pos.x, y = pos.y, z = pos.z, stackpos = 0}).itemid == 0 then
    	return false
	elseif getTopCreature(pos).uid > 0 then
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

local function easterInvasion()
	doBroadcastMessage("[Páscoa] Muitos Coelhos Da Páscoa estão invadindo a cidade!! Acabem com eles para conseguir ovos!")
	local count = 0
	for i=1,70 do
		local pos = {x = math.random(frompos.x,topos.x), y = math.random(frompos.y,topos.y), z = 7}
		if not isWalkable(pos) then
			local max = 20
			repeat
				pos = {x = math.random(frompos.x,topos.x), y = math.random(frompos.y,topos.y), z = 7}
				count = count + 1
			until isWalkable(pos) or count >= max
		end
		doCreateMonster("Coelho Da Pascoa",pos)
	end
	addEvent(easterInvasion,math.random(20*60,40*60)*1000)
end

function onSay(cid,words,param,channel)
	--addEvent(easterInvasion,math.random(3600*3,3600*4)*1000)
	easterInvasion()
	return true
end