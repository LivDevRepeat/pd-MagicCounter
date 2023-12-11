import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local dspl <const> = playdate.display
local geo <const> = playdate.geometry
local lifecounter = {
    {life = 40, maxlife = 10, playerID = 1, },
   {life = 40, maxlife = 10, playerID = 2,},
   {life = 40, maxlife = 10, playerID = 3, },
   {life = 40, maxlife = 10, playerID = 4, }
}

local rects ={
    playdate.geometry.rect.new(0, 20, 120, 200),
    playdate.geometry.rect.new(100, 0, 200, 100),   
    playdate.geometry.rect.new(100, 120, 200, 120),
    playdate.geometry.rect.new(280, 20, 120, 200)
}

local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")
local rectimage = gfx.image.new(120,200) 

local a_sign = -1
local b_sign = 1
local selectedPlayerID = 0
local currentView = 1

function drawlifecounter(x,y,angle,playerID)
    local rotate = gfx.image.new(200,101)
    local rect = geo.rect.new(5, 20, 190, 100)
    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)
    

        -- Dither Background
        if(lifecounter[playerID].playerID == selectedPlayerID) then
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

local tableType = {
        {
        draw = function()
                drawlifecounter(200,190,0,1)
                drawlifecounter(350,120,270,2)
                drawlifecounter(200,50,180,3)
                drawlifecounter(50,120,90,4)
            end,
        title="4 Players Round",
        },
        {
        draw = function()
                drawlifecounter(100,190,0,1)
                drawlifecounter(300,190,0,2)
                drawlifecounter(300,50,180,3)
                drawlifecounter(100,50,180,4)         
            end,
        title="4 Players Square",

        }
 
 }

function UpdateCounter()
    gfx.clear()
    tableType[currentView].draw()
end




  




UpdateCounter() 


local changeInputs = {
    AButtonDown = function()
       ChangeLife(a_sign,selectedPlayerID)
    end,
    BButtonDown = function()
        ChangeLife(b_sign,selectedPlayerID)
    end,

    leftButtonUp = function()
        reset()
    end,
    rightButtonUp = function()
        reset()
    end,
    upButtonUp = function()
        reset()
    end,
    downButtonUp = function()
        reset()
    end,

}

local myInputHandlers = {

    rightButtonDown = function()
        editLife(2)
    end,
   
    upButtonDown = function()
        editLife(3)
    end,
   
    downButtonDown = function()
        editLife(1)
    end,

    leftButtonDown = function()
        editLife(4)
    end,

    AButtonDown = function()
        cycleView()
    end,

}

function cycleView()
    currentView = currentView + 1
    if currentView > #tableType then
        currentView = 1
    end
    
end

function reset()
    playdate.inputHandlers.pop()
    selectedPlayerID = 0
end

function editLife(playerID)
    selectedPlayerID = playerID
    playdate.inputHandlers.push(changeInputs)   
end





playdate.inputHandlers.push(myInputHandlers)

function playdate.update() 

    UpdateCounter()

end




function ChangeLife(sign,playerID)
    lifecounter[playerID].life = lifecounter[playerID].life + 1 * sign
    if lifecounter[playerID].life <= 0 then
        lifecounter[playerID].life = 0
    end
    UpdateCounter()
end

   
    