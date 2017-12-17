require "Player/playerManager"

local playerSelection = {}
local grid = {}

function playerSelection.load(menuManager)
  playerSelection.menuManager = menuManager
  grid.data = {}
  playerSelection.n_players = 0
  box_color = {}
  playerSelection.loadData("Magnolio")
  playerSelection.loadData("VR-704")
  playerSelection.loadData("Godo")
  playerSelection.loadData("Cpt. Rubi")
  background_img = love.graphics.newImage("Assets/Menu/background_character_select.png")
  unselected_img = love.graphics.newImage("Assets/Menu/box_unselected.png")
  for i=1, 4 do
    box_color[i] = love.graphics.newImage("Assets/Menu/box_"..i..".png")
end
function playerSelection.start()
  playerSelection.keys = playerManager.keys
  audioManager.play(audioManager.characterScreenMusic)
  playerSelection.nPlayers = 0
  playerSelection.create(1, 4)
  end
end

function playerSelection.update(dt)
  
end

function playerSelection.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(background_img, love.graphics.getWidth()/2, love.graphics.getHeight()/2, 0, 1, 1, background_img:getWidth()/2, background_img:getHeight()/2)
  for i=1, #grid.data do
    love.graphics.draw(unselected_img, 10 + 320*(i-1), 100, 0, 0.8, 0.8)
  end
  for i,v in ipairs(playerSelection) do
    for j,p in ipairs(v) do
      love.graphics.setColor(255,255,255)
      love.graphics.draw(box_color[j], 10 + 320*(j-1), 100, 0, 0.8, 0.8)
      love.graphics.draw(grid.data[p.id].img, 45 + 320*(j-1), 180, 0, 0.8, 0.8)
      love.graphics.setColor(0,0,0)
      love.graphics.print(grid.data[p.id].name, 90 + 320*(j-1), 550, 0, 1.2, 1.2, (#grid.data[p.id].name)*3)
    end
  end
end

function playerSelection.startGame()
  local players = {}
  for i,v in ipairs(playerSelection) do
    for j,w in ipairs(v) do
      table.insert(players,w)
    end
  end
  playerSelection.menuManager.game.goToGameManager(players)  
end

function playerSelection.keypressed(key)
  local foundPlayer = false
  for i, row in ipairs(playerSelection) do
    for j, p in ipairs(row) do
      if p.joy==nil and playerSelection.selection(p, key) then
        foundPlayer = true
        break
      end
    end
  end
  if not foundPlayer then
    local k = playerSelection.keys.keyboard
    for i,v in ipairs(k) do
      if key == v.confirm then
        playerSelection.newPlayer(v)
        break
      end
    end
  end
end

function playerSelection.gamepadpressed(joystick, button)
  local foundPlayer = false
  for i, row in ipairs(playerSelection) do
    for j, p in ipairs(row) do
      if p.joy~=nil then
        if p.joy==joystick then
          playerSelection.selection(p, button)
          foundPlayer = true
          break
        end
      end
    end
  end
  if not foundPlayer then
    local v = playerSelection.keys.joy
    if v.confirm == button then
      playerSelection.newPlayer(v,joystick)
    end
  end
end

function playerSelection.newPlayer(keys, joy)
  playerSelection.nPlayers = playerSelection.nPlayers + 1
  for i,v in ipairs(playerSelection) do
    local last = #v
    if last<playerSelection.n_cols then
      v[last+1] = {id = 1, keys = keys, joy=joy}
      break
    end
  end
end

function playerSelection.create(n_rows, n_cols)
  playerSelection.n_rows = n_rows
  playerSelection.n_cols = n_cols
  for i=1, n_rows do
    playerSelection[i] = {}
    for j=1, n_cols do
      --playerSelection[i][j] = {connected = false, id = 0, key = {}}
    end
  end
end
function playerSelection.loadData(string)
  table.insert(grid.data,{name=string,img=love.graphics.newImage("Assets/Menu/"..string.."_selec.png")})
end
function playerSelection.selection(player, key)
  local pk = player.keys
  if key == pk.up then
    player.id = player.id + 1
    if player.id >= #grid.data + 1 then
      player.id = 1
    end
    do return true end
  elseif key == pk.down then
    player.id = player.id - 1
    if player.id <= 0 then
      player.id = #grid.data
    end
    do return true end
  elseif key == pk.confirm then
    if playerSelection.nPlayers>1 then
      audioManager.playCharacterSelectSound()
      --playerSelection.confirmados = playerSelection.confirmados + 1
      playerSelection.startGame()
    end
    do return true end
  end
  return false
end
return playerSelection
