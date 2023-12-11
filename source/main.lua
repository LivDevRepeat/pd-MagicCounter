import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local dspl <const> = playdate.display
local geo <const> = playdate.geometry
local lifecounter = {
   {life = 40, maxlife = 10, playerID = 3, button = "up",isSelect = false},
   {life = 40, maxlife = 10, playerID = 2, button = "right",isSelect = false},
   {life = 40, maxlife = 10, playerID = 1, button = "down", isSelect = false},
   {life = 40, maxlife = 10, playerID = 4, button = "left", isSelect = false}
}

local rects ={
    playdate.geometry.rect.new(0, 20, 120, 200),
    playdate.geometry.rect.new(100, 0, 200, 100),   
    playdate.geometry.rect.new(100, 120, 200, 120),
    playdate.geometry.rect.new(280, 20, 120, 200)
}

local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")
local rectimage = gfx.image.new(120,200) 

local operations ={
    {button = "a" ,sign = -1},
    {button = "b", sign = 1}
} 

function drawlifecounter(x,y,angle,playerID)
    local rotate = gfx.image.new(200,101)
    local rect = geo.rect.new(5, 20, 190, 100)
    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)
    

        -- Dither Background
        if(lifecounter[playerID].isSelect) then
            gfx.pushContext()
            gfx.setColor(gfx.kColorBlack)
            gfx.setDitherPattern(0.75, gfx.image.kDitherTypeDiagonalLine)
            gfx.fillRoundRect(rect,20)
            gfx.popContext()
        end

     
    
        --Border 
        gfx.pushContext()
        gfx.setLineWidth(4)
        gfx.drawRoundRect(rect,20)
        gfx.popContext()


        gfx.drawTextInRect("Player ".. playerID,0,0,200,20,nil,nil ,kTextAlignment.center)
        --Text
        gfx.pushContext()
            gfx.setFont(newfont)
            rect:inset(0,10)
            gfx.drawTextInRect(tostring(lifecounter[playerID].life),rect,nil,nil ,kTextAlignment.center)
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

    for i , player in pairs(lifecounter) do
        if playdate.buttonIsPressed(player.button) then
            lifecounter[player.playerID].isSelect = true 
            UpdateCounter() 
            for i, operation in pairs(operations) do
                if playdate.buttonJustPressed(operation.button) then
                    ChangeLife(operation.sign,player.playerID) 
                end
            end   
        end

        if playdate.buttonJustReleased(player.button)  then
            lifecounter[player.playerID].isSelect = false
            UpdateCounter()
        end
       
    end

end


function ChangeLife(sign,playerID)
    lifecounter[playerID].life = lifecounter[playerID].life + 1 * sign
    if lifecounter[playerID].life <= 0 then
        lifecounter[playerID].life = 0
    end
    UpdateCounter()
end

   
    