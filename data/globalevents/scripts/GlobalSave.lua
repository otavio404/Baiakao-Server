function prepareShutdown(minutes)
        if(minutes <= 0) then
                doSetGameState(GAMESTATE_SHUTDOWN)
                return false
        end

        if(minutes == 1) then
                doBroadcastMessage("Falta apenas " .. minutes .. " minuto para o Servidor Reinciar.")
        elseif(minutes <= 3) then
                doBroadcastMessage("Global Serve Save em " .. minutes .. " minutos. Procure um lugar seguro!")
        else
                doBroadcastMessage("Global Serve Save em " .. minutes .. " minutos. Procure um lugar seguro!")
        end

        shutdownEvent = addEvent(prepareShutdown, 60000, minutes - 1)
        return true
end

function onTime()
    return prepareShutdown(5)
end