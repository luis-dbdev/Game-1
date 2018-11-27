-- jambo.lua
-- Performance bindings
local newImage = love.graphics.newImage

-- Requires
local Animation = require("scripts.player_animation")
local Move = require("scripts.movement")

-- Jambo character file
local Jambo = {}

-- Jambo constructor
local function newJambo()
  -- Create a new jambo table
  local jambo = {Animation = Animation.new(),
                  Move = Move}
  
  function jambo:update(dt)
    self.Move:update(dt)
    -- Select animation based on movement direction
    local direction = self.Move.direction
    
    
    if direction == 0 then
      if not self.Move.jumping then
        self.Animation.idle()
      else
        self.Animation.jumping()
      end
      
    elseif direction == 1 or direction == 4 then
      self.Animation.running()
      
    elseif direction == 2 then
      if self.Move.jumping then
        self.Animation.jump_aimUp()
      else
        self.Animation.lookingUp()
      end
      
    elseif direction == 3 or direction == 6 then
      if self.Move.jumping then
        self.Animation.jump_aimDiagUp()
      else
        self.Animation.runUpDiag()
      end
      
    elseif direction == 8 then
      if self.Move.jumping then
        self.Animation.jump_aimDown()
      else
        self.Animation.lookingDownDiag()
      end
      
    elseif direction == 9 or direction == 12 then
      if self.Move.jumping then
        self.Animation.jump_aimDiagDown()
      else
        self.Animation.running()
      end
      
    end
    
    self.Animation.update(dt)
  end
  
  function jambo:keypressed(key)
    self.Move:keypressed(key)
  end
  
  function jambo:collision(object)
    self.Move:grounded()
  end
  
  return jambo
end

Jambo.newJambo = newJambo
return Jambo