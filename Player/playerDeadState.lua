

PlayerDeadState = class_new("dead")


function PlayerDeadState.new(player)
  local self = PlayerDeadState.newObject()
  self.player = player
  return self   
end

function PlayerDeadState:start()
  local p = self.player
  p.speed = {x=0,y=0}
  p:switchAnimation(p.deathId)
  animationManager_restart(p:getCurrentComp())
  p:disableArm()
end

function PlayerDeadState:tookHit(dt)
end
function PlayerDeadState:keypressed(key)
end
function PlayerDeadState:attack()
end
function PlayerDeadState:update(dt)
  local p = self.player
  if p:getCurrentComp().finished then
    playerManager.killPlayer(p)
  end
end

function PlayerDeadState:draw(of)
  self.player.super:draw(of)
end