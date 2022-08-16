function onThink(interval, lastExecution)
  -- Configurações
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[[Loteria System] A Cada 4 Horas será sorteado 2 premiums points para um jogador aleatório, quanto mais ativo você for, mais chance de ganhar!]]}

  -- Fim de Configurações

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end