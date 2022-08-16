Points_Trade = {
	Document_ItemID = 7724,
	Points = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
}

function DocumentPoints(Item)
	return tonumber(getItemAttribute(Item.uid, "points"))
end

function getPlayerPoints(cid)
	local AccountID = getPlayerAccountId(cid)
	local Result = db.getResult("SELECT `premium_points` FROM `accounts` WHERE `id` = ".. AccountID)
	return Result:getDataInt("premium_points") <= 0 and 0 or Result:getDataInt("premium_points") -- DataInt é number.
end

function doPlayerAddPoints(cid, Points)
	local AccountID = getPlayerAccountId(cid)
	local Result = db.getResult("SELECT `premium_points` FROM `accounts` WHERE `id` = '".. AccountID .."'")
	if Result:getID() ~= -1 then
		db.executeQuery("UPDATE `accounts` SET `premium_points` = " .. getPlayerPoints(cid) + Points .. " WHERE `id` = " .. AccountID .. ";")
	end
	return true
end

function doPlayerRemovePoints(cid, Points)
	local AccountID = getPlayerAccountId(cid)
	local Result = db.getResult("SELECT `premium_points` FROM `accounts` WHERE `id` = '".. AccountID .."'")
	if Result:getID() ~= -1 then
		db.executeQuery("UPDATE `accounts` SET `premium_points` = " .. getPlayerPoints(cid) - Points .. " WHERE `id` = " .. AccountID .. ";")
	end
	return true
end