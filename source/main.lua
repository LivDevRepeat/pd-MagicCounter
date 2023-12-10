import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local dspl <const> = playdate.display
local geo <const> = playdate.geometry
local lifecounter = {
   {life = 40, maxlife = 10, playerID = 1},
   {life = 40, maxlife = 10, playerID = 2},
   {life = 40, maxlife = 10, playerID = 3},
   {life = 40, maxlife = 10, playerID = 4}
}

local rects ={
    playdate.geometry.rect.new(0, 20, 120, 200),
    playdate.geometry.rect.new(100, 0, 200, 100),   
    playdate.geometry.rect.new(100, 120, 200, 120),
    playdate.geometry.rect.new(280, 20, 120, 200)
}

local newfont = gfx.font.new("Marble Madness- 80pxNum")
local rectimage = gfx.image.new(120,200) 



for i = 1, #rects do  
   --gfx.drawRect(rects[i])
  -- rects[i]:inset(8, 8)
   
  --gfx.drawTextInRect(tostring(lifecounter[i].life),rects[i] ,nil,nil ,kTextAlignment.center,newfont)
end
function drawlifecounter(x,y,angle,number)
local rotate = gfx.image.new(200,101)
local rect = geo.rect.new(5, 20, 190, 100)
gfx.pushContext(rotate)
    gfx.setColor(gfx.kColorBlack)
  

    -- Dither Background
    gfx.pushContext()
        gfx.setDitherPattern(0.5, gfx.image.kDitherTypeAtkinson)
        gfx.fillRoundRect(rect,20)
    gfx.popContext()

    --Border 
    gfx.pushContext()
      gfx.setLineWidth(4)
      gfx.drawRoundRect(rect,20)
    gfx.popContext()


    gfx.drawTextInRect("Player ".. number,0,0,200,20,nil,nil ,kTextAlignment.center)
    --Text
    gfx.pushContext()
        gfx.setFont(newfont)
        rect:inset(0,10)
        gfx.drawTextInRect(tostring(lifecounter[number].life),rect,nil,nil ,kTextAlignment.center)
    gfx.popContext()
gfx.popContext()     
rotate:drawRotated(x,y,angle) 
end

function UpdateCounter()
    gfx.clear()
    drawlifecounter(200,190,0,1)
    drawlifecounter(350,120,270,2)

    drawlifecounter(200,50,180,3)
    drawlifecounter(50,120,90,4)
end
UpdateCounter()

function playdate.update() 

   if playdate.buttonIsPressed( "up" ) then
     HandleLife(3) 
   end
   if playdate.buttonIsPressed("down") then
    HandleLife(1)
   end
   if playdate.buttonIsPressed( "right" ) then
    HandleLife(2) 
  end
  if playdate.buttonIsPressed("left") then
   HandleLife(4)
  end

  --HandleLife(1)

    playdate.timer:updateTimers()
end

function HandleLife(number)
    if playdate.buttonJustPressed("a") then
        lifecounter[number].life = lifecounter[number].life + 1
        UpdateCounter()
    end

    if playdate.buttonJustPressed("b") then
        lifecounter[number].life = lifecounter[number].life -1
        if lifecounter[number].life <= 0 then
            lifecounter[number].life = 0
        end
        UpdateCounter()
    end

   

end

   
    