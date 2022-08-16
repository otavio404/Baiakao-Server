function onUse(cid, item, frompos, item2, topos)
	if item.uid == 61469 then
		local guild = getGlobalStorageValue(realCastle.guild_storage) > 1 and "a guild "..getGuildNameByID(getGlobalStorageValue(realCastle.guild_storage)).." possui o domínio" or "nenhuma guild possui o domínio do castelo"
		local sto = realCastle.date_storages
		local gsto = getGlobalStorageValue
		local time = gsto(sto[1]).."/"..gsto(sto[2]).."/"..gsto(sto[3])
		local domain = realCastle.isOpen() and "as guilds estão batalhando pelo domínio do castelo" or guild
		local msg = " -----[Hotkey]-----\n\n\auto 100 listas 'Mining' | setcolor 255 255 255 | useongrounditem 2553 5645 | useongrounditem 2553 5634 | useongrounditem 2553 5631 | useongrounditem 2553 5635 | useongrounditem 2553 5632 | useongrounditem 2553 5636 | useongrounditem 2553 5633 | useongrounditem 2553 5647 | useongrounditem 2553 5650 | useongrounditem 2553 5649 | useongrounditem 2553 5637 | useongrounditem 2553 5638"
		doShowTextDialog(cid,8977,msg)
		return true
	end
	if not realCastle.isOpen() then 
		doTeleportThing(cid,getTownTemplePosition(1)) 
		return true 
	end
	if not realCastle.isDominating(cid) then
		realCastle.domain(cid)
		doSendMagicEffect(getThingPos(cid), CONST_ME_CRAPS)
	else
		doPlayerSendCancel(cid,"Sua guild já está com o domínio do castelo.")
	end
	return true
end
