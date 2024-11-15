local witchTime = {}

witchTime.meter = 60
witchTime.meterSize = 60 * (16/3)
witchTime.active = false
witchTime.scene = false

function witchTime.update()
  if witchTime.scene == false then
    witchTime.meter = 0
    witchTime.meterSize = 0
    witchTime.active = false
    return
  end
  
  witchTime.active = false
  if kb.spaceHeld() then
    if witchTime.meter > 0 then 
      witchTime.meter = witchTime.meter - 1
      witchTime.meterSize = util.round(witchTime.meter * (16/3))
      if witchTime.meterSize < 1 then
        witchTime.meterSize = 0
      end
      witchTime.active = true
    else
      kb.reset()
    end
  elseif witchTime.meter < 60 then
    witchTime.meter = witchTime.meter + 0.1
    witchTime.meterSize = util.round(witchTime.meter * (16/3))
  end
end

function witchTime.draw()
  love.graphics.setColor(0,0,0,1)
  love.graphics.rectangle("fill",0,0,640,10)
  love.graphics.setColor(.8,.8,.8,1)
  love.graphics.rectangle("fill",320-witchTime.meterSize,0,witchTime.meterSize,10)
  love.graphics.rectangle("fill",320,0,witchTime.meterSize,10)
  if (witchTime.active) then 
    love.graphics.setColor(0,0,1,.1)
    love.graphics.rectangle("fill",0,0,640,480)
  end
  love.graphics.setColor(1,1,1,1)
end

return witchTime