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
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")

-- System Menu
local menu = playdate.getSystemMenu()
menu:addMenuItem("New Game", function() Reset() end)

-- Main update function
function playdate.update()
   -- UpdateCounter()
end

-- Reset game state
function Reset()
    lifecounters = {
        {life = 40, label = "Player 1", playerID = 1, button = 1},
        {life = 20, label = "Commander Damage", playerID = 1, button = 2},
        {life = 40, label = "Player 2", playerID = 3, button = 3},
        {life = 20, label = "Commander Damage", playerID = 3, button = 4},
    }
    UpdateCounter()
end

-- Update counter display
function UpdateCounter()
    gfx.clear()
    tableType[currentView].draw()
end


-- Additional functions


function ResetCurrentDirection()
    playdate.inputHandlers.pop()
    currentDirection = 0
end

function SetCurrentDirection(dir)
    currentDirection = dir
    playdate.inputHandlers.push(selectedDirInputHandlers)
end



-- Initialize input handlers


-- Initial update call
UpdateCounter()
