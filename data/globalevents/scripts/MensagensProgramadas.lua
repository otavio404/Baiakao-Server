local msg = {
	--['05:30'] = {text = '[Evento] Ás 06:00hrs ocorrerá o [Campo Minado]! O Teleport será criado no templo.', type = 21},
	--['05:50'] = {text = '[Evento] Ás 06:00hrs ocorrerá o [Campo Minado]! O Teleport será criado no templo.', type = 21},
	
	--['07:30'] = {text = '[Evento] Ás 08:00hrs ocorrerá o [Snowball]! O Teleport será criado no templo.', type = 21},
	--['07:50'] = {text = '[Evento] Ás 08:00hrs ocorrerá o [Snowball]! O Teleport será criado no templo.', type = 21},
	
	--['09:30'] = {text = '[Evento] Ás 10:00hrs ocorrerá o [Capture The Flag]! O Teleport será criado no templo.', type = 21},
	--['09:50'] = {text = '[Evento] Ás 10:00hrs ocorrerá o [Capture The Flag]! O Teleport será criado no templo.', type = 21},
	
	--['11:30'] = {text = '[Evento] Ás 12:00hrs ocorrerá o [Firestorm]! O Teleport será criado no templo.', type = 21},	
	--['11:50'] = {text = '[Evento] Ás 12:00hrs ocorrerá o [Firestorm]! O Teleport será criado no templo.', type = 21},
	
	--['13:30'] = {text = '[Evento] Ás 14:00hrs ocorrerá o [Defend The Tower]! O Teleport será criado no templo.', type = 21},
	--['13:50'] = {text = '[Evento] Ás 14:00hrs ocorrerá o [Defend The Tower]! O Teleport será criado no templo.', type = 21},
	
	--['15:30'] = {text = '[Evento] Ás 16:00hrs ocorrerá o [Desert War]! O Teleport será criado no templo.', type = 21},
	--['15:50'] = {text = '[Evento] Ás 16:00hrs ocorrerá o [Desert War]! O Teleport será criado no templo.', type = 21},
	
	--['17:30'] = {text = '[Evento] Ás 18:00hrs ocorrerá o [Battlefield]! O Teleport será criado no templo.', type = 21},
	--['17:50'] = {text = '[Evento] Ás 18:00hrs ocorrerá o [Battlefield]! O Teleport será criado no templo.', type = 21},
	
	--['19:30'] = {text = '[Evento] Ás 20:00hrs ocorrerá o [Snowball]! O Teleport será criado no templo.', type = 21},
	--['19:50'] = {text = '[Evento] Ás 20:00hrs ocorrerá o [Snowball]! O Teleport será criado no templo.', type = 21},
	
	--['21:30'] = {text = '[Evento] Ás 22:00hrs ocorrerá o [Defend The Tower]! O Teleport será criado no templo.', type = 21},
	--['21:50'] = {text = '[Evento] Ás 22:00hrs ocorrerá o [Defend The Tower]! O Teleport será criado no templo.', type = 21},
	
	--['00:30'] = {text = '[Evento] Ás 01:00hrs ocorrerá o [Firestorm]! O Teleport será criado no templo.', type = 21},
	--['00:50'] = {text = '[Evento] Ás 01:00hrs ocorrerá o [Firestorm]! O Teleport será criado no templo.', type = 21},
	
	['20:00:'] = {text = '[Insanity Claste] Ás 21:00 o Castle será aberto para invasões. A guild que manter dominado o Castlelo até o termino, receberá por 24hrs Hunts Privadas!', type = 21},
	['20:30'] = {text = '[Insanity Claste] Ás 21:00 o Castle será aberto para invasões. A guild que manter dominado o Castlelo até o termino, receberá por 24hrs Hunts Privadas!', type = 21},
	['20:50'] = {text = '[Insanity Claste] Faltam apenas 10 minutos para o Castle abrir!', type = 21},
	
	['21:00'] = {text = '[Insanity Claste] O Castle está aberto! Chame seu time e venha dominar para ganhar Hunts Privadas, por 24hrs!', type = 21},	
	['21:00'] = {text = '[Insanity Claste] O Castle está aberto! Chame seu time e venha dominar para ganhar Hunts Privadas, por 24hrs!', type = 21},

	['22:00'] = {text = '[Insanity Claste] O Castle termina em 30 minutos.', type = 21},
	['22:20'] = {text = '[Insanity Claste] O Castle termina em 10 minutos.', type = 21},
}

function onThink(interval, lastExecution)
	local h = msg[os.date('%X'):sub(1, 5)]
	return h and doBroadcastMessage(h.text, h.type) or true
end