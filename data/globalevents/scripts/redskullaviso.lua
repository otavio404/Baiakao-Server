function onThink(interval, lastExecution)
  -- Configura��es
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[[Loteria System] A Cada 4 Horas ser� sorteado 2 premiums points para um jogador aleat�rio, quanto mais ativo voc� for, mais chance de ganhar!]]}

  -- Fim de Configura��es

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end