local fire = Object:extend()

function fire:create()
  self.timer = 0
  self.sprite = asset.sprite["spr_fire"]
  
  self.score = objectManager.getObjectByTag("score")
  self.score.stop = true
  
  self.generator = objectManager.getObjectByTag("generator")
  self.generator.stop = true
  
  self.spaceRelease = false
  witchTime.scene = false
  kb.reset()
end

function fire:update()
  self.timer = self.timer + 1
  if self.timer % 10 == 0 then
    self.flip = self.flip * -1
  end
  
  if not love.keyboard.isDown("space") then
    self.spaceRelease = true
  end
  
  if love.keyboard.isDown("space") and self.spaceRelease then
    scene.restart()
    kb.reset()
  end
end

return fire