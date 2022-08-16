local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local Topic = {}

-- OTServ event handling functions start
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end
-- OTServ event handling functions end

function greetCallback(cid)
	Topic[cid] = 1
	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, 'yalsadasdahar') then
		npcHandler:say("Do you seek a passage to Yalahar for " .. (getConfigInfo("freeTravel") and "free?" or "275 gold?"), cid)
		Topic[cid] = 1
	elseif Topic[cid] == 1 and msgcontains(msg, 'yes') then
		local storage = 88775
		if doPlayerRemoveMoney(cid, 275) == true then
			if getPlayerStorageValue(cid, storage) == 1 then
				npcHandler:say('And, here we go!', cid)
				npcHandler:releaseFocus(cid)
				doSendMagicEffect(getThingPos(cid), CONST_ME_TELEPORT)
				local yalahar = {x = 32816, y = 31272, z = 6}
				doTeleportThing(cid, yalahar)
				doSendMagicEffect(yalahar, CONST_ME_TELEPORT)
				Topic[cid] = 0
			else
				npcHandler:say('You have not helped Wyrdin! Come back when you have done so.', cid)
				Topic[cid] = 0
			end
		else
			npcHandler:say('You do not have enough money.', cid)
			Topic[cid] = 0
		end
	end
	return true
end

local travelNode = keywordHandler:addKeyword({'ethno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to Ethno for 0 gold?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=32048, y=31974, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})
	
local travelNode = keywordHandler:addKeyword({'gengia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to Gengia for 0 gold?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=32071, y=32182, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})

local travelNode = keywordHandler:addKeyword({'dhfhuduhdhu'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to Pyre for 0 gold?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=31196, y=32345, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})

local travelNode = keywordHandler:addKeyword({'addon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to Addon City for 0 gold?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=32544, y=32351, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})

local travelNode = keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Carlin, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 10, destination = {x=32387, y=31821, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})	

local travelNode = keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Venore, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=32954, y=32022, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})	

local travelNode = keywordHandler:addKeyword({'abdendriel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para Ab dendriel,  você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=32734, y=31669, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})
	
local travelNode = keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you seek a passage to Thais for 0 gold?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=32310, y=32210, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})

local travelNode = keywordHandler:addKeyword({'eremo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Você quer ir para eremo, você tem certeza ?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = true, level = 0, cost = 0, destination = {x=33321, y=31883, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'Next time maybe.'})
	
local travelNode = keywordHandler:addKeyword({'gorsdasdoma'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ugh. You really want to go back to Goroma? I\'ll surely have to repair my ship afterwards, so I have to charge 0 gold pieces. Okay?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=32161, y=32558, z=6} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})

local travelNode = keywordHandler:addKeyword({'furia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ugh. You really want to go back to Furia? I\'ll surely have to repair my ship afterwards, so I have to charge 0 gold pieces. Okay?'})
	travelNode:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, level = 0, cost = 0, destination = {x=31922, y=32351, z=7} })
	travelNode:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, reset = true, text = 'We would like to serve you some time.'})	

        keywordHandler:addKeyword({'travel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Venore, Thais, Carlin, Abdendriel,Goroma, Eremo, Pyre, Addon City, Gengia, Ethno, Furia '})
        -- Makes sure the npc reacts when you say hi, bye etc.
        npcHandler:addModule(FocusModule:new())