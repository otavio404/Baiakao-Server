local EventsListalist = {

		{time = "00:30", name = "CTF Event"},
		{time = "02:30", name = "SBW Event"},
	    {time = "04:30", name = "FireStorm Event"},
	    {time = "06:30", name = "Battlefield Event"},
	    {time = "08:30", name = "CampoMinado Event"},
	    {time = "10:30", name = "DTT Event"},
	    {time = "12:30", name = "Bomberman Event"},
	    {time = "14:30", name = "CTF Event"},
	    {time = "16:30", name = "SBW Event"},
	    {time = "18:30", name = "FireStorm Event"},
	    {time = "20:30", name = "Battlefield Event"},
	    {time = "22:30", name = "CampoMinado Event"},

	}
	
	local position = {x = 151, y = 43, z = 7}
	
	
	function onThink(interval, lastExecution)
		
	 local people = getPlayersOnline()
    if #people == 0 then
        return true
    end
	
	local Count = 0
	  for _, t in ipairs(EventsListalist) do
	        local eventTime = hourToNumber(t.time)
	        local realTime = hourToNumber(os.date("%H:%M:%S"))
	        if eventTime >= realTime then
	       doPlayerSay(people[1], "Próximo evento às {"..t.time.."h} "..t.name..", faltam "..timeString(eventTime - realTime)..".", TALKTYPE_MONSTER_SAY, false, 0, position)
	            return true
	        end
	        Count = Count + 1
	    end
		return true
	end