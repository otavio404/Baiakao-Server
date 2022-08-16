function onSay(cid, words, param)
pos = {x=1318, y=1828, z=7}
doSendMagicEffect(getPlayerPosition(cid),53)
doPlayerSendCancel(cid,"Teleportado!")
doTeleportThing(cid,pos)
return true
end