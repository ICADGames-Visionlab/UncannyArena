require "Utils/animationManager"
--require "animatedEntity"
require "armedAnimatedEntity"
require "Direction"
require "Weapon/weapon"
require "Player/playerAliveState" 
require "Player/playerDeadState"

Player = class_extends(ArmedAnimatedEntity, "alive")

function Player.load()
  --Player.score = 0 
  Player.width = 48--48  58,90
  Player.height = Player.width*68/58--96
  Player.speed = 280
  Player.maxHP = 4 
  Player.score = 0
  Player.deathId = "death"
  Player.idleId = "idle"
  Player.walkId = "walk"
end
function Player:tookHit()
 self.curr_state:tookHit()
end

function Player.new(index,bulletClass,assetInfo,keys,icon, iconPosition, joy)  
  local self = Player.newObject(0,0,Player.width,Player.height,assetInfo)
  self.joy = joy
  --Init properties
  self.speed = {x=0,y=0}
  self.keys = keys--Player.data[index].keys
  self.hp = Player.maxHP
  self.score = 0
  self.iconPos = iconPosition
  self.index = index
  self.weapon = Weapon.new(self,bulletClass)
  --ele deve receber algo vindo do playerSelection.lua
  self.icon = icon
  self.states = { 
    alive = PlayerAliveState.new(self),
    dead = PlayerDeadState.new(self)
  }
  self.curr_state = self.states.alive
  
  return self
end

function Player:keypressed(key)
  self.curr_state:keypressed(key)
end
function Player:attack()
  self.curr_state:attack()
end

function Player:update(dt)
   self.super:update(dt)
   self.curr_state:update(dt)
  
end
function Player:draw(of)
  self.curr_state:draw(of)
  love.graphics.setColor(0,0,0)
  if config.debugBoundingBoxMode then love.graphics.rectangle("line",self.x+of.x,self.y+of.y,self.width,self.height) end
  love.graphics.setColor(255,255,255)
end

function Player:setState(state)
  self.curr_state = state
  self.curr_state:start()
end