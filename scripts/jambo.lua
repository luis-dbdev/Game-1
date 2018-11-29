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
  local jambo = {Move = Move}
  jambo = Animation.new(jambo)
  
  function jambo:update(dt)
    self.Move:update(dt)
    -- Select animation based on movement direction
    local direction = self.Move.direction
    
    
    if direction == 0 then
      if not self.Move.jumping then
        self.idle()
      else
        self.jumping()
      end
      
    elseif direction == 1 or direction == 4 then
      self.running()
      
    elseif direction == 2 then
      if self.Move.jumping then
        self.jump_aimUp()
      else
        self.lookingUp()
      end
      
    elseif direction == 3 or direction == 6 then
      if self.Move.jumping then
        self.jump_aimDiagUp()
      else
        self.runUpDiag()
      end
      
    elseif direction == 8 then
      if self.Move.jumping then
        self.jump_aimDown()
      else
        self.lookingDownDiag()
      end
      
    elseif direction == 9 or direction == 12 then
      if self.Move.jumping then
        self.jump_aimDiagDown()
      else
        self.running()
      end
      
    end
    
    self.update_animation(dt)
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