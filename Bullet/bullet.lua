--  bullet.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "entity"
require "contact"

Bullet = class_extends(Entity,"bullet")
Bullet.width = 25
Bullet.height = 25
Bullet.color = {0,255,0}

function Bullet.load()
  --Bullet.img = love.graphics.newImage('Assets/bullet.png')
  --[[
  local img = love.graphics.newImage("Assets/particle.png")
  Bullet.particleScale = 12/img:getWidth()
  Bullet.psystem = love.graphics.newParticleSystem(img, 200)
	Bullet.psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	Bullet.psystem:setEmissionRate(20)
	Bullet.psystem:setSizeVariation(1)
  Bullet.psystem:start()
  ]]
end

--[[ Bullet.new
Creates a new bullet shot
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - direction: a table {x = 1 or 0 or -1, y = 1 or 0 or -1}, specifying the direction the bullet should go
  - speed: the modular (absolute value) speed of the bullet
]]
function Bullet.new(x,y,direction,speed)
  self = Bullet.newObject(x,y,Bullet.width,Bullet.height)
  self.super.img = self.img
  self.speed = {
    x = speed * direction.x,
    y = speed * direction.y
  }
  --[[
  self.psystem = Bullet.psystem:clone()
  self.psystem:setDirection(-direction.x,-direction.y,0)
  self.psystem:setSpeed(1000,1000)
  ]]
  return self
end

--[[ Bullet:update
Updates the bullet behaviour. This function should be overrided by its subclasses
-
Parameters:
  - dt: the delta time since last frame update
]]
function Bullet:update(dt)
  self.super:update(dt)
  --[[
  self.psystem:update(dt)
  self.psystem:emit(1)
  self.psystem:setDirection(-self.speed.x,-self.speed.y,0)
  ]]
end

--[[ Bullet:checkPlayerContact
Check either or not the bullet is touching a given player
-
Parameters:
  - player: the Player entity to check if the bullet is in contact with

Returns: 
  - true: if the player is in contact with the bullet
  - false: otherwise
]]
function Bullet:checkPlayerContact(player)
  return contact.isInContact(self,player)
end

--[[
function Bullet:draw(of)
  self.super:draw(of)
  local s = Bullet.particleScale
  love.graphics.draw(self.psystem,self.x+of.x,self.y+of.y,0,s,s)
end
]]