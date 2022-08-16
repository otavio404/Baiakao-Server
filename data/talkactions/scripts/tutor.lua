local blockedLinks = {'bug', 'bugado', 'pick', 'cave exclusiva', 'addon', 'mining', 'donate', 'doação', 'points', 'exclusiva', 'minera', 'mineração', 'hunt exclusiva', 'staff', 'adm', 'admin', 'task', 'missão', 'site', 'stamina', 'update', 'castle', 'element', 'elementos', 'elemento', 'refine', 'refinar', 'red', 'skull', 'magia', 'magias', 'autoloot', 'site', 'enforced', 'hardcore', 'dodge', 'critical', 'troco', 'vendo', 'sell', 'buy', 'compro', 'wand energy', 'pure energy'}

-- END OF CONFIG --

local blockedLinksData = {}
local separator = '[ !\t%$%^%+%-%.%%_,<>]*'
for _, linkText in pairs(blockedLinks) do
    local data = {}
    data.link = linkText

    data.preg = '.*'
    for c in string.gmatch(linkText, '.') do
        if(c == '.') then
            data.preg = data.preg .. '.*'
        else
            data.preg = data.preg .. c .. separator
        end
    end
    data.preg = data.preg .. '.*'

    table.insert(blockedLinksData, data)
end

function isLegalMessage(words)
    for _, blockedLink in pairs(blockedLinksData) do
        if(string.match(words, blockedLink.preg) ~= nil) then
            return false, blockedLink.link
        end
    end
    return true, ''
end

function onSay(cid, words, param, channel)
if(not checkExhausted(cid, 660, 5)) then
return false
end
    words = words .. ' ' .. param
    local legalMessage, forbiddenLink = isLegalMessage(
    string.lower(words))

    if getPlayerLevel(cid) <= 200 then return true end
    if(not legalMessage) then
	if channel == CHANNEL_HELP then
		if getPlayerStorageValue(cid, 46349) - os.time() <= 0 then
		timePassed = 2 * 60
		local pid = getPlayersOnline()
	  		for i = 1, #pid do
				if forbiddenLink == "mining" or forbiddenLink == "minerar" or forbiddenLink == "minera" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Para minerar basta comprar uma pick e usar no chao ou parede da mina, sua entrada fica no templo ao lado do NPC Premium Points. Voce pode vender os itens obtidos la no NPC Mirrorem. [Hotkey]: auto 200 listas 'Mining Insanity' | setcolor 255 215 0 | useongrounditem 3456  4463 |", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "cave exclusiva" or forbiddenLink == "exclusiva" or forbiddenLink == "hunt exclusiva" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Cave Exclusiva só pode ser usada ate o level 620. Caso Voce veja algum Player em sua cave, não se assuste logo menos ele será expulso.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "addon" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Voce pode obter addon com o Item: [Addon Doll]. Este Item Voce consegue atraves do Boss Addon Doll, Evento Dice, e comprando no NPC Event Seller.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "donate" or forbiddenLink == "doação" or forbiddenLink == "points" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Para fazer uma doação (donate) para o nosso Servidor, Voce precisa ir no nosso WebSite (http://baiak-insanity.com) logar sua conta e clicar no botão (Donate). Nossas promoções: Acima de 20 Reais receba o Dobro, Acima de 100 Reais receba o Triplo.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "staff" or forbiddenLink == "adm" or forbiddenLink == "admin" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Nossos ADM's se encontram ausente no momento. Para recorrer a um ADM, entre no nosso grupo do Discord, ou no do Whatssap, todos os links estão no nosso site (http://baiak-insanity.com).", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "task" or forbiddenLink == "missão" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Voce encontra todas as missões no teleport Tasks que se encontra no templo ao lado do NPC Premium Points. Ao fim de todas as missões do NPC Task Insanity, Voce tem a oportunidade de obter um Items, e ate mesmo experiência.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "site" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: WebSite do servidor e (http://baiak-insanity.com).", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "stamina" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Temos diversas maneiras de recuperar a stamina, dentre elas estão: Stamina Potion (Item Obitido em Eventos e na Alavanca do Templo), Stamina Infinita (Item Obito no nosso Shop), e em Treiners.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "castle" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: O Insanity Castle abre todos os dias as 21:00 ate as 22:30, a guild que permanecer com o domínio do Castle ate o termino terá 24HRs de Hunts Privadas.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "refine" or forbiddenLink == "refinar" or forbiddenLink == "wand energy" or forbiddenLink == "pure energy" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Em Breve.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "element" or forbiddenLink == "elemento" or forbiddenLink == "elementos" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Para trocar o elemento da sua Wand, use o comando (!wand), para mais informações digite (!wand help).", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "magia" or forbiddenLink == "magias" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Voce pode ver suas magias digitando !spells. Para ter acesso as novas magias, e preciso fazer a quest delas.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "pick" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Voce pode usar um Pick para minerar e conseguir items valiosos. Este item Voce consegue comprando no NPC Mirrorem.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "autoloot" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Voce pode coletar items (!autoloot add, NOMEDOITEM) e dinheiro (!autoloot gold) automaticamente usando nosso AutoLoot. tambem temos um Boost que faz vender os items automaticamente, ele se chama Autoloot Boost. Para mais informações, digite (!autoloot).", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "skull" or forbiddenLink == "red" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Para Voce não catar Red e dropar todos seus items, tome cuidado com seus frags (!frags). RedSkull: 120 Frags. BlackSkull: Sem limite.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "enforced" or forbiddenLink == "hardcore" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Ao matar jogadores 100 leveis acima que o seu Voce ganha experience, quanto maior o level mais experience!", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "bug" or forbiddenLink == "bugado" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Encontrou um bug? reporte Via Whatsapp ou Via Discord. Voce tambem pode abrir um ticket em nosso WebSite que corrigiremos em no maximo 24 horas! (http://biak-insanity.com).", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "compro" or forbiddenLink == "vendo" or forbiddenLink == "sell" or forbiddenLink == "buy" or forbiddenLink == "troco" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Por favor, para comercio use o chat Trade e mantenha este chat limpo para melhor suporte.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				
				elseif forbiddenLink == "dodge" or forbiddenLink == "critical" then
					doPlayerSendChannelMessage(pid[i], "", "Tutor [999]: Com Dodge, e possível Voce se defender de ataques inimigos, quanto maior for a Skill de Dodge, mais defesa terá. Com Critical, e possível Voce da um hit maior em seu inimigo, quanto maior for a Skill de Critical, mais dano terá.", TALKTYPE_CHANNEL_O, CHANNEL_HELP)
				end
				setPlayerStorageValue(cid, 46349, os.time() + timePassed)
	  		end
		else
			doPlayerSendCancel(cid, "O Tutor [999]: Já lhe respondeu uma pergunta nos ultimos 2 minutos.")
		end
	end
    end
    return true
end
