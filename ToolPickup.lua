for i,v in pairs(game:GetService("Workspace").Ignored.ItemsDrop:GetChildren()) do
    if v:IsA("Part") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        task.wait(1)
    end
end
