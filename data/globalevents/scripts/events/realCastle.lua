--[[

				Real Castle Event
	Desenvolvido por V�tor Bertolucci (Killua)

]]

function onTime()
	if not realCastle.isOpen() then
		realCastle.open()
	else
		realCastle.close()
	end
    return true
end