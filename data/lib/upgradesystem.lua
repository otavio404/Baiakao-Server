UpgradeHandler = {
    levels = {
        [1] = {100, false, false},
        [2] = {50, false, false},
        [3] = {40, false, true},
        [4] = {30, true, true},
        [5] = {10, true, true},
        [6] = {7, true, true},
        [7] = {6, true, true},
        [8] = {3, true, true},
        [9] = {2, true, true},
        [10] = {1, true, true}

    },
    broadcast = 4,
    broadcastfail = 4,
    attributes = {
        ["attack"] = 1,
        ["defense"] = 1,
        ["armor"] = 5,
    },
    message = {
        console = "{Upgrade System} Refinando %s para o level %s adiante você tem %s%% de conseguir.",
        success = "{Upgrade System} Você conseguiu Refinar %s para o level +%s.",
        fail = "{Upgrade System} Você falhou a sua refinação.",
        downgrade = "{Upgrade System} Seu item %s voltou para o level +%s.",
        erase = "{Upgrade System} O level da refinação %s foi apagado.",
        maxlevel = "{Upgrade System} O item %s ja esta no level maximo.",
        notupgradeable = "{Upgrade System} Este item não é refinavel.",
        broadcast = "{Upgrade System} O Jogador %s obteve sucesso no seu Upgrade de %s para o level +%s.\nParabens!!",
        broadcastfail = "{Upgrade System} O Jogador %s não obteve sucesso no seu Upgrade de %s voltou de +%s para o level +%s.",
        invalidtool = "{Upgrade System} Este não é um item de refinação valido.",
        toolrange = "{Upgrade System} Você so pode usar o refinamento do level +%s ate +%s."
    },
    tools = {
       -- [8300] = {range = {0, 10}, info = {chance = 0, removeable = true}},
       -- [8306] = {range = {0, 10}, info = {chance = 80, removeable = true}}
    },
    
    isEquipment = function(self)
        local weaponType = self:getItemWeaponType()
        return ((weaponType > 0 and weaponType < 7) or self.item.armor ~= 0)
    end,
    
    setItemName = function(self, name)
        return doItemSetAttribute(self.item.uid, "name", name)
    end,
    
    chance = function(self)
        local chances = {}
        chances.upgrade = (100 - self.item.level * (self.item.level % 2 == 0 and 9.5 or 10))
        chances.downgrade = (self.item.level * 5)
        chances.erase = (self.item.level * 11)
        
        return chances
    end
}

function UpgradeHandler:new(item)
    local obj, ret = {}
    obj.item = {}
    
    obj.item.level = 0
    obj.item.uid = item.uid
    for key, value in pairs(getItemInfo(item.itemid)) do
        obj.item[key] = value
    end
    
    ret = setmetatable(obj, {__index = function(self, index)
            if _G[index] then
                    return (setmetatable({callback = _G[index]}, {__call = function(self, ...)
                        return self.callback(item.uid, ...)
                end}))
            else
                return UpgradeHandler[index]
            end
    end})
    
    if ret:isEquipment() then
        ret:update()
        return ret
    end
    return false
end

function UpgradeHandler:update()
    self.item.level = (tonumber(self:getItemName():match("%+(%d+)")) or 0)
end

function UpgradeHandler:refine(uid, item)
    if not self.item then
        doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, self.message.notupgradeable)
        return "miss"
    end
    
    local tool = self.tools[item.itemid]
    
    if(tool == nil) then
        doPlayerSendTextMessage(uid, MESSAGE_EVENT_DEFAULT, self.message.invalidtool)
        return "miss"
    end
    
    if(self.item.level > 10) then
        doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.maxlevel:format(self.item.name))
        return "miss"
    end
    
    if(self.item.level < tool.range[1] or self.item.level >= tool.range[2]) then
        doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.toolrange:format(unpack(tool.range)))
        return "miss"
    end
    
    local chance = (self:chance().upgrade + tool.info.chance)
    doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_BLUE, self.message.console:format(self.item.name, (self.item.level + 1), math.min(100, chance)))
    
    if(tool.info.removeable == true) then
        doRemoveItem(item.uid, 1)
    end
    
    if chance * 100 > math.random(1, 10000) then
        doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_ORANGE, self.message.success:format(self.item.name, (self.item.level + 1)))
        if (self.item.level + 1) >= self.broadcast then
            doBroadcastMessage(self.message.broadcast:format(getCreatureName(uid), self.item.name, (self.item.level + 1)))
        end
        
        self:setItemName((self.item.level > 0 and self:getItemName():gsub("%+(%d+)", "+".. (self.item.level + 1)) or (self:getItemName() .." +1")))
        for key, value in pairs(self.attributes) do
            if getItemAttribute(self.item.uid, key) ~= nil or self.item[key] ~= 0 then
                doItemSetAttribute(self.item.uid, key, (self.item.level > 0 and getItemAttribute(self.item.uid, key) or self.item[key]) + value)
            end
        end
        return "success"
    elseif item.itemid == 8306 then
        doPlayerSendTextMessage(uid, MESSAGE_STATUS_CONSOLE_RED, self.message.downgrade:format(self.item.name, (self.item.level - 1)))
        if (self.item.level - 1) >= self.broadcastfail then
           doBroadcastMessage(self.message.broadcastfail:format(getCreatureName(uid), self.item.name, self.item.level, (self.item.level - 1)))
        end
        self:setItemName((self.item.level == 1 and self.item.name or self:getItemName():gsub("%+(%d+)", "+".. (self.item.level - 1))))
        for key, value in pairs(self.attributes) do
            if getItemAttribute(self.item.uid, key) ~= nil or self.item[key] ~= 0 then
                doItemSetAttribute(self.item.uid, key, (self.item[key] + value * (self.item.level - 1)))
            end
        end
        return "fail"
    end
end