--  bulletStraight.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "bullet/bullet"

BulletStraight = class_extends(Bullet,"straight")
BulletStraight.speed = 400
BulletStraight.color = {0,0,255}

--[[ BulletStraight.new
Creates a new BulletStraight shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - dir: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
]]
function BulletStraight.new(x,y,dir)
  local self = BulletStraight.newObject(x,y,dir,BulletStraight.speed)
  return self
end