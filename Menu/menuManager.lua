local instruct = require "Menu/instruct"
local menu = require "Menu/menu"
local playerSelection = require "Menu/playerSelection"
local winnerScreen = require "Menu/winnerScreen"

local menuManager = {}

function menuManager.load(game)
  menuManager.game = game
  menu.load(menuManager)
  instruct.load(menuManager)
  playerSelection.load(menuManager)
  winnerScreen.load(game,menuManager)
end

function menuManager.setWinnerScreen(...)
  menuManager.setState(winnerScreen,...)
end

function menuManager.start()
  menuManager.setState(menu)
end

function menuManager.update(dt)
  menuManager.curr_state.update(dt)
end

function menuManager.draw()
  menuManager.curr_state.draw()
end

function menuManager.keypressed(key)
  menuManager.curr_state.keypressed(key)
end
function menuManager.gamepadpressed(joystick,button)
  if menuManager.curr_state.gamepadpressed ~= nil then
    menuManager.curr_state.gamepadpressed(joystick,button)
  end
end

function menu.mousepressed(x, y, button)
  menu.mousepressed(x, y, button)
end

function menuManager.goToPlayerSelection()
  menuManager.setState(playerSelection)
end
function menuManager.goToMenu()
  menuManager.setState(menu)
end
function menuManager.goToInstruct()
  menuManager.setState(instruct)
end
function menuManager.setState(state,...)
  menuManager.curr_state = state
  state.start(...)
end
return menuManager
