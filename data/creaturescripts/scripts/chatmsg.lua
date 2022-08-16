local channels = {
    [2] = {txt = "Tutor [999]: Matenha este Chat sempre aberto, assim voc� pode tirar d�vidas com Cargos Superiores aos seus."}, -- Staff Channel
    [6] = {txt = "Tutor [999]: Este Chat � apenas para TROCAS de itens relacionados ao jogo. Qualquer coisa al�m disso pode ocasionar um mute ou banimento."}, -- Trade Channel
    [9] = {txt = "Tutor [999]: Este Chat � apenas para D�VIDAS/AJUDA. Fa�a sua pergunta educadamente, ou se voc� estiver respondendo uma d�vida, seja claro e objetivo. Falta de educa��o n�o ser� tolerado e voc� ser� mutado ou ate mesmo banido!\nCaso n�o tenha nenhum Membro da Staff online, voc� pode usar o comando (!tutor d�vida) que nosso Tutor Rob� ir� te responder. Exemplo: (!tutor site)"}, -- Help Channel
	[11] = {txt = "Tutor [999]: Chat para formar time para fazer Quests. Qualquer coisa al�m disso pode ocasionar em mute ou banimento."}, -- Quest Channel
	[12] = {txt = "Tutor [999]: Chat para conversar entre voc�s mesmo. Qualquer coisa al�m disso pode ocasionar em mute ou banimento."}, -- Channel
	[13] = {txt = "Tutor [999]: Mantenha este Chat sempre aberto! Assim voc� fica por dentro de todos os Avisos e Novidades."} -- Channel	
}

function onChannelJoin(cid, channelId, users)
    local t = channels[channelId]
    
    if t then

       addEvent(doPlayerSendChannelMessage, 150, cid, "", t.txt, TALKTYPE_CHANNEL_O, channelId)
    end
    return true
end