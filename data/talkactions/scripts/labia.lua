function onSay(cid, words, param)
if(not checkExhausted(cid, 660, 5)) then
return false
end
local param = param:lower()
if not param or param == "" or param == "info" then
local info = [[
|-- Labia System Info --|

[-> Labia System <-]

� um sistema que proporciona ao jogador a capacidade de aprimorar sua habilidade de venda, aumentando assim sua Labia Skill e obtendo maiores lucros em futuras vendas de itens.

[-> Upando Skill <-]

Basta vender itens no NPC, Quanto mais caro for, o item vendido, maior ser� a porcentagem de l�bia upada.

[-> Free & Premium <-]
Lembrando que sendo free, sua l�bia pode ser upada apenas at� skill 90. J� sendo premmium at� a l�bia 120. Se o player for premmy account, de repente ficar free... sua l�bia cai para 90, e todos os itens ser�o vendidos com pre�os avaliados dentro dessa l�bia!

[-> Benef�cios da L�bia <-]

Quanto maior for sua Labia Skill, maior ser� o valor pago pelas NPC's Soya e Soya Master em troca do seu item ! Lembrando que, este � um benef�cio apenas, para premiuns!, Desta maneira, jogadores premiuns com labia skill alta, conseguem  maiores lucros ao vender seus itens!

[->Vale a pena lembrar que <-]

O valor do item varia de acordo com a Labia upada! Quanto mais skill, mais lucro na venda!

[-> Maior Labia  <-] 

A maior Labia alcan�ada � Skill 120.
]]
doShowTextDialog(cid, 1903, info) return true
elseif isInArray({"level","lvl","l"}, param) then
local limit = isPremium(cid) and Labia_System.Skill_Limit.premium or Labia_System.Skill_Limit.free
doPlayerPopupFYI(cid, "[+]---------------> [Labia System] <---------------[+]\n\nSuas Informa��es:\n\nLabia Skill Level: ["..getLabiaLevel(cid).."/"..limit.."]\n\n"..(getLabiaLevel(cid) == limit and "Voc� j� atingiu o level mais alto de Labia! Parab�ns." or "Voc� precisa de aproximadamente "..math.floor(getLabiaExpTo(getLabiaLevel(cid))).." de Skill Tries Labia para passar ao proximo nivel!")) return true
end
return true
end
