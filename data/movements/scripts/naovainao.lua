function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor) 
storage_guild = getGlobalStorageValue(realCastle.guild_storage) 
local tpos,v = {x=3360,y=301,z=9},getThingPos(cid) -- {x=1,y=1,z=1} is the position you teleport to, don't change getThingPos(cid).  

if isPlayer(cid) then 
if getPlayerGuildId(cid) == storage_guild then 
doTeleportThing(cid,position) 
else 
doTeleportThing(cid,tpos) 
doCreatureSay(cid, "[Castle48hrs] Sua guild n�o � mais dona do Castle e voc� foi expulso! :(", TALKTYPE_SAY) 
doSendMagicEffect(getPlayerPosition(cid),6) 
end 
return true 
end
end