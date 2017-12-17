require "class"

Entity = class_new("entity")
Entity.isCircle = true

function Entity.new(x,y,width,height)
  local self = Entity.newObject()
  self.x = x
  self.y = y
  if width ~= nil then self.width = width end
  if height ~= nil then self.height = height end
  self.color = {0,0,0}
  return self
end

function Entity:update(dt)
  
end

function Entity:draw(of)
  if of == nil then of = {x=0,y=0} end
  if self.img == nil then
    love.graphics.setColor(self.color)
    if self.isCircle then
      love.graphics.circle("fill",self.x+of.x+self.width/2,self.y+of.y+self.height/2,(self.width+self.height)/4)
    else
      love.graphics.rectangle("fill",self.x+of.x,self.y+of.y,self.width,self.height)
    end
    love.graphics.setColor(255,255,255)
  else
    love.graphics.setColor(255,255,255)
    love.graphics.draw(self.img,self.x+of.x,self.y+of.y,0,self.width/self.img:getWidth(),self.height/self.img:getHeight())
  end
end
