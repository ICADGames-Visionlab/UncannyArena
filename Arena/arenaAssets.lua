require "Utils/animations"

local arenaAssets = {}

function arenaAssets.load()
  local s = love.graphics.newImage("/Assets/Stages/TileSet.png")
  --animations.loadQuads(quant,nCol,sprite_width,sprite_height)
  local i = 0
  local num = 0
  local quads = animations.loadMatrixQuads(s:getHeight()/64,s:getWidth()/64,s:getWidth(),s:getHeight())
  arenaAssets.sheet = s
  arenaAssets.random = love.math.random(0,4)
  if arenaAssets.random <= 1 then
    i = 1
    num = 4
  else
    i = 2
    arenaAssets.random = 1
    num = 0
  end
  arenaAssets.maps = {
    --brocolis
    {
      defaultFloor = quads[3][2],
      defaultWall = quads[3][1],
      destruct = quads[i][arenaAssets.random*arenaAssets.random+num],
      transitionMiddleLeft = quads[4][1],
      transitionMiddleRight = quads[3][7],
      transitionMiddleTop = quads[4][2],
      transitionMiddleBottom = quads[4][3],
      transitionBottomLeft = quads[3][5],
      transitionBottomRight = quads[3][6],
      transitionTopLeft = quads[3][3],
      transitionTopRight = quads[3][4]
    },
    --robo
    {
      defaultFloor = quads[6][1],
      defaultWall = quads[7][3],
      destruct = quads[6][3]
    },
    --alien
    {
      defaultFloor = quads[2][3],
      defaultWall = quads[2][4],
      destruct = quads[2][5],
      obstacle = quads[2][5]
    },
    --pirata
    {
      defaultFloor = quads[5][6],
      defaultWall = quads[5][5],
      destruct = quads[6][4],
      transitionMiddleLeft = quads[5][1],
      transitionMiddleRight = quads[5][2],
      transitionMiddleTop = quads[5][4],
      transitionMiddleBottom = quads[5][3],
      transitionBottomLeft = quads[4][4],
      transitionBottomRight = quads[4][5],
      transitionTopLeft = quads[4][6],
      transitionTopRight = quads[4][7]
    }
  }
  --default
  arenaAssets.maps[0] = {defaultFloor = quads[1][3],defaultWall = quads[1][2],destruct = quads[1][1]}
end

return arenaAssets