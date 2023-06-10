-- better version of auto armor made by 15rih. pls skid!!!!!!!
local Executer = identifyexecutor();

if identifyexecutor() == "Fluxus" or "Electron" then -- delete this and the end that is marked if you don't use fluxus or electron.
getgenv().Prefix = "."; -- Prefix here for STOP & START [Default Is .]
getgenv().Amount = 20; -- Health amount here to buy ARMOR [ Don't put this above 100. ] 

local Workspace = game.Workspace
local Char = game.Players.LocalPlayer.Character
local Lp = game.Players.LocalPlayer
local Hmrp = game.Players.LocalPlayer.Character.HumanoidRootPart

local Prefix = getgenv().Prefix
local Amount = getgenv().Amount

function AutoArmor()
    game:GetService("RunService"):BindToRenderStep("AutoArmor", 0, function()
        for i,v in ipairs(Workspace.Ignored.Shop["[High-Medium Armor] - $2369"]:GetChildren()) do
            if Char.Humanoid.Health <= tonumber(Amount) then
                local op = Hmrp.CFrame
                if v:FindFirstChild("ClickDetector") or v.Name == ("Head") then
                    Hmrp.CFrame = v.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.2)
                    fireclickdetector(Workspace.Ignored.Shop["[High-Medium Armor] - $2369"].ClickDetector)
                    task.wait(0.2)
                    Hmrp.CFrame = op
                end
            end
        end
    end)
end

Lp.Chatted:Connect(function(b)
    if b:lower() == Prefix.."start" then
        AutoArmor()
    elseif b:lower() == Prefix.."stop" then
            game:GetService('RunService'):UnbindFromRenderStep("AutoArmor")
        end
    end)
end
