local config = {
   effectonuse = 29, -- efeito que sai
   levelscrit = 100,  --- leveis que ter�o
   storagecrit = 98798644 -- storage que ser� verificado
   }
   
function onUse(cid, item, frompos, item2, topos)
	if (getPlayerStorageValue(cid, config.storagecrit) < config.levelscrit) then
		doRemoveItem(item.uid, 1)
		doSendMagicEffect(topos,config.effectonuse)
		if (getPlayerStorageValue(cid, config.storagecrit) == -1) then setPlayerStorageValue(cid, config.storagecrit, 0) end
		doPlayerSendTextMessage(cid,22,"Voce elevou seus dodges para ["..(getPlayerStorageValue(cid, config.storagecrit)+1).."/100].")
		setPlayerStorageValue(cid, config.storagecrit, getPlayerStorageValue(cid, config.storagecrit)+1)
	elseif getPlayerStorageValue(cid, config.storagecrit) >= config.levelscrit then
		doPlayerSendTextMessage(cid,22,"Voce ja chegou no nivel Maximo de Dodges.\nParab�ns.")
		return 0
	end
	return 1
end