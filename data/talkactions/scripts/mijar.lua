local times = 10
storage = 92857

function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
if getPlayerStorageValue(cid, storage) <= os.time() then
		
			setPlayerStorageValue(cid, storage, os.time() + times)

local pos = {x=getCreaturePosition(cid).x, y=getCreaturePosition(cid).y, z=getCreaturePosition(cid).z, stackpos=1}
if getCreatureLookDirection(cid) == SOUTH then
pos = {x=getCreaturePosition(cid).x, y=getCreaturePosition(cid).y+1, z=getCreaturePosition(cid).z, stackpos=255}
elseif getCreatureLookDirection(cid) == NORTH then
pos = {x=getCreaturePosition(cid).x, y=getCreaturePosition(cid).y-1, z=getCreaturePosition(cid).z, stackpos=255}
elseif getCreatureLookDirection(cid) == EAST then
pos = {x=getCreaturePosition(cid).x+1, y=getCreaturePosition(cid).y, z=getCreaturePosition(cid).z, stackpos=255}
elseif getCreatureLookDirection(cid) == WEST then
pos = {x=getCreaturePosition(cid).x-1, y=getCreaturePosition(cid).y, z=getCreaturePosition(cid).z, stackpos=255}
end

doSendAnimatedText(getThingPos(cid),"xiiii",TEXTCOLOR_YELLOW)
local getThing = getThingFromPos(pos)
doSendMagicEffect(pos, 1)  

	if getCreatureLookDirection(cid) == SOUTH then
	doCreateItem(5662, 1, pos)
	addEvent (
		function (cid)
		if getTileItemById(pos,5662).uid > 0 then
doRemoveItem(getTileItemById(pos,5662).uid > 0 and getTileItemById(pos ,5662).uid )
end
		end, 500
	) 
	end
	
		if getCreatureLookDirection(cid) == EAST then
	doCreateItem(5665, 1, pos)
	addEvent (
		function (cid)
		if getTileItemById(pos,5665).uid > 0 then
doRemoveItem(getTileItemById(pos,5665).uid > 0 and getTileItemById(pos ,5665).uid )
end
		end, 500
	) 
	end
	
	
	addEvent (
		function (cid)
		local a = doCreateItem(2030, 13, pos)
		doDecayItem(a)
		end, 100
	) 
	addEvent (
		function (cid)
		local a = doCreateItem(2029, 13, pos)
		doDecayItem(a)
		end, 150
	) 
	addEvent (
		function (cid)
		local a = doCreateItem(2028, 13, pos)
		doDecayItem(a) 
		end, 200
	) 
	addEvent (
		function (cid)
		local a = doCreateItem(2027, 13, pos)
		doDecayItem(a)
		end, 250
		) 
	addEvent (
		function (cid)
		local a = doCreateItem(2026, 13, pos)
		doDecayItem(a)
		end, 300
	)
	addEvent (
		function (cid)
		local a = doCreateItem(2025, 13, pos)
		doDecayItem(a)
		end, 400
	)
	
	else
		doPlayerSendCancel(cid, 'Espere '.. times ..' segundos, para mijar novamente.')
		doSendMagicEffect(getThingPos(cid), 2)
	end
	return true
end