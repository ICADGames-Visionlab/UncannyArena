Direction = {
  Right = 1,
  Up = 2,
  Left = 3,
  Down = 4
}
function Direction.getSpeed(dir)
  return dir == Direction.Left and {x=-1,y=0} or 
  dir == Direction.Right and {x=1,y=0} or 
  dir == Direction.Up and {x=0,y=-1} or {x=0,y=1}
end
return Direction
