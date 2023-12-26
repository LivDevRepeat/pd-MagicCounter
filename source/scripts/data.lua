local lifecounters = {
    {life = 40, label = "Player 1", playerID = 1, button = 1},
    {life = 20, label = "Commander Damage", playerID = 1, button = 2},
    {life = 40, label = "Player 2", playerID = 3, button = 3},
    {life = 20, label = "Commander Damage", playerID = 3, button = 4},
}

-- Load game data
local gameData = playdate.datastore.read()
if gameData then
    lifecounters = gameData.lifecounters
end

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
end