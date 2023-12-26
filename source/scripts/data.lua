local player = {}

function addPlayer(startlife, label)
    player[#player + 1] = {life = startlife, label = label}
end

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
