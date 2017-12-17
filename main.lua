local RPG_local = require "RPG_Full_Logo/RPG_Logo"
local game = require "Game/game"
audioManager = require "audioManager"

io.stdout:setvbuf("no")

local state

function love.load()
  local font = love.graphics.setNewFont("Assets/game_over.ttf", 100)
  love.graphics.setFont(font)
  audioManager.load()
  RPG_Logo.load(1.5,1.5,1.5,function ()
    state = game
    state.start()
  end)
  game.load()
  state = RPG_Logo
end
function love.update(dt)
  state.update(dt)
end
function love.draw()
  state.draw()
end
function love.keypressed(key)
  state.keypressed(key)
end
function love.gamepadpressed(joystick,button)
  state.gamepadpressed(joystick,button)
end
--[[function love.mousepressed(x, y, button)
  game.mousepressed(x, y, button)
end]]
