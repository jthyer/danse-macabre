--[[
A scene is basically a room from Game Maker. It reads tile and object data
from my Ogmo scene files in the "scene" folder into a big table, then draws
that data on the screen. 

Let's start with just the tiles and bg images.
--]]

local scene = {}
local sceneData = require("core.sceneData")
local bg = require("core.bg")
local sceneNum = 1

function scene.load(s)
  sceneNum = s
  bg.load(sceneData[sceneNum].tileData)
  objectManager.load(sceneData[sceneNum].objectData)
end

function scene.update()
  objectManager.update()
end

function scene.draw()
  bg.draw()
  objectManager.draw()
end

function scene.restart()
  scene.load(sceneNum)
end

return scene