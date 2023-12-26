playdate.inputHandlers.push(baseInputHandlers)-- Input Handlers
local selectedDirInputHandlers = {
    AButtonDown = function() ChangeLife(a_sign, currentDirection) end,
    BButtonDown = function() ChangeLife(b_sign, currentDirection) end,
    leftButtonUp = function() ResetCurrentDirection() end,
    rightButtonUp = function() ResetCurrentDirection() end,
    upButtonUp = function() ResetCurrentDirection() end,
    downButtonUp = function() ResetCurrentDirection() end,
}

local baseInputHandlers = {
    downButtonDown = function() SetCurrentDirection(1) end,
    rightButtonDown = function() SetCurrentDirection(2) end,
    upButtonDown = function() SetCurrentDirection(3) end,
    leftButtonDown = function() SetCurrentDirection(4) end,
    AButtonDown = function() cycleView() end,
    BButtonDown = function() cylcelMode() end,
}
