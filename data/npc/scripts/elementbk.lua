local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

keywordHandler:addKeyword({"elementos"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Para usar o sistema de elementos voc� precisa obter a ben��o do Dragon Elements Book que voc� pode obter no WebShop ou concluindo todas as tasks no npc Dragon Tasks, voc� pode manipular elementos em armas Dragon ou Magias!"})
keywordHandler:addKeyword({"magias"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Voc� pode trocar o elemento da sua magia especial usando um element stone na fonte de energia que deseja, lembre-se que o nome da magia ir� mudar!"})
keywordHandler:addKeyword({"dragon staff"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Se voc� possue a ben�a do Dragon Elements Book voc� pode trocar o elemento da sua Dragon Staff +1 at� +6 a qualquer momento usando ela na fonte de energia que deseja, lembre-se que somente a Staff estando +6 pode trocar de elemento."})

npcHandler:addModule(FocusModule:new())