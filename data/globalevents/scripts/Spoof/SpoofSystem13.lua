function onTime(interval, lastExecution)
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13079;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13080;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13081;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13082;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13083;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13084;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13077;")
			db.query("UPDATE `players` SET `online` = 0 WHERE `online` = 1 AND `id` = 13078;")
	return true
end