function onTime(interval, lastExecution)
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13097;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13098;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 13099;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14000;")
	return true
end