function onTime(interval, lastExecution)
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 11300;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 11301;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 11302;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 11303;")
	return true
end