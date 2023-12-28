local gfx <const> = playdate.graphics

debuglife = 40
debugCommanderDamege = 20

function debugTwoplayerUpdate()
    gfx.clear()
    drawlifecounter(posconfigs[3][1], "P1", debuglife, {debugCommanderDamege,0,4})
    drawlifecounter(posconfigs[3][2], "P2", debuglife, {debugCommanderDamege,0,4})
end

vc.AddView("test", function()debugTwoplayerUpdate() end, function() end)