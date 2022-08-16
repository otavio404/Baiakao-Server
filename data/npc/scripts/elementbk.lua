local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

keywordHandler:addKeyword({"elementos"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Para usar o sistema de elementos você precisa obter a benção do Dragon Elements Book que você pode obter no WebShop ou concluindo todas as tasks no npc Dragon Tasks, você pode manipular elementos em armas Dragon ou Magias!"})
keywordHandler:addKeyword({"magias"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Você pode trocar o elemento da sua magia especial usando um element stone na fonte de energia que deseja, lembre-se que o nome da magia irá mudar!"})
keywordHandler:addKeyword({"dragon staff"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Se você possue a bença do Dragon Elements Book você pode trocar o elemento da sua Dragon Staff +1 até +6 a qualquer momento usando ela na fonte de energia que deseja, lembre-se que somente a Staff estando +6 pode trocar de elemento."})

npcHandler:addModule(FocusModule:new())