joyManager = {}

function joyManager.start()
  joyManager.list = {}
  for v in love.joystick.getJoysticks() do
    table.insert(joyManager.list,{joy=v})
  end
end

function joyManager.newJoyPlayer(joy)
  table.insert(joyManager.list,{joy=joy})
end

function joyManager.update(dt)
  local newList = love.joystick.getJoysticks()
end

function joyManager.searchJoy(joy)
  for i,v in ipairs(joyManager.list) do
    if v.joy == joy then
      
    end
  end
  return -1
end