local menuManager = require "Menu/menuManager"
local gameManager = require "Game/gameManager"
local winnerScreen = require "Menu/winnerScreen"
local playerSelection = require "Menu/playerSelection"

local game = {}

function game.start()
  game.curr_state = menuManager
  menuManager.start()
end
function game.load()
  menuManager.load(game)
  gameManager.load(game)
  winnerScreen.load(game, menuManager)
end

function game.update(dt)
  game.curr_state.update(dt)
end

function game.draw()
  game.curr_state.draw()
end

function game.keypressed(key)
  game.curr_state.keypressed(key)
end
--[[function game.mousepressed(x, y, button)
  menuManager.mousepressed(x, y, button)
end]]
function game.goToMenuManager(n_players)
  game.setState(menuManager, n_players)
end
function game.goToGameManager(playersInfo)
  game.setState(gameManager,playersInfo)
end
function game.goToWinnerScreen(playersInfo, winner)
  game.setState(winnerScreen, playersInfo, winner)
end
function game.goToPlayerSelection()
  game.setState(playerSelection)
end
function game.setState(state, ...)
  game.curr_state = state
  state.start(...)
end
function game.gamepadpressed(joystick,button)
  game.curr_state.gamepadpressed(joystick,button)
end
return game
