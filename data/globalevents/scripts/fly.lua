function onThink(interval, lastExecution)
  -- Configurações
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Esta Preso?
  Sem Saída?
  Preguiça de Andar? 
  Entao Diga 
!tp templo, !tp depot, !tp trainer]]
}

  -- Fim de Configurações

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end