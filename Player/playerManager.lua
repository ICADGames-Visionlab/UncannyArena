--  playerManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

local player = require "Player/player"
local playerAssets = require "Player/playerAssets"
local playerIcon = require "Player/playerIcon"
local BulletIcon = require "Player/playerBulletIcon"
playerManager = {}
playerManager.list = {}

local orderByHeight, sortDraw
local HpArt = love.graphics.newImage("/Assets/HUD/Heart_HUD_2.png")
local iconPosition = {{x=20, y=60}, {x=1160, y=60}, {x=20, y=410}, {x=1160, y=410}}

playerManager.keys = {
  keyboard = {
    {left="left",up="up",right="right",down="down",attack=",",confirm="m"},
    {left="a",up="w",right="d",down="s",jump="space",attack="space",confirm="return"}
  },
  joy = {left="dpleft",up="dpup",right="dpright",down="dpdown",jump="dpju",attack="a",confirm="start"}
}

local arenaPos

function playerManager.load()
end

function playerManager.start(players)
  local ax,ay = arena.tileSize.width+10, arena.tileSize.height+10
  local aw,ah = arena.width, arena.height
  arenaPos = {
    {x=ax,y=ay},
    {x=aw-ax-Player.width,y=ay},
    {x=ax,y=ah-ay-Player.height},
    {x=aw-ax-Player.width,y=ah-ay-Player.height}
  }
  playerManager.list = {}
  for i,v in ipairs(players) do
    local p = Player.new(i,bulletManager.randomBullet(),playerAssets[v.id],v.keys,playerIcon[v.id], iconPosition[i], v.joy)
    p.id = v.id
    table.insert(playerManager.list,p)
  end
  playerManager.resetPlayers()
end

function playerManager.update(dt)
  for i,v in ipairs(playerManager.list) do
    v:update(dt)
  end
  arena.handleMovements(dt,playerManager.list)
end

function playerManager.keypressed(key)
  for i,v in ipairs(playerManager.list) do
    if v.joy == nil then v:keypressed(key) end
  end
end

function playerManager.gamepadpressed(joystick,button)
  for i,v in ipairs(playerManager.list) do
    if v.joy == joystick then
      v:keypressed(button)
    end
  end
end

function playerManager.draw(of)
  local players = sortDraw(playerManager.list)
  for i,v in ipairs(playerManager.list) do
    --love.graphics.print(tostring(v.hp), 0 , i*50)    
    for j=1, v.hp do
      if i%2 == 0 then
        love.graphics.draw(HpArt,(v.iconPos.x+45) - 30*(j-1), v.iconPos.y-40, 0, 0.75, 0.75)
      else
        love.graphics.draw(HpArt,(v.iconPos.x+12) + 30*(j-1), v.iconPos.y-40, 0, 0.75, 0.75)
      end
    end
    v:draw(of)
    for i,v in ipairs(playerManager.list) do
      if i%2 == 0 then
        love.graphics.draw(v.icon, v.iconPos.x+100, v.iconPos.y, 0, -0.75, 0.75)
      else
        love.graphics.draw(v.icon, v.iconPos.x, v.iconPos.y, 0, 0.75, 0.75)
      end
    end
  end
  for i,v in ipairs(playerManager.list) do
      if i%2 == 0 then
        love.graphics.print("Player"..i..": ".. v.score, v.iconPos.x-55, v.iconPos.y+260, 0, 0.75, 0.75)
      else
        love.graphics.print("Player"..i..": ".. v.score, v.iconPos.x, v.iconPos.y+260, 0, 0.75, 0.75)
      end
    end
     
  
  for i,v in ipairs(playerManager.list) do
    if v.weapon.bulletClass:is_a(BulletBoomerang) then
      if i%2 == 0 then
        love.graphics.draw(BulletIcon[1],v.iconPos.x+100,v.iconPos.y+160,0,-0.75,0.50)
      else 
        love.graphics.draw(BulletIcon[1],v.iconPos.x,v.iconPos.y+160,0,0.75,0.50)
      end
    elseif v.weapon.bulletClass:is_a(BulletExpo) then
      if i%2 == 0 then
        love.graphics.draw(BulletIcon[2],v.iconPos.x+100,v.iconPos.y+160,0,-0.75,0.50)
      else 
        love.graphics.draw(BulletIcon[2],v.iconPos.x,v.iconPos.y+160,0,0.75,0.50)
      end
    elseif v.weapon.bulletClass:is_a(BulletGrow) then
      if i%2 == 0 then
        love.graphics.draw(BulletIcon[3],v.iconPos.x+100,v.iconPos.y+160,0,-0.75,0.50)
      else 
        love.graphics.draw(BulletIcon[3],v.iconPos.x,v.iconPos.y+160,0,0.75,0.50)
      end
    elseif v.weapon.bulletClass:is_a(BulletSenoid) then
      if i%2 == 0 then
        love.graphics.draw(BulletIcon[4],v.iconPos.x+100,v.iconPos.y+160,0,-0.75,0.50)
      else 
        love.graphics.draw(BulletIcon[4],v.iconPos.x,v.iconPos.y+160,0,0.75,0.50)
      end
    end
  end
end

function playerManager.killPlayer(player)
  for i,v in ipairs(playerManager.list) do
    if v==player then
      --v = nil
      --table.remove(playerManager.list,i)
      --audioManager.playDeathSound()
      break
    end
  end
end

function playerManager.resetPlayers()
  for i, v in ipairs(playerManager.list) do
    v:setState(v.states.alive)
    local p = arenaPos[i]
    v.x = p.x
    v.y = p.y
  end
end

function playerManager.getAlivePlayers()
  local list = {}
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then table.insert(list,v) end
  end
  return list
end

function sortDraw(players)
  draw = {}
  for i,v in ipairs(players) do table.insert(draw,v) end
  table.sort(draw,orderByHeight)
  return draw
end

function orderByHeight(a,b)
  return a.y<b.y
end
function playerManager.getLastPlayer()
  local alive_players = {}  
  for i,v in ipairs(playerManager.list) do
    if not v.curr_state:is_a(PlayerDeadState) then
      table.insert(alive_players,v)  
    end
  end
  return alive_players
end
--return playerManager
