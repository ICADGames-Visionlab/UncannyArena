PlayerInvulnerableState = class_new("vulnerable")

PlayerInvulnerableState.invTime = 1
PlayerInvulnerableState.blinkTime = 0.09

function PlayerInvulnerableState.new(aliveState)
  local self = PlayerInvulnerableState.newObject()
  self.aliveState = aliveState
  return self   
end

function PlayerInvulnerableState:start()
  self.timer = self.invTime
end

function PlayerInvulnerableState.load()
  
end

function PlayerInvulnerableState:update(dt)
  self.timer = self.timer - dt
  if self.timer < 0 then
    self.aliveState:setVulnerability(self.aliveState.vulnerability.vulnerable)
  end
end

function PlayerInvulnerableState:tookHit()
  
end

function PlayerInvulnerableState:draw(of)
  if math.floor((self.invTime-self.timer)/self.blinkTime)%2==1 then
    self.aliveState.player.super:draw(of)
  end
end

