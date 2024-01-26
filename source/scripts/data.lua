 PlayersController = {}
PlayersController.new = function()
    local self = {}

     self.Players = {}
    
     -- SetUpFunctions
    function self.AddPlayer(startlife, label)
        local Players = self.Players
        Players[#Players + 1] = {life = startlife, label = label }
        print("Player " .. #Players .. " added")
    end


    function self.AddCommanderDamageTable(player)
        self.Players[player].cdTable = {}
        index = 1
        for i = 1, #self.Players do
            if( i == player) then
                print("Skip self")
                -- self.Players[player].cdTable[i] = {commanderID = i, damage = 0}
            else
                self.Players[player].cdTable[index] = {commanderID = i, damage = 0}
                index = index + 1
                print("Add Commander " .. i .. " to Player " .. player)
            end
        end

        print(#self.Players[player].cdTable .. " Commanders added to Player " .. player    )

    end


    function self.AddCommanderDamageTables()
        for i = 1, #self.Players do
            self.AddCommanderDamageTable(i)
        end
    end

    function self.AddNumberOfPlayers(playercount, startlife)
        for i = 1, playercount do
            self.AddPlayer(startlife, "Player " .. tostring(i))
        end

        self.AddCommanderDamageTables()
    end

    -- Getters

    function self.GetPlayerLife(player)
        return self.Players[player].life
    end

    function self.GetCommanderID(player, target)
        return self.Players[player].cdTable[target].commanderID
    end

    function self.GetCommanderTables(player)
        return self.Players[player].cdTable
    end

    -- Actions 

    function self.IncreasePlayerLife(player)
        self.Players[player].life = self.Players[player].life + 1
    end

    function self.DecreasePlayerLife(player)
        self.Players[player].life = self.Players[player].life - 1
    end

    function self.increaseCommanderDamage(player, target)
        self.Players[player].cdTable[target] = self.Players[player].cdTable[target] + 1
    end


   


    return self
end










    

