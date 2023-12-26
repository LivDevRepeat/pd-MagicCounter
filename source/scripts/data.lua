 PlayersController = {}
PlayersController.new = function()
    local self = {}

     self.Players = {}
    
    function self.AddPlayer(startlife, label)
        local Players = self.Players
       Players[#Players + 1] = {life = startlife, label = label, commanderDamage = {} }
        print("Player " .. #Players .. " added")
    end


    return self
end








    

