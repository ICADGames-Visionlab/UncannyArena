require "Utils/animationManager"
require "animatedEntity"
require "Direction"
require "Weapon/weapon"

Player = class_extends(AnimatedEntity)

local adjustSpeed
local resetFrame

--Load player class resources
function Player.load()
  Player.data = {
    {color = {255,255,255}, keys = {left="left",up="up",right="right",down="down",jump="space",attack=",",run="m"}},
    {color = {0,255,0}, keys = {left="a",up="w",right="d",down="s",jump="space",attack="c",run="x"}},
    {color = {100,100,255}, keys = {left="k",up="o",right=";",down="l",jump="space",attack="]",run="["}},
    {color = {0,0,0}}
  }
  --[[
  local img = love.graphics.newImage("Assets/walk.png")
  local aw = img:getWidth()
  local ah = img:getHeight()
  local ew = aw/5
  local eh = ah/4
  local quads={}
  for i=1,4 do
    quads[i] = {}
    for j=1,5 do
      table.insert(quads[i],love.graphics.newQuad((j-1)*ew+22,(i-1)*eh+11,ew-44,eh-22,aw,ah))
    end
  end
  Player.assets = {sheet=img,quads=quads}
  Player.width = ew-44
  Player.height = eh-22
  ]]
  Player.width = 48
  Player.height = 96
  Player.speed = 280
  Player.maxHP = 4
  
end
--Create an instance of Player
function Player.new(index,bulletClass)
  local pirate = {
    idle = {sheetFilename="/Assets/Player/Pirate/pirate_idle.png",
      animationTime = 0.5,
      nCol = 7,
      nRow = 4,
      shouldLoop = true
      --framesQuant = {}
    }
  }
  local self = Player.newObject(100,100,Player.width,Player.height,pirate)
  --Init properties
  self.color = Player.data[index].color
  --self.dir = Direction.Left
  self.speed = {x=0,y=0}
  --self.aComp = animationManager_new(4,0.5,true)
  self.keys = Player.data[index].keys
  self.hp = Player.maxHP
  self.weapon = Weapon.new(self,bulletClass)
  return self
end

function Player:tookHit(dt)
  self.hp = self.hp - 1

  if self.hp == 0 then
    playerManager.killPlayer(self)
  end
end

function Player:update(dt)
  self.super:update(dt)
  self:updateMovement(dt)  
end
  
function Player:keypressed(key)
  if key == self.keys.attack then
    self:attack()
  end
end

function Player:attack()
  self.weapon:shoot()
end

function Player:updateMovement(dt)
  self:updateHorizontal()
  self:updateVertical()
  self:updateBoost(dt)
  --[[
  self.x = self.x + self.speed.x*dt
  self.y = self.y + self.speed.y*dt
  ]]
end

--[[
function Player:draw(offset)
  if offset==nil then offset={x=0,y=0} end
  love.graphics.setColor(self.color)
  local a = Player.assets
  local x = offset.x+self.x
  local y = offset.y+self.y
  love.graphics.draw(a.sheet,a.quads[self.dir][self.aComp.curr_frame],x,y)
  if config.debugMode then
    love.graphics.rectangle("line",x,y,self.width,self.height)
  end
  --love.graphics.rectangle("line",self.x,self.y,a.sheet:getWidth()/5-44,a.sheet:getHeight()/4-22)
end
]]

function Player:updateHorizontal()
  local k = self.keys
  if love.keyboard.isDown(k.left) then
    self.speed.x = -Player.speed
    self.dir = Direction.Left
  elseif love.keyboard.isDown(k.right) then
    self.speed.x = Player.speed
    self.dir = Direction.Right
  else
    self.speed.x = 0
  end
end

function Player:updateVertical()
  local k = self.keys
  if love.keyboard.isDown(k.down) then
    self.speed.y = Player.speed
    self.dir = Direction.Down
  elseif love.keyboard.isDown(k.up) then
    self.speed.y = -Player.speed
    self.dir = Direction.Up
  else
    self.speed.y = 0
  end
end

function Player:updateBoost(dt)
  local factor
  local k = self.keys
  if love.keyboard.isDown(k.run) then
    self.speed.x = self.speed.x*1.7
    self.speed.y = self.speed.y*1.7
    factor = 1.7
  else
    factor = 1
  end
  if self.speed.x ~= 0 or self.speed.y ~= 0 then
    --animationManager_update(dt*factor,self.aComp)
    if self.speed.x ~= 0 and self.speed.y ~= 0 then
      self.speed.x = self.speed.x/math.sqrt(2)
      self.speed.y = self.speed.y/math.sqrt(2)
    end
  else
    --animationManager_restart(self.aComp)
  end
end