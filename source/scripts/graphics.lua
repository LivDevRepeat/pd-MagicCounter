-- Constants
local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")
local twoCharWidth = newfont:getTextWidth("00")



function drawlifecounter(posconfig,labelText, lifecounter,commanderdamage,isSelected, isHighlighted,selectedCommander )
   
    -- Images
    local rotate = gfx.image.new(200, 121)
    local mainImage = gfx.image.new(190, 100)
    local rect = geo.rect.new(0, 0, 190, 100)
   -- local commanderdamage = { 20,20,20}

    gfx.pushContext(rotate)

        
        gfx.setColor(gfx.kColorBlack)
        gfx.pushContext(mainImage)

            -- Text
            local textWidth = newfont:getTextWidth(tostring(lifecounter))
            local scale = math.min(1,twoCharWidth/textWidth)
            local reverseScale = math.max(1,textWidth/twoCharWidth)
  
            local textImage = gfx.image.new(190*reverseScale, 80)
            local textRect = geo.rect.new(0,0, 190*reverseScale, 80)
            local mainImageRound = 0
            
            -- Clear Draw    
            gfx.pushContext()
                gfx.setColor(gfx.kColorWhite)
                gfx.fillRect(0,0,190,100)
            gfx.popContext()

            -- Dither Background if selected
            if( isSelected == true) then 
            gfx.pushContext()
                gfx.setStrokeLocation(gfx.kStrokeInside)
                gfx.setColor(gfx.kColorBlack)
                gfx.setDitherPattern(0.75, gfx.image.kDitherTypeDiagonalLine)
                gfx.fillRoundRect(rect,mainImageRound)
            gfx.popContext()
            end
            
            -- Text
            gfx.pushContext(textImage)
                gfx.setFont(newfont)
                gfx.drawTextInRect(tostring(lifecounter),textRect, nil, nil, kTextAlignment.center)  
            gfx.popContext()

            local center = rect:centerPoint()
            textImage = textImage:scaledImage(scale)
            textImage:drawCentered(center.x, center.y)


            -- Border
            gfx.pushContext()
                if( isSelected == false ) then
                    gfx.setDitherPattern(0.75, gfx.image.kDitherTypeDiagonalLine)
                    gfx.setLineWidth(4)
                else
                    gfx.setLineWidth(6)
                end
                gfx.setStrokeLocation(gfx.kStrokeInside)
               
                gfx.drawRoundRect(rect,mainImageRound)
            gfx.popContext()
      
        gfx.popContext()

   
        -- Text
       -- gfx.drawTextInRect(labelText, 0, 0, 200, 20, nil, nil, kTextAlignment.center)
 
       -- Bubbles 

        local bubbleWidth = 60
        local bubbleHeight = 28
        local bubbleOffset = 8
        local bubbleInset = 4.0
        local bubble =  gfx.image.new(190,bubbleHeight)

        gfx.pushContext(bubble)
            for i = 1, #commanderdamage do
               
                local bubbleRect = geo.rect.new(5+(bubbleWidth*(i-1)), bubbleOffset,bubbleWidth, bubbleHeight)
                gfx.setLineWidth(2)
                if( commanderdamage[i].damage > 0) then
                gfx.pushContext()
                    
                    gfx.setStrokeLocation(gfx.kStrokeOutside)
                    gfx.setColor(gfx.kColorWhite)
                    gfx.fillRect(bubbleRect)
                    gfx.drawRoundRect(bubbleRect,5)
                gfx.popContext()

                

                gfx.pushContext()
                
                    gfx.setStrokeLocation(gfx.kStrokeInside)
                    gfx.setDitherPattern(0.8, gfx.image.kDitherTypeDiagonalLine)
                    gfx.drawRoundRect(bubbleRect,5)
                    bubbleRect:inset(0, bubbleInset)
                    gfx.drawTextInRect(tostring(commanderdamage[i].damage), bubbleRect, nil, nil, kTextAlignment.center)
                
                    gfx.popContext()
                end
            end
        gfx.popContext()
        bubble:draw(5,0)

        gfx.pushContext(bubble)
        for i = 1, #commanderdamage do
            if( i == selectedCommander) then
                gfx.setColor(gfx.kColorBlack)
         
           
            local bubbleRect = geo.rect.new(5+(bubbleWidth*(i-1)), 5,bubbleWidth, bubbleHeight)

            gfx.pushContext()
                gfx.setLineWidth(2)
                gfx.setStrokeLocation(gfx.kStrokeInside)
                gfx.drawRoundRect(bubbleRect,5)
                bubbleRect:inset(0, 5)
                gfx.drawTextInRect(tostring(commanderdamage[i].damage), bubbleRect, nil, nil, kTextAlignment.center)
               
            gfx.popContext()
        end
        end
    gfx.popContext()
    bubble:draw(5,0)
   

    mainImage:draw(5,30)

    gfx.popContext()

   
   rotate:drawRotated(posconfig.x, posconfig.y, posconfig.angle, posconfig.scale)  
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