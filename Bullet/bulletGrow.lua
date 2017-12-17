--  bulletGrow.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Bullet/bullet"

BulletGrow = class_extends(Bullet,"grow")
BulletGrow.growSpeed = 100
BulletGrow.speed = 600
BulletGrow.color = {0,0,255}
BulletGrow.img = love.graphics.newImage("Assets/Bullet/tiro_grow.png")

--[[ BulletGrow.new
Creates a new BulletGrow shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - dir: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletGrow.new(x,y,dir)
  local self = BulletGrow.newObject(x,y,dir,BulletGrow.speed)
  return self
end

--[[ BulletGrow:update
Updates the bullet behaviour.
-
Parameters:
  - dt: the delta time since last frame update
]]
function BulletGrow:update(dt)
  self.super:update(dt)
  local inc = BulletGrow.growSpeed*dt
  self.width = self.width+inc
  self.height = self.height+inc
  self.x = self.x-inc/2
  self.y = self.y-inc/2
end
