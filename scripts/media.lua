-- media.lua
-- Performance bindings
local graphics = love.graphics


-- Empty return table
local Media = {}

-------------------------------------------------------------------
-------------------------------------------------------------------
-- ANIMATION LOAD FUNCTION ----------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function newAnimation(image, width, height, duration, short)
  -- Create a new animation
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};
  animation.currentTime = 0

  for y = 0, image:getHeight() - height, height do -- Breakup spritesheet
    for x = 0, image:getWidth() - width, width do
      -- create quads
      table.insert(animation.quads, graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  end
  -- Select the duration or make it one second if none
  animation.duration = duration or 1
  -- Begin from first frame
  animation.currentTime = 0
  
  -- Functions
  function animation:draw(x, y, sx, sy, spriteNum)
    graphics.draw(self.spriteSheet, self.quads[spriteNum], x, y, 0, sx, sy)
  end
  
  -- Update animation frames
  function animation:update(dt)
    
    self.currentTime = self.currentTime + dt
    
    if self.currentTime >= self.duration then
      -- Animation comes to final frame
      if not short then -- Shuold it start again?
        self.currentTime = self.currentTime - self.duration
      else
        self.currentTime = self.duration-2*dt
      end
    end
  end
  
  -- Reset the animation
  function animation:reset()
    self.currentTime = 0
  end
  
  return animation
end

Media.newAnimation = newAnimation
return Media
