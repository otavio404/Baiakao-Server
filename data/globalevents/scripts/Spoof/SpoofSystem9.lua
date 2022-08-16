function onTime(interval, lastExecution)
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14001;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14002;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14003;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14004;")
			db.query("UPDATE `players` SET `online` = 1 WHERE `online` = 0 AND `id` = 14005;")
	return true
end