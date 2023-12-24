-- Imports
import "CoreLibs/graphics"
import "CoreLibs/ui"
import "CoreLibs/nineslice"

-- Constants
local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

-- Global Variables
local lifecounters = {
    {life = 40, label = "Player 1", playerID = 1, button = 1},
    {life = 20, label = "Commander Damage", playerID = 1, button = 2},
    {life = 40, label = "Player 2", playerID = 3, button = 3},
    {life = 20, label = "Commander Damage", playerID = 3, button = 4},
}

local currentDirection = 0
local currentView = 2
local a_sign = -1
local b_sign = 1

-- Function to save game data
function saveGameData()
    local gameData = {lifecounters = lifecounters}
    playdate.datastore.write(gameData)
end

-- Lifecycle Event Handlers
function playdate.gameWillTerminate()
    saveGameData()
end

function playdate.gameWillSleep()
    saveGameData()
end

-- Load game data
local gameData = playdate.datastore.read()
if gameData then
    lifecounters = gameData.lifecounters
end

-- UI setup
playdate.setAutoLockDisabled(true)
local newfont = gfx.font.new("fonts/Marble Madness- 80pxNum")

-- Function for drawing life counters
function drawlifecounter(x, y, angle, playerID)
    local rotate = gfx.image.new(200, 101)
    local rect = geo.rect.new(5, 20, 190, 100)
    gfx.pushContext(rotate)
        gfx.setColor(gfx.kColorBlack)

        -- Dither Background
        if playerID == currentDirection then
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

        -- Text
        gfx.drawTextInRect(lifecounters[playerID].label, 0, 0, 200, 20, nil, nil, kTextAlignment.center)
        gfx.pushContext()
            gfx.setFont(newfont)
            rect:inset(0, 10)
            gfx.drawTextInRect(tostring(lifecounters[playerID].life), rect, nil, nil, kTextAlignment.center)
        gfx.popContext()
    gfx.popContext()
    rotate:drawRotated(x, y, angle)
end

-- Table types with different layouts
local tableType = {
    -- Table type 1: 4 Players Round
    {
        draw = function()
            drawlifecounter(200, 190, 0, 1)
            drawlifecounter(350, 120, 270, 2)
            drawlifecounter(200, 50, 180, 3)
            drawlifecounter(50, 120, 90, 4)
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

-- System Menu
local menu = playdate.getSystemMenu()
menu:addMenuItem("New Game", function() Reset() end)

-- Main update function
function playdate.update()
    UpdateCounter()
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

-- Input Handlers
local changeInputs = {
    AButtonDown = function() ChangeLife(a_sign, currentDirection) end,
    BButtonDown = function() ChangeLife(b_sign, currentDirection) end,
    leftButtonUp = function() ResetCurrentDirection() end,
    rightButtonUp = function() ResetCurrentDirection() end,
    upButtonUp = function() ResetCurrentDirection() end,
    downButtonUp = function() ResetCurrentDirection() end,
}

local myInputHandlers = {
    downButtonDown = function() SetCurrentDirection(1) end,
    rightButtonDown = function() SetCurrentDirection(2) end,
    upButtonDown = function() SetCurrentDirection(3) end,
    leftButtonDown = function() SetCurrentDirection(4) end,
    AButtonDown = function() cycleView() end,
    BButtonDown = function() cylcelMode() end,
}

-- Additional functions
function cycleView()
    currentView = currentView + 1
    if currentView > #tableType then
        currentView = 1
    end
end

function cylcelMode()
    -- Logic for cycling modes (currently empty)
end

function ResetCurrentDirection()
    playdate.inputHandlers.pop()
    currentDirection = 0
end

function SetCurrentDirection(dir)
    currentDirection = dir
    playdate.inputHandlers.push(changeInputs)
end

function ChangeLife(sign, currentDirection)
    local playerID = 0
    for i = 1, #lifecounters do 
        if lifecounters[i].button == currentDirection then
            playerID = lifecounters[i].playerID
        end
    end

    for i = 1, #lifecounters do 
        if (lifecounters[i].playerID == playerID and lifecounters[i].button == currentDirection) or (lifecounters[i].playerID == lifecounters[i].button and lifecounters[i].playerID == playerID) then
            lifecounters[i].life = lifecounters[i].life + 1 * sign
            if lifecounters[i].life <= 0 then
                lifecounters[i].life = 0
            end
        end
    end
    UpdateCounter()
end

-- Initialize input handlers
playdate.inputHandlers.push(myInputHandlers)

-- Initial update call
UpdateCounter()
