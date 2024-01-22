local gfx <const> = playdate.graphics
local geo <const> = playdate.geometry

debuglife = 40
debugCommanderDamege = 0
debugInputTimerLeght = 5000

currentDirection = 0


local baseInputHandlers = {
    downButtonDown = function() SetCurrentDirection(1) end,
    rightButtonDown = function() SetCurrentDirection(2) end,
    upButtonDown = function() SetCurrentDirection(3) end,
    leftButtonDown = function() SetCurrentDirection(4) end,
   -- AButtonDown = function() cycleView() end,
  --  BButtonDown = function() cylcelMode() end,
}

local possibleModes = {
    {name = "Damage", calc = function() print("Do Damage " .. tostring(currentDirection)) end},
    {name = "Commander Damage", calc = function() print("Do Commander Damage " .. tostring(currentDirection)) end},
    {name = "Heal", calc = function() print("Heal " .. tostring(currentDirection)) end},
}

local currentMode = 1



local a_sign = -1



local selectedDirInputHandlers = {
    AButtonDown = function() 
        resetInput:reset()
        resetInput:start()
        possibleModes[currentMode].calc() end,
    BButtonDown = function() 
        resetInput:reset()
        resetInput:start()
        CycleMode() end,
    downButtonDown = function() ResetCurrentDirection(currentDirection) end,
    rightButtonDown = function() ResetCurrentDirection(currentDirection) end,
    upButtonDown = function() ResetCurrentDirection(currentDirection) end,
    leftButtonDown = function() ResetCurrentDirection(currentDirection) end
}





function ResetCurrentDirection(dir)
    resetInput:remove()
    clearTimerDraw()

    playdate.inputHandlers.pop()
    drawlifecounter(posconfigs[1][dir], "P2", 40,{20},false)
    currentDirection = 0
end

function SetCurrentDirection(dir)

    resetInput:remove()
    resetInput = playdate.timer.new(debugInputTimerLeght, function() ResetCurrentDirection(currentDirection) end)
    resetInput.updateCallback = function(timer) drawTimer(timer.timeLeft) end

    currentDirection = dir
    drawlifecounter(posconfigs[1][dir], "P2", 40,{20},true)

    playdate.inputHandlers.push(selectedDirInputHandlers)
end


function CycleMode()
    currentMode = currentMode + 1
    if(currentMode > #possibleModes) then
        currentMode = 1
    end
    print(currentMode)

end


function setUpView()

    print("Setting up test view")
    debuglife = 40
    debugCommanderDamege = 0

    gfx.clear()
    drawlifecounter(posconfigs[1][1], "P1", debuglife, {debugCommanderDamege},false)
    drawlifecounter(posconfigs[1][2], "P2", debuglife, {debugCommanderDamege},false)
    drawlifecounter(posconfigs[1][3], "P3", debuglife, {debugCommanderDamege},false)
    drawlifecounter(posconfigs[1][4], "P4", debuglife, {debugCommanderDamege},false)

    resetInput = playdate.timer.new(5000, function() ResetCurrentDirection(currentDirection) end)
    resetInput:pause()
    playdate.inputHandlers.push(baseInputHandlers)
end


local timerRect = geo.rect.new(170,110,60,20)

function Update()
    playdate.timer:updateTimers()

end



function drawTimer(timeleft)
    clearTimerDraw()
    gfx.drawTextInRect(string.format("%d s",math.ceil(timeleft/1000)),timerRect, nil, nil, kTextAlignment.center)
end
function clearTimerDraw()
    gfx.pushContext()
        gfx.setColor(gfx.kColorWhite)
        gfx.fillRect(timerRect)
    gfx.popContext()
end

vc.AddView("test", function() setUpView() end, function() Update() end)