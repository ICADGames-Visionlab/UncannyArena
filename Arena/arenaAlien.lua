local destructTile = require "Arena/destructTile"

local arenaAlien = {index = 3}

local preparePositions, round, evaluate, readTxt

function arenaAlien.start(arena)
  --Read txt with inputs
  arenaAlien.arena = arena
  local txtData = readTxt()
  preparePositions(txtData)
end

function arenaAlien.update(dt)
  local ps = playerManager.getAlivePlayers()
  local inContact = {}
  for i,pan in ipairs(arenaAlien.ovnis) do
    for j=#ps,1,-1 do
      local pl = ps[j]
      if contact.isInContact(pan,pl) then
        table.insert(inContact,{player=pl,ovniId=i})
        table.remove(ps,j)
      end
    end
  end
  for i=#arenaAlien.inContact,1,-1 do
    local v=arenaAlien.inContact[i]
    local exists = false
    for j,w in ipairs(inContact) do
      if v==w.player then exists = true break end
    end
    if exists then
      table.remove(inContact,j)
    else
      table.remove(arenaAlien.inContact,i)
    end
  end
  
  for i,v in ipairs(inContact) do
    table.insert(arenaAlien.inContact,v.player)
    arenaAlien.teletransport(v.player,v.ovniId)
  end
end

function arenaAlien.teletransport(player,ovniId)
  local copy = {}
  for i,v in ipairs(arenaAlien.ovnis) do
    table.insert(copy,v)
  end
  table.remove(copy,ovniId)
  local dest = copy[love.math.random(#copy)]
  player.x = dest.x
  player.y = dest.y
end

function readTxt()
  local file = love.filesystem.read("/Assets/Stages/Alien_Stage2.txt")
  local data = {blocks={},ovnis={}}
  for line in file:gmatch('([^\n]+)') do
    local words = {}
    for w in line:gmatch("%S+") do table.insert(words,w) end
    local v = {x=tonumber(words[1]),y=tonumber(words[2])}
    if #data.ovnis>1 then
      table.insert(data.blocks,v)
    else
      table.insert(data.ovnis,v)
    end
  end
  return data
end

function preparePositions(inputs)
  arenaAlien.pos = {}
  arenaAlien.ovnis = {}
  arenaAlien.inContact = {}
  local a = arenaAlien.arena
  local tw = a.tileSize.width
  local th = a.tileSize.height
  for i,v in ipairs(inputs.ovnis) do
    local col = round(v.x*a.nCol)
    local row = round(v.y*a.nRow)
    local o = FreeTile.new(col*tw,row*th,a.sheet,a.mapInfo.destruct)
    o.floor = a.obstacles[row][col]
    table.insert(arenaAlien.ovnis,o)
    a.obstacles[row][col] = o
  end
  for i,v in ipairs(inputs.blocks) do
    local col = round(v.x*a.nCol)
    local row = round(v.y*a.nRow)
    a.obstacles[row][col] = SolidTile.new(col*tw,row*th,a.sheet,a.mapInfo.defaultWall)
  end
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end
return arenaAlien
