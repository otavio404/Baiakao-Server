local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
	local shopWindow = {}
	local onSell = function(cid, item, subType, amount, ignoreCap, inBackpacks)
		local store,exausted = 874661,5
		local old_level,priceTicks = getLabiaLevel(cid), getPriceLabiaLevel(cid, Labia_Items[item].price)*amount -- evita bugs
		if getPlayerStorageValue(cid, store) >= os.time() then
			doPlayerSendCancel(cid, "wait " .. getPlayerStorageValue(cid, store) - os.time() .. " seconds to sell items.") return true
		end
		if doPlayerRemoveItem(cid, item, amount) then
			doPlayerAddMoney(cid, priceTicks)
			local exp = getItemExpLabia(item)
			for i = 1, amount do
				addLabiaTry(cid, exp)
			end
			npcHandler:say("You have sold " .. amount .. "x " .. getItemNameById(item) .. " for " .. priceTicks .. " gold.", cid)
			setPlayerStorageValue(cid, store, os.time()+exausted) 
			if old_level ~= getLabiaLevel(cid) then 
				closeShopWindow(cid) -- para atualizar os prices dos itens
			end
		end
		return true
	end
	if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
		for var, ret in pairs(Labia_Items) do
			table.insert(shopWindow, {id = var, subType = 0, sell = getPriceLabiaLevel(cid, ret.price), name = getItemNameById(var)})
		end
		openShopWindow(cid, shopWindow, onBuy, onSell)
	end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())