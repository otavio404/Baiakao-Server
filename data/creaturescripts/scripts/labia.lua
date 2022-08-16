function onLogin(cid)
local limit = isPremium(cid) and Labia_System.Skill_Limit.premium or Labia_System.Skill_Limit.free
	if not isPremium(cid) and getLabiaLevel(cid) > limit then
		setPlayerLabiaLevel(cid, limit)
 		setLabiaTry(cid, 0)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "[Labia System] Sua Skill Labia foi atualizado para "..limit.." por você não ser mais premium!")
	end
return true
end