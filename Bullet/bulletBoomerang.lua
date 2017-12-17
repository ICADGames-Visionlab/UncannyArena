--  bulletBoomerang.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Bullet/bullet"

BulletBoomerang = class_extends(Bullet,"boomerang")
BulletBoomerang.speed = 1200--700
BulletBoomerang.distance = 250--300
BulletBoomerang.amp = 290--280
BulletBoomerang.velA = -math.pi*1.2
BulletBoomerang.img = love.graphics.newImage("Assets/Bullet/tiro_boomerang.png")

--[[ BulletBoomerang.new
Creates a new BulletBoomerang shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - dir: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletBoomerang.new(x,y,dir)
  local self = BulletBoomerang.newObject(x,y,dir,BulletBoomerang.speed)
  self:prepare(dir)
  return self
end

--[[ BulletBoomerang:prepare
Prepares the bullet variables for boomerang movement. Locally called on initiation.
-
Parameters:
  - dir:  a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletBoomerang:prepare(dir)
  local pi = math.pi
  self.alpha = 0
  if dir.x==0 then
    self.distance = BulletBoomerang.amp
    self.amp = BulletBoomerang.distance
    self.alpha0 = dir.y==1 and pi/2 or pi*3/2
  else
    self.alpha0 = dir.x==1 and pi or 0
  end
  self.x = self.x+30*dir.x
  self.y = self.y+30*dir.y
  self.center = {
    x = self.x + self.width/2 + self.distance/2*dir.x,
    y = self.y + self.height/2 + self.amp/2*dir.y
  }
end

--[[ BulletBoomerang:update
Updates the bullet behaviour.
-
Parameters:
  - dt: the delta time since last frame update
]]
function BulletBoomerang:update(dt)
  self.super:update(dt)
  self.alpha = self.alpha + self.velA*dt
  if self.alpha < -math.pi*2 then
    bulletManager.terminateBullet(self)
  else
    local angle = self.alpha - self.alpha0
    local x = self.distance/2*math.cos(angle)+self.center.x
    local y = self.amp/2*math.sin(angle)+self.center.y
    self.speed.x = (x-self.x)/dt
    self.speed.y = (y-self.y)/dt
  end
end
