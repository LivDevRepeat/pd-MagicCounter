local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry


currentDirection = 0
currentViewMode = 1
playercount = 4
timerLenght = 5000

local currentCalcMode = 1

local baseInputHandlers = {
    downButtonDown = function() SetCurrentDirection(1) end,
    rightButtonDown = function() SetCurrentDirection(2) end,
    upButtonDown = function() SetCurrentDirection(3) end,
    leftButtonDown = function() SetCurrentDirection(4) end,
    AButtonUp = function() cycleView() end,
  --  BButtonDown = function() cylcelMode() end,
}

local possibleModes = {
    {name = function() return "Damage" end, calc = function() pc.DecreasePlayerLife(currentDirection) end, onEnable = function() print("Damage") end},
    {name = function() return "Heal"end, calc = function() pc.IncreasePlayerLife(currentDirection) end, onEnable = function() print("Heal") end},
    {name = function() return string.format("Commader %d", pc.GetCommanderID(currentDirection,1)) end , calc = function() DoCommanderDamage(1) end, onEnable = function() EnableCommander(1) end},
    {name = function() return string.format("Commader %d", pc.GetCommanderID(currentDirection,2)) end , calc = function() DoCommanderDamage(2) end, onEnable = function() EnableCommander(2) end},
    {name = function() return string.format("Commader %d", pc.GetCommanderID(currentDirection,3)) end , calc = function() DoCommanderDamage(3) end, onEnable = function() EnableCommander(3) end},
  --  {name = "Com 2 Damage", calc = function() print("Do Commander Damage " .. tostring(currentDirection)) end},
    -- {name = "Com 3 Damage", calc = function() print("Do Commander Damage " .. tostring(currentDirection)) end}
}



cycleView = function()
    currentViewMode = currentViewMode + 1
    max = #posconfigs
    if(playercount > 2) then
        max = 3
    end
    if(currentViewMode > max) then
        currentViewMode = 1
    end
    print(currentViewMode)
    setUpView()
end


function DoCommanderDamage(target)
    pc.increaseCommanderDamage(currentDirection,target)

    for i = #pc.Players, 1, -1 do
       -- drawlifecounter(posconfigs[currentViewMode][i], "P" .. tostring(i), pc.GetPlayerLife(i),pc.Players[i].cdTable,false, true)
    end

end



local selectedDirInputHandlers = {
    AButtonUp = function() 
        resetInput:reset()
        resetInput:start()
        possibleModes[currentCalcMode].calc() 
        i = currentDirection
        drawlifecounter(posconfigs[currentViewMode][i], "P" .. tostring(i), pc.GetPlayerLife(i),pc.Players[i].cdTable,true)
    end,

    BButtonUp = function() 
        resetInput:reset()
        resetInput:start()
        CycleMode() end,
    downButtonDown = function() ResetCurrentDirection(currentDirection) end,
    rightButtonDown = function() ResetCurrentDirection(currentDirection) end,
    upButtonDown = function() ResetCurrentDirection(currentDirection) end,
    leftButtonDown = function() ResetCurrentDirection(currentDirection) end
}





function ResetCurrentDirection(i)
    resetInput:remove()
    clearTimerDraw()

    currentCalcMode = 1

    playdate.inputHandlers.pop()
    drawlifecounter(posconfigs[currentViewMode][i], "P" .. tostring(i), pc.GetPlayerLife(i),pc.Players[i].cdTable,false)
    currentDirection = 0
end

function SetCurrentDirection(i)

    resetInput:remove()
    resetInput = playdate.timer.new(timerLenght, function() ResetCurrentDirection(currentDirection) end)
    resetInput.updateCallback = function(timer) drawTimer(timer.timeLeft) end

    currentDirection = i
    drawlifecounter(posconfigs[currentViewMode][i], "P" .. tostring(i), pc.GetPlayerLife(i),pc.Players[i].cdTable,true)

    playdate.inputHandlers.push(selectedDirInputHandlers)
end


function CycleMode()
    currentCalcMode = currentCalcMode + 1
    if(currentCalcMode > #possibleModes) then
        currentCalcMode = 1
    end
    print(currentCalcMode)
  
end


function setUpView()
    print("Setting up test view")

    gfx.clear()
    for i = #pc.Players, 1, -1 do
        drawlifecounter(posconfigs[currentViewMode][i], "P" .. tostring(i), pc.GetPlayerLife(i),pc.GetCommanderTables(i),false)
    end

    resetInput = playdate.timer.new(timerLenght, function() ResetCurrentDirection(currentDirection) end)
    resetInput:pause()
    playdate.inputHandlers.push(baseInputHandlers)
end


local timerRect = geo.rect.new(120,110,160,20)

function Update()
    playdate.timer:updateTimers()

end




function drawTimer(timeleft)
    clearTimerDraw()
    gfx.drawTextInRect(string.format("%s  ( %d s)",possibleModes[currentCalcMode].name(),math.ceil(timeleft/1000)),timerRect, nil, nil, kTextAlignment.center)
end
function clearTimerDraw()
    gfx.pushContext()
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(timerRect)
    gfx.popContext()
end

vc.AddView("test", function() setUpView() end, function() Update() end)