local config = {
   tp_pos = {x=170, y=53, z=7},
   player_pos = {x=14770, y=15025, z=7},
   item = {x=14770, y=15026, z=7}
}

function onSay(cid, param)
   local tp = getTileItemById(config.tp_pos, 1387)
 
   if tp.uid > 100 then
      doRemoveItem(tp.uid)
      doBroadcastMessage("O Portal Para O Evento Dice Foi Fechado!")
   else
      doCreateTeleport(1387, config.player_pos, config.tp_pos)
      doBroadcastMessage("O Portal Para O Evento Dice Esta Aberto!")
      doCreateItem(3615, config.item)
   end
 
   return true
end