PlayerVulnerableState = class_new("vulnerable")

function PlayerVulnerableState.new(aliveState)
  local self = PlayerVulnerableState.newObject()
  self.aliveState = aliveState
  return self   
end

function PlayerVulnerableState:start()
  
end

function PlayerVulnerableState.load()
  
end

function PlayerVulnerableState:update(dt)
  
end

function PlayerVulnerableState:tookHit()
  local a = self.aliveState
  local p = a.player
  p.hp = p.hp-1
  if p.hp == 0 then
    p:setState(p.states.dead)
  else
    a:setVulnerability(a.vulnerability.invulnerable)
  end
end

function PlayerVulnerableState:draw(of)
  self.aliveState.player.super:draw(of)
end