ViewsController = {}
ViewsController.new = function()

    local self = {}
     self.Views = {}
 self.CurrentView = 1
    
    function self.AddView(name, setUp, onUpdate)
        local Views = self.Views
        Views[#Views + 1] = {name = name, setUp = setUp, onUpdate = onUpdate}
        print("View " .. name .. " added")
    end

    function self.SetCurrentView(view)
        self.CurrentView = view
    end

    function self.UpdateCurrentView()
        local Views = self.Views
        local CurrentView = self.CurrentView
        Views[CurrentView].onUpdate()
    end

    function self.SetUpCurrentView()
        local Views = self.Views
        local CurrentView = self.CurrentView
        Views[CurrentView].setUp()
    end

    function self.CycleView()
        local Views = self.Views
        local CurrentView = self.CurrentView
        if CurrentView == #Views then
            self.SetCurrentView(1)
        else
            self.SetCurrentView(CurrentView + 1)
            
        end

        self.SetUpCurrentView()
    end


    return self
end