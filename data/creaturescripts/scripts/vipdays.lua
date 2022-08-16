function onLogin(cid)
    local days = 2
    if db.getResult("SELECT `premiumgift` FROM `accounts` WHERE `id` = "..getPlayerAccountId(cid)):getDataInt("premiumgift") <= 0 then
        doPlayerAddPremiumDays(cid, days)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Recompensa: Por voce ser um dos 50 Players a logar primeiro, voce recebeu "..days.." Dias de Premium Account, parabens!")
        db.executeQuery("UPDATE `accounts` SET `premiumgift` = 1 WHERE `id` = "..getPlayerAccountId(cid))
    end
    return true
end