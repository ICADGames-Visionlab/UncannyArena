--  destructTile.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/solidTile"

DestructTile = class_extends(SolidTile,"destructTile")
DestructTile.color = {0,0,255,255}

function DestructTile.new(x,y,image,quad,manager)
  local self = DestructTile.newObject(x,y,image,quad)
  self.manager = manager
  return self
end

function DestructTile:tookHit(entity)
  if entity:is_a(Bullet) then
    self.manager.destroy(self)
  end
end

function DestructTile:draw(of)
  self.floor:draw(of)
  self.super:draw(of)
end