local buttons = require "Menu/buttons"
local menu = {}

local tw = love.graphics.getWidth()
local th = love.graphics.getHeight()

function menu.load(manager)
  menu.manager = manager
  buttons.load()
end

function menu.start()
  audioManager.play(audioManager.menuMusic)
  love.graphics.setColor(255, 255, 255)
  buttons.start()
end

function menu.update(dt)
  buttons.update(dt)
end

function menu.draw()
  buttons.draw()
end

function menu.keypressed(key)
  buttons.keypressed(key)
  if key == "return" and buttons.pressed == 1 then
    menu.manager.goToInstruct()
    audioManager.playOptionSelectSound()
  elseif key == "return" and buttons.pressed == 2 then
    love.event.push("quit")
    audioManager.playExitSound()
  end
end

function menu.mousepressed(x, y, button)
  mouse.x = x
  mouse.y = y
  if key == 1 and buttons[1].colliding then
    menu.manager.goToInstruct()
    audioManager.playOptionSelectSound()
  elseif key == 1 and buttons[2].colliding then
    love.event.push("quit")
  end
end
return menu
