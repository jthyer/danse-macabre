local score = Object:extend()

function score:create()
  self.frameTimer = 0
  self.score = 0
  self.displayScore = "0:00"
  self.hiscore = 0
  self.displayHiscore = "0:00"
  
  local info = love.filesystem.getInfo( "score" )
  if info ~= nil then
    local read = love.filesystem.read( "score" )
    self.hiscore = tonumber(read)
    self.displayHiscore = self:getDisplayScore(self.hiscore)
  else
    love.filesystem.write( "score", self.hiscore)
  end
end

function score:update()
  if self.stop == nil then 
    self.frameTimer = self.frameTimer + 1
  elseif self.score > self.hiscore then
    self.hiscore = self.score
    self.displayHiscore = self:getDisplayScore(self.hiscore)
    love.filesystem.write( "score", self.hiscore )
  end
  if self.frameTimer == 60 then
    self.frameTimer = 0
    self.score = self.score + 1
    self.displayScore = self:getDisplayScore(self.score)
  end
end

function score:draw()
  love.graphics.setColor(1,0,0)
  love.graphics.printf(self.displayScore,font,0+2,420+2,640,"center")

  if self.stop == nil then
   love.graphics.setColor(1,1,1)
  else
    love.graphics.setColor(0,0,1)
    love.graphics.printf("Press Space to Restart.",font,0+2,30+2,640,"center")  
    love.graphics.printf("High Score:\n"..self.displayHiscore,font,0+2,420-80+2,640,"center")       
    love.graphics.setColor(1,1,1)
    love.graphics.printf("Press Space to Restart.",font,0,30,640,"center")  
    love.graphics.printf("High Score:\n"..self.displayHiscore,font,0,420-80,640,"center")  
    love.graphics.setColor(.7,.7,.7)
  end
  love.graphics.printf(self.displayScore,font,0,420,640,"center")
  love.graphics.setColor(1,1,1)
end

function score:getDisplayScore(s)
  return math.floor(s/60) .. ":" ..
    math.floor((s % 60)/10) .. s % 10
end

return score