function executeSaveServer()
    doSaveServer()
	doCleanMap()
    return true
end

function onThink(interval, lastExecution, thinkInterval)
    doBroadcastMessage("Servidor ser� salvo e o mapa ficar� limpo em um minuto, cuidado pode haver freeze!", 22)
    addEvent(executeSaveServer, 60000)
    return true
end