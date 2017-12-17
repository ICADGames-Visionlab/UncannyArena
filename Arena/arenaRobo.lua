require "Arena/freeTile"
require "Arena/solidTile"

local arenaRobo = {index=2 }

local mode

function arenaRobo.start(arena)
  --Read txt with inputs
  arenaRobo.arena = arena
  local txtData = readTxt()
  preparePositions(txtData)
  for i,v in ipairs(playerManager.list) do
    v.x = arenaRobo.arena.width/2
    v.y = arenaRobo.arena.height/2
  end
end

function arenaRobo.update(dt)
  local ps = playerManager.getAlivePlayers()
  local inContact = {}
  
  for i,pan in ipairs(arenaRobo.panels) do
    for j=#ps,1,-1 do
      local pl = ps[j]
      if contact.isInContact(pan,pl) then
        table.insert(inContact,pl)
        table.remove(ps,j)
      end
    end
  end
  for i=#arenaRobo.inContact,1,-1 do
    local v = arenaRobo.inContact[i]
    local exists = false
    for j,w in ipairs(inContact) do
      if v==w then exists = true break end
    end
    if exists then
      table.remove(inContact,j)
    else
      table.remove(arenaRobo.inContact,i)
    end
  end
  if #inContact>0 then
    for i,v in ipairs(inContact) do
      table.insert(arenaRobo.inContact,v)
    end
    arenaRobo.switchPanel()
  end
end

function arenaRobo.switchPanel()
  local oldMode = mode
  mode = mode%2+1
  local tw = arenaRobo.arena.tileSize.width
  local th = arenaRobo.arena.tileSize.height
  local obs = arena.obstacles
  for i,v in ipairs(arenaRobo.blocks) do
    local p = arenaRobo.pos[v.index][oldMode]
    obs[p.row][p.col] = v.floor
  end
  for i,v in ipairs(arenaRobo.blocks) do
    local p = arenaRobo.pos[v.index][mode]
    v.floor = obs[p.row][p.col]
    obs[p.row][p.col] = v
    v.x = tw*p.col
    v.y = th*p.row
  end
end

function readTxt()
  local file = love.filesystem.read("/Assets/Stages/Robo_Stage1.txt")
  local data = {blocks={},panels={}}
  for line in file:gmatch('([^\n]+)') do
    local words = {}
    for w in line:gmatch("%S+") do table.insert(words,w) end
    if #data.panels>1 then
      table.insert(data.blocks,{x1=tonumber(words[1]),y1=tonumber(words[2]),x2=tonumber(words[3]),y2=tonumber(words[4])})
    else
      table.insert(data.panels,{x=tonumber(words[1]),y=tonumber(words[2])})
    end
  end
  return data
end

function preparePositions(inputs)
  mode = 1
  arenaRobo.pos = {}
  arenaRobo.blocks = {}
  arenaRobo.arenaReplacement = {}
  arenaRobo.arenaPanels = {}
  arenaRobo.inContact = {}
  arenaRobo.panels = {}
  for i,v in ipairs(inputs.blocks) do
    evaluate(v)
  end
  local tw = arenaRobo.arena.tileSize.width
  local th = arenaRobo.arena.tileSize.height
  local a = arenaRobo.arena
  for i,v in ipairs(inputs.panels) do
    local col = round(v.x*a.nCol)
    local row = round(v.y*a.nRow)
    local x = col*tw
    local y = row*th
    local p = FreeTile.new(x,y,a.sheet,a.mapInfo.destruct)
    table.insert(arenaRobo.panels,p)
    p.floor = arenaRobo.arena.obstacles[row][col]
    arenaRobo.arena.obstacles[row][col] = p
  end
end

function evaluate(input)
  local a = arenaRobo.arena
  local col,row = round(input.x1*arenaRobo.arena.nCol), round(input.y1*arenaRobo.arena.nRow)
  local col2,row2 = round(input.x2*arenaRobo.arena.nCol), round(input.y2*arenaRobo.arena.nRow)
  print(col, row, col2, row2)
  table.insert(arenaRobo.pos,{{col=col,row=row},{col=col2,row=row2}})
  local v = SolidTile.new(col*arenaRobo.arena.tileSize.width,row*arenaRobo.arena.tileSize.height,a.sheet,a.mapInfo.defaultWall)
  v.index = #arenaRobo.pos
  table.insert(arenaRobo.blocks,v)
  local obs = arenaRobo.arena.obstacles
  local pos = arenaRobo.pos[v.index][1]
  local floor = obs[pos.row][pos.col]
  v.floor = floor
  --arenaRobo.arenaReplacement[v.index] = floor
  obs[pos.row][pos.col] = v
end

function round(n)
  local f = math.floor(n)
  return n-f < 0.5 and f or f+1
end

return arenaRobo