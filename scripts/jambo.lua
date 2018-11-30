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
  jambo = Move.make_movable(jambo)
  
  function jambo:update(dt)
    self.Move(dt)
    
    self.update_animation(dt)
  end
  
  function jambo:keypressed(key)
    self.Move_keypressed(key)
  end
  
  function jambo:collision(object)
    self.grounded()
  end
  
  return jambo
end

Jambo.newJambo = newJambo
return Jambo