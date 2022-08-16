local channels = {
    [2] = {txt = "Tutor [999]: Matenha este Chat sempre aberto, assim você pode tirar dúvidas com Cargos Superiores aos seus."}, -- Staff Channel
    [6] = {txt = "Tutor [999]: Este Chat é apenas para TROCAS de itens relacionados ao jogo. Qualquer coisa além disso pode ocasionar um mute ou banimento."}, -- Trade Channel
    [9] = {txt = "Tutor [999]: Este Chat é apenas para DÚVIDAS/AJUDA. Faça sua pergunta educadamente, ou se você estiver respondendo uma dúvida, seja claro e objetivo. Falta de educação não será tolerado e você será mutado ou ate mesmo banido!\nCaso não tenha nenhum Membro da Staff online, você pode usar o comando (!tutor dúvida) que nosso Tutor Robô irá te responder. Exemplo: (!tutor site)"}, -- Help Channel
	[11] = {txt = "Tutor [999]: Chat para formar time para fazer Quests. Qualquer coisa além disso pode ocasionar em mute ou banimento."}, -- Quest Channel
	[12] = {txt = "Tutor [999]: Chat para conversar entre vocês mesmo. Qualquer coisa além disso pode ocasionar em mute ou banimento."}, -- Channel
	[13] = {txt = "Tutor [999]: Mantenha este Chat sempre aberto! Assim você fica por dentro de todos os Avisos e Novidades."} -- Channel	
}

function onChannelJoin(cid, channelId, users)
    local t = channels[channelId]
    
    if t then

       addEvent(doPlayerSendChannelMessage, 150, cid, "", t.txt, TALKTYPE_CHANNEL_O, channelId)
    end
    return true
end