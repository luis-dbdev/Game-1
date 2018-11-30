-- movement.lua

-- Performance bindings
local print = print
local bit = bit
local table = table
local ipairs = ipairs

-- Return table


-- Script global locals
local speedX          = 0 -- Abstracted away from main.lua
local speedY          = 0 -- Abstracted away from main.lua
local gravity         = 1800 -- Self explanatory
local hAcc            = 5000 -- Horizontal acceleration (for moving)
local vAcc            = 7000-- Vertical acceleration (for jumping)

function make_movable(self)
  
  -- Initiate table
  self.move = {direction = 0,
               buffer = {},
               jumping = false}
  
  
  -- Update function
  function self.Move(dt)
    
    self.move.direction = 0
    
    if love.keyboard.isDown('right') then -- 0x0001
      self.move.direction = 1
    end
    if love.keyboard.isDown('up') then -- 0x0010
      self.move.direction = bit.bor(self.move.direction, bit.lshift(1,1))
    end
    if love.keyboard.isDown('left') then -- 0x0100
      self.move.direction = bit.bor(self.move.direction, bit.lshift(1,2))
    end
    if love.keyboard.isDown('down') then -- 0x1000
      self.move.direction = bit.bor(self.move.direction, bit.lshift(1, 3))
    end
    
    -- Select animation based on:
    -- 0x0001 (1) - Moving right
    -- 0x0010 (2) - Looking up
    -- 0x0100 (4) - Moving left
    -- 0x1000 (8) - Looking down
    -- 0x0011 (3) - Moving right looking up
    -- 0x0110 (6) - Moving left looking up
    -- 0x1100 (12)- Moving left looking down
    -- 0x1001 (9) - Moving right looking down
    
    
    
    -- Select animation based on movement direction
    local direction = self.move.direction
    
    
    if direction == 0 then
      if not self.move.jumping then
        self.idle()
      else
        self.jumping()
      end
      
    elseif direction == 1 or direction == 4 then
      self.running()
      
    elseif direction == 2 then
      if self.move.jumping then
        self.jump_aimUp()
      else
        self.lookingUp()
      end
      
    elseif direction == 3 or direction == 6 then
      if self.move.jumping then
        self.jump_aimDiagUp()
      else
        self.runUpDiag()
      end
      
    elseif direction == 8 then
      if self.move.jumping then
        self.jump_aimDown()
      else
        self.lookingDownDiag()
      end
      
    elseif direction == 9 or direction == 12 then
      if self.move.jumping then
        self.jump_aimDiagDown()
      else
        self.running()
      end
    end
    
  end

  function self.Move_keypressed(key)
    
    if key == "space" then
      self.move.jumping = true
    end
    if key == "lctrl" then
      self.move.crouching = true
    end
  end

  function self.grounded()
    self.move.jumping = false
  end
return self
end


return {make_movable=make_movable}