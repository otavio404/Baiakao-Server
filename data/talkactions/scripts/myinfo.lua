function timeString(timeDiff)
	local dateFormat = {
		{"day", timeDiff / 60 / 60 / 24},
		{"hour", timeDiff / 60 / 60 % 24},
		{"minute", timeDiff / 60 % 60},
		{"second", timeDiff % 60}
	}
	local out = {}
	for k, t in ipairs(dateFormat) do
		local v = math.floor(t[2])
		if(v > 0) then
			table.insert(out, (k < #dateFormat and (#out > 0 and ', ' or '') or ' and ') .. v .. ' ' .. t[1] .. (v ~= 1 and 's' or ''))
		end
	end
	local ret = table.concat(out)
	if ret:len() < 16 and ret:find("second") then
		local a, b = ret:find(" and ")
		ret = ret:sub(b+1)
	end
	
	return ret
end
function getPremiumPoints(cid)
    local query = db.getResult("SELECT `premium_points` FROM `accounts` WHERE `id` = "..getPlayerAccountId(cid))
    return query:getDataInt("premium_points") <= 0 and 0 or query:getDataInt("premium_points")
end
function doCalcPercent(cid, a, b)
    return math.floor(b/a*100)
end
function getExperienceForLevel(lv)
    lv = lv - 1
    return ((50 * lv * lv * lv) - (150 * lv * lv) + (400 * lv)) / 3
end
local var = {
    ["fist fighting"] = 0,
    ["club fighting"] = 1,
    ["sword fighting"] = 2,
    ["axe fighting"] = 3,
    ["distance fighting"] = 4,
    ["shield fighting"] = 5,
    ["fishing"] = 6,
    ["magic"] = 9
}
function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Premium Points: "..getPremiumPoints(cid))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Dias Premmy: "..getPlayerPremiumDays(cid))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Dodge Level: "..(getPlayerStorageValue(cid, 98798644) <= 0 and 0 or getPlayerStorageValue(cid, 98798644)))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Critical Level: "..(getPlayerStorageValue(cid, 48903) <= 0 and 0 or getPlayerStorageValue(cid, 48903)))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Stamina: "..timeString((getPlayerStamina(cid)*60)))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Cap livre: "..getPlayerFreeCap(cid))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Banco: "..getPlayerBalance(cid))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Experiencia: "..getPlayerExperience(cid))
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"Informacoes das skills de "..getCreatureName(cid))
    local lvl, ln = getPlayerLevel(cid),-(getPlayerExperience(cid) - getExperienceForLevel((getPlayerLevel(cid)+1)))
    local z = (getExperienceForLevel(getPlayerLevel(cid)) - getExperienceForLevel(getPlayerLevel(cid)+1))
    local w = (getExperienceForLevel(getPlayerLevel(cid)) - getPlayerExperience(cid))
    local v = math.floor(w/z*100)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"- level: "..lvl.." {"..(v <= 0 and 0 or v).."%}. Faltando "..ln.." pontos de experiencia.")
    for name, id in pairs(var) do
        if name == "magic" then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"- ".. name .. ": "..getPlayerMagLevel(cid).." {" .. doCalcPercent(cid, getPlayerRequiredMana(cid, getPlayerMagLevel(cid)+1), getPlayerSpentMana(cid)) .. "%}. Faltando "..getPlayerRequiredMana(cid, getPlayerMagLevel(cid)+1) - getPlayerSpentMana(cid).." pontos.") 
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"- ".. name .. ": "..getPlayerSkillLevel(cid, id).." {" .. doCalcPercent(cid, getPlayerRequiredSkillTries(cid, id, getPlayerSkillLevel(cid, id)+1), getPlayerSkillTries(cid, id)) .. "%}. Faltando "..getPlayerRequiredSkillTries(cid, id, getPlayerSkillLevel(cid, id)+1) - getPlayerSkillTries(cid, id).." pontos.") 
        end
    end
    --doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE,"- labia: "..getLabiaLevel(cid).." {" .. doCalcPercent(cid, getLabiaExpTo(getLabiaLevel(cid)+1), getLabiaTries(cid)) .. "%}. Faltando ".. math.floor(getLabiaExpTo(getLabiaLevel(cid)+1) - getLabiaTries(cid)).." pontos.") 
    --ShowMyBuffs(cid)
    return true
end