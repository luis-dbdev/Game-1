-- dust animation.lua

local newImage = love.graphics.newImage
local Media = require("scripts.media")

-- Run dust size
local run_dust_width = 21.6
local run_dust_height = 18

local run_dust = "run_dust.png"
local path = "res/gfx/SpriteSheets/player/"
local run_dust = newImage(path .. run_dust)
run_dust = Media.newAnimation(run_dust, run_dust_width, run_dust_height, 1, true)