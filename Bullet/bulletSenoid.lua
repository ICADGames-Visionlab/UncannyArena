--  bulletSenoid.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Bullet/bullet"

BulletSenoid = class_extends(Bullet,"senoid")
BulletSenoid.amp = 66 --100
BulletSenoid.time = 0.7 --0.9
--Bullet.sign = 1
BulletSenoid.speed = 600 --700
BulletSenoid.color = {0,0,255}
BulletSenoid.img = love.graphics.newImage("Assets/Bullet/tiro_seno.png")

local horizontal = {}
local vertical = {}

--[[ BulletSenoid.new
Creates a new BulletSenoid shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - dir: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletSenoid.new(x,y,dir)
  local self = BulletSenoid.newObject(x,y,dir,BulletSenoid.speed)
  self.x0 = x
  self.y0 = y
  self.type = dir.x ~= 0 and horizontal or vertical
  self.sign = (sign == nil and 1 or sign)
  self.type.start(self)
  return self
end

--[[ BulletSenoid:update
Updates the bullet behaviour.
-
Parameters:
  - dt: the delta time since last frame update
]]
function BulletSenoid:update(dt)
  self.super:update(dt)
  self.type.update(dt,self)
end

--[[ horizontal.start
Bullet's variables preparation when shot horizontally. Called locally.
-
Parameters:
  - self: the BulletExpo instance to be prepared
]]
function horizontal.start(self)
  self.mult = math.pi*2/(BulletSenoid.time*self.speed.x)*self.sign
end

--[[ horizontal.update
Updates the bullet when shot horizontally. Called locally.
-
Parameters:
  - dt: the delta time since last frame update
  - self: the BulletExpo instance to be updated
]]
function horizontal.update(dt,self)
  local nextY = BulletSenoid.amp*math.sin((self.x-self.x0)*self.mult) + self.y0
  self.speed.y = (nextY-self.y)/dt
end

--[[ vertical.start
Bullet's variables preparation when shot vertically. Called locally.
-
Parameters:
  - self: the BulletExpo instance to be prepared
]]
function vertical.start(self)
  self.mult = math.pi*2/(BulletSenoid.time*self.speed.y)*self.sign
end

--[[ vertical.update
Updates the bullet when shot vertically. Called locally.
-
Parameters:
  - dt: the delta time since last frame update
  - self: the BulletExpo instance to be updated
]]
function vertical.update(dt, self)
  local nextX = BulletSenoid.amp*math.sin((self.y-self.y0)*self.mult) + self.x0
  self.speed.x = (nextX-self.x)/dt
end

