function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
local param = param:lower()
if not param or param == "" or param == "info" then
local info = [[
|-- Labia System Info --|

[-> Labia System <-]

É um sistema que proporciona ao jogador a capacidade de aprimorar sua habilidade de venda, aumentando assim sua Labia Skill e obtendo maiores lucros em futuras vendas de itens.

[-> Upando Skill <-]

Basta vender itens no NPC, Quanto mais caro for, o item vendido, maior será a porcentagem de lábia upada.

[-> Free & Premium <-]
Lembrando que sendo free, sua lábia pode ser upada apenas até skill 90. Já sendo premmium até a lábia 120. Se o player for premmy account, de repente ficar free... sua lábia cai para 90, e todos os itens serão vendidos com preços avaliados dentro dessa lábia!

[-> Benefícios da Lábia <-]

Quanto maior for sua Labia Skill, maior será o valor pago pelas NPC's Soya e Soya Master em troca do seu item ! Lembrando que, este é um benefício apenas, para premiuns!, Desta maneira, jogadores premiuns com labia skill alta, conseguem  maiores lucros ao vender seus itens!

[->Vale a pena lembrar que <-]

O valor do item varia de acordo com a Labia upada! Quanto mais skill, mais lucro na venda!

[-> Maior Labia  <-] 

A maior Labia alcançada é Skill 120.
]]
doShowTextDialog(cid, 1903, info) return true
elseif isInArray({"level","lvl","l"}, param) then
local limit = isPremium(cid) and Labia_System.Skill_Limit.premium or Labia_System.Skill_Limit.free
doPlayerPopupFYI(cid, "[+]---------------> [Labia System] <---------------[+]\n\nSuas Informações:\n\nLabia Skill Level: ["..getLabiaLevel(cid).."/"..limit.."]\n\n"..(getLabiaLevel(cid) == limit and "Você já atingiu o level mais alto de Labia! Parabéns." or "Você precisa de aproximadamente "..math.floor(getLabiaExpTo(getLabiaLevel(cid))).." de Skill Tries Labia para passar ao proximo nivel!")) return true
end
return true
end
