--  bulletExpo.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe and Nicolas Paes
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Bullet/bullet"

BulletExpo = class_extends(Bullet,"expo")
BulletExpo.speed = 500
BulletExpo.damping = 25 --50
BulletExpo.curveFactor = 300 --4
BulletExpo.img = love.graphics.newImage("Assets/Bullet/tiro_expo.png")

local horizontal = {}
local vertical = {}

--[[ BulletExpo.new
Creates a new BulletExpo shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - dir: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletExpo.new(x,y,dir)
  local self = BulletExpo.newObject(x,y,dir,BulletExpo.speed)
  self.x0 = x
  self.y0 = y
  self:prepare(dir)
  return self
end

--[[ BulletExpo:prepare
Prepares the bullet variables for exponential movement. Locally called on initiation.
-
Parameters:
  - dir:  a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletExpo:prepare(dir)
  self.speed = {
      x = BulletExpo.speed*dir.x,
      y = BulletExpo.speed*dir.y
    }
  if dir.x ~= 0 then
    self.type = horizontal
    self.sign = dir.x
  else
    self.type = vertical
    self.sign = dir.y
  end
end

--[[ BulletExpo:update
Updates the bullet behaviour.
-
Parameters:
  - dt: the delta time since last frame update
]]
function BulletExpo:update(dt)
  self.super:update(dt)
  self.type.update(self,dt)
end
  
--[[ horizontal.update
Updates the bullet when shot horizontally. Called locally.
-
Parameters:
  - self: the BulletExpo instance to be updated
  - dt: the delta time since last frame update
]]
function horizontal.update(self,dt)
  local x = math.abs(self.x-self.x0)
  local NextY = math.exp(x/self.damping)/self.curveFactor*self.sign + self.y0
  self.speed.y = (NextY-self.y)/dt
end

--[[ vertical.update
Updates the bullet when shot vertically. Called locally.
-
Parameters:
  - self: the BulletExpo instance to be updated
  - dt: the delta time since last frame update
]]
function vertical.update(self,dt)
  local y = math.abs(self.y-self.y0)
  local NextX = math.exp(y/self.damping)/4*self.sign + self.x0
  self.speed.x = (NextX-self.x)/dt
end
  
