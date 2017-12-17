--  explosiveTile.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "Arena/solidTile"

ExplosiveTile = class_extends(DestructTile,"destructTile")
ExplosiveTile.color = {0,0,255,255}

function ExplosiveTile.new(x,y,image,quad,manager)
  local self = ExplosiveTile.newObject(x,y,image,quad,manager)
  return self
end

function ExplosiveTile:tookHit(entity)
  if entity:is_a(Bullet) then
    self.manager.explode(self)
  end
end