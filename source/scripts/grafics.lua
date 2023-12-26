local gfx <const> = playdate.graphics

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