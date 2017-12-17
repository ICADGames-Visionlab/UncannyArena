require "Player/playerVulnerableState"
require "Player/playerInvulnerableState"

PlayerAliveState = class_new("alive")

function PlayerAliveState.new(player)
  local self = PlayerAliveState.newObject()
  self.vulnerability = { 
    vulnerable = PlayerVulnerableState.new(self),
    invulnerable = PlayerInvulnerableState.new(self),
  }
  self:setVulnerability(self.vulnerability.vulnerable)
  self.player = player
  return self   
end

function PlayerAliveState:start()
  local p = self.player
  p:switchAnimation(p.idleId)
  p.hp = p.maxHP
  p:enableArm()
end

function PlayerAliveState:setState(tableKey,tableValue)
  PlayerAliveState[tableKey].curr_state = PlayerAliveState[tableKey][tableValue]
end

function PlayerAliveState:tookHit()
  self.vulnerability.curr_state:tookHit()
end

function PlayerAliveState:update(dt)
  self.vulnerability.curr_state:update(dt)
  self:updateMovement(dt)
  self.player.weapon:update(dt)
end
function PlayerAliveState:updateMovement(dt)
  self:updateHorizontal()
  self:updateVertical()
  --self:updateBoost(dt)
  --[[
  p.x = p.x + p.speed.x*dt
  p.y = p.y + p.speed.y*dt
  ]]
end

function PlayerAliveState:keypressed(key)
  if key == self.player.keys.attack then
    self:attack()
  end
end

function PlayerAliveState:attack()
  local p = self.player
  p.weapon:shoot()
end
function PlayerAliveState:updateHorizontal()
  local p = self.player
  local k = p.keys
  local isLeft, isRight
  if p.joy == nil then
    isLeft = love.keyboard.isDown(k.left)
    isRight = love.keyboard.isDown(k.right)
  else
    local ax = p.joy:getAxis(1)
    if ax < -0.4 then
      isLeft = true
    elseif ax > 0.4 then
      isLeft = false
      isRight = true
    else
      isLeft = p.joy:isGamepadDown(k.left)
      isRight = p.joy:isGamepadDown(k.right)
    end
  end
  if isLeft then
    p.speed.x = -p:class().speed
    p.dir = Direction.Left
    p:switchAnimation(p.walkId)
  elseif isRight then
    p.speed.x = p:class().speed
    p.dir = Direction.Right
    p:switchAnimation(p.walkId)
  else
    p.speed.x = 0
  end
  if p.speed.x == 0 then
      p:switchAnimation(p.idleId)
  end
end

function PlayerAliveState:updateVertical()
  local p = self.player
  local k = p.keys
  local isDown, isUp
  if p.joy == nil then
    isDown = love.keyboard.isDown(k.down)
    isUp = love.keyboard.isDown(k.up)
  else
    local ax = p.joy:getAxis(2)
    if ax > 0.4 then
      isDown = true
    elseif ax < -0.4 then
      isDown = false
      isUp = true
    else
      isDown = p.joy:isGamepadDown(k.down)
      isUp = p.joy:isGamepadDown(k.up)
    end
  end
  if isDown then
    p.speed.y = p:class().speed
    p.dir = Direction.Down
    p:switchAnimation(p.walkId)
  elseif isUp then
    p.speed.y = -p:class().speed
    p.dir = Direction.Up
    p:switchAnimation(p.walkId)
  else
    p.speed.y = 0
  end
end

function PlayerAliveState:updateBoost(dt)
  local p = self.player
  local factor
  local k = p.keys
  if love.keyboard.isDown(k.run) then
    p.speed.x = p.speed.x*1.7
    p.speed.y = p.speed.y*1.7
    factor = 1.7
  else
    factor = 1
  end
  if p.speed.x ~= 0 or p.speed.y ~= 0 then
    --animationManager_update(dt*factor,p.aComp)
    if p.speed.x ~= 0 and p.speed.y ~= 0 then
      p.speed.x = p.speed.x/math.sqrt(2)
      p.speed.y = p.speed.y/math.sqrt(2)
    end
  else
    --animationManager_restart(p.aComp)
  end
end
function PlayerAliveState:draw(of)
 self.vulnerability.curr_state:draw(of)
 --self.player.super:draw(of)
end

function PlayerAliveState:setVulnerability(vulnerability)
  self.vulnerability.curr_state = vulnerability
  vulnerability:start()
end