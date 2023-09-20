if not game:IsLoaded() then
    game.Loaded:Wait()
end
if game:service"CoreGui":FindFirstChild("OcinCrasher") then return end
game:service"StarterGui":SetCore("SendNotification",{
    Title = "Ocin Crash!";
    Text = "Loading...";
    Duration = 10;
})
repeat wait(0.001) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)
game:service"StarterGui":SetCore("SendNotification",{
    Title = "Ocin Crash!";
    Text = "Loaded!";
    Duration = 10;
})

local OcinCrasher = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Header = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local DisplayInfo = Instance.new("Frame")
local Credit = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local Status = Instance.new("TextLabel")
local MainControl = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local Pause = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local Start = Instance.new("ImageButton")
local UICorner_2 = Instance.new("UICorner")
local ForceCrash = Instance.new("ImageButton")
local UICorner_3 = Instance.new("UICorner")
local PowerControl = Instance.new("Frame")
local UIListLayout_3 = Instance.new("UIListLayout")
local AddPower = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local ReducePower = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")

OcinCrasher.Name = "OcinCrasher"
OcinCrasher.Parent = game:service"CoreGui"
OcinCrasher.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = OcinCrasher
Main.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
Main.BorderColor3 = Color3.fromRGB(24, 24, 34)
Main.Position = UDim2.new(0.343373477, 0, 0.503952563, 0)
Main.Size = UDim2.new(0, 359, 0, 155)

Header.Name = "Header"
Header.Parent = Main
Header.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
Header.BorderColor3 = Color3.fromRGB(10, 8, 19)
Header.Size = UDim2.new(0, 359, 0, 19)

Title.Name = "Title"
Title.Parent = Header
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(0, 359, 0, 19)
Title.Font = Enum.Font.SciFi
Title.Text = "Ocin Crasher"
Title.TextColor3 = Color3.fromRGB(214, 69, 92)
Title.TextSize = 16.000

DisplayInfo.Name = "DisplayInfo"
DisplayInfo.Parent = Main
DisplayInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DisplayInfo.BackgroundTransparency = 1.000
DisplayInfo.Position = UDim2.new(0.0194986071, 0, 0.174193546, 0)
DisplayInfo.Size = UDim2.new(0, 345, 0, 55)

Credit.Name = "Credit"
Credit.Parent = DisplayInfo
Credit.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Credit.BackgroundTransparency = 1.000
Credit.Size = UDim2.new(0, 345, 0, 17)
Credit.Font = Enum.Font.SciFi
Credit.Text = "Made by Pennywise / Ocin"
Credit.TextColor3 = Color3.fromRGB(214, 69, 92)
Credit.TextSize = 14.000

UIListLayout.Parent = DisplayInfo
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local maxitems = math.random(1250,1260)
Status.Name = "Status"
Status.Parent = DisplayInfo
Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Status.BackgroundTransparency = 1.000
Status.Size = UDim2.new(0, 345, 0, 17)
Status.Font = Enum.Font.SciFi
Status.Text = "Status: 0/"..tostring(maxitems).." %0"
Status.TextColor3 = Color3.fromRGB(214, 69, 92)
Status.TextSize = 14.000

MainControl.Name = "MainControl"
MainControl.Parent = Main
MainControl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainControl.BackgroundTransparency = 1.000
MainControl.Position = UDim2.new(0.0194986071, 0, 0.56774193, 0)
MainControl.Size = UDim2.new(0, 345, 0, 55)

UIListLayout_2.Parent = MainControl
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 3)

Pause.Name = "Pause"
Pause.Parent = MainControl
Pause.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
Pause.BorderColor3 = Color3.fromRGB(10, 8, 19)
Pause.Position = UDim2.new(0.355072469, 0, 0, 0)
Pause.Size = UDim2.new(0, 50, 0, 50)
Pause.Image = "rbxassetid://7072720054"
Pause.ImageColor3 = Color3.fromRGB(214, 69, 92)

UICorner.CornerRadius = UDim.new(0, 3)
UICorner.Parent = Pause

Start.Name = "Start"
Start.Parent = MainControl
Start.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
Start.BorderColor3 = Color3.fromRGB(10, 8, 19)
Start.Position = UDim2.new(0.355072469, 0, 0, 0)
Start.Size = UDim2.new(0, 50, 0, 50)
Start.Image = "rbxassetid://7072706620"
Start.ImageColor3 = Color3.fromRGB(214, 69, 92)

