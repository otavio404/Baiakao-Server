local monsterPosition = {x = 141, y = 45, z = 7}
local lootBoostPosition = {x = 142, y = 45, z = 7}
local expBoostPosition = {x = 140, y = 45, z = 7}

local BOOST_SYSTEM_MONSTER_NAME_STORAGE = 12380
local BOOST_SYSTEM_LOOT_BONUS_STORAGE = 12381
local BOOST_SYSTEM_EXP_BONUS_STORAGE = 12382

string.upperAllFirst = string.upperAllFirst or function (str)
  return string.gsub(' ' .. str, '%W%l', string.upper):sub(2)
end

local days = {
  ["Sunday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Domingo
  ["Monday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Segunda-feira
  ["Tuesday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Terça-feira
  ["Wednesday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Quarta-feira
  ["Thursday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Quinta-feira
  ["Friday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"}, -- Sexta-feira
  ["Saturday"] = {"Warlock", "Dragon Lord", "Draken Abomination", "Behemoth", "Medusa", "Frost Dragon", "Demon", "Grim Reaper", "Serpent Spawn", "Hydra", "Ghastly Dragon", "Hellhound", "Undead Dragon", "Draken Elite", "Fury"} -- Sábado
}

function onStartup()
  local monsters = days[os.date("%A")]
  if not monsters then
    return true 
  end
  
  
  local func = db.query or db.executeQuery
  local monster = monsters[math.random(1, #monsters)]
  print(monster)
  doSetStorage(BOOST_SYSTEM_MONSTER_NAME_STORAGE, monster:lower())
  doSetStorage(BOOST_SYSTEM_LOOT_BONUS_STORAGE, math.random(30, 50))
  doSetStorage(BOOST_SYSTEM_EXP_BONUS_STORAGE, math.random(30, 50))
  doCreateMonster(monster, monsterPosition, false, true)
  func("INSERT INTO monster_boost (monster, loot, exp) VALUES ('"..monster.."', '"..getStorage(BOOST_SYSTEM_LOOT_BONUS_STORAGE).."', '"..getStorage(BOOST_SYSTEM_EXP_BONUS_STORAGE).."')")
  return true
end

function onThink()
  local monsterName = getStorage(BOOST_SYSTEM_MONSTER_NAME_STORAGE)
  if monsterName == EMPTY_STORAGE then 
    return true
  end

  local creature = getTopCreature(monsterPosition)
  if not creature or creature.uid == 0 then 
    doCreateMonster(monsterName, monsterPosition, false, true)
  elseif getCreatureName(creature.uid):lower() ~= monsterName then
    doRemoveCreature(creature.uid)
    doCreateMonster(monsterName, monsterPosition, false, true)
  end

  --doSendAnimatedText(monsterPosition, string.upperAllFirst(monsterName), COLOR_LIGHTBLUE)
  doSendAnimatedText(lootBoostPosition, "Loot +" .. getStorage(BOOST_SYSTEM_LOOT_BONUS_STORAGE) .. "%", 194)
  doSendAnimatedText(expBoostPosition, "Exp +" .. getStorage(BOOST_SYSTEM_EXP_BONUS_STORAGE) .. "%", 194)

  return true
end
