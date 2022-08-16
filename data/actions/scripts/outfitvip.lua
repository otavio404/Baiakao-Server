function onUse(cid, item, itemEx, toPosition, fromPosition)
if getPlayerStorageValue(cid, 19000) <= 0 then
setPlayerStorageValue(cid, 19000, 1)
doPlayerSendTextMessage(cid, 22, "Parabens! Voce ganhou o Outfit Supremo.")
doSendMagicEffect(getPlayerPosition(cid), 30)
doRemoveItem(item.uid)
if getPlayerSex(cid) == 0 then
doPlayerAddOutfit(cid, 194, 1)
else
doPlayerAddOutfit(cid, 332, 1)
end
else
doPlayerSendCancel(cid, "Voce ja tem esse outfit.")
return true
end
return true
end