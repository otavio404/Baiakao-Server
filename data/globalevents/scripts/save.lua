function executeSaveServer()
    doSaveServer()
	doCleanMap()
    return true
end

function onThink(interval, lastExecution, thinkInterval)
    doBroadcastMessage("Servidor será salvo e o mapa ficará limpo em um minuto, cuidado pode haver freeze!", 22)
    addEvent(executeSaveServer, 60000)
    return true
end