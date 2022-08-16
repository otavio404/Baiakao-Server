local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end

function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end

function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end

function onThink()
	npcHandler:onThink()
end

function greetCallback(cid)
	talkState[cid] = 0
	return true
end

function creatureSayCallback(cid, type, msg)
	if (not npcHandler:isFocused(cid)) then
		return false
	end
	if talkState[cid] == nil or talkState[cid] == 0 then
		Count_Points = tonumber(msg)
		if isInArray(Points_Trade.Points, Count_Points) then
			npcHandler:say("Do you want to buy a premium points transfer document that will transfer ".. Count_Points .." premium points, right?", cid)
			talkState[cid] = 1
		else
			npcHandler:say("Escolha um numero entre ".. table.concat(Points_Trade.Points, ', ') ..".", cid)
			talkState[cid] = 0
		end
	elseif talkState[cid] == 1 then
		if msgcontains(msg, 'yes') then
		 if getPlayerPoints(cid) >= Count_Points then
			local Document = doCreateItemEx(Points_Trade.Document_ItemID)
			doItemSetAttribute(Document, "name", "".. Count_Points .." premium points transfer document")
			doItemSetAttribute(Document, "points", Count_Points)
			doPlayerAddItemEx(cid, Document)
			npcHandler:say("Você obteve um documento que vale ".. Count_Points .." premium points, use ele no trade com alguem.", cid)
			talkState[cid] = 0
		else
			npcHandler:say("Desculpe, mas voce nao tem ".. Count_Points .." Points.", cid)
			talkState[cid] = 0
		end
		else
			npcHandler:say("Ok, volte mais tarde.", cid)
			talkState[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Ola |PLAYERNAME|. Eu vendo alguns utensílios e Premium Points transfers para você transferir pontos para outros jogadores, lembre-se para comprar use '10,ppt' para 10 pontos.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())