local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)            npcHandler:onCreatureAppear(cid)        end
function onCreatureDisappear(cid)        npcHandler:onCreatureDisappear(cid)        end
function onCreatureSay(cid, type, msg)        npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                npcHandler:onThink()                end

-- Storage IDs --
local Warmaster    = 10043    


local newaddon    = 'Here you are, enjoy your brand new addon!'
local noitems        = 'You do not have all the required items.'
local noitems2    = 'You do not have all the required items or you do not have the first addon, which by the way, is a requirement for this addon.'
local already        = 'It seems you already have this addon, don\'t you try to mock me son!'
        
-- WARMASTER START --
function OrientalFirst(cid, message, keywords, parameters, node)

    if(not npcHandler:isFocused(cid)) then
        return false
    end

    if isPremium(cid) then
    addon = getPlayerStorageValue(cid,Warmaster)
    if addon == -1 then
        if getPlayerItemCount(cid,11328) >= 100 then
        if doPlayerRemoveItem(cid,11328,100) then
            selfSay(newaddon)
             
            doSendMagicEffect(getCreaturePosition(cid), 13)
            doPlayerAddOutfit(cid, 336, 1)
            doPlayerAddOutfit(cid, 336, 1)
            setPlayerStorageValue(cid,Warmaster,1)
        end
        else
            selfSay(noitems)
        end
    else
        selfSay(already)
    end
    end

end

function OrientalSecond(cid, message, keywords, parameters, node)

    if(not npcHandler:isFocused(cid)) then
        return false
    end

    if isPremium(cid) then
    addon = getPlayerStorageValue(cid,Warmaster+1)
    if addon == -1 then
        if getPlayerItemCount(cid,11296) >= 1
        if doPlayerRemoveItem(cid,11296,1)
            selfSay(newaddon)
             
            doSendMagicEffect(getCreaturePosition(cid), 13)
            doPlayerAddOutfit(cid, 336, 2)
            doPlayerAddOutfit(cid, 336, 2)
            setPlayerStorageValue(cid,Warmaster+1,1)
        end
        else
            selfSay(noitems)
        end
    else
        selfSay(already)
    end
    end

end
-- WARMASTER END --

keywordHandler:addKeyword({'addons'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you first & second addons of the Warmaster outfit."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you do is that you type 'first Warmaster addon' or 'second Warmaster addon'. Assuming that you already collected all the required pieces, say 'yes' and vo?la - you got yourself an addon!"})

local node1 = keywordHandler:addKeyword({'first Warmaster addon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'To achieve the first Warmaster addon you need to give me a 100 legionnaire's flags. Do you have it with you?'})
    node1:addChildKeyword({'yes'}, OrientalFirst, {npcHandler = npcHandler, onlyFocus = true, reset = true})
    node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Alright then. Come back when you got all neccessary items.', reset = true})

local node2 = keywordHandler:addKeyword({'second Warmaster addon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'To achieve the second Warmaster addon you need to give me 1 zaoan helmet. Do you have them with you?'})
    node2:addChildKeyword({'yes'}, OrientalSecond, {npcHandler = npcHandler, onlyFocus = true, reset = true})
    node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Alright then. Come back when you got all neccessary items.', reset = true})
npcHandler:addModule(FocusModule:new())