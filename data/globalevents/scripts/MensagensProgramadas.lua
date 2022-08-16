local msg = {
	--['05:30'] = {text = '[Evento] �s 06:00hrs ocorrer� o [Campo Minado]! O Teleport ser� criado no templo.', type = 21},
	--['05:50'] = {text = '[Evento] �s 06:00hrs ocorrer� o [Campo Minado]! O Teleport ser� criado no templo.', type = 21},
	
	--['07:30'] = {text = '[Evento] �s 08:00hrs ocorrer� o [Snowball]! O Teleport ser� criado no templo.', type = 21},
	--['07:50'] = {text = '[Evento] �s 08:00hrs ocorrer� o [Snowball]! O Teleport ser� criado no templo.', type = 21},
	
	--['09:30'] = {text = '[Evento] �s 10:00hrs ocorrer� o [Capture The Flag]! O Teleport ser� criado no templo.', type = 21},
	--['09:50'] = {text = '[Evento] �s 10:00hrs ocorrer� o [Capture The Flag]! O Teleport ser� criado no templo.', type = 21},
	
	--['11:30'] = {text = '[Evento] �s 12:00hrs ocorrer� o [Firestorm]! O Teleport ser� criado no templo.', type = 21},	
	--['11:50'] = {text = '[Evento] �s 12:00hrs ocorrer� o [Firestorm]! O Teleport ser� criado no templo.', type = 21},
	
	--['13:30'] = {text = '[Evento] �s 14:00hrs ocorrer� o [Defend The Tower]! O Teleport ser� criado no templo.', type = 21},
	--['13:50'] = {text = '[Evento] �s 14:00hrs ocorrer� o [Defend The Tower]! O Teleport ser� criado no templo.', type = 21},
	
	--['15:30'] = {text = '[Evento] �s 16:00hrs ocorrer� o [Desert War]! O Teleport ser� criado no templo.', type = 21},
	--['15:50'] = {text = '[Evento] �s 16:00hrs ocorrer� o [Desert War]! O Teleport ser� criado no templo.', type = 21},
	
	--['17:30'] = {text = '[Evento] �s 18:00hrs ocorrer� o [Battlefield]! O Teleport ser� criado no templo.', type = 21},
	--['17:50'] = {text = '[Evento] �s 18:00hrs ocorrer� o [Battlefield]! O Teleport ser� criado no templo.', type = 21},
	
	--['19:30'] = {text = '[Evento] �s 20:00hrs ocorrer� o [Snowball]! O Teleport ser� criado no templo.', type = 21},
	--['19:50'] = {text = '[Evento] �s 20:00hrs ocorrer� o [Snowball]! O Teleport ser� criado no templo.', type = 21},
	
	--['21:30'] = {text = '[Evento] �s 22:00hrs ocorrer� o [Defend The Tower]! O Teleport ser� criado no templo.', type = 21},
	--['21:50'] = {text = '[Evento] �s 22:00hrs ocorrer� o [Defend The Tower]! O Teleport ser� criado no templo.', type = 21},
	
	--['00:30'] = {text = '[Evento] �s 01:00hrs ocorrer� o [Firestorm]! O Teleport ser� criado no templo.', type = 21},
	--['00:50'] = {text = '[Evento] �s 01:00hrs ocorrer� o [Firestorm]! O Teleport ser� criado no templo.', type = 21},
	
	['20:00:'] = {text = '[Insanity Claste] �s 21:00 o Castle ser� aberto para invas�es. A guild que manter dominado o Castlelo at� o termino, receber� por 24hrs Hunts Privadas!', type = 21},
	['20:30'] = {text = '[Insanity Claste] �s 21:00 o Castle ser� aberto para invas�es. A guild que manter dominado o Castlelo at� o termino, receber� por 24hrs Hunts Privadas!', type = 21},
	['20:50'] = {text = '[Insanity Claste] Faltam apenas 10 minutos para o Castle abrir!', type = 21},
	
	['21:00'] = {text = '[Insanity Claste] O Castle est� aberto! Chame seu time e venha dominar para ganhar Hunts Privadas, por 24hrs!', type = 21},	
	['21:00'] = {text = '[Insanity Claste] O Castle est� aberto! Chame seu time e venha dominar para ganhar Hunts Privadas, por 24hrs!', type = 21},

	['22:00'] = {text = '[Insanity Claste] O Castle termina em 30 minutos.', type = 21},
	['22:20'] = {text = '[Insanity Claste] O Castle termina em 10 minutos.', type = 21},
}

function onThink(interval, lastExecution)
	local h = msg[os.date('%X'):sub(1, 5)]
	return h and doBroadcastMessage(h.text, h.type) or true
end