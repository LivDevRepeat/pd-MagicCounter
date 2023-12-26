local gfx <const> = playdate.graphics
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")
local tableType = {
    -- Table type 1: 4 Players Round
    {
        draw = function()
            drawlifecounter(200, 190, 0, 1)
            drawlifecounter(350, 120, 270, 2)
            drawlifecounter(200, 50, 180, 3)
            drawlifecounter(50, 120, 90, 4)
        end,
        title = "4 Players Round",
    },
    -- Table type 2: 4 Players Square
    {
        draw = function()
            drawlifecounter(100, 190, 0, 1)
            drawlifecounter(300, 190, 0, 2)
            drawlifecounter(300, 50, 180, 3)
            drawlifecounter(100, 50, 180, 4)
        end,
        title = "4 Players Square",
    }
}
function drawlifecounter(x, y, angle, lifecounter)
    local rotate = gfx.image.new(200, 101)
    local rect = geo.rect.new(5, 20, 190, 100)
    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)

        -- Dither Background
        if button == currentDirection then
            gfx.pushContext()
            gfx.setColor(gfx.kColorBlack)
            gfx.setDitherPattern(0.75, gfx.image.kDitherTypeDiagonalLine)
            gfx.fillRoundRect(rect, 20)
            gfx.popContext()
        end

        -- Border
        gfx.pushContext()
        gfx.setLineWidth(4)
        gfx.drawRoundRect(rect, 20)
        gfx.popContext()

        if button == 2 then
            rotate:clear(playdate.graphics.kColorWhite)
            print("clear")
        end


        -- Text
        gfx.drawTextInRect(lifecounter.label, 0, 0, 200, 20, nil, nil, kTextAlignment.center)
       DrawText(rect,lifecounter.life)
    gfx.popContext()


return rotate, rect 
    end


function DrawText(rect,text)
    
    gfx.pushContext()
        gfx.setFont(newfont)
        rect:inset(0, 10)
        gfx.drawTextInRect(tostring(text), rect, nil, nil, kTextAlignment.center)
    gfx.popContext()
end


function cycleView()
    currentView = currentView + 1
    if currentView > #tableType then
        currentView = 1
    end
end

function cylcelMode()
    -- Logic for cycling modes (currently empty)
end