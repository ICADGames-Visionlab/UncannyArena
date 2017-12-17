require "animatedEntity"
require "class"

ArmedAnimatedEntity = class_extends(AnimatedEntity)


function ArmedAnimatedEntity.new(x,y,width,height,assetInfo)
  local self = ArmedAnimatedEntity.newObject(x,y,width,height,assetInfo)
  self.isShooting = false
  self.index = 1
  self:start()
  return self
end

function ArmedAnimatedEntity:start()
  self.enabled = true
end

function ArmedAnimatedEntity:update(dt)
  self.super:update(dt)
  if self.isShooting then
    local a = self.assets.shoot.animComp
    animationManager_update(dt,a)
    if a.finished then
      self.isShooting = false
    else
      self.index = self.curr_animation == walk and 2 or 1
    end
  end
end

function ArmedAnimatedEntity:setShootAnimation()
  self.isShooting = true
  animationManager_restart(self.assets.shoot.animComp)
end

function ArmedAnimatedEntity:disableArm()
  self.enabled = false
end

function ArmedAnimatedEntity:enableArm()
  self.enabled = true
end

function ArmedAnimatedEntity:draw(of)
  self.super:draw(of)
  if self.enabled then
    if not self.isShooting then
      self:drawAsset(of,2,self.curr_animation)
    else
      self:drawAsset(of,1,self.assets.shoot)
    end
  end
end