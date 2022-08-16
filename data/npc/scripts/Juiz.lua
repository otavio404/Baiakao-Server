local focuses = {}
local function isFocused(cid)
for i, v in pairs(focuses) do
  if(v == cid) then
   return true
  end
end
return false
end[/left]

local function addFocus(cid)
if(not isFocused(cid)) then
  table.insert(focuses, cid)
end
end

local function removeFocus(cid)
for i, v in pairs(focuses) do
  if(v == cid) then
   table.remove(focuses, i)
   break
  end
end
end

local function lookAtFocus()
for i, v in pairs(focuses) do
  if(isPlayer(v)) then
   doNpcSetCreatureFocus(v)
   return
  end
end
doNpcSetCreatureFocus(0)
end

function onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
if(isFocused(cid)) then
  selfSay("Hmph!")
  removeFocus(cid)
  if(isPlayer(cid)) then --Be sure he's online
   closeShopWindow(cid)
  end
end
end

function onCreatureSay(cid, type, msg)
end

function onPlayerCloseChannel(cid)
if(isFocused(cid)) then
  selfSay("Hmph!")
  closeShopWindow(cid)
  removeFocus(cid)
end
end

function onThink()
for i, focus in pairs(focuses) do
  if(not isCreature(focus)) then
   removeFocus(focus)
  else

   local distance = getDistanceTo(focus) or -1
   if((distance > 4) or (distance == -1)) then
	selfSay("Hmph!")
	closeShopWindow(focus)
	removeFocus(focus)
   end
  end
end

lookAtFocus()
end