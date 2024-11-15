global = {}
global.WINDOW_WIDTH = 640
global.WINDOW_HEIGHT = 480
global.TILE_DIMENSION = 16

local gameTitle = "Danse Macabre"
local fontPath = "assets/fonts/BetterComicSans.ttf"
local fontSize = 32

Object = require "core.object" 
objectManager = require "core.objectManager"
asset = require "core.asset"
scene = require "core.scene"
kb = require "core.kb"
util = require "core.util"
witchTime = require "source.witchTime"

local tickPeriod = 1/60
local accumulator = 0.0

local gameStart = false
local gameActive = false

function love.load()
  love.graphics.setDefaultFilter("linear", "linear", 1)
  love.window.setTitle(gameTitle)
  love.window.setVSync( 1 )  
  font = love.graphics.newFont(fontPath,fontSize,"mono")

  local song = love.audio.newSource("assets/sounds/macabre.ogg", "stream")
  song:setLooping(true)
  song:play()

  scene.load(1)
end

function love.update(dt)
  --if gameActive == false 
   -- if love.keyboard.isDown("space")
  
  local delta = dt
  
  if witchTime.active == true then
    delta = delta / 2 -- debugging -- actually let's make it a mechanic lol
  end 

  accumulator = accumulator + delta
  if accumulator >= tickPeriod then
    kb.update()
    scene.update()
    witchTime.update()
    accumulator = accumulator - tickPeriod
  end  
end

function love.draw()
  scene.draw()
  witchTime.draw()
end

function love.keypressed(key, scancode)
   if key == "escape" then
      love.event.quit()
   end
end