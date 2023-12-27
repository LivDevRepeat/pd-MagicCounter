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

import "scripts/data"
import "scripts/graphics"


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


local tableType = {
    -- Table type 1: 4 Players Round
    {
        draw = function()
            drawlifecounter(200, 190, 0, "Pia", "40")
          
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


drawlifecounter(200, 190, 0,0.9, "Pia", 120, {})
drawlifecounter(350, 120, 270, 0.9,"Pia", 40, {})
drawlifecounter(200, 50, 180,0.9, "Pia", 4, {})
drawlifecounter(50, 120, 90,0.9, "Pia", 40, {})

local debuglife = 40
local debugCommanderDamege = 67

local testInputHandlers = {
    AButtonDown = function()
         drawlifecounter(200, 190, 0,0.9, "Pia", debuglife, {debugCommanderDamege,0,4,0}) 
         debuglife = debuglife +7
         debugCommanderDamege = debugCommanderDamege + 1
        end
}

playdate.inputHandlers.push(testInputHandlers)
function playdate.update()

end







