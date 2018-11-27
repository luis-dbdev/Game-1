-- movement.lua

-- Performance bindings
local print = print
local bit = bit
local table = table
local ipairs = ipairs

-- Return table
move = {}
move.direction = 0
move.buffer = {}
move.jumping = false

-- Script global locals
local speedX          = 0 -- Abstracted away from main.lua
local speedY          = 0 -- Abstracted away from main.lua
local gravity         = 1800 -- Self explanatory
local hAcc            = 5000 -- Horizontal acceleration (for moving)
local vAcc            = 7000-- Vertical acceleration (for jumping)

-- Update function
function move:update(dt)
  move.direction = 0
  if love.keyboard.isDown('right') then -- 0x0001
    self.direction = 1
  end
  if love.keyboard.isDown('up') then -- 0x0010
    self.direction = bit.bor(move.direction, bit.lshift(1,1))
  end
  if love.keyboard.isDown('left') then -- 0x0100
    self.direction = bit.bor(move.direction, bit.lshift(1,2))
  end
  if love.keyboard.isDown('down') then -- 0x1000
    self.direction = bit.bor(move.direction, bit.lshift(1, 3))
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
  
end

function move:keypressed(key)
  table.insert(self.buffer, key)
  
  if table.getn(self.buffer) > 2 then
    table.remove(self.buffer, 1)
  end
  if key == "space" then
    self.jumping = true
  end
  if key == "lctrl" then
    self.crouching = true
  end
end

function move:grounded()
  self.jumping = false
end


return move