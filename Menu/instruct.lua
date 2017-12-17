local instruct = {}

function instruct.load(menuManager)
  instruct.menuManager = menuManager
  instruct.image = love.graphics.newImage("Assets/Menu/Instructions.png")
end

function instruct.start(n_players)
  
end

function instruct.update(dt)
  
end

function instruct.draw()
  love.graphics.draw(instruct.image, 0, 0)
end

function instruct.keypressed(key)
  if key == "escape" then
    instruct.menuManager.goToMenu()
  end
  if key == "return" then
    instruct.menuManager.goToPlayerSelection()
    audioManager.playOptionSelectSound()
  end
end
return instruct
