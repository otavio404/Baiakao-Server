function onStepIn(cid, item, position, fromPosition)

sorte = math.random(1,5)

if getPlayerAccess(cid) <= 2 then
	if sorte == 1 then
	doSendMagicEffect(position,6)
	doTeleportThing(cid,{x=497,y=631,z=7})
	doTransformItem(item.uid,1502)
	doSendAnimatedText(position,"BooomM",149)
	else
	doSendAnimatedText(position,"Ttlec",16)
	doSendMagicEffect(position,3)
	end
end

	return TRUE
end













