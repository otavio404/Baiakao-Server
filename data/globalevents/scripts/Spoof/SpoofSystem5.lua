function onTime(interval, lastExecution)
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13079;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13080;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13081;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13082;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13083;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13084;")
	return true
end