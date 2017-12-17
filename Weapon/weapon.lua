--  weapon.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "class"

Weapon = class_new("Weapon")

-- Properties for subclasses to override or to be customized
Weapon.cooldown = 0.6

--[[ Weapon.new
Creates a new weapon for the given player and Bullet subclass
-
Parameters:
  - player: The Player instance to associate the weapon with
  - bulletClass: The class of the Bullet it shoots
]]
function Weapon.new(player, bulletClass)
  local self = Weapon.newObject()
  self.player = player
  self.bulletClass = bulletClass
  self.timer = 0
  return self
end

--[[ Weapon:update
Updates the weapon's variables, such as cooldown time
-
Parameters:
  - dt: the delta time since last frame update
]]
function Weapon:update(dt)
  if self.timer > 0 then
    self.timer = self.timer - dt
  end
  
end
--[[ Weapon:shoot
Called when a shoot is requested. Verifies if it is possible to shoot. If yes, it requests the bullet.
]]
function Weapon:shoot()
  if self.timer <= 0 then
    self.player:setShootAnimation()
    self.timer = self.cooldown
    audioManager.playBulletSound(self.player.id)
    bulletManager.newBullet(self.player,self.bulletClass)
  end
end