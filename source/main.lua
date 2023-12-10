import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local dspl <const> = playdate.display
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

local newfont = gfx.font.new("Marble Madness",50,bold) 

for i = 1, #rects do  
    gfx.drawRect(rects[i])
    rects[i]:inset(8, 8)
 --   gfx.setFont(newfont)
    gfx.drawTextInRect("Life ".. lifecounter[i].life,rects[i] ,nil,nil ,kTextAlignment.center,newfont)
end


function playdate.update() 
  
    
    playdate.timer:updateTimers()
end



   
    