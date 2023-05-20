-- THIS WILL NOT WORK ANYMORE NOW THAT THE EGG EVENT IN DA HOOD IS OVER.
local HumanoidR = game.Players.LocalPlayer.Character.HumanoidRootPart

game.Workspace.Ignored.ChildAdded:Connect(function()
    for _,v in pairs(game.Workspace.Ignored:GetChildren()) do
        if v:FindFirstChild("TouchInterest") then
            repeat 
                task.wait()
                firetouchinterest(HumanoidR, v, 0)
                task.wait()
                firetouchinterest(HumanoidR, v, 1)
            until
            print("Egg Autofarm aaaaaa") -- just added this for looks, can be empty
        end
    end
end)
