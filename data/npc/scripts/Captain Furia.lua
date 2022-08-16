local keywordHandler = KeywordHandler:new()
        local npcHandler = NpcHandler:new(keywordHandler)
        NpcSystem.parseParameters(npcHandler)
        
        
        
        -- OTServ event handling functions start
        function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
        function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
        function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
        function onThink() 						npcHandler:onThink() end
        -- OTServ event handling functions end
        
        
        -- Don't forget npcHandler = npcHandler in the parameters. It is required for all StdModule functions!
local travelNode = keywordHandler:addKeyword({'hydra'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de Hydra, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=31716, y=32350, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'cyclops'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de Cyclops, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31702, y=32430, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'dragons'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de Dragons, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31760, y=32293, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'demons'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de Demons, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31603, y=32270, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

local travelNode = keywordHandler:addKeyword({'warlock'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de Warlocks,  você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31602, y=32348, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})
	
	local travelNode = keywordHandler:addKeyword({'hellnaut'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Hunt de HellNaut,  você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31597, y=32427, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})

	      
        keywordHandler:addKeyword({'travel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Hydra, Cyclops, Dragons, Demons, Warlocks, Hellnaut '})
        -- Makes sure the npc reacts when you say hi, bye etc.
        npcHandler:addModule(FocusModule:new())