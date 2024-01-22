
local gfx <const> = playdate.graphics

local menuOptions = { 1,2,3,4}
listview = playdate.ui.gridview.new(50,50)
listview:setNumberOfColumns(#menuOptions)
listview:setNumberOfRows(1)
listview:setCellPadding(0, 0, 13, 10)
listview:setContentInset(24, 24, 13, 11)



function listview:drawCell(section, row, column, selected, x, y, width, height)
     
    if selected then
        gfx.fillRoundRect(x, y, width, 20, 4)
        playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)
        gfx.drawTextInRect(tostring(menuOptions[column]), x, y+2, width, height, nil, "...", kTextAlignment.center)

    else
        playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillBlack)
        gfx.drawRoundRect(x, y, width, 20, 4)
        gfx.drawTextInRect(tostring(menuOptions[column]), x, y+2, width, height, nil, "...", kTextAlignment.center)
    end
       
end
function mainUpdate()
    gfx.clear()
    listview:drawInRect(0, 0, 400, 240)
    playdate.timer:updateTimers()
end

vc.AddView("main", function() end,function()mainUpdate() end)