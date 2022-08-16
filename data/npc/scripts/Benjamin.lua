local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'PESSOAL AJUDEM FAZER O SERVER CRESCER CONTINUAMENTE, DEEM SUAS SUGESTOES NO POST REFERENTE A ESTE ASSUNTO NA PAGINA DO FACEBOOK E CURTEM A PAGINA, OBRIGADO!' },
	{ text = 'PROCURANDO UM HOST DE QUALIDADE? ACESSE NOSSO PARCEIRO WWW.UPPERHOST.NET' },
	{ text = 'PARA OS NOVOS PLAYERS, QUE NÂO SABEM COMO USAR O AUTOLOOT E MINING, NA PAGINA DO FACEBOOK: https://www.facebook.com/baiakinho-1305789806137280/ TEM UM TUTORIAL LA!' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "It was a pleasure to help you, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
