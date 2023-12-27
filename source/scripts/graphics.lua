-- Constants
local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")



function drawlifecounter(x, y, angle,scale, labelText, lifecounter,commanderdamage)
   
    -- Images
    local rotate = gfx.image.new(200, 121)
    local mainImage = gfx.image.new(190, 100)
    local rect = geo.rect.new(0, 0, 190, 100)
    local commanderdamage = { 20,20,20}

    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)

        -- Dither Background
        gfx.pushContext(mainImage)
            gfx.pushContext()
                gfx.setColor(gfx.kColorBlack)
                gfx.setDitherPattern(0.75, gfx.image.kDitherTypeDiagonalLine)
              --  gfx.fillRect(rect)
            gfx.popContext()
        

            -- Border
            gfx.pushContext()
                gfx.setStrokeLocation(gfx.kStrokeInside)
                gfx.setLineWidth(4)
               -- gfx.drawRect(rect)
            gfx.popContext()

            -- Text
            local twoCharWidth = newfont:getTextWidth("00")
            local textWidth = newfont:getTextWidth(tostring(lifecounter))

            local scale = twoCharWidth/textWidth
            local reverseScale = math.max(1, textWidth/twoCharWidth)
            print(scale, reverseScale)
            local textImage = gfx.image.new(190*reverseScale, 80)
            local textRect = geo.rect.new(0,0, 190*reverseScale, 80)
            gfx.drawRect(rect)
            local center = rect:centerPoint()
          
            gfx.pushContext(textImage)
               
                gfx.setFont(newfont)
                gfx.drawTextInRect(tostring(lifecounter),textRect, nil, nil, kTextAlignment.center)
                 
            gfx.popContext()

            textImage = textImage:scaledImage(scale)
            textImage:drawCentered(center.x, center.y)
      
        gfx.popContext()

      

        mainImage:draw(5,30)
        -- Text
       -- gfx.drawTextInRect(labelText, 0, 0, 200, 20, nil, nil, kTextAlignment.center)
 
       -- Bubbles 

        local bubbleWidth = 45
        local bubbleHeight = 30
        local bubble =  gfx.image.new(190,bubbleHeight )
        gfx.pushContext(bubble)
            for i = 1, #commanderdamage do
                local bubbleRect = geo.rect.new(5+(bubbleWidth*(i-1)), 5,bubbleWidth, bubbleHeight)
                gfx.pushContext()
                gfx.setColor(gfx.kColorBlack)
                gfx.setLineWidth(2)
                gfx.drawRect(bubbleRect)
                bubbleRect:inset(0, 3)
                gfx.drawTextInRect(tostring(commanderdamage[i]), bubbleRect, nil, nil, kTextAlignment.center)
                gfx.popContext()
            end
        gfx.popContext()

        bubble:draw(5,0)
     

    gfx.popContext()

   
   -- rotate = rotate:scaledImage(scale)
   rotate:drawRotated(x, y, angle)
   -- rotate = rotate:rotatedImage(angle)
   -- rotate:draw(x, y)     
 end


function DrawText(text)

    local textImage = gfx.image.new(300, 120)
    local textRect = geo.rect.new(0,0, 280, 100)
    gfx.pushContext(textImage)
        gfx.setFont(newfont)
        gfx.drawTextInRect(tostring(text),textRect, nil, nil, kTextAlignment.center)
        gfx.setStrokeLocation(gfx.kStrokeInside)
        gfx.setLineWidth(10)
        gfx.drawRect(textRect)
    gfx.popContext()
  
    textImage:draw(0,10)
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