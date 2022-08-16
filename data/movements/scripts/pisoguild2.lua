local tempo = 5
function onStepIn(cid, item, position, fromPosition)
local n, g = getCreatureName(cid), getPlayerGuildName(cid)
if getPlayerGuildId(cid) == 0 then
doPlayerSendCancel(cid, "[Castle24Hrs] Apenas jogadores com guild e acima de level 100 podem entrar nessa zona.")
doTeleportThing(cid, fromPosition, false) return true
end

if (getPlayerStorageValue(cid, 9952) <= os.time()) then
doBroadcastMessage("O Jogador [".. getCreatureName(cid) .."] da guild [".. getPlayerGuildName(cid) .."] está invadindo o Castle24Hrs. Aviso aos donos atuais, corram para protegê-lo!", 21)
setPlayerStorageValue(cid, 9952, os.time()+tempo)
end
return TRUE
end