-- Imports
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"

-- Constants
local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry


-- Global Variables

local currentDirection = 0
local currentView = 2
local a_sign = -1
local b_sign = 1


-- UI setup
playdate.setAutoLockDisabled(true)


-- System Menu
local menu = playdate.getSystemMenu()
menu:addMenuItem("New Game", function() Reset() end)

menu:addOptionsMenuItem("Player", {1,2,3,4}, 1, function(value)
    print(value)
   end
   )

import "scripts/data"
import "scripts/graphics"
import "scripts/views"


-- PlayerController Class
local pc = PlayersController.new()
pc.AddPlayer(40, "Pia")
pc.AddPlayer(40, "Lina")



-- Load game data
local gameData = playdate.datastore.read()
if gameData then
    player = gameData.players
end

-- Function to save game data
function saveGameData()
    local gameData = {players = players}
    playdate.datastore.write(gameData)
end

-- Lifecycle Event Handlers
function playdate.gameWillTerminate()
    saveGameData()
end

function playdate.gameWillSleep()
    saveGameData()
end

playercount = 2

local posconfigs = {
    -- Table type 1: 4 Players Round
    {
        {x = 200, y = 190, angle = 0, scale = 1},
        {x = 350, y = 120, angle = 270, scale = 1},
        {x = 200, y = 50, angle = 180, scale = 1},
        {x = 50, y = 120, angle = 90, scale = 1},
    },
    -- Table type 2: 4 Players Square
    {
        {x = 100, y = 190, angle = 0, scale = 1},
        {x = 300, y = 190, angle = 0, scale = 1},
        {x = 300, y = 50, angle = 180, scale = 1},
        {x = 100, y = 50, angle = 180, scale = 1},
    },
    -- Table type 3: 2 Players
    {
        {x = 322, y = 120, angle = 270, scale = 1.3},
        {x = 78, y = 120, angle = 90, scale = 1.3},
    },
}

local debuglife = 40
local debugCommanderDamege = 20





local menuOptions = { 1,2,3,4}
local listview = playdate.ui.gridview.new(50,50)
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





local vc = ViewsController.new()
vc.AddView("main", function() end,function()mainUpdate() end)
vc.AddView("test", function()debugTwoplayerUpdate() end, function() end)
vc.SetCurrentView(1)



function mainUpdate()
    gfx.clear()
    listview:drawInRect(0, 0, 400, 240)
    playdate.timer:updateTimers()
end


function debugTwoplayerUpdate()
    gfx.clear()
    drawlifecounter(posconfigs[3][1], "P1", debuglife, {debugCommanderDamege,0,4})
    drawlifecounter(posconfigs[3][2], "P2", debuglife, {debugCommanderDamege,0,4})
end


local testInputHandlers = {
    AButtonDown = function()    
        -- drawlifecounter(posconfigs[1].2.x, , debuglife, {debugCommanderDamege,0,4}) 
         debuglife = debuglife +7
         debugCommanderDamege = debugCommanderDamege + 1
        end,
    downButtonDown = function() 
        vc.CycleView()
    end,

    rightButtonDown = function() 

        listview:selectNextColumn(true)
    end
}

--drawlifecounter(posconfigs[3][1], "P1", debuglife, {debugCommanderDamege,0,4})
--drawlifecounter(posconfigs[3][2], "P2", debuglife, {debugCommanderDamege,0,4})

playdate.inputHandlers.push(testInputHandlers)

function playdate.update()
    vc.UpdateCurrentView()
    
end







