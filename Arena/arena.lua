--  arena.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

local solidTile = require "Arena/solidTile"
local freeTile = require "Arena/freeTile"
local arenaBrocolis = require "Arena/arenaBrocolis"
local arenaDefault = require "Arena/arenaDefault"
local arenaAssets = require "Arena/arenaAssets"
local arenaAlien = require "Arena/arenaAlien"
local arenaPirata = require "Arena/arenaPirata"
local arenaRobo = require "Arena/arenaRobo"
arena = {}

local loadDimensions, loadTiles

local tiles = {}
tiles[0] = FreeTile
tiles[1] = SolidTile

arena[0] = arenaDefault
arena[1] = arenaBrocolis
arena[2] = arenaRobo
arena[3] = arenaAlien
arena[4] = arenaPirata
function arena.load(row,col)
  arenaAssets.load()
  arena.nRow = row
  arena.nCol = col
end

function loadDimensions()
  local w,h = love.graphics.getWidth(), love.graphics.getHeight()
  local ts = math.floor(math.min(w/arena.nCol,h/arena.nRow))
  arena.tileSize = {width=ts,height=ts}
  Tile.setTileSize(arena.tileSize)
  arena.width = arena.tileSize.width*arena.nCol
  arena.height = arena.tileSize.height*arena.nRow
  arena.x = (w-arena.width)/2
  arena.y = (h-arena.height)/2
end

function loadTiles()
  arena.obstacles = {}
  local w = arena.tileSize.width
  local h = arena.tileSize.height
  local wa = arena.mapInfo.defaultWall
  local fa = arena.mapInfo.defaultFloor
  local img = arena.sheet
  for i=1,arena.nRow-2 do
    arena.obstacles[i] = {}
    arena.obstacles[i][0] = SolidTile.new(0,i*h,img,wa)
    for j=1,arena.nCol-2 do
      arena.obstacles[i][j] = FreeTile.new(j*w,i*h,img,fa)
    end
    local j = arena.nCol-1
    arena.obstacles[i][arena.nCol-1] = SolidTile.new(j*w,i*h,img,wa)
  end
  local i = arena.nRow-1
  arena.obstacles[0]={}
  arena.obstacles[i]={}
  for j=0,arena.nCol-1 do
    arena.obstacles[0][j] = SolidTile.new(j*w,0,img,wa)
    arena.obstacles[i][j] = SolidTile.new(j*w,i*h,img,wa)
  end
  
  --arena.testObstacles()
end

function arena.testObstacles()
  local w = arena.tileSize.width
  local h = arena.tileSize.height
  local ind=3
  local endRow = arena.nRow-ind-2
  local endCol = arena.nCol-ind-2
  local wa = arena.mapInfo.defaultWall
  local fa = arena.mapInfo.defaultFloor
  local img = arena.sheet
  for i=0, 1 do
    for j=0, 1 do
      --table.remove(arena.obstacles[i+ind][j+ind])
      arena.obstacles[i+ind][j+ind] = SolidTile.new((j+ind)*w,(i+ind)*h,img,wa)
      --table.remove(arena.obstacles[i+ind][endCol+j])
      arena.obstacles[i+ind][endCol+j] = SolidTile.new((endCol+j)*w,(i+ind)*h,img,wa)
      --table.remove(arena.obstacles[endRow+i][j+ind])
      arena.obstacles[endRow+i][j+ind] = SolidTile.new((j+ind)*w,(endRow+i)*h,img,wa)
      --table.remove(arena.obstacles[endRow+i][endCol+j])
      arena.obstacles[endRow+i][endCol+j] = SolidTile.new((endCol+j)*w,(endRow+i)*h,img,wa)
    end
  end
end
function arena.loadTransitions()
  local w = arena.tileSize.width
  local h = arena.tileSize.height
  local t1 = arena.mapInfo.transitionMiddleLeft
  local t2 = arena.mapInfo.transitionMiddleRight
  local t3 = arena.mapInfo.transitionMiddleTop
  local t4 = arena.mapInfo.transitionMiddleBottom
  local t5 = arena.mapInfo.transitionBottomLeft
  local t6 = arena.mapInfo.transitionBottomRight
  local t7 = arena.mapInfo.transitionTopLeft
  local t8 = arena.mapInfo.transitionTopRight
  local img = arena.sheet
  arena.obstacles[1][1] = FreeTile.new(1*w,1*h,img,t7)
  arena.obstacles[1][13] = FreeTile.new(13*w,1*h,img,t8)
  arena.obstacles[10][1] = FreeTile.new(1*w,10*h,img,t5)
  arena.obstacles[10][13] = FreeTile.new(13*w,10*h,img,t6)
  for j=2,arena.nRow do
    arena.obstacles[1][j] = FreeTile.new(j*w,1*h,img,t3)
    arena.obstacles[10][j] = FreeTile.new(j*w,10*h,img,t4)
  end
  for i=2,arena.nCol-6 do
    arena.obstacles[i][1] = FreeTile.new(1*w,i*h,img,t2)
    arena.obstacles[i][13] = FreeTile.new(13*w,i*h,img,t1)
  end
  
