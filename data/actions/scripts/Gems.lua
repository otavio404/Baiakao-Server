--[[
    Gems System By Maxwell Denisson(MaXwEllDeN)
    V 1.0
    --]]
function onUse(cid, item, frompos, item2, topos) 
  
   if (getPlayerStorageValue(cid, 45783) > 0) then  
      return doPlayerSendCancel(cid, "Voc� j� est� sob o efeito de uma Magic Gem.")
   end         

   AtiveGem(cid, item)  
   return true
end