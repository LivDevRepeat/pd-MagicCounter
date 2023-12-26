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

-- PlayerController Class
local pc = PlayersController.new()
pc.AddPlayer(40, "Pia")
pc.AddPlayer(40, "Lina")

pc.Players[1].commanderDamage[1] = 0

print(pc.Players[1].label .. " has " .. pc.Players[1].life .. " life")


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


function playdate.update()
    -- Update game logic here
end





