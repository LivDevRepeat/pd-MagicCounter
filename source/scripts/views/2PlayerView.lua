local gfx <const> = playdate.graphics

debuglife = 40
debugCommanderDamege = 0

function debugTwoplayerUpdate()
    gfx.clear()
    drawlifecounter(posconfigs[1][1], "P1", debuglife, {debugCommanderDamege},true)
    drawlifecounter(posconfigs[1][2], "P2", debuglife, {debugCommanderDamege},false)
end

function setUpView()
    print("Setting up test view")
    debuglife = 40
    debugCommanderDamege = 0
    -- Push the Input Here
end

vc.AddView("test", function()debugTwoplayerUpdate() setUpView() end, function() end)