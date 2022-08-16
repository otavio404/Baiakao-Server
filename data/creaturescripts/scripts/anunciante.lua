local YELL = {
	"Double Points Para Doacoes Acima De R$30,00. (Tempo Limitado)",
	"O Baiak Light Tem Sistemas Exclusivos.",
	"Mapa e sistemas estao sendo refeitos do zero.",	
	"Siga a gente em nossas redes sociais",
	"Discord: https://discordapp.com/invite/Bz2Ezat",
	"Facebook: https://www.facebook.com/baiaklight/",
	"Instagram: https://www.instagram.com/baiak.light/"	
}
local npc = "Anunciante"
local exaust = 15
function onThink(cid, interval)
	local pos = getPlayerPosition(cid)
	local t = getSpectators(pos, 7, 5, false)
	if t then
		for _, cid in ipairs(t) do
			if isNpc(cid) and getCreatureName(cid) == "Anunciante" then
				if getGlobalStorageValue(cid) - os.time() <= 0 then
					doCreatureSay(cid, YELL[math.random(#YELL)], 1)
					setGlobalStorageValue(cid, os.time()+exaust)
				end 
			end
		end
	end 
	return true
end