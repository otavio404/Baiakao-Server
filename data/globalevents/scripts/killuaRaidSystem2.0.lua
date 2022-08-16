function onTime()
	local random = math.random(12)
	addEvent(killuaRaids.start,random*3600000,killuaRaids.raids[math.random(#killuaRaids.raids)])
    return true
end