UICorner_2.CornerRadius = UDim.new(0, 3)
UICorner_2.Parent = Start

ForceCrash.Name = "ForceCrash"
ForceCrash.Parent = MainControl
ForceCrash.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
ForceCrash.BorderColor3 = Color3.fromRGB(10, 8, 19)
ForceCrash.Position = UDim2.new(0.355072469, 0, 0, 0)
ForceCrash.Size = UDim2.new(0, 50, 0, 50)
ForceCrash.Image = "rbxassetid://7072725299"
ForceCrash.ImageColor3 = Color3.fromRGB(214, 69, 92)

UICorner_3.CornerRadius = UDim.new(0, 3)
UICorner_3.Parent = ForceCrash

PowerControl.Name = "PowerControl"
PowerControl.Parent = Main
PowerControl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PowerControl.BackgroundTransparency = 1.000
PowerControl.Position = UDim2.new(0.0194986071, 0, 0.393548399, 0)
PowerControl.Size = UDim2.new(0, 345, 0, 9)

UIListLayout_3.Parent = PowerControl
UIListLayout_3.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Padding = UDim.new(0, 3)

AddPower.Name = "AddPower"
AddPower.Parent = PowerControl
AddPower.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
AddPower.BorderColor3 = Color3.fromRGB(10, 8, 19)
AddPower.Position = UDim2.new(0.350724638, 0, 0, 0)
AddPower.Size = UDim2.new(0, 98, 0, 16)
AddPower.Font = Enum.Font.SciFi
AddPower.Text = "Add Power"
AddPower.TextColor3 = Color3.fromRGB(214, 69, 92)
AddPower.TextSize = 14.000

UICorner_4.CornerRadius = UDim.new(0, 2)
UICorner_4.Parent = AddPower

ReducePower.Name = "ReducePower"
ReducePower.Parent = PowerControl
ReducePower.BackgroundColor3 = Color3.fromRGB(10, 8, 19)
ReducePower.BorderColor3 = Color3.fromRGB(10, 8, 19)
ReducePower.Position = UDim2.new(0.350724638, 0, 0, 0)
ReducePower.Size = UDim2.new(0, 98, 0, 16)
ReducePower.Font = Enum.Font.SciFi
ReducePower.Text = "Reduce Power"
ReducePower.TextColor3 = Color3.fromRGB(214, 69, 92)
ReducePower.TextSize = 14.000

UICorner_5.CornerRadius = UDim.new(0, 2)
UICorner_5.Parent = ReducePower

-- main
local remotes = {
    "CHECKER_1",
    "CHECKER_2",
    "TeleportDetect",
    "OneMoreTime",
    "BreathingHAMON",
    "VirusCough",
}

local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
    local args = {...}
    local method = getnamecallmethod()
    if (method == "FireServer" and args[1].Name == "MainEvent" and table.find(remotes, args[2])) then
        return
    end
    return __namecall(table.unpack(args))
end)

local av1 = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	av1:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	av1:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

Main.Active = true
Main.Draggable = true

local player = game:service"Players".LocalPlayer
local ws = workspace
local shop = ws.Ignored:FindFirstChild("Shop")

player:GetMouse().KeyDown:Connect(function(key)
    if key:lower() == "j" then
        Main.Visible = not Main.Visible
    end
end)

local Paused, Stopped, Running = false, false, false

local function notify(a,b,c)
    game:service"StarterGui":SetCore("SendNotification",{
        Title = a;
        Text = b;
        Duration = c;
    })
end

local function GatherItems()
    local plr = game:service"Players".LocalPlayer
    local cnt = 0
    for i,v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Tool") then
            cnt = cnt + 1
            if v:FindFirstChild("Handle") then
                --[[
                if v:FindFirstChild("Handle"):FindFirstChild("WeldConstraint") then
                    v:FindFirstChild("Handle"):FindFirstChild("WeldConstraint").Enabled = false
                end
                ]]
                v:FindFirstChild("Handle").Transparency = 100
            end
        end
    end
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            cnt = cnt + 1
            if v:FindFirstChild("Handle") then
                --[[
                if v:FindFirstChild("Handle"):FindFirstChild("WeldConstraint") then
                    v:FindFirstChild("Handle"):FindFirstChild("WeldConstraint").Enabled = false
                end
                ]]
                v:FindFirstChild("Handle").Transparency = 100
            end
        end
    end
    return cnt
end

