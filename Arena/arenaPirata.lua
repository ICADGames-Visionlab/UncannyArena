local destructTile = require "Arena/destructTile"

local arenaPirata = {index = 4}

local preparePositions, round, evaluate, readTxt

arenaPirata.spawnTime = 10
arenaPirata.explosionTime = 1.5

function arenaPirata.start(arena)
  --Read txt with inputs
  arenaPirata.arena = arena
  arena.loadTransitions()
  local txtData = readTxt()
  preparePositions(txtData)
end

function arenaPirata.update(dt)
  local exp = arenaPirata.spawnTime-arenaPirata.explosionTime
  local ps = playerManager.getAlivePlayers()
  for i,v in ipairs(arenaPirata.destroyed) do
    v.timer = v.timer - dt
    if v.timer<0 then
      v.timer = nil
      table.insert(arenaPirata.blocks,table.remove(arenaPirata.destroyed,i))
      local obs = arena.obstacles
      local pos = arenaPirata.pos[v.index]
      local floor = obs[pos.row][pos.col]
      v.floor = floor
      arenaPirata.arenaReplacement[v.index] = floor
      obs[pos.row][pos.col] = v
    elseif v:is_a(DestructTile) and v.timer>exp then
      arenaPirata.explosionCheck(v,ps)
    end
  end
end

function arenaPirata.explosionCheck(tile,players)
  local t = {
    x = tile.x - tile.width,
    y = tile.y - tile.height,
    width = tile.width*3,
    height = tile.height*3
  }
  for i,v in ipairs(players) do
    if contact.isInContact(v,t) then
      v:tookHit()
    end
  end
end

function arenaPirata.destroy(block)
  for i,v in ipairs(arenaPirata.blocks) do
    if v == block then
      table.insert(arenaPirata.destroyed,table.remove(arenaPirata.blocks,i))
      block.timer = arenaPirata.spawnTime
      local pos = arenaPirata.pos[block.index]
      local obs = arena.obstacles
      obs[pos.row][pos.col] = arenaPirata.arenaReplacement[block.index]
    end
  end
end

function readTxt()
  local file = love.filesystem.read("/Assets/Stages/Pirata_Stage1.txt")
  local data = {}
  for line in file:gmatch('([^\n]+)') do
    local words = {}
    for w in line:gmatch("%S+") do table.insert(words,w) end
    table.insert(data,{x=tonumber(words[3]),y=tonumber(words[1])})
  end
  return data
end

function preparePositions(inputs)
  arenaPirata.pos = {}
  arenaPirata.blocks = {}
  arenaPirata.arenaReplacement = {}
  arenaPirata.destroyed = {}
  for i,v in ipairs(inputs) do
    evaluate(v)
  end
end

function evaluate(input)
  local a = arenaPirata.arena
  local col,row = round(input.x*arenaPirata.arena.nCol), round(input.y*arenaPirata.arena.nRow)
  table.insert(arenaPirata.pos,{col=col,row=row})
  local v = DestructTile.new(col*arenaPirata.arena.tileSize.width,row*arenaPirata.arena.tileSize.height,a.sheet,a.mapInfo.destruct,arenaPirata)
  v.index = #arenaPirata.pos
  table.insert(arenaPirata.blocks,v)
  local obs = arenaPirata.arena.obstacles 
  local pos = arenaPirata.pos[v.index]
  local floor = obs[pos.row][pos.col]
  v.floor = floor
  arenaPirata.arenaReplacement[v.index] = floor
  obs[pos.row][pos.col] = v
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end
return arenaPirata
