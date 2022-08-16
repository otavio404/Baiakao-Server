function reloadCampoMinado()

for x = 478,489 do
for y = 621,632 do

ppos = {x=x,y=y,z=7,stackpos=2}
pos = getThingfromPos(ppos)

	if pos.itemid == 1502 then
		doTransformItem(pos.uid,10570)

	end
end
end
end

function onTime()
	local time = os.date("*t")
	if (CampoMinado_STARTAUTO) and (isInArray(CampoMinado_DAYS,time.wday)) then
			doCreateTeleport(1387, _Lib_CampoMinado_Info.DestinoPos, _Lib_CampoMinado_Info.tpPos)
			doBroadcastMessage("{CampoMinado} Teleport criado no templo, o evento inicia em "..OpenTime.." minutos!")
			setGlobalStorageValue(27381, 0)
			addEvent(reloadCampoMinado, 1*60*1000)
			addEvent(StartCampoMinado, OpenTime*60*1000)
			return
	end
return true
end