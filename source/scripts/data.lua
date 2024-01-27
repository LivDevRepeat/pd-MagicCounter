 PlayersController = {}
PlayersController.new = function( playercount, startlife)
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

            local cdTable = self.Players[player].cdTable
            local CommanderID = self.GetNextCommander(player)
            for i = 1, #self.Players do
                cdTable[i]={commanderID = CommanderID, damage = 0}
                CommanderID = self.GetNextCommander(CommanderID)
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

    -- Helpers
    

    function self.GetNextCommander(player)
        if(player == #self.Players) then
            return 1
        else
            return player + 1
        end
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
        self.Players[player].cdTable[target].damage = self.Players[player].cdTable[target].damage + 1
    end


   
     self.AddNumberOfPlayers(playercount, startlife)

    return self
end










    

