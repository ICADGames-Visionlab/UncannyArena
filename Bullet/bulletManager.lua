--  bulletManager.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

local bullet = require "Bullet/bullet"
local bulletSenoid = require "Bullet/bulletSenoid"
local bulletGlow = require "Bullet/bulletGrow"
local bulletBoomerang = require "Bullet/bulletBoomerang"
local bulletExpo = require "Bullet/bulletExpo"
local Direction = require "Direction"
require "Utils/animations"

bulletManager = {}
bulletManager.list = {}
bulletManager.bullets = {
  BulletExpo,
  BulletBoomerang,
  BulletGrow,
  BulletSenoid
}

--[[ bulletManager.randomBullet
Gets a random subclass of Bullet
-
Returns: a random Bullet subclass
]]
function bulletManager.randomBullet()
  return bulletManager.bullets[love.math.random(#bulletManager.bullets)]
end

function bulletManager.load()
  animations.load()
  Bullet.load()
end

function bulletManager.start()
  
end

--[[ bulletManager.update
Updates bullets behaviour
-
Parameters:
  - dt: the delta time since last frame update
]]
function bulletManager.update(dt)
  animations.update(dt)
  for i,v in ipairs(bulletManager.list) do
    v:update(dt)
    if not arena.handleHorizontal(dt,v) or not arena.handleVertical(dt,v) then
      bulletManager.bulletCollided(i)
    else
      bulletManager.searchPlayerContact(i,v)
    end
  end
end

--[[ bulletManager.searchPlayerContact
Verifies if a bullet is touching one of the players
-
Parameters:
  - v: the bullet
]]
function bulletManager.searchPlayerContact(i,v)
  local list = playerManager.getAlivePlayers()
  for j,p in ipairs(list) do
    if v:checkPlayerContact(p) then
      bulletManager.bulletCollided(i)
      p:tookHit()
      break
    end
  end
end

--[[ bulletManager.newBullet
Creates a new bullet shot by the given player
-
Parameters:
  - player: the Player entity that is shooting the bullet
]]
function bulletManager.newBullet(player,bClass,...)
  local dir = Direction.getSpeed(player.dir)
  local pos_x = player.x + (dir.x>0 and player.width or dir.x<0 and -bClass.width or player.width/2-bClass.width)
  local pos_y = player.y + (dir.y>0 and player.height or dir.y<0 and -bClass.height or player.height/2-bClass.height)
  table.insert(bulletManager.list,bClass.new(pos_x,pos_y,dir,player,...))
end

--[[ bulletManager.draw
Draws all the bullets
-
Parameters:
  - offset: a table (x,y) with offset distance from the screen's top left corner
]]
function bulletManager.draw(offset)
  bulletManager.offset = offset
  for i,v in ipairs(bulletManager.list) do
    v:draw(offset)
  end
  animations.draw()
end

--[[ bulletManager.bulletCollided
Called when a bullet collides, creates visual effect for it and remove the bullet from the game
-
Parameters:
  - bulletIndex: the index of the bullet in the bulletManager.list
]]
function bulletManager.bulletCollided(bulletIndex)
  local of = bulletManager.offset
  local bullet = table.remove(bulletManager.list,bulletIndex)
  animations.createSplash(of.x+bullet.x+bullet.width/2,of.y+bullet.y+bullet.height/2)
end

--[[ bulletManager.terminateBullet
Called when a bullet collides, it searchs for the bullet in the list and performs necessary measures
-
Parameters:
  - bullet: the Bullet entity that collided
]]
function bulletManager.terminateBullet(bullet)
  for i,v in ipairs(bulletManager.list) do
    if v==bullet then
      bulletManager.bulletCollided(i)
      --table.remove(bulletManager.list,i)
      break
    end
  end
end
--return bulletManager
