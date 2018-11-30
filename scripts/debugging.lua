-- Debugging panel

-- Bindings
local debug_print = love.graphics.print
local isDown = love.keyboard.isDown


-- Locals
local keyPressed = ' '
local keyDown = ' '


function draw()
  debug_print("Debugging...", 100, 100)
  debug_print("Last key pressed:  " .. keyPressed, 100, 120)
end

function keypress(key)
  keyPressed = key
end

function buttonpress(button)
  keyPressed = button
end


return {draw=draw,
        keypress=keypress,
        buttonpress=buttonpress}