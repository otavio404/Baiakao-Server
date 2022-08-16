local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local travelNode = keywordHandler:addKeyword({"morgum"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de ir a morgum por " .. (getConfigInfo("freeTravel") and "free?" or "30 gold?")})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 30, destination = {x=2376, y=808, z=7} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

local travelNode = keywordHandler:addKeyword({"liberty bay"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de acessar a cidade de Liberty Bay?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 30, destination = {x=2982, y=2697, z=6} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

local travelNode = keywordHandler:addKeyword({"venom"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de acessar a cidade de Venom?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 30, destination = {x=2912, y=2918, z=6} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

local travelNode = keywordHandler:addKeyword({"skyler"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de acessar a cidade Skyler?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 30, destination = {x=2296, y=2547, z=6} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})
	
local travelNode = keywordHandler:addKeyword({"eximus"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de acessar a cidade Eximus?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 30, destination = {x=2051, y=1708, z=6} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

local travelNode = keywordHandler:addKeyword({"principal"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de voltar para Baiak City?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 30, destination = {x=144, y=42, z=7} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

local travelNode = keywordHandler:addKeyword({"new city"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gostaria de acessar a cidade New City?"})
	travelNode:addChildKeyword({"yes"}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 30, destination = {x = 2946, y = 1342, z = 7} })
	travelNode:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = "We would like to serve you some time."})

npcHandler:addModule(FocusModule:new())