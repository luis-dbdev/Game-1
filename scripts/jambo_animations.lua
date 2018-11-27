-- Jambo animations

-- Performance bindings
local newImage                = love.graphics.newImage

-- Imports
local Media                   = require("scripts.media")

-- Sprite geometry
local sprite_width = 26
local sprite_height = 22

-- Resources path file
local path                    = "res/gfx/SpriteSheets/player/"

-- Animation spritesheets
local idle                    = "john_idle_ng.png"
local run                     = "john_run_ng.png"
local crouch                  = "john_crouch_ng.png"
local jump                    = "john_jump_ng.png"
local looking_up              = "john_stand_looking_up.png"
local running_updiag          = "john_run_up_diag.png"
local looking_downdiag        = "john_stand_looking_down_diag.png"
local jump_aimdiagdown        = "john_jump_ng_aimdiagdown.png"
local jump_aimdiagup          = "john_jump_ng_aimdiagup.png"
local jump_aimdown            = "john_jump_ng_aimdown.png"
local jump_aimup              = "john_jump_ng_aimup.png"


-- Load images
local jambo_idle              = newImage(path .. idle)
local jambo_run               = newImage(path .. run)
local jambo_crouch            = newImage(path .. crouch)
local jambo_jump              = newImage(path .. jump)
local jambo_lookup            = newImage(path .. looking_up)
local jambo_runupdiag         = newImage(path .. running_updiag)
local jambo_lookdowndiag      = newImage(path .. looking_downdiag)
local jambo_jumpaimdiagdown   = newImage(path .. jump_aimdiagdown)
local jambo_jumpaimdiagup     = newImage(path .. jump_aimdiagup)
local jambo_jumpaimdown       = newImage(path .. jump_aimdown)
local jambo_jumpaimup         = newImage(path .. jump_aimup)


-- Animations
return {
idle_animation            = Media.newAnimation(jambo_idle,            sprite_width, sprite_height, 1,   false),
run_animation             = Media.newAnimation(jambo_run,             sprite_width, sprite_height, 1,   false),
crouch_animation          = Media.newAnimation(jambo_crouch,          sprite_width, sprite_height, 0.1, true),
jump_animation            = Media.newAnimation(jambo_jump,            sprite_width, sprite_height, 0.8, true),
lookup_animation          = Media.newAnimation(jambo_lookup,          sprite_width, sprite_height, 1,   false),
runupdiag_animation       = Media.newAnimation(jambo_runupdiag,       sprite_width, sprite_height, 1,   false),
lookdowndiag_animation    = Media.newAnimation(jambo_lookdowndiag,    sprite_width, sprite_height, 1,   false),
jumpaimdiagdown_animation = Media.newAnimation(jambo_jumpaimdiagdown, sprite_width, 26,            1,   true), -- Non-standard height
jumpaimdiagup_animation   = Media.newAnimation(jambo_jumpaimdiagup,   sprite_width, sprite_height, 1,   true),
jumpaimdown_animation     = Media.newAnimation(jambo_jumpaimdown,     sprite_width, 26,            0.5, true), -- Non-standard height
jumpaimup_animation       = Media.newAnimation(jambo_jumpaimup,       sprite_width, 26,            1,   true), -- Non-standard height
}