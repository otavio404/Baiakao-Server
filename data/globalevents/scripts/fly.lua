function onThink(interval, lastExecution)
  -- Configura��es
    local cor = 22 -- Defina a cor da mensagem (22 = branco)
    local mensagens ={
[[Esta Preso?
  Sem Sa�da?
  Pregui�a de Andar? 
  Entao Diga 
!tp templo, !tp depot, !tp trainer]]
}

  -- Fim de Configura��es

  doBroadcastMessage(mensagens[math.random(1,table.maxn(mensagens))], cor)
return TRUE
end