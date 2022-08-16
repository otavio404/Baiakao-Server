-- This script is part of Campo Minado Event
-- Copyright (C) 2017 By Ciroc Developer
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

-- //

-- CONFIGURACOES DO EVENTO
CampoMinado_DAYS = {1,2,3,4,5,6,7} -- DIAS DA SEMANA QUE VAI ABRIR
CampoMinado_STARTAUTO = true -- TRUE ATIVA/FALSE DESATIVA
OpenTime = 5 -- TEMPO EM MINUTOS PARA O EVENTO INICIAR

_Lib_CampoMinado_Info = {
RewardPrimeiro = {6527,50}, -- RECOMPENSA/QUANTIDADE 1 COLOCADO
RewardSegundo = {6527,25}, -- RECOMPENSA/QUANTIDADE 2 COLOCADO
RewardTerceiro = {6527,10}, -- RECOMPENSA/QUANTIDADE 3 COLOCADO
tpPos = {x = 151, y = 43, z = 7}, -- POSICAO QUE ABRE O TP
PerdeuPos = {x=477, y=621, z=7}, -- ULTIMA POSICAO ANTES DO TROFEU
ExitPos = {x=153, y=52, z=7}, -- POSICAOO ONDE VAI AO SAIR DO EVENTO
DestinoPos = {x=497, y=645, z=7}, -- POSICAO ENTRADA SALA DO EVENTO
limit_Time = 15 -- LIMITE DE TEMPO EM MINUTOS
}

function OpenWallCampoMinado()
local B = {
{1304,{x=487, y=633, z=7, stackpos = 1}}, -- POSICAO DA PEDRA1
{1304,{x=488, y=633, z=7, stackpos = 1}}, -- POSICAO DA PEDRA2
{1304,{x=489, y=633, z=7, stackpos = 1}}, -- POSICAO DA PEDRA3
}
	for i = 1, #B do
		if getTileItemById(B[i][2], B[i][1]).uid == 0 then
			doCreateItem(B[i][1], 1, B[i][2])
		else
			doRemoveItem(getThingfromPos(B[i][2]).uid,1)
		end
	end
end

function removeCampoMinadoTp()
	local t = getTileItemById(_Lib_CampoMinado_Info.tpPos, 1387).uid
	return t > 0 and doRemoveItem(t) and doSendMagicEffect(_Lib_CampoMinado_Info.tpPos, CONST_ME_POFF)
end

function removeCampoMinadoResetPerdeu()
	local t = getTileItemById(_Lib_CampoMinado_Info.PerdeuPos, 1387).uid
	return t > 0 and doRemoveItem(t) and doSendMagicEffect(_Lib_CampoMinado_Info.PerdeuPos, CONST_ME_POFF)
end

function StartCampoMinado()
	removeCampoMinadoTp()
	removeCampoMinadoResetPerdeu()
	reloadCampoMinado()
	doBroadcastMessage("{CampoMinado} Teleport fechado, evento ira iniciar em um minuto, crie sua estrategia!")
	addEvent(doBroadcastMessage, 1*60*1000, "{CampoMinado} Evento iniciado!")
	addEvent(OpenWallCampoMinado, 1*60*1000)
end