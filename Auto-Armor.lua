-- Auto Armor [ Made by 15rih, steal credits I don't care this shit is so easy now ]
_G.Prefix = "."; -- Prefix Here For Stop [Default Is .]
_G.Amount = 20; -- Health Amount Here To Buy Armor

game:GetService("RunService"):BindToRenderStep("AutoArmor", 0, function()
    for i,v in ipairs(game:GetService("Workspace").Ignored.Shop["[High-Medium Armor] - $2369"]:GetChildren()) do
        if game.Players.LocalPlayer.Character.Humanoid.Health <= tonumber(_G.Amount) then
            local op = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            if v.Name == ("Head") and v:IsA("Part") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 3, 0)
                task.wait(0.2)
                fireclickdetector(game:GetService("Workspace").Ignored.Shop["[High-Medium Armor] - $2369"].ClickDetector)
                task.wait(0.2)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = op
            end
        end
    end
end)

game.Players.LocalPlayer.Chatted:Connect(function(b)
    if b:lower() == _G.Prefix.."stop" then
        game:GetService('RunService'):UnbindFromRenderStep("AutoArmor")
    end
end)
