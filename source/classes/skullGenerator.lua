local skullGenerator = Object:extend()

function skullGenerator:create()
  self.timer = 80
  if math.random(2) == 1 then
    self.side = 1
  else 
    self.side = -1
  end
   
  self.level = 0
  
  self.generator = true
end

function skullGenerator:step()
  if self.scoreObj == nil then
    self.scoreObj = objectManager.getObjectByTag("score") 
  end
  
  if self.stop == nil then
    self.timer = self.timer - 1
  end
  
  if self.timer == 0 then
    local x

    if self.side == 1 then 
      x = -32 
    else 
      x = global.WINDOW_WIDTH + 32 
    end
  
    self.side = self.side * -1
    self:instanceCreate("skull",x,love.math.random(320)+64)
    
    self.level = math.floor(self.scoreObj.score/20) 
    
    if self.level > 6 then self.level = 6 end
    
    self.timer = 60 - (self.level * 5)
  end
end

return skullGenerator