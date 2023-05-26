local Drop = game.Workspace.Ignored.Drop
local Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local CD = 'ClickDetector'

if identifyexecutor() == ('Fluxus') or ('Electron') then
    coroutine.resume(coroutine.create(function()
        for i,v in pairs(Drop:GetChildren()) do
            if v:IsA'Part' and v.Name == 'MoneyDrop' then
                if (v.Position - Position).Magnitude <= 13.5 then
                    fireclickdetector(v:FindFirstChild(CD))
                end
            end
        end
    end))
end