end
function arena.start(id)
  audioManager.play(soundAssets[id+1].stage)
  arena.curr = arena[id]
  arena.mapInfo = arenaAssets.maps[arena.curr.index]
  arena.sheet = arenaAssets.sheet
  loadDimensions()
  loadTiles()
  arena.curr.start(arena)
end

function arena.update(dt,players)
  --arena.handleMovements(dt,players)
  arena.curr.update(dt)
end

function arena.draw()
  local offset = {x=arena.x,y=arena.y}
  for i=0, arena.nRow-1 do
    for j=0, arena.nCol-1 do
      local w = arena.obstacles[i][j]
      w:draw(offset)
    end
  end
end

function arena.handleMovements(dt,players)
  for i,v in ipairs(players) do
    arena.handleHorizontal(dt,v)
    arena.handleVertical(dt,v)
  end
end

function arena.handleHorizontal(dt,entity)
  local s = math.sign(entity.speed.x)
  local front = entity.x + entity.width/2 + entity.width/2*s
  local dx = front+entity.speed.x*dt
  local col = math.floor(dx/arena.tileSize.width)
  local canMove
  if col>=arena.nCol then
    canMove = false
    col = arena.nCol-1
  elseif col<0 then
    canMove = false
    col = 0
  else
    canMove = true
    local aux = entity.y/arena.tileSize.height
    local firstRow = math.floor(aux)
    local lastRow = math.floor(aux+entity.height/arena.tileSize.height)
    for i=firstRow,lastRow do
      local ob = arena.obstacles[i][col]
      ob:tookHit(entity)
      if not ob:canMove(entity) then
        canMove = false
        break
      end
    end
  end
  if canMove then
    entity.x = entity.x + (dx - front)
  else
    entity.x = (col+0.5)*arena.tileSize.width-entity.width/2 -s*((arena.tileSize.width+entity.width)/2+0.1)
  end
  return canMove
end

function arena.handleVertical(dt,entity)
  local s = math.sign(entity.speed.y)
  local front = entity.y + entity.height/2 + entity.height/2*s
  local dy = front+entity.speed.y*dt
  local row = math.floor(dy/arena.tileSize.height)
  local canMove
  if row>=arena.nRow then
    canMove = false
    row = arena.nRow-1
  elseif row<0 then
    canMove = false
    row = 0
  else
    canMove = true
    local aux = entity.x/arena.tileSize.width
    local firstCol = math.floor(aux)
    local lastCol = math.floor(aux+entity.width/arena.tileSize.width)
    for j=firstCol,lastCol do
      local ob = arena.obstacles[row][j]
      ob:tookHit(entity)
      if not ob:canMove(entity) then
        canMove = false
        break
      end
    end
  end
  if canMove then
    entity.y = entity.y + (dy - front)
  else
    entity.y = (row+0.5)*arena.tileSize.height-entity.height/2 -s*((arena.tileSize.height+entity.height)/2+0.1)
  end
  return canMove
end

function math.sign(num)
  return (num<0 and -1 or 1)
end

function prepareDrawOrder(players)
  local grid = {}
  for i=0,arena.nRow-1 do
    grid[i]={}
  end
  for i,v in ipairs(players) do
    table.insert(grid[math.floor(v.y/arena.tileSize.height)],v)
  end
  return grid
end

function isColliding(player)
  local firstRow = math.floor(player.y/arena.tileSize.height)
  local lastRow = math.floor((player.y+player.height)/arena.tileSize.height)
  local firstCol = math.floor(player.x/arena.tileSize.width)
  local lastCol = math.floor((player.x+player.width)/arena.tileSize.width)
  for i=firstRow,lastRow do
    for j=firstCol,lastCol do
      local row = arena.obstacles[i]
      if row == nil then
        return true
      else
        tile = row[j]
        if tile == nil then
          return true
        else
          return not tile:canMove(player)
        end
      end
    end
  end
end