local x = 100
local y = 200
local speed = 5
local scale = 3
local sx = scale
local sy = scale
local file = "res/gfx/SpriteSheets/player/john_idle.png"
local run = "res/gfx/SpriteSheets/player/john_run.png"


function love.load()
    animation = newAnimation(love.graphics.newImage("res/gfx/SpriteSheets/player/john_idle.png"), 26, 22, 1)
end
 
function love.update(dt)
    animation.currentTime = animation.currentTime + dt
    if animation.currentTime >= animation.duration then
        animation.currentTime = animation.currentTime - animation.duration
    end
    
    if love.keyboard.isDown('left') then
      x = x - speed
    end
    if love.keyboard.isDown('right') then
      x = x + speed
    end
    
end
 
function love.draw()
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    --love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], 0, 0, 0, 4)
    animation.draw(x, y, sx, sy, spriteNum)
end


function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
  if key == 'left' then
    sx = -scale
    animation = newAnimation(love.graphics.newImage(run), 26, 22, 1)
  end
  if key == 'right' then
    sx = scale
    animation = newAnimation(love.graphics.newImage(run), 26, 22, 1)
  end
  print (key)
end

function love.keyreleased(key)
  animation = newAnimation(love.graphics.newImage("res/gfx/SpriteSheets/player/john_idle.png"), 26, 22, 1)
end

 
function newAnimation(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0
    
    function draw(x, y, sx, sy, spriteNum)
      love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], x, y, 0, sx, sy)
    end
    
    animation.draw = draw
     
    return animation
end