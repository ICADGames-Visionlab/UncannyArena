buttonsWinner = {}
local direction = {
   horizontal = 0,
   vertical = 1
  }
function buttonsWinner.load()
  mouse={}
  mouse.x = 0
  mouse.y = 0
  title = love.graphics.newImage("Assets/Menu/background_character_select.png")
end

function buttonsWinner.start()
  buttonsWinner.remove()
  buttonsWinner.create(3, direction.vertical, 600, 350, 200, 25)
  buttonsWinner.color = {{255, 255, 255}}
  for i=1, #buttonsWinner do
    buttonsWinner[i].imageNormal = love.graphics.newImage("Assets/Menu/winner_normal_"..i..".png")
    buttonsWinner[i].imageSelected = love.graphics.newImage("Assets/Menu/winner_select_"..i..".png")
    buttonsWinner[i].imageCurrent = buttonsWinner[i].imageNormal 
    --buttonsWinner[i].color = {255, 255, 255}
    --buttonsWinner[i].colliding = false
  end
  buttonsWinner.select(1)
  buttonsWinner.collided()
end

function buttonsWinner.update(dt)
  
end

function buttonsWinner.draw()
  love.graphics.draw(title,0, 0)
  --love.graphics.print(buttonsWinner.pressed, 200, 300)
  for i, but in ipairs(buttonsWinner) do
    --love.graphics.setColor(but.color)
    --love.graphics.rectangle("fill", but.x, but.y, but.width, but.height)
    love.graphics.draw(but.imageCurrent, but.x, but.y, 0, 1.5, 1.5)
  end
end

function buttonsWinner.keypressed(key)
  if key == "s" or key  == "down" then
    local index = buttonsWinner.pressed%#buttonsWinner+1
    buttonsWinner.select(index)
  elseif key == "w" or key == "up" then
    local q = #buttonsWinner
    local index = (buttonsWinner.pressed-2+q)%q+1
    buttonsWinner.select(index)
  end
  if buttonsWinner[1].colliding then
    buttonsWinner.pressed = 1
  elseif buttonsWinner[2].colliding then
    buttonsWinner.pressed = 2
  end
end

function buttonsWinner.create(n, tipo, but1_pos_x, but1_pos_y, but1_w, but1_h)
  local spacing = 75
  if tipo == 0 then
    for i=1, n do
      table.insert(buttonsWinner, {x = but1_pos_x +(spacing + but1_w)*(i-1), y = but1_pos_y, width = but1_w, height = but1_h})
    end
  else
    for i=1, n do
      table.insert(buttonsWinner, {x = but1_pos_x , y = but1_pos_y + (spacing + but1_h)*(i-1), width = but1_w, height = but1_h})
    end
  end
end
function buttonsWinner.select(index)
  if buttonsWinner.pressed ~= nil then
    local b = buttonsWinner[buttonsWinner.pressed]
    b.imageCurrent = b.imageNormal
    --b.color = {255, 255, 255}
  end
  buttonsWinner.pressed = index
  local b = buttonsWinner[buttonsWinner.pressed]
  b.imageCurrent = b.imageSelected
  --b.color = {255, 0, 0}
end

function buttonsWinner.remove()
  while #buttonsWinner > 0 do
    table.remove(buttonsWinner)
  end
end
function buttonsWinner.collided()
  for i=1, #buttonsWinner do
    if(buttonsWinner.checkMouseCollision(buttonsWinner[i].x, buttonsWinner[i].y, buttonsWinner[i].height, buttonsWinner[i].width, mouse.x, mouse.y)) then
      buttonsWinner[i].colliding = true
    end
  end
end
function buttonsWinner.checkMouseCollision(but_x, but_y, but_h, but_w, mouse_x, mouse_y)
  return but_x < mouse_x+1 and but_y < mouse_y +1 and mouse_x < but_x+but_w and mouse_y < but_y+but_h
end