local ItemCnt = GatherItems()
local old = 0
coroutine.resume(coroutine.create(function()
    while wait(1) do
        if Running == true then
            ItemCnt = GatherItems()
            local tot = ItemCnt/maxitems*100
            tot = tonumber(string.format("%.2f",tot))
            Status.Text = "Progess: "..tostring(ItemCnt).."/"..tostring(maxitems).." %"..tostring(tot)
        end
    end
end))

AddPower.MouseButton1Click:Connect(function()
    maxitems = maxitems + 10
end)
AddPower.MouseEnter:Connect(function()
    notify("Tip!","Increases how much items to crash with!",5)
end)
ReducePower.MouseButton1Click:Connect(function()
    if maxitems > 1250 and maxitems - 100 >= 1250 then
        maxitems = maxitems - 10
    else
        notify("Warning!","Using power 1250 and below can risk the chances of the server being unable to crash.",5)
        maxitems = maxitems - 10
    end
end)
ReducePower.MouseEnter:Connect(function()
    notify("Tip!","Decreases how much items to crash with!",5)
end)

local function equipall()
    for i,v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = player.Character
        end
    end
end

local function uneqipall()
    for i,v in pairs(player.Character:GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = player.Backpack
        end
    end
end

local function check_grenade()
    local cnt = 0
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == '[Grenade]' then
            cnt = cnt + 1
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.Name == '[Grenade]' then
            cnt = cnt + 1
        end
    end
    return cnt
end

local function check_lockpicks()
    local cnt = 0
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.Name == '[LockPicker]' then
            cnt = cnt + 1
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v.Name == '[LockPicker]' then
            cnt = cnt + 1
        end
    end
    return cnt
end

local GoodOverride = false
local oldcash = player.DataFolder.Currency.Value
player.DataFolder.Currency.Changed:Connect(function()
    if tonumber(player.DataFolder.Currency.Value) ~= tonumber(oldcash) then
        oldcash = player.DataFolder.Currency.Value
        GoodOverride = true
    end
end)

Pause.MouseButton1Click:Connect(function()
    Paused = not Paused
    if Paused then
        Pause.Image = "rbxassetid://7072720722"
        notify("Ocin Crash!","Paused!",3)
    else
        Pause.Image = "rbxassetid://7072720054"
        notify("Ocin Crash!","Resumed!",3)
    end
end)
Pause.MouseEnter:Connect(function()
    notify("Tip!","Pauses the crash!",5)
end)
Start.MouseEnter:Connect(function()
    notify("Tip!","Starts the crasher!",5)
end)
ForceCrash.MouseEnter:Connect(function()
    notify("Tip!","Stops / force crashes!",5)
end)

Start.MouseButton1Click:Connect(function()
    if Running == false then
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        for i,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("Part") then
                v.Material = "Plastic"
                --v.Transparency = 1
            end
        end
        notify("Ocin Crash!","Started!",5)
        Running = true
        local Items = {
            "[Flowers] - $5", "[Glock] - $500", "[Cranberry] - $3", "[TacticalShotgun] - $1750", 
            "[P90] - $1000", "[AUG] - $1950", "[PepperSpray] - $75", "[Silencer] - $400", "[Donut] - $5", 
            "[SMG] - $750", "[AR] - $1000", "[Shotgun] - $1250", "[Taser] - $1000", "[Weights] - $120", 
            "[HeavyWeights] - $250", "[Popcorn] - $7", "[Camera] - $100", "[Chicken] - $7", "[Pizza] - $5", 
            "[Flashlight] - $10", "[Bat] - $250", "[Lettuce] - $5", "[Pitchfork] - $320", "[Taco] - $2", 
            "[Hamburger] - $5", "[Lemonade] - $3", "[SledgeHammer] - $350", "[LMG] - $3750", 
            "[Starblox Latte] - $5", "[StopSign] - $300", "[SilencerAR] - $1250", "[AK47] - $2250", 
            "[DrumGun] - $3000", "[Money Gun] - $777", "[Shovel] - $320", "[BrownBag] - $25", "[Shotgun] - $1250", 
            "[Flashbang] - $550", "[Double-Barrel SG] - $1400", "[Revolver] - $1300", "[Donut] - $10", "[Pencil] - $175", 
            "[Popcorn] - $14", "[Nunchucks] - $450", "[HotDog] - $8", "[Taser] - $1250", "[Key] - $125", 
            "[Meat] - $12", "[Da Milk] - $7", "[Rifle] - $1550", 
        }
        if player.Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O") then
            player.Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O"):Destroy()
        end
        uneqipall()
        repeat
            if Paused == true then
                repeat wait(0.001) until Paused == false
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[Grenade] - $700"].Head.CFrame
            fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $700"].ClickDetector)
            wait(0.01)
        until check_grenade() >= 11
        repeat
            if Paused == true then
                repeat wait(0.001) until Paused == false
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Ignored.Shop["[LockPicker] - $100"].Head.CFrame
            fireclickdetector(game.Workspace.Ignored.Shop["[LockPicker] - $100"].ClickDetector)
            wait(0.01)
        until check_lockpicks() >= 11
        local g, groups = {},game:service"GroupService":GetGroupsAsync(game:service"Players".LocalPlayer.UserId)
        for i,v in pairs(groups) do
            table.insert(g,v.Id)
        end
        if not g[1] then
            game:service"StarterGui":SetCore("SendNotification",{
                Title = "Error!";
                Text = "Please be atleast in 1 group.";
                Duration = 10;
            })
            return
        end
        local SelectedId = g[math.random(#g)]
        local function equipallcans()
            for i,v in pairs(player.Backpack:GetChildren()) do
                if v:IsA("Tool") and v.Name == "[SprayCan]" then
                    v.Parent = player.Character
                end
            end
        end

        game:service"RunService":BindToRenderStep("RUNNNER_1",1,function()
            --equipallcans()
            pcall(function()
                game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Crew.CrewFrame.Visible = false
            end)
            pcall(function()
                game:GetService("Players").LocalPlayer.PlayerGui.GoThruGui.RecordingFrame.Visible = false
            end)
            pcall(function()
                game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.PhoneCalls.Visible = false
            end)
            game:service"ReplicatedStorage".MainEvent:FireServer("JoinCrew",tostring(SelectedId))
        end)
        
        for i,v in pairs(Items) do
            equipall()
            local place = shop:FindFirstChild(v)
            GoodOverride = false
            if Paused == true then
                repeat wait(0.001) until Paused == false
            end
            repeat
                player.Character.HumanoidRootPart.CFrame=place.Head.CFrame*CFrame.new(0,2,0)
                fireclickdetector(place.ClickDetector)
                wait(0.001)
            until GoodOverride == true
        end
        for i,v in pairs(Items) do
            equipall()
            local place = shop:FindFirstChild(v)
            GoodOverride = false
            if Paused == true then
                repeat wait(0.001) until Paused == false
            end
            repeat
                player.Character.HumanoidRootPart.CFrame=place.Head.CFrame*CFrame.new(0,2,0)
                fireclickdetector(place.ClickDetector)
                wait(0.001)
            until GoodOverride == true
        end
        uneqipall()
        game:service"RunService":BindToRenderStep("CANNER",1,function()
            equipallcans()
        end)

        local function collect_ground_items()
            pcall(function()
                for i,v in pairs(game.Workspace.Ignored.ItemsDrop:GetDescendants()) do
                    if v.Name == "[Knife]" or v.Name == "[LockPicker]" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Parent.CFrame.X,v.Parent.CFrame.Y,v.Parent.CFrame.Z)
                        wait(0.1)
                    end
                end
            end)
        end
        repeat
            wait(0.001)
            --equipall()
            if Paused == true then
                repeat wait(0.001) until Paused == false
            end
            collect_ground_items()
            game:service"ReplicatedStorage".MainEvent:FireServer("Block",true)
            player.Character.HumanoidRootPart.CFrame=shop:FindFirstChild("[Flowers] - $5").Head.CFrame*CFrame.new(0,2,0)
            fireclickdetector(shop:FindFirstChild("[Flowers] - $5").ClickDetector)
        until ItemCnt >= maxitems
        pcall(function() game:service"RunService":UnBindToRenderStep("CANNER") end)
        equipall()
        if ItemCnt >= maxitems then
            equipall()
            for i,v in pairs(game.Workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name):GetChildren()) do
                if v:IsA("Accessory") or v:IsA("MeshPart") or v.Name == "Humanoid" or v.Name == "HumanoidRootPart" then 
                    v:Destroy()
                end
            end
        end
    else
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        notify("Ocin Crash!","You've already started crashing...",5)
    end
end)

ForceCrash.MouseButton1Click:Connect(function()
    equipall()
    for i,v in pairs(player.Character:GetChildren()) do
        if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Accessory") or v.Name == "HumanoidRootPart" then
            v:Destroy()
        end
    end
end)
