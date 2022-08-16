local bless = {1, 2, 3, 4, 5}
local cost = 80000
function onSay(cid, words, param)
    for i = 1, table.maxn(bless) do
        if(getPlayerBlessing(cid, bless[i])) then
            doPlayerSendCancel(cid, "Voce ja possui todas as blessings.")
            return true
        end
    end

    if doPlayerRemoveMoney(cid, cost) then
        for i = 1, table.maxn(bless) do
            doPlayerAddBlessing(cid, bless[i])
        end
        doCreatureSay(cid, "Agora voce possui todas as blessings!" ,19)
        doSendMagicEffect(getPlayerPosition(cid), 49)
    else
        doPlayerSendCancel(cid, "Voce nao possui dinheiro o suficiente.")
    end
    return true
end 