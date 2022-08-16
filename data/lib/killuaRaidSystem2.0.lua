killuaRaids = {}
killuaRaids.raids = {

	{name = "Dragon Lord", city = "Baiak City", monsters = {"Dragon Lord"}, fromTo = {{{x=147,y=57,z=7}, {x=155,y=59,z=7}}}},
}

killuaRaids.messages = {
	
	"Uma legião de @ está invadindo #, corram para proteger a cidade!",
	"Um grupo de @ foi visto adentrando #, é uma invasão!",
	"@ estão invadindo #, corram para salvar a cidade!"
}

killuaRaids.sort = function()
	return killuaRaids.raids[math.random(#killuaRaids.raids)]
end

killuaRaids.warn = function(message,times)
	local time = times - 1
	if time == 0 then return end
	doBroadcastMessage(message)
	addEvent(killuaRaids.warn,10000,message,time)
end

killuaRaids.summon = function(raid,times)
	local time = times - 1
	if time == 0 then return end
	local fromTo = raid.fromTo[math.random(#raid.fromTo)]
	local position = {x = math.random(fromTo[1].x, fromTo[2].x), y = math.random(fromTo[1].y, fromTo[2].y), z = fromTo[1].z}
	doCreateMonster(raid.monsters[math.random(#raid.monsters)],position)
	doSendMagicEffect(position,CONST_ME_FIREAREA)
	addEvent(killuaRaids.summon,700,raid,time) -- Tempo de Respawn
end

killuaRaids.start = function(raid)
	killuaRaids.warn(killuaRaids.messages[math.random(#killuaRaids.messages)]:gsub("@",raid.name):gsub("#",raid.city),10)
	killuaRaids.summon(raid,300) -- Quantidade de Respawn
end