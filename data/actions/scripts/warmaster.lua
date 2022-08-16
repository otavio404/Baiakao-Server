local addons = {
        [6062] = {[0] = 335, [1] = 336, name = "Warmaster"}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
        if addons[item.uid] then
                local storage = item.uid + 10000
                if getPlayerStorageValue(cid, storage) == -1 then
                        doPlayerSendTextMessage(cid, 25, "Você achou o conjunto de addons ".. addons[item.uid].name ..".")
                        doPlayerAddOutfit(cid, addons[item.uid][getPlayerSex(cid)], 3)
                        setPlayerStorageValue(cid, storage, 1)
                else
                        doPlayerSendTextMessage(cid, 25, "Você já possui este addon.")
                end
                return true
        end
end