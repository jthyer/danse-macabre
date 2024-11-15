local SPEED = 3;

local player = Object:extend()

function player:create()
  self.sprite = asset.sprite["spr_player"]
  self.width = 32
  self.height = 32
  self.mask.width = 8
  self.mask.height = 8
  self.mask.x_offset = 12
  self.mask.y_offset = 12

  witchTime.scene = true
  witchTime.meter = 60
  witchTime.meterSize = util.round(witchTime.meter * (16/3))
  self.player = true
end

function player:step()
  self:readMovement()
  self:checkEnemyCollision()
end

function player:readMovement()
  local old_x = self.x
  local old_y = self.y
  local hspeed, vspeed, collide
  
  -- read keyboard input
  if kb.left() then
    hspeed = -SPEED    
  elseif kb.right() then
    hspeed = SPEED  
  else
    hspeed = 0
  end

  if kb.up() then 
    vspeed = -SPEED 
  elseif kb.down() then
    vspeed = SPEED 
  else
    vspeed = 0
  end
  
  -- set speed
  if hspeed ~= 0 and vspeed ~= 0 then
    hspeed = hspeed * .71
    vspeed = vspeed * .71
  end
  
  self:move(hspeed,0)
  
  collide = self:checkCollision("solid")
  if (collide) then
    self:move(old_x-self.x,0)
    self:moveToContactHor(collide)
  end
  
  self:move(0,vspeed)
  
  collide = self:checkCollision("solid")
  if (collide) then
    self:move(0,old_y-self.y)
    self:moveToContactVert(collide)
  end
end

function player:checkEnemyCollision()
  local collide = self:checkCollision("enemy")
  
  if (collide) then
    self:instanceCreate("fire",self.x,self.y)
    self:instanceDestroy()
  end
end

function player:draw()
  love.graphics.draw(self.sprite,self.x+self.origin_offset,self.y+self.origin_offset,self.rotation,self.flip,1,self.origin_offset,self.origin_offset) 
end

return player