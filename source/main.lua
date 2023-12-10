import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local dspl <const> = playdate.display
local geo <const> = playdate.geometry
local lifecounter = {
   {life = 40, maxlife = 10, playerID = 1},
   {life = 40, maxlife = 10, playerID = 2},
   {life = 36, maxlife = 10, playerID = 3},
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
local rotate = gfx.image.new(190,120)
local rect = geo.rect.new(0, 20, 190, 100)
gfx.pushContext(rotate)
    gfx.setColor(gfx.kColorBlack)
    gfx.setFont(newfont)
    gfx.drawRect(rect)
    rect:inset(10,10)
    gfx.drawTextInRect(tostring(lifecounter[2].life),rect,nil,nil ,kTextAlignment.center)
gfx.popContext()
rotate:drawRotated(x,y,angle) 
end

function playdate.update() 
  
    drawlifecounter(200,60,180)
    drawlifecounter(200,180,0)
    drawlifecounter(60,120,90)
    drawlifecounter(340,120,270)

    playdate.timer:updateTimers()
end



   
    