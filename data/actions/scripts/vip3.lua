function onUse(cid)
local storage = 88889

if getPlayerStorageValue(cid, storage) ~= 1 then
doPlayerSetStorageValue(cid, storage, 1)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Agora voce pode acessar a Vip3. Parabens!")
    
elseif getPlayerStorageValue(cid, storage) == 1 then
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce ja tem acesso a Vip3.")
    
end
return TRUE
end