-- Player Animations

-- Create module's return table
Animation = {}

-- Load jambo's animations
local animations = require("scripts.jambo_animations")

-- Idle is default animation
local defaultAnimation = animations.idle_animation

function Animation.new()
    -- Constructor
    local self = {}
    
    -- Private variables
    local current_animation = defaultAnimation -- Select default animation

    -- Public methods:
    -- State functions
    function self.idle()
    if current_animation ~= animations.idle_animation then
      current_animation:reset()
      current_animation = animations.idle_animation
    end
    end

    function self.running()
    if current_animation ~= animations.run_animation then
      current_animation:reset()
      current_animation = animations.run_animation
    end
    end

    function self.jumping()
    if current_animation ~= animations.jump_animation then
      current_animation:reset()
      current_animation = animations.jump_animation
    end
    end

    function self.crouching()
    if current_animation ~= animations.crouch_animation then
      current_animation:reset()
      current_animation = animations.crouch_animation
    end
    end

    function self.lookingUp()
    if current_animation ~= animations.lookup_animation then
      current_animation:reset()
      current_animation = animations.lookup_animation
    end
    end

    function self.runUpDiag()
    if current_animation ~= animations.runupdiag_animation then
      current_animation:reset()
      current_animation = animations.runupdiag_animation
    end
    end

    function self.lookingDownDiag()
    if current_animation ~= animations.lookdowndiag_animation then
      current_animation:reset()
      current_animation = animations.lookdowndiag_animation
    end
    end

    function self.jump_aimDiagDown()
    if current_animation ~= animations.jumpaimdiagdown_animation then
      current_animation:reset()
      current_animation = animations.jumpaimdiagdown_animation
    end
    end

    function self.jump_aimDiagUp()
    if current_animation ~= animations.jumpaimdiagup_animation then
      current_animation:reset()
      current_animation = animations.jumpaimdiagup_animation
    end
    end

    function self.jump_aimDown()
    if current_animation ~= animations.jumpaimdown_animation then
      current_animation:reset()
      current_animation = animations.jumpaimdown_animation
    end
    end

    function self.jump_aimUp()
    if current_animation ~= animations.jumpaimup_animation then
      current_animation:reset()
      current_animation = animations.jumpaimup_animation
    end
    end

    function self.update(dt) current_animation:update(dt) end

    function self.draw(x, y, sx, sy)
        local floor = math.floor
        
        local currentTime = current_animation.currentTime
        local duration = current_animation.duration
        local quads = current_animation.quads

        local spriteNum = floor(currentTime / duration * #quads) + 1

        current_animation:draw(x, y, sx, sy, spriteNum)
        
    end
    
    return self
    
end

return Animation