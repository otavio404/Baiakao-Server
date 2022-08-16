function onSay(cid, words, param, channel)

	if not isInParty(cid) then
		doPlayerSendCancel(cid, "Voc� n�o est� em nenhuma party atualmente")
		return true
	end
	local party = getPlayerParty(cid)
	local members = getPartyMembers(party)
	local druid = 0
	local sorc = 0
	local pala = 0
	local knight = 0
	local level = 0
	for i = 1,#members do
	
		local p_level = getPlayerLevel(members[i])
		if  p_level > level then
			level = p_level
		end
		
		if isDruid(members[i]) then
			druid = 1
		elseif isPaladin(members[i]) then
			pala = 1
		elseif isSorcerer(members[i]) then
			sorc = 1
		elseif isKnight(members[i]) then
			knight = 1
		end
	end
	local soma = sorc + druid + pala + knight
	local level_min = "O menor level que um player pode ter para compartilhar a experi�ncia � "..math.ceil((level*2)/3)
	if soma == 1 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "A sua party possui apenas 1 voca��o, por isso a sua experi�ncia n�o aumentar�!, caso esteja em shared experience.\n".. level_min)
	elseif soma == 2 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "A sua party possui 2 voca��es diferentes, por isso a sua experi�ncia aumentar� em 20%!, caso esteja em shared experience.\n".. level_min)
	elseif soma == 3 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "A sua party possui 3 voca��es diferentes, por isso a sua experi�ncia aumentar� em 60%!, caso esteja em shared experience.\n".. level_min)
	elseif soma == 4 then
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "A sua party possui 4 voca��es diferentes, por isso a sua experi�ncia aumentar� em 100%!, caso esteja em shared experience.\n".. level_min)
	end
	return true
	
end