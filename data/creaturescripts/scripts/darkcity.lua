function onKill(cid, target, lastHit)

local questCreatures =
{
        ["Donate Frost Dragon"] = {questStarted = 1713, questStorage = 75001, creatureStorage = 17001, killsRequired = 1000, raceName = "Donate Frost Dragon"},
        
        ["Triple Medusa"] = {questStarted = 1714, questStorage = 75002, creatureStorage = 17002, killsRequired = 600, raceName = "Triple Medusa"},
        
        ["Donate Grim Reaper"] = {questStarted = 1715, questStorage = 75003, creatureStorage = 17003, killsRequired = 500, raceName = "Donate Grim Reaper"},
        
        ["Donate Demon"] = {questStarted = 1716, questStorage = 75004, creatureStorage = 17004, killsRequired = 666, raceName = "Donate Demon"},
        
        ["Champion Warlock"] = {questStarted = 1717, questStorage = 75005, creatureStorage = 17005, killsRequired = 1400, raceName = "Champion Warlock"},

        ["Draken Elite"] = {questStarted = 1718, questStorage = 75006, creatureStorage = 17006, killsRequired = 5000, raceName = "Draken Elite"},

        ["Terramite"] = {questStarted = 1719, questStorage = 75007, creatureStorage = 17007, killsRequired = 8000, raceName = "Terramite"},

        ["Devil Flamebeast"] = {questStarted = 1720, questStorage = 75008, creatureStorage = 17008, killsRequired = 15000, raceName = "Devil Flamebeast"},

        ["Spider Fiery"] = {questStarted = 1719, questStorage = 75009, creatureStorage = 17009, killsRequired = 30000, raceName = "Spider Fiery"},
	 
    }

local creature = questCreatures[getCreatureName(target)]
       
        if creature then
                if(isPlayer(target) == true) then
                        return true
                end
                if getPlayerStorageValue(cid, creature.questStarted) > 0 then
                        if getPlayerStorageValue(cid, creature.questStorage) < creature.killsRequired then
                                if getPlayerStorageValue(cid, creature.questStorage) < 0 then
                                        doPlayerSetStorageValue(cid, creature.questStorage, 0)
                                end

                                if getPlayerStorageValue(cid, creature.creatureStorage) < 0 then
                                        doPlayerSetStorageValue(cid, creature.creatureStorage, 0)
                                end
                                doPlayerSetStorageValue(cid, creature.questStorage, getPlayerStorageValue(cid, creature.questStorage) + 1)
                                doPlayerSetStorageValue(cid, creature.creatureStorage, getPlayerStorageValue(cid, creature.creatureStorage) + 1)
                                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "" .. getPlayerStorageValue(cid, creature.creatureStorage) .. " " .. getCreatureName(target) .. " defeated. Total [" .. getPlayerStorageValue(cid, creature.questStorage) .. "/" .. creature.killsRequired .. "] " .. creature.raceName .. ".")
                        end
                end
        end
        return true
end