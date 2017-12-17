--[[ To manage sprite animation (know what frame of the animation you want to reproduce each time), you need to provide:
  - qFrames: number of frames of the animation
  - animTime: the duration time desired for the animation
  - doRepeat: a boolean to state if the animation should loop, when not given, the default is TRUE
  
  Run the update function to update the manager
  
  To know the actual frame of an animationManager just access the curr_frame property
  
  If you stop updating the animation and then need to run again, call the RESTART function (to put the curr_frame back to 1).
  
  EXAMPLE CODE:
  
  (GLOBAL)
  local runSpriteSheet
  local runQuads
  local myManager
  
  (LOAD)
  runSpriteSheet = love.graphics.newImage("runSheet.png")
  runQuads = {
    love.graphics.newQuad(0,0,20,20),
    love.graphics.newQuad(20,0,20,20),
    love.graphics.newQuad(40,0,20,20),
    love.graphics.newQuad(60,0,20,20)
  }
  myManager = animationManager_new(4,0.6)
  -- manager loaded ready for loop
  
  (UPDATE)
  animationManager_update(dt, myManager)
  
  (DRAW)
  local actualFrame = myManager.curr_frame
  love.graphics.draw(runSpriteSheet,runQuads[actualFrame])
  ]]

function animationManager_new(qFrames, animTime, doRepeat)
  local anim = {}
  anim.time = animTime
  anim.capTime = animTime / qFrames
  anim.qFrames = qFrames
  anim.canRepeat = (doRepeat==nil or doRepeat==true)
  animationManager_restart(anim)
  return anim;
end

function animationManager_update(dt, anim)
  anim.curr_time = anim.curr_time + dt
  if anim.curr_time > anim.capTime then
    anim.curr_time = anim.curr_time - anim.capTime
    anim.curr_frame = anim.curr_frame+1
    if anim.curr_frame > anim.qFrames then
      if not anim.canRepeat then
        anim.curr_frame = anim.qFrames
        anim.finished = true
        return -1
      else
        anim.curr_frame = 1
      end
    end
  end
  return anim.curr_frame
end

function animationManager_restart(anim)
  anim.curr_frame = 1
  anim.curr_time = 0
  anim.finished = false
end