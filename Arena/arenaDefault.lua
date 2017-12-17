require "Arena/destructTile"
local arenaDefault = {index=0}

local preparePositions, round, evaluate, readTxt

function arenaDefault.start(arena)
  arena.testObstacles()
end
function arenaDefault.update(dt)
  
end
function arenaDefault.destroy(block)
 
end
function readTxt()
 
end
function preparePositions(inputs)
  
end
function evaluate(input)
  
end
function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end

return arenaDefault