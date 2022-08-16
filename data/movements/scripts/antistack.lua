local positions = {
{x = 152, y = 52, z = 7}, -- aqui vc coloca a posição pra onde ele vão
{x = 151, y = 53, z = 7}, 
{x = 152, y = 54, z = 7},
{x = 153, y = 53, z = 7},
{x = 153, y = 54, z = 7}, 
{x = 153, y = 52, z = 7},
{x = 151, y = 52, z = 7},
{x = 151, y = 54, z = 7}
}

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition, actor)
doTeleportThing(cid, positions[math.random(1, #positions)])
return true
end