function onStepIn(cid, item, position, fromPosition)


local castle_one_name = "Castle24H"   -- Nome do castelo 1
local storages = {154154,54321,123123}    -- Storages ( se vc eh iniciante, deixe como est&#225;...)




local sto_ativ = getGlobalStorageValue(storages[2])
position = getCreaturePosition(cid)




   if isPlayerGuild(cid) == TRUE then
 if sto_ativ == 1 or sto_ativ == -1 then


guildname = getPlayerGuildName(cid) 
guild = getPlayerGuildId(cid) 
guild_sto = getGlobalStorageValue(storages[3])


if guild ~= guild_sto then 


  doBroadcastMessage("Aviso aos atuais donos do ["..castle_one_name.."], o Jogador ["..getCreatureName(cid).."] da guild [\""..guildname.."] esta tentando invadir.", MESSAGE_STATUS_WARNING) 




else
 doPlayerSendCancel(cid,"Avance")
end
 else
 doPlayerSendCancel(cid,"Avance")
 end 
   else
   doPlayerSendCancel(cid,"Avance")
   end
   return true
end




function isPlayerGuild(cid)
if getPlayerGuildName(cid) ~= "" then
return TRUE
else
return FALSE
end
end