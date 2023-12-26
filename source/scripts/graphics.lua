-- Constants
local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")



function drawlifecounter(x, y, angle, labelText, numberText)
    local rotate = gfx.image.new(200, 101)
    local rect = geo.rect.new(5, 20, 190, 100)
    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)

        -- Dither Background
        if playerID == currentDirection then
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

        -- Text
        gfx.drawTextInRect(labelText, 0, 0, 200, 20, nil, nil, kTextAlignment.center)
        gfx.pushContext()
            gfx.setFont(newfont)
            rect:inset(0, 10)
            gfx.drawTextInRect(numberText, rect, nil, nil, kTextAlignment.center)
        gfx.popContext()
    gfx.popContext()
    rotate:drawRotated(x, y, angle)
 end


function DrawText(rect,text)
    
    gfx.pushContext()
        --gfx.setFont(newfont)
        rect:inset(0, 10)
        gfx.drawTextInRect(tostring(text), rect, nil, nil, kTextAlignment.center)
    gfx.popContext()

   gfx.drawText(text,0,0)
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