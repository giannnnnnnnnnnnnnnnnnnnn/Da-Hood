-- DISABLE SEAT
for i,v in pairs(workspace:GetDescendants()) do 
	if v:IsA("Seat") or v:IsA("VehicleSeat") then 
		v.Disabled = true
	end
end

-- MAIN SCRIPT
getgenv().MoneyFling = true
while MoneyFling == true do
    for i,v in pairs(game:GetService("Workspace").Ignored.Drop:GetChildren()) do
        if v.Name == ("MoneyDrop") or v:IsA("Part") then
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(60, 0, 5)
            game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(600, 0, 0)
        end
    end
end
