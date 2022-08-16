local tasks =
{

        [1] = {questStarted = 1713, questStorage = 75001, killsRequired = 1000, raceName = "Donate Frost Dragon", rewards = {first = {enable = true, type = "exp", values = 400000}, second = {enable = true, type = "money", values = 10000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [2] = {questStarted = 1714, questStorage = 75002, killsRequired = 600, raceName = "Triple Medusa", rewards = {first = {enable = true, type = "exp", values = 500000}, second = {enable = true, type = "money", values = 80000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [3] = {questStarted = 1715, questStorage = 75003, killsRequired = 500, raceName = "Donate Grim Reaper", rewards = {first = {enable = true, type = "exp", values = 60000}, second = {enable = true, type = "money", values = 20000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [4] = {questStarted = 1716, questStorage = 75004, killsRequired = 666, raceName = "Donate Demon", rewards = {first = {enable = true, type = "exp", values = 70000}, second = {enable = true, type = "money", values = 30000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [5] = {questStarted = 1717, questStorage = 75005, killsRequired = 1400, raceName = "Champion Warlock", rewards = {first = {enable = true, type = "exp", values = 80000}, second = {enable = true, type = "money", values = 40000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [6] = {questStarted = 1718, questStorage = 75006, killsRequired = 5000, raceName = "Draken Elite", rewards = {first = {enable = true, type = "exp", values = 90000}, second = {enable = true, type = "money", values = 100000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [7] = {questStarted = 1719, questStorage = 75007, killsRequired = 8000, raceName = "Terramite", rewards = {first = {enable = true, type = "exp", values = 1000000}, second = {enable = true, type = "money", values = 130000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [8] = {questStarted = 1720, questStorage = 75008, killsRequired = 15000, raceName = "Devil Flamebeast", rewards = {first = {enable = true, type = "exp", values = 1100000}, second = {enable = true, type = "money", values = 200000000}, third = {enable = false, type = nil, values = {nil, nil}}}},

        [9] = {questStarted = 1721, questStorage = 75009, killsRequired = 30000, raceName = "Spider Fiery", rewards = {first = {enable = true, type = "exp", values = 1200000}, second = {enable = true, type = "money", values = 300000000}, third = {enable = true, type = "boss", values = {x = 412, y = 426, z = 7}}}}

        
}

local storage = 74521

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
local voc = {}

function onCreatureAppear(cid)                          npcHandler:onCreatureAppear(cid)                        end
function onCreatureDisappear(cid)                       npcHandler:onCreatureDisappear(cid)                     end
function onCreatureSay(cid, type, msg)                  npcHandler:onCreatureSay(cid, type, msg)                end
function onThink()                                      npcHandler:onThink()                                    end

function creatureSayCallback(cid, type, msg)

        local s = getPlayerStorageValue(cid, storage)

        if(not npcHandler:isFocused(cid)) then
                return false
        end
        local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_PRIVATE and 0 or cid
        if msgcontains(msg, 'task') then

                if(s < 1) then
                        doPlayerSetStorageValue(cid, storage, 1)
                end

                if tasks[s] then
                        if(getPlayerStorageValue(cid, tasks[s].questStarted) < 1) then
                                if(getPlayerStorageValue(cid, tasks[s].creatureStorage) < 0) then
                                        doPlayerSetStorageValue(cid, tasks[s].creatureStorage, 0)
                                end

                                if(getPlayerStorageValue(cid, tasks[s].questStorage) < 0) then
                                        doPlayerSetStorageValue(cid, tasks[s].questStorage, 0)
                                end

                                doPlayerSetStorageValue(cid, tasks[s].questStarted, 1)
                                selfSay('You have started the task number ' .. getPlayerStorageValue(cid, storage) .. ', in this task you need to kill ' .. tasks[s].killsRequired .. ' ' .. tasks[s].raceName .. '.', cid)
                        else
                                selfSay('You are currently making task about ' .. tasks[s].raceName .. '.', cid)
                        end
                else
                        print("[Warning - Error::Killing in the name of::Tasks config] Something is wrong.")
                end

        elseif msgcontains(msg, 'report') then
                if tasks[s] and tasks[s].questStarted > 0 then
                        if(getPlayerStorageValue(cid, tasks[s].creatureStorage) < 0) then
                                doPlayerSetStorageValue(cid, tasks[s].creatureStorage, 0)
                        end

                        if(getPlayerStorageValue(cid, tasks[s].questStorage) < 0) then
                                doPlayerSetStorageValue(cid, tasks[s].questStorage, 0)
                        end

                        if(getPlayerStorageValue(cid, tasks[s].questStorage) >= tasks[s].killsRequired) then
                                selfSay('Great!... you have finished the task number ' .. s .. '. Good job.', cid)
                                doPlayerSetStorageValue(cid, storage, s + 1)
                                if(tasks[s].rewards.first.enable) then
                                        if(tasks[s].rewards.first.type == "boss") then
                                                doTeleportThing(cid, tasks[s].rewards.first.values)
                                        elseif(tasks[s].rewards.first.type == "exp") then
                                                doPlayerAddExperience(cid, tasks[s].rewards.first.values)
                                        elseif(tasks[s].rewards.first.type == "item") then
                                                doPlayerAddItem(cid, tasks[s].rewards.first.values[1], tasks[s].rewards.first.values[2])
                                        elseif(tasks[s].rewards.first.type == "money") then
                                                doPlayerAddMoney(cid, tasks[s].rewards.first.values)
                                        elseif(tasks[s].rewards.first.type == "storage") then
                                                doPlayerSetStorageValue(cid, tasks[s].rewards.first.values[1], tasks[s].rewards.first.values[2])
                                        end
                                end
                                if(tasks[s].rewards.second.enable) then
                                        if(tasks[s].rewards.second.type == "boss") then
                                                doTeleportThing(cid, tasks[s].rewards.second.values)
                                        elseif(tasks[s].rewards.second.type == "exp") then
                                                doPlayerAddExperience(cid, tasks[s].rewards.second.values)
                                        elseif(tasks[s].rewards.second.type == "item") then
                                                doPlayerAddItem(cid, tasks[s].rewards.second.values[1], tasks[s].rewards.second.values[2])
                                        elseif(tasks[s].rewards.second.type == "money") then
                                                doPlayerAddMoney(cid, tasks[s].rewards.second.values)
                                        elseif(tasks[s].rewards.second.type == "storage") then
                                                doPlayerSetStorageValue(cid, tasks[s].rewards.second.values[1], tasks[s].rewards.second.values[2])
                                        end
                                end
                                if(tasks[s].rewards.third.enable) then
                                        if(tasks[s].rewards.third.type == "boss") then
                                                doTeleportThing(cid, tasks[s].rewards.third.values)
                                        elseif(tasks[s].rewards.third.type == "exp") then
                                                doPlayerAddExperience(cid, tasks[s].rewards.third.values)
                                        elseif(tasks[s].rewards.third.type == "item") then
                                                doPlayerAddItem(cid, tasks[s].rewards.third.values[1], tasks[s].rewards.third.values[2])
                                        elseif(tasks[s].rewards.third.type == "money") then
                                                doPlayerAddMoney(cid, tasks[s].rewards.third.values)
                                        elseif(tasks[s].rewards.third.type == "storage") then
                                                doPlayerSetStorageValue(cid, tasks[s].rewards.third.values[1], tasks[s].rewards.third.values[2])
                                        end
                                end                          
                        else
                                selfSay('Current ' .. getPlayerStorageValue(cid, tasks[s].questStorage) .. ' ' .. tasks[s].raceName .. ' killed, you need to kill ' .. tasks[s].killsRequired .. '.', cid)
                        end
                else
                        selfSay('You do not have started any task.', cid)
                end
        end
        return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())