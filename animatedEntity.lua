--  animatedEntity.lua
--  PUC Arena
--  Created by Pietro Ribeiro Pepe
--  Copyright © 2016 Rio PUC Games. All rights reserved.

require "entity"
require "Utils/animationManager"
require "Utils/animations"

AnimatedEntity = class_extends(Entity,"AnimatedEntity")

--[[ AnimatedEntity.new
Creates a new animated entity
-
Parameters:
  - x: the x position of the bullet, relative to the top-left corner of the arena
  - y: the y position of the bullet, relative to the top-left corner of the arena
  - width: the width of the player hitbox
  - height: the height of the player hitbox
  - assetsInfo: a table of tables containing information about each animation.
  For each one we have:
    .sheetFilename = the string representing the sheet image
    .animationTime = the animation time
    .nCol = numberOfColumns of the spriteSheet
    .nRow = numberOfRows of the spriteSheet
    .shouldLoop = boolean informing if the animation shouldLoop
    {
     Right = 4
     Left = 3
     Up = 8
     Down = 8
    }
]]

function AnimatedEntity.new(x,y,width,height,assetsInfo)
  local self = AnimatedEntity.newObject(x,y,width,height)
  self:prepareAssets(assetsInfo)
  self.curr_animation = self.assets.idle
  self.dir = Direction.Left
  return self
end

function AnimatedEntity:switchAnimation(animationId)
  self.curr_animation = self.assets[animationId]
end

function AnimatedEntity:prepareAssets(assetsInfo)
  self.assets = {}
  for key,value in pairs(assetsInfo) do
    local imgs = {}
    if type(value.sheetFilename)=="table" then
      for i,v in ipairs(value.sheetFilename) do
        imgs[i] = love.graphics.newImage(v)
      end
    else
      imgs[1] = love.graphics.newImage(value.sheetFilename)
    end
    local img = imgs[1]
    local all_w = img:getWidth()
    local all_h = img:getHeight()
    local quads = animations.loadMatrixQuads(value.nRow,value.nCol,all_w,all_h)
    local animComp = animationManager_new(value.nCol, value.animationTime, value.shouldLoop)
    self.assets[key] = {sheet=imgs, quads=quads, animComp=animComp, size={width=58,height=68}}--width=58,height=108}}--{width=all_w/value.nCol,height=all_h/value.nRow}}
  end
end
--0.46774193548387
function AnimatedEntity:update(dt)
  self.super:update(dt)
  animationManager_update(dt, self.curr_animation.animComp)
end
  
function AnimatedEntity:draw(of)
  --self.super:draw()
  self:drawAsset(of,index,self.curr_animation)
end

function AnimatedEntity:drawAsset(of,index,asset)
  if index == nil then index = 1 end
  local s = asset
  --for i,v in ipairs(s.sheet) do
    love.graphics.draw(s.sheet[index],s.quads[self.dir][s.animComp.curr_frame],of.x+self.x,of.y+self.y,0,self.width/s.size.width,self.height/s.size.height,33,60)--20)
  --end
end

function AnimatedEntity:getCurrentComp()
  return self.curr_animation.animComp
end