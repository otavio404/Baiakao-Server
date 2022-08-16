local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

keywordHandler:addKeyword({"recompensa"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Você pode pegar a recompensa clicando no bau que fica logo ali a baixo no bau ao finalizar a warzone, ela é completamente random e tem a possibilidade de cair Points, Dinheiro, Cave Exclusiva, Addon Doll, Green Gem, Stamina Refil, Double Experience, Critical Stone, Dodge Stone, Wand Energy, Pure Energy ou Dias Vip. Boa Sorte!"})

npcHandler:addModule(FocusModule:new())