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
import "scripts/views/views"


-- PlayerController Class
local pc = PlayersController.new()
pc.AddPlayer(40, "Player 1")
pc.AddPlayer(40, "Player 2")

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

posconfigs = {
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



vc = ViewsController.new()

-- Import Views
import "scripts/views/menuView"
import "scripts/views/gameView"
vc.SetCurrentView(1)





local testInputHandlers = {
    AButtonDown = function()    
        debuglife = debuglife +7
        debugCommanderDamege = debugCommanderDamege + 1
        drawlifecounter(posconfigs[3][1], "P1", debuglife, {debugCommanderDamege,0,4})
        end,
    downButtonDown = function() 
        vc.CycleView()
    end,

    rightButtonDown = function() 

        listview:selectNextColumn(true)
    end
}

playdate.inputHandlers.push(testInputHandlers)

function playdate.update()
    vc.UpdateCurrentView()
end