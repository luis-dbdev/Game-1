local pairs, ipairs             = pairs, ipairs
local table, math               = table, math
local tostring                  = tostring
local next                      = next


local Jambo = require("scripts.jambo")
local player1 = Jambo.newJambo()

-- Debugging
local debug = require("scripts.debugging")


local x = 10
local y = 200
local speed = 500
local scale = 5
local jambo_width = 26
local jambo_height = 22
local running = false
local sx = scale
local sy = scale


local gravity = 1800
local jump = 20
local speedY = 0
local speedX = 0
local jumping = false
local double_jump = false
local friction = 0.09
local crouching = false
local button_print = ' '
local debug_string = 'Debugging...'
local debugging = true
local t = 0
local acceleration = 5000




-- Create a buffer for codes
local keyBuffer = {}
local debug_entered = 0
local looking_up = false

--[[ TODO: 
** Add key/button combination (to access debugging or cheats)
** Create debugging environment
** Give more meaningful names to variables
** Look into creating gamepad mappings
** Make jambo look different directions
** Fix jumping and crouching animations
** Add world physics and collisions
** Create player table
** Add bullets
** Abstract away the animation portion of the code
** Create maps
** Animate shooting and enemies
** Add sound to animations
** Add start menu
** Add enemy AI
** Add documentation
** Comment out code
** Select resolution
** Make fullscreen and scale dimensions and speeds
--]] 


-------------------------------------------------------------------
-------------------------------------------------------------------
-- LOAD FUNCTION --------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.load()
  
  -- Set the display
  love.window.setMode(1440,810)
  
  -- Get joysticks
  joysticks = love.joystick.getJoysticks()
  
  
  

end
-------------------------------------------------------------------
-------------------------------------------------------------------
-- UPDATE CALLBACK ------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.update(dt)
  
  -- Move all objects
  -- Check for collisions
  -- Update stats
  -- Remove objects
  
  
  -- Update player animation
  player1:update(dt)


  
  -- Add gravity
  speedY = speedY + gravity*dt
  
  
  
  -- Move player based on keyboard
  if love.keyboard.isDown('left') then
    speedX = speedX - acceleration*dt
  end
  if love.keyboard.isDown('right') then
    speedX = speedX + acceleration*dt
  end
  if love.keyboard.isDown('space') then
    --y = y - speed
  end
  
  
  -- If the player is using a controller
  -- Must add player table
  for i, joystick in ipairs(joysticks) do
    --joystick = joysticks[1]
    if joystick:isGamepadDown('dpleft') then
      speedX = speedX - 5000*dt
    end
    if joystick:isGamepadDown('dpright') then
      speedX = speedX + 5000*dt
    end
    if joystick:isGamepadDown('a') then
      --
    end
    if joystick:isGamepadDown('rightshoulder') then
      -- Shooting
    end
  end
    
    
    
  -- Make player turn when changing directions
  if speedX > 0 and not running then
    running = true
    if sx < 0 then
      sx = scale
      x = x - jambo_width*scale
    end
  end
  if speedX < 0 and not running then
    running = true
    if sx > 0 then
      sx = -scale
      x = x + jambo_width*scale
    end
  end
      
   
  -- Change running state (allowing to slide while idle)
  if math.abs(speedX) < 100 then
    running = false
  end 
  -- Limit player's speed
  if math.abs(speedY) > 1000 then
    speedY = 1000 * speedY / math.abs(speedY)
  end
  if math.abs(speedX) > speed then
    speedX = speed * speedX/math.abs(speedX)
  end
  if math.abs(speedX) < 20 then
    speedX = 0
  end
  
  -- Update positions
  y = y + speedY*dt
  x = x + speedX*dt
  
  -------------------------------------------
  -- GROUND COLLISION (NEEDS MAJOR WORK) ----
  -------------------------------------------
  -- Must introduce tables that hold the   --
  -- positions of all ground objects to    --
  -- detect collision.                     --
  -------------------------------------------
  if y >= 780-jambo_height*scale then
    y = 780-jambo_height*scale
    speedY = 0
    jumping, double_jump = false
    player1:collision("ground")
    
    -- Friction
    if speedX ~= 0 then
      speedX = speedX * (1 - friction)
    end
  end
end
 
 
 
-------------------------------------------------------------------
-------------------------------------------------------------------
-- DRAW CALLBACK --------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.draw()
  player1.draw(x, y, sx, sy)
  
  -- Debugging
  if debugging then
    debug.draw()
  end
end


-------------------------------------------------------------------
-------------------------------------------------------------------
-- KEYPRESS CALLBACK ----------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.keypressed(key)
  player1:keypressed(key)
  
  -- debugging
  if debugging then
    debug.keypress(key)
  end
  
  if key == 'escape' then
    love.event.quit()
  end
  
  if key == 'left' then
    if sx > 0 then
      sx = -scale
      x = x + jambo_width*scale
    end
  end
  
  if key == 'right' then
    if sx < 0 then
      sx = scale
      x = x - jambo_width*scale
    end
  end
  
  if key == 'space' then
    if not double_jump then
      if jumping then
        double_jump = true
      end
      speedY = speedY - 700
      jumping = true
    end
  end
  
end
-------------------------------------------------------------------
-------------------------------------------------------------------
-- GAMEPADPRESS CALLBACK ------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.gamepadpressed(joystick, button)
  
  -- Debugging
  if debugging then
    debug.buttonpress(button)
  end
  
  
  -- Check for codes
  local debug_code = {"y", "a","rightshoulder","dpup","dpdown"}

  
  for i, key in ipairs(keyBuffer) do
    if key ~= debug_code[i] then 
      debug_entered = 0
      break
    end
    debug_entered = debug_entered + 1
  end
  
  debug_string = debug_string .. " " .. tostring(debug_entered)
  
  if debug_entered == 5 then
    if not debugging then
      debugging = true
    else
      debugging = false
    end
  end

  button_print = button
  if button == 'dpleft' then
    if sx > 0 then
      sx = -scale
      x = x + jambo_width*scale
    end
  end
  if button == 'dpright' then
    if sx < 0 then
      sx = scale
      x = x - jambo_width*scale
    end
  end
  if button == 'a' then
    if not double_jump then
      if jumping then
        double_jump = true
      end
      speedY = speedY - 700
      jumping = true
    end
  end
  if button == 'rightshoulder' then
  end
  if button == 'leftshoulder' then
  end
  if button == 'y' then
  end
  
  
end
-------------------------------------------------------------------
-------------------------------------------------------------------
-- KEYRELEASE CALLBACK --------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.keyreleased(key)
  running = false
end
-------------------------------------------------------------------
-------------------------------------------------------------------
-- GAMEPADRELEASE CALLBACK ----------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
function love.gamepadreleased(joystick, button)
  running = false
end
