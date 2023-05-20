-- Statistics UI For Da Hood, Idk why I made this. I havent touched it or messed with it since 3/3/22 so why not post it.
getgenv().Settings = {
    fps = 160, -- fps amount here [caps/locks it there] {FPS UNLOCKER MUST BE ON IN EXECUTER SETTINGS}
    lowgfxmode = false, -- set to true if you want to have low graphics in game
    automaskonexecute = true, -- set to false if you dont want it to buy a mask on execution
    synapsemode = false, -- this isnt fully developed I just added it for testing [deleted the orig code]
}

setfpscap(tonumber(getgenv().Settings.fps))

if getgenv().Settings.lowgfxmode == true then
    loadstring(game:HttpGet("https://pastebin.com/raw/rePnrZ7V"))
end

if getgenv().Settings.automaskonexecute == true then
    local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for i,v in pairs(game:GetService("Workspace").Ignored.Shop["[Surgeon Mask] - $26"]:GetChildren()) do
        if v.Name == "Head" and v:IsA("Part") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame * CFrame.new(0, 5, 0)
            task.wait(1)
            fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Surgeon Mask] - $26"].ClickDetector)
            task.wait(1)
            game.Players.LocalPlayer.Backpack:FindFirstChild("[Mask]").Parent = game.Players.LocalPlayer.Character
            game.Players.LocalPlayer.Character:FindFirstChild("[Mask]"):Activate()
            task.wait(1)
            game.Players.LocalPlayer.Character:FindFirstChild("[Mask]").Parent = game.Players.LocalPlayer.Backpack
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
        else
            if game.Players.LocalPlayer.DataFolder.Currency.Value < 26 then
                print("Not Enough Cash [POORON]")
            end
        end
    end
end

-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Username = Instance.new("TextLabel")
local UserId = Instance.new("TextLabel")
local Ping = Instance.new("TextLabel")
local Cash = Instance.new("TextLabel")
local Fps = Instance.new("TextLabel")
local RunService = game:GetService("RunService")

--Properties:

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 0.950
Frame.Position = UDim2.new(0.00555556966, 0, 0.908641875, 0)
Frame.Size = UDim2.new(0, 187, 0, 65)
Frame.Active = true
Frame.Draggable = true

Username.Name = "Username"
Username.Parent = Frame
Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Username.BackgroundTransparency = 1.000
Username.BorderColor3 = Color3.fromRGB(27, 42, 53)
Username.Size = UDim2.new(0, 187, 0, 13)
Username.Font = Enum.Font.SourceSans
Username.Text = "Username: "..game.Players.LocalPlayer.Name
Username.TextColor3 = Color3.fromRGB(0, 0, 0)
Username.TextSize = 14.000

UserId.Name = "UserId"
UserId.Parent = Frame
UserId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UserId.BackgroundTransparency = 1.000
UserId.BorderColor3 = Color3.fromRGB(27, 42, 53)
UserId.Position = UDim2.new(0, 0, 0.200000003, 0)
UserId.Size = UDim2.new(0, 187, 0, 13)
UserId.Font = Enum.Font.SourceSans
UserId.Text = "UserId: "..game.Players.LocalPlayer.UserId
UserId.TextColor3 = Color3.fromRGB(0, 0, 0)
UserId.TextSize = 14.000

Ping.Name = "Ping"
Ping.Parent = Frame
Ping.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Ping.BackgroundTransparency = 1.000
Ping.BorderColor3 = Color3.fromRGB(27, 42, 53)
Ping.Position = UDim2.new(0, 0, 0.400000006, 0)
Ping.Size = UDim2.new(0, 187, 0, 13)
Ping.Font = Enum.Font.SourceSans
Ping.Text = "Ping: "
Ping.TextColor3 = Color3.fromRGB(0, 0, 0)
Ping.TextSize = 14.000
RunService:BindToRenderStep("Ping", 0, function()
    Ping.Text = "Ping: "..game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
end)

Cash.Name = "Cash:"
Cash.Parent = Frame
Cash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cash.BackgroundTransparency = 1.000
Cash.BorderColor3 = Color3.fromRGB(27, 42, 53)
Cash.Position = UDim2.new(0, 0, 0.600000024, 0)
Cash.Size = UDim2.new(0, 187, 0, 12)
Cash.Font = Enum.Font.SourceSans
Cash.Text = "Cash: "
Cash.TextColor3 = Color3.fromRGB(0, 0, 0)
Cash.TextSize = 14.000
RunService:BindToRenderStep("Cash", 0, function()
    Cash.Text = "Cash: "..game.Players.LocalPlayer.DataFolder.Currency.Value
end)

Fps.Name = "Fps"
Fps.Parent = Frame
Fps.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fps.BackgroundTransparency = 1.000
Fps.BorderColor3 = Color3.fromRGB(27, 42, 53)
Fps.Position = UDim2.new(0, 0, 0.784615397, 0)
Fps.Size = UDim2.new(0, 187, 0, 12)
Fps.Font = Enum.Font.SourceSans
Fps.Text = "FPS: "
Fps.TextColor3 = Color3.fromRGB(0, 0, 0)
Fps.TextSize = 14.000


local plrFPS = 0

function rfps()
    local TimeFunction = RunService:IsRunning() and time or os.clock
    local Start, LastIteration
    local FrameUpdate = {}
    local function heartbeat()
        LastIteration = TimeFunction()
        for Index = #FrameUpdate, 1, -1 do
            FrameUpdate[Index + 1] = FrameUpdate[Index] >= LastIteration - 1 and FrameUpdate[Index] or nil
        end
        FrameUpdate[1] = LastIteration
        plrFPS = math.floor(TimeFunction() - Start >= 1 and #FrameUpdate or #FrameUpdate / (TimeFunction() - Start))
    end
    Start = TimeFunction()
    RunService.Heartbeat:Connect(heartbeat)
end
task.spawn(rfps)

RunService:BindToRenderStep("FPS", 0, function()
    Fps.Text = "FPS: "..plrFPS
end)

while wait() do
	Fps.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	Cash.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	Ping.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	UserId.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	Username.TextColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
end
