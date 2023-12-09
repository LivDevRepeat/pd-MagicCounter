import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"


local gfx <const> = playdate.graphics
local lifecounter = {
   {life = 0, maxlife = 10, playerID = 1},
   {life = 0, maxlife = 10, playerID = 2},
   {life = 0, maxlife = 10, playerID = 3},
   {life = 0, maxlife = 10, playerID = 4}
}



local gfx = playdate.graphics
local gridview = playdate.ui.gridview.new(44, 44)
--gridview.backgroundImage = playdate.graphics.nineSlice.new('shadowbox', 4, 4, 45, 45)
gridview:setNumberOfColumns(8)
gridview:setNumberOfRows(2, 4, 3, 5) -- number of sections is set automatically
gridview:setSectionHeaderHeight(24)
gridview:setContentInset(1, 4, 1, 4)
gridview:setCellPadding(4, 4, 4, 4)
gridview.changeRowOnColumnWrap = false

function gridview:drawCell(section, row, column, selected, x, y, width, height)
    if selected then
        gfx.drawCircleInRect(x-2, y-2, width+4, height+4, 3)
    else
        gfx.drawCircleInRect(x+4, y+4, width-8, height-8, 0)
    end
    local cellText = ""..row.."-"..column
    gfx.drawTextInRect(cellText, x, y+14, width, 20, nil, nil, kTextAlignment.center)
end

function gridview:drawSectionHeader(section, x, y, width, height)
    gfx.drawText("*SECTION ".. section .. "*", x + 10, y + 8)
end



local menuOptions = {"Sword", "Shield", "Arrow", "Sling", "Stone", "Longbow", "MorningStar", "Armour", "Dagger", "Rapier", "Skeggox", "War Hammer", "Battering Ram", "Catapult"}
local listview = playdate.ui.gridview.new(0, 10)
listview.backgroundImage = playdate.graphics.nineSlice.new('MiniNine(1)', 8, 8,10,10)
listview:setNumberOfRows(#menuOptions)
listview:setCellPadding(0, 0, 13, 10)
listview:setContentInset(24, 24, 13, 11)

function listview:drawCell(section, row, column, selected, x, y, width, height)
        if selected then
                gfx.fillRoundRect(x, y, width, 20, 4)
              --  gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
        else
                gfx.drawRoundRect(x, y, width, 20, 4)
               -- gfx.setImageDrawMode(gfx.kDrawModeCopy)
        end
        gfx.drawTextInRect(menuOptions[row], x, y+5, width, height, nil, "...", kTextAlignment.center)
end





function playdate.update() 
    gridview:drawInRect(20, 20, 180, 200)
    listview:drawInRect(220, 20, 160, 210)
    playdate.timer:updateTimers()
end



   
    