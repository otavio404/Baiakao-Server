local config = {
money = 50000000, -- Dinheiro que vai custar
item = 2346, -- ID do item que vai vender
count = 1, -- Quantidade
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
pos = getCreaturePosition(cid)

if item.itemid == 1945 then
 if doPlayerRemoveMoney(cid, config.money) == TRUE then
doPlayerAddItem(cid, config.item, config.count)
doPlayerSendTextMessage(cid, 18, "Você acaba de comprar "..config.count.." "..getItemNameById(config.item)..".")
doSendMagicEffect(pos, CONST_ME_MAGIC_BLUE)
 else
doPlayerSendTextMessage(cid, 18, "Desculpe, mas você nao tem dinheiro suficiente.")
doSendMagicEffect(pos, CONST_ME_POFF)
end
end

end