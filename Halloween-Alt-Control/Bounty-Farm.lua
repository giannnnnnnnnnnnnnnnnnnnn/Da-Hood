--[[
    Setting up config tutorial: https://www.youtube.com/watch?v=CgiFXyx1Kas&list=RDMM&index=2
    Commands:
    /start -- Begins the bounty farm
    /stop -- Stops the bounty farm
    /cpu -- Loads up CPU Savers for the host account
    /bounty {user} -- Host says the bounty of the user in chat
    /fps {amount} -- Sets the hosts FPS Cap to the inputted amount
    Loadstring Version: https://github.com/halloweevn/roblox-scripts/blob/main/DHBountyFarmer/loadstring.lua
]]--

-- // IF YOU ARE USING THE SOURCE VERSION THEN REMOVE THE --[[ & ]]--

--[[
	getgenv().Settings = {
	    ["HostSettings"] = {
		["Host"] = 3089996348, -- // Host ID (Account that inputs commands and collects stomps/bounty)
		["KickAfter"] = 6, -- // Input nil for no kick | Amount of hours you want the host to be kicked after (Prevents not saving due to crashing/data-overflow)
	    },
	    ["AttackerSettings"] = {
		["Attacker"] = 2609275756, -- // Attacker ID (Account that kills all the ALTs)
		["Location"] = "Admin", -- // Location that the attacker will kill the ALTs (Admin, Bank, School, Uphill, Downhill)
	    },
	    ["CrewID"] = 2, -- // Group ID (Attacker + Host must be inside of the group)
	    ["ALTSettings"] = {
		["FPS"] = 3, -- // ALTs FPS
		["ALTs"] = { -- // WARNING: These ALTs will lose there bounty
		    3984370157,
		    3984371129,
		    12345,
		},
	    },
	}
]]--

-- // Check if already loaded
if getgenv().BountyFarm_Loaded then
    return
else
    getgenv().BountyFarm_Loaded = true
end

-- // Check game
if game.PlaceId ~= 2788229376 then
    game:GetService("Players").LocalPlayer:Kick("ERROR: Script only works inside of Da Hood.")
    task.wait(3)
    game:Shutdown()
end

-- // Await until game is fully loaded
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Workspace").Players:FindFirstChild(game:GetService("Players").LocalPlayer.Name)

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GroupService = game:GetService("GroupService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- // Variables
local LocalPlayer = Players.LocalPlayer
local UserID = LocalPlayer.UserId
local Name = LocalPlayer.Name
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
local AttackerName, HostName = Players:GetNameFromUserIdAsync(tonumber(getgenv().Settings.AttackerSettings.Attacker)), Players:GetNameFromUserIdAsync(tonumber(getgenv().Settings.HostSettings.Host))
local Time = tick()
local FlaggedRemotes = { "TeleportDetect", "CHECKER_1", "CHECKER_2", "OneMoreTime", "VirusCough", "BreathingHAMON", "TimerMoney" }
local Locations_ = { "admin", "bank", "school", "uphill", "downhill" }
local Locations = { ["admin"] = "-871.935181, -38.4068375, -588.868347, -0.999704123, 0, 0.0243410096, 0, 1, 0, -0.0243410096, 0, -0.999704123", ["bank"] = "-376.216675, 21.2503242, -298.184235, -0.999768972, 0, -0.0214929413, 0, 1, 0, 0.0214929413, 0, -0.999768972", ["school"] = "-601.21228, 21.2503242, 188.315369, -0.999998808, 0, 0.00155379577, 0, 1, 0, -0.00155379577, 0, -0.999998808", ["uphill"] = "389.474701, 47.7507286, -929.45166, -0.999916553, 0, -0.0129480334, 0, 1, 0, 0.0129480334, 0, -0.999916553", ["downhill"] = "-382.443329, 12.7501945, -689.088623, -0.998909593, 0, 0.0466874763, 0, 1, 0, -0.0466874763, 0, -0.998909593" }
local Accounts = {}

-- // ANTI AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
end)

-- // Adding accounts to a dictionary/table
table.insert(Accounts, tonumber(getgenv().Settings.HostSettings.Host))
table.insert(Accounts, tonumber(getgenv().Settings.AttackerSettings.Attacker))
for _, v in pairs(getgenv().Settings.ALTSettings.ALTs) do
    table.insert(Accounts, tonumber(v))
end
table.sort(Accounts)

-- // Checking for duplicate IDs
for _, v in ipairs(Accounts) do
    if v ~= 12345 then
        if Accounts[_ + 1] == v then
            LocalPlayer:Kick("ERROR: Duplicate account has been found. ID: " .. v)
            task.wait(10)
            while true do end -- // Incase of ANTI kick
        end
    end
end

-- // Awaiting until Host + Attacker has joined the game
StarterGui:SetCore("SendNotification", { Title = "*", Text = "Awaiting until " .. HostName .. " joins the game.", Duration = 10 })
repeat task.wait() until Players:FindFirstChild(HostName)
StarterGui:SetCore("SendNotification", { Title = "*", Text = "Awaiting until " .. AttackerName .. " joins the game.", Duration = 10 })
repeat task.wait() until Players:FindFirstChild(AttackerName)
StarterGui:SetCore("SendNotification", { Title = "!", Text = "Bounty Farmer has been loaded.", Duration = 10 })

-- // Checking if the account is inside of the Settings dictionary
if table.find(Accounts, UserID) then

    -- // ANTI Seats (Honestly i just dont like seats)
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v.Disabled = true
        end
    end

    -- // Checking if the location is correct
    if not table.find(Locations_, getgenv().Settings.AttackerSettings.Location:lower()) then

        LocalPlayer:Kick("ERROR: Selected location: " .. getgenv().Settings.AttackerSettings.Location .. " doesn't exist. Available locations: (Admin, Bank, School, Uphill, Downhill)")
        task.wait(10)
        while true do end -- // Incase of ANTI kick

    end

    getgenv().DH_Bounty_Farm_Stomps = 0

    -- // Joining crew
    if UserID == getgenv().Settings.HostSettings.Host or UserID == getgenv().Settings.AttackerSettings.Attacker then

        -- // Counting executions
        game:HttpGet("https://api.countapi.xyz/hit/31d6cfe0d16ae931b73c59d7e0c089c0") -- // Spam it if you must, all it does is count up (Credits to 9Oblivion#6121 for API)

        local Groups = {}

        for _, v in pairs(GroupService:GetGroupsAsync(UserID)) do
            table.insert(Groups, v.Id)
        end

        if table.find(Groups, getgenv().Settings.CrewID) then
            
            ReplicatedStorage.MainEvent:FireServer("JoinCrew", getgenv().Settings.CrewID)
            repeat task.wait() until LocalPlayer.PlayerGui.MainScreenGui.Crew.CrewFrame.Visible == true
            task.wait()
            LocalPlayer.PlayerGui.MainScreenGui.Crew.CrewFrame.Visible = false

        else
            
            StarterGui:SetCore("SendNotification", { Title = "ERROR", Text = "Please join the group you inputed inside of Crew_ID on your Attacker + Host Accounts. ID: " .. tonumber(getgenv().Settings.CrewID), Duration = tonumber(math.huge) })
            getgenv().BountyFarm_Loaded = false
            return
            
        end
        
    else

        ReplicatedStorage.MainEvent:FireServer("LeaveCrew")

    end

    -- // ANTI Cheat bypass
    local oldnamecall;
    oldnamecall = hookmetamethod(game, "__namecall", function(...)
        local args = {...}
        local namecallmethod = getnamecallmethod()
        if (namecallmethod == "FireServer" and args[1] == "MainEvent" and table.find(FlaggedRemotes, args[2])) then
            return
        end
        return oldnamecall(table.unpack(args))
    end)

    -- // Creating chat commands
    ReplicatedStorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Command)

        local MessageData = string.lower(Command.Message)
        local args = string.split(MessageData, " ")
        if Players[Command.FromSpeaker].UserId == getgenv().Settings.HostSettings.Host then

            -- // Start command
            if args[1] == "/start" then
                
                -- // Checking if DH_Bounty_Farm is already toggled
                if DH_Bounty_Farm then

                    if UserID == getgenv().Settings.HostSettings.Host then

                        -- // ERROR Message
                        StarterGui:SetCore("SendNotification", { Title = "*", Text = "DH_Bounty_Farm is already active, please input /stop before attempting to start it again.", Duration = 3 })

                    end

                else

                    -- // Setting boolen to true
                    getgenv().DH_Bounty_Farm = true

                    if UserID == getgenv().Settings.HostSettings.Host then

                        -- // Stomping/Bounty-Farming operation
                        task.spawn(function()
                            repeat task.wait() until Workspace.Players:FindFirstChild(Name)
                            while DH_Bounty_Farm do
                                task.wait()
                                for _, v in pairs(Workspace.Players:GetChildren()) do
                                    local Old_Position = nil
                                    local TargetID = Players:GetUserIdFromNameAsync(v.Name)
                                    if v.BodyEffects["K.O"].Value == true and v.BodyEffects["Grabbed"].Value == nil and v.BodyEffects["Dead"].Value == false and table.find(getgenv().Settings.ALTSettings.ALTs, TargetID) then
                                        Old_Position = LocalPlayer.Character.HumanoidRootPart.CFrame.Position
                                        if Players:FindFirstChild(v.Name) and Workspace.Players:FindFirstChild(v.Name) then
                                            pcall(function()
                                                repeat
                                                    task.wait()
                                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[v.Name].Character.UpperTorso.Position + Vector3.new(0, 2, 0))
                                                    ReplicatedStorage.MainEvent:FireServer("Stomp")
                                                until v.BodyEffects["Dead"].Value == true or not DH_Bounty_Farm
                                                DH_Bounty_Farm_Stomps = DH_Bounty_Farm_Stomps + 1
                                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Old_Position)
                                                v:Destroy() -- // Destroying player when dead to stop there body from getting in the way
                                            end)
                                        end
                                    end
                                end
                            end
                        end)

                        -- // Restarting Stomping/Bounty-Farming operation if host died
                        task.spawn(function()
                            LocalPlayer.CharacterAdded:Connect(function()
                                if DH_Bounty_Farm then
                                    repeat task.wait() until Workspace.Players:FindFirstChild(Name)
                                    while DH_Bounty_Farm do
                                        task.wait()
                                        for _, v in pairs(Workspace.Players:GetChildren()) do
                                            local Old_Position = nil
                                            local TargetID = Players:GetUserIdFromNameAsync(v.Name)
                                            if v.BodyEffects["K.O"].Value == true and v.BodyEffects["Grabbed"].Value == nil and v.BodyEffects["Dead"].Value == false and table.find(getgenv().Settings.ALTSettings.ALTs, TargetID) then
                                                Old_Position = LocalPlayer.Character.HumanoidRootPart.CFrame.Position
                                                if Players:FindFirstChild(v.Name) and Workspace.Players:FindFirstChild(v.Name) then
                                                    pcall(function()
                                                        repeat
                                                            task.wait()
                                                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[v.Name].Character.UpperTorso.Position + Vector3.new(0, 2, 0))
                                                            ReplicatedStorage.MainEvent:FireServer("Stomp")
                                                        until v.BodyEffects["Dead"].Value == true or not DH_Bounty_Farm
                                                        DH_Bounty_Farm_Stomps = DH_Bounty_Farm_Stomps + 1
                                                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Old_Position)
                                                        v:Destroy() -- // Destroying player when dead to stop there body from getting in the way
                                                    end)
                                                end
                                            end
                                        end
                                    end
                                end
                            end)
                        end)

                        -- // Resetting player every 10 mins to stop bugs
                        task.spawn(function()
                            while DH_Bounty_Farm do
                                task.wait(600)
                                StarterGui:SetCore("SendNotification", { Title = "#", Text = "Your character will force-reset in 3 seconds to fix bugs.", Duration = 3 })
                                task.wait(3)
                                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                                    if v:IsA("BasePart") then
                                        v:Destroy()
                                    end
                                end
                            end
                        end)

                        -- // Kicking host after so long to prevent data not saving
                        task.spawn(function()
                            if getgenv().Settings.HostSettings.KickAfter ~= nil then
                                local Converted_Time = tonumber(Settings.HostSettings.KickAfter) * 3600
                                task.wait(tonumber(Converted_Time))
                                LocalPlayer:Kick("Your data has been saved. (This prevents not saving due to crashing/data-overflow)")
                            end
                        end)
                    
                    elseif UserID == getgenv().Settings.AttackerSettings.Attacker then

                        if DH_Bounty_Farm then

                            local Selected_Location = getgenv().Settings.AttackerSettings.Location:lower()

                            -- // Destroying LocalPlayers scripts (Fixes not being able to deal no damage when TPing)
                            if LocalPlayer.Character:FindFirstChildWhichIsA("Script").Name ~= "Health" then
                                LocalPlayer.Character:FindFirstChildWhichIsA("Script"):Destroy()
                            end

                            -- // Stopping people from unequipping fists
                            task.spawn(function()
                                while DH_Bounty_Farm do
                                    task.wait()
                                    if not LocalPlayer.Character:FindFirstChild("Combat") then
                                        LocalPlayer.Backpack:FindFirstChild("Combat").Parent = LocalPlayer.Character
                                    end
                                end
                            end)

                            -- // Killing operation
                            task.spawn(function()
                                while DH_Bounty_Farm do
                                    task.wait()
                                    local Selected_Location = getgenv().Settings.AttackerSettings.Location:lower()
                                    local Position = string.split(Locations[Selected_Location])
                                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Position[1], Position[2], Position[3], Position[4], Position[5], Position[6], Position[7], Position[8], Position[9], Position[10], Position[11], Position[12])
                                    LocalPlayer.Character:FindFirstChild("Combat"):Activate()
                                end
                            end)
                        end
                    
                    elseif table.find(getgenv().Settings.ALTSettings.ALTs, UserID) then

                        -- // TPing to attacker until dead
                        repeat wait() until Workspace.Players:FindFirstChild(Name)
                        repeat
                            task.wait()
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[AttackerName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 0, 3)
                        until Workspace.Players:FindFirstChild(Name).BodyEffects["Dead"].Value == true or not DH_Bounty_Farm
                        
                        -- // Restarting loop on death
                        LocalPlayer.CharacterAdded:Connect(function()
                            repeat wait() until Workspace.Players:FindFirstChild(Name)
                            repeat
                                task.wait()
                                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Players[AttackerName].Character.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 0, 3)
                            until Workspace.Players:FindFirstChild(Name).BodyEffects["Dead"].Value == true or not DH_Bounty_Farm
                        end)
                    end
                end

            -- // Stop command
            elseif args[1] == "/stop" then

                if not DH_Bounty_Farm then

                    if UserID == getgenv().Settings.HostSettings.Host then

                        -- // ERROR Message
                        StarterGui:SetCore("SendNotification", { Title = "*", Text = "DH_Bounty_Farm is not active, please input /start before attempting to stop it.", Duration = 3 })

                    end

                else

                    -- // Setting boolen to false
                    getgenv().DH_Bounty_Farm = false

                    if UserID == getgenv().Settings.AttackerSettings.Attacker then

                        task.wait(2) -- // Just to stop things from breaking badly

                        --// Reseting attacker to get the LocalPlayer scripts back
                        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                            if v:IsA("BasePart") then
                                v:Destroy()
                            end
                        end

                    end
                end

            -- // CPU command
            elseif args[1] == "/cpu" then

                if not CPU_Toggle then

                    if UserID == getgenv().Settings.HostSettings.Host then

                        -- // Setting boolen to true
                        getgenv().CPU_Toggle = true
                        
                        -- // Black screen (With cool stats 😉)
                        local d41d8cd98f00b204e9800998ecf8427e = Instance.new("ScreenGui")
                        local BlackScreenFrame = Instance.new("Frame")
                        local BountyFarmText = Instance.new("TextLabel")
                        local CreatorText = Instance.new("TextLabel")
                        local CPUText = Instance.new("TextLabel")
                        local StatsButton = Instance.new("ImageButton")
                        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
                        local StatsFrame = Instance.new("Frame")
                        local AmountOfStompsText = Instance.new("TextLabel")
                        local BountyValueText = Instance.new("TextLabel")
                        local TimeInGameText = Instance.new("TextLabel")
                        local UICorner = Instance.new("UICorner")
                        d41d8cd98f00b204e9800998ecf8427e.Name = "d41d8cd98f00b204e9800998ecf8427e"
                        d41d8cd98f00b204e9800998ecf8427e.Parent = CoreGui
                        d41d8cd98f00b204e9800998ecf8427e.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        BlackScreenFrame.Name = "BlackScreenFrame"
                        BlackScreenFrame.Parent = d41d8cd98f00b204e9800998ecf8427e
                        BlackScreenFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                        BlackScreenFrame.Position = UDim2.new(-0.392961025, 0, -0.298732191, 0)
                        BlackScreenFrame.Size = UDim2.new(0, 6274, 0, 2023)
                        BountyFarmText.Name = "BountyFarmText"
                        BountyFarmText.Parent = d41d8cd98f00b204e9800998ecf8427e
                        BountyFarmText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BountyFarmText.BackgroundTransparency = 1.000
                        BountyFarmText.Position = UDim2.new(0.428050041, 0, 0.373684198, 0)
                        BountyFarmText.Size = UDim2.new(0.143378526, 0, 0.0631579012, 0)
                        BountyFarmText.Font = Enum.Font.GothamBlack
                        BountyFarmText.Text = "Bounty Farm"
                        BountyFarmText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        BountyFarmText.TextSize = 54.000
                        CreatorText.Name = "CreatorText"
                        CreatorText.Parent = d41d8cd98f00b204e9800998ecf8427e
                        CreatorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        CreatorText.BackgroundTransparency = 1.000
                        CreatorText.Position = UDim2.new(0.428050041, 0, 0.436842084, 0)
                        CreatorText.Size = UDim2.new(0.143378526, 0, 0.0631579012, 0)
                        CreatorText.Font = Enum.Font.GothamBlack
                        CreatorText.Text = "Halloween#0002"
                        CreatorText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        CreatorText.TextSize = 22.000
                        CPUText.Name = "CPUText"
                        CPUText.Parent = d41d8cd98f00b204e9800998ecf8427e
                        CPUText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        CPUText.BackgroundTransparency = 1.000
                        CPUText.Position = UDim2.new(0.428050041, 0, 0.488421053, 0)
                        CPUText.Size = UDim2.new(0.143378526, 0, 0.0631579012, 0)
                        CPUText.Font = Enum.Font.GothamBlack
                        CPUText.Text = "CPU/Memory Saver (Input /cpu to remove this)"
                        CPUText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        CPUText.TextSize = 37.000
                        StatsButton.Name = "StatsButton"
                        StatsButton.Parent = d41d8cd98f00b204e9800998ecf8427e
                        StatsButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        StatsButton.BackgroundTransparency = 1.000
                        StatsButton.Position = UDim2.new(0.486444235, 0, 0.572631598, 0)
                        StatsButton.Size = UDim2.new(0.0260000005, 0, 0.0529999994, 0)
                        StatsButton.Image = "http://www.roblox.com/asset/?id=6022668897"
                        UIAspectRatioConstraint.Parent = StatsButton
                        UIAspectRatioConstraint.AspectRatio = 0.990
                        StatsFrame.Name = "StatsFrame"
                        StatsFrame.Parent = d41d8cd98f00b204e9800998ecf8427e
                        StatsFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                        StatsFrame.Position = UDim2.new(0.373305529, 0, 0.657894731, 0)
                        StatsFrame.Size = UDim2.new(0.253388941, 0, 0.291578948, 0)
                        StatsFrame.Visible = false
                        AmountOfStompsText.Name = "AmountOfStompsText"
                        AmountOfStompsText.Parent = StatsFrame
                        AmountOfStompsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        AmountOfStompsText.BackgroundTransparency = 1.000
                        AmountOfStompsText.Position = UDim2.new(0.329284668, 0, 0.175128162, 0)
                        AmountOfStompsText.Size = UDim2.new(0.336794347, 0, 0.178681195, 0)
                        AmountOfStompsText.Font = Enum.Font.GothamBlack
                        AmountOfStompsText.Text = "Amount of stomps: 0"
                        AmountOfStompsText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        AmountOfStompsText.TextSize = 22.000
                        BountyValueText.Name = "BountyValueText"
                        BountyValueText.Parent = StatsFrame
                        BountyValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        BountyValueText.BackgroundTransparency = 1.000
                        BountyValueText.Position = UDim2.new(0.329284668, 0, 0.398954898, 0)
                        BountyValueText.Size = UDim2.new(0.336794347, 0, 0.178681195, 0)
                        BountyValueText.Font = Enum.Font.GothamBlack
                        BountyValueText.Text = "Bounty: nil"
                        BountyValueText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        BountyValueText.TextSize = 22.000
                        TimeInGameText.Name = "TimeInGameText"
                        TimeInGameText.Parent = StatsFrame
                        TimeInGameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        TimeInGameText.BackgroundTransparency = 1.000
                        TimeInGameText.Position = UDim2.new(0.329284668, 0, 0.644442141, 0)
                        TimeInGameText.Size = UDim2.new(0.336794347, 0, 0.178681195, 0)
                        TimeInGameText.Font = Enum.Font.GothamBlack
                        TimeInGameText.Text = "Time in game: 00:00:00"
                        TimeInGameText.TextColor3 = Color3.fromRGB(148, 148, 148)
                        TimeInGameText.TextSize = 22.000
                        UICorner.Parent = StatsFrame
                        local function CTHGMF_fake_script()
                            local script = Instance.new('LocalScript', StatsButton)
                            local Debounce = false
                            script.Parent.MouseButton1Click:Connect(function()	
                                if not Debounce then
                                    Debounce = true
                                    task.wait()
                                    script.Parent.Parent.StatsFrame.Visible = true
                                elseif Debounce then
                                    Debounce = false
                                    task.wait()
                                    script.Parent.Parent.StatsFrame.Visible = false
                                end
                            end)
                        end
                        coroutine.wrap(CTHGMF_fake_script)()
                        local function EQLDGG_fake_script()
                            local script = Instance.new('LocalScript', AmountOfStompsText)
                            function CommaValue(Amount)
                                local Formatted = Amount
                                while true do  
                                    Formatted, k = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                                    if (k == 0) then
                                        break
                                    end
                                end
                                return Formatted
                            end
                            while task.wait() do
                                script.Parent.Text = "Amount of stomps: " .. CommaValue(DH_Bounty_Farm_Stomps)
                            end
                        end
                        coroutine.wrap(EQLDGG_fake_script)()
                        local function GBOXQFG_fake_script()
                            local script = Instance.new('LocalScript', BountyValueText)
                            function CommaValue(Amount)
                                local Formatted = Amount
                                while true do  
                                    Formatted, k = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                                    if (k == 0) then
                                        break
                                    end
                                end
                                return Formatted
                            end
                            while task.wait() do
                                script.Parent.Text = "Bounty: " .. CommaValue(game:GetService("Players").LocalPlayer.DataFolder.Information.Wanted.Value)
                            end
                        end
                        coroutine.wrap(GBOXQFG_fake_script)()
                        local function GFDOJSA_fake_script()
                            local script = Instance.new('LocalScript', TimeInGameText)
                            function convertToHMS(Seconds)
                                local Minutes = (Seconds - Seconds % 60) / 60
                                Seconds = Seconds - Minutes * 60
                                local Hours = (Minutes - Minutes % 60) / 60
                                Minutes = Minutes - Hours * 60
                                return string.format("%02i", Hours) .. ":" .. string.format("%02i", Minutes) .. ":" .. string.format("%02i", Seconds)
                            end
                            while task.wait(1) do
                                script.Parent.Text = "Time in game: " .. convertToHMS(tick() - Time)
                            end
                        end
                        coroutine.wrap(GFDOJSA_fake_script)()

                        -- // CPU saving
                        RunService:Set3dRenderingEnabled(false)
                        settings().Rendering.QualityLevel = 1
                        UserSettings().GameSettings.MasterVolume = 0
                        pcall(set_fps_cap, 30)
                        pcall(setfpscap, 30)

                    end
                
                elseif CPU_Toggle then

                    if UserID == getgenv().Settings.HostSettings.Host then

                        -- // Setting boolen to false
                        getgenv().CPU_Toggle = false

                        -- // Destroying black screen
                        game:GetService("CoreGui").d41d8cd98f00b204e9800998ecf8427e:Destroy()

                        -- // Disabling the CPU savers
                        RunService:Set3dRenderingEnabled(true)
                        settings().Rendering.QualityLevel = 3
                        UserSettings().GameSettings.MasterVolume = 4
                        pcall(set_fps_cap, 60)
                        pcall(setfpscap, 60)
                    
                    end
                end
            
            -- // Bounty command
            elseif args[1] == "/bounty" and args[2] ~= nil then

                if UserID == getgenv().Settings.HostSettings.Host then

                    local Target = nil

                    function CommaValue(Amount)
                        local Formatted = Amount
                        while true do  
                            Formatted, k = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
                            if (k == 0) then
                                break
                            end
                        end
                        return Formatted
                    end

                    for _, v in pairs(Players:GetChildren()) do
                        if string.sub(string.lower(v.Name), 1, string.len(args[2])) == string.lower(args[2]) or string.sub(string.lower(v.DisplayName), 1, string.len(args[2])) == string.lower(args[2]) then
                            Target = v.Name
                        end
                    end

                    if Target ~= nil then
                        SayMessageRequest:FireServer(Target .. "'s Bounty: " .. CommaValue(Players[Target].DataFolder.Information.Wanted.Value), "All")

                    else

                        -- // ERROR Message
                        StarterGui:SetCore("SendNotification", { Title = "*", Text = "Failed to find a player with the name " .. args[2] .. ".", Duration = 3 })

                    end
                end
            
            -- // FPS command
            elseif args[1] == "/fps" and args[2] ~= nil then

                if UserID == getgenv().Settings.HostSettings.Host then

                    if tonumber(args[2]) >= 30 and tonumber(args[2]) <= 999 then

                        pcall(setfpscap, tonumber(args[2]))
                        pcall(set_fps_cap, tonumber(args[2]))
                        SayMessageRequest:FireServer("Your FPS has been capped to " .. tonumber(args[2]), "All")
                    
                    else

                        -- // ERROR Message
                        StarterGui:SetCore("SendNotification", { Title = "*", Text = "Please retry with the FPS range from 30-999.", Duration = 3 })

                    end
                end
            end
        end
    end)

    -- // CPU saving
    if UserID == getgenv().Settings.AttackerSettings.Attacker or table.find(getgenv().Settings.ALTSettings.ALTs, UserID) then

        -- // Black screen
        local _4918cab1d537edb8775f295fcb3496ea = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        local TextLabel_2 = Instance.new("TextLabel")
        local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
        local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
        local TextLabel_3 = Instance.new("TextLabel")
        local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
        local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
        _4918cab1d537edb8775f295fcb3496ea.Name = "4918cab1d537edb8775f295fcb3496ea"
        _4918cab1d537edb8775f295fcb3496ea.Parent = CoreGui
        _4918cab1d537edb8775f295fcb3496ea.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Frame.Parent = _4918cab1d537edb8775f295fcb3496ea
        Frame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        Frame.Position = UDim2.new(-0.398196638, 0, -0.301901758, 0)
        Frame.Size = UDim2.new(0, 6274, 0, 2023)
        TextLabel.Parent = _4918cab1d537edb8775f295fcb3496ea
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Position = UDim2.new(0.466182709, 0, 0.416190147, 0)
        TextLabel.Size = UDim2.new(0.0681818202, 0, 0.0649001524, 0)
        TextLabel.Font = Enum.Font.GothamBlack
        TextLabel.Text = "Bounty Farmer"
        TextLabel.TextColor3 = Color3.fromRGB(125, 125, 125)
        TextLabel.TextSize = 49.000
        UITextSizeConstraint.Parent = TextLabel
        UITextSizeConstraint.MaxTextSize = 49
        UIAspectRatioConstraint.Parent = TextLabel
        UIAspectRatioConstraint.AspectRatio = 2.862
        TextLabel_2.Parent = _4918cab1d537edb8775f295fcb3496ea
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.Position = UDim2.new(0.462198675, 0, 0.525099754, 0)
        TextLabel_2.Size = UDim2.new(0.0755681843, 0, 0.0583717376, 0)
        TextLabel_2.Font = Enum.Font.GothamBlack
        TextLabel_2.Text = "CPU & Memory Saver (NO YOU CAN'T REMOVE THIS)"
        TextLabel_2.TextColor3 = Color3.fromRGB(125, 125, 125)
        TextLabel_2.TextSize = 49.000
        UITextSizeConstraint_2.Parent = TextLabel_2
        UITextSizeConstraint_2.MaxTextSize = 49
        UIAspectRatioConstraint_2.Parent = TextLabel_2
        UIAspectRatioConstraint_2.AspectRatio = 1.981
        TextLabel_3.Parent = _4918cab1d537edb8775f295fcb3496ea
        TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_3.BackgroundTransparency = 1.000
        TextLabel_3.Position = UDim2.new(0.468624562, 0, 0.480885178, 0)
        TextLabel_3.Size = UDim2.new(0.0630681813, 0, 0.0443788879, 0)
        TextLabel_3.Font = Enum.Font.GothamBlack
        TextLabel_3.Text = "By Halloween#0002"
        TextLabel_3.TextColor3 = Color3.fromRGB(125, 125, 125)
        TextLabel_3.TextSize = 27.000
        UITextSizeConstraint_3.Parent = TextLabel_3
        UITextSizeConstraint_3.MaxTextSize = 27
        UIAspectRatioConstraint_3.Parent = TextLabel_3
        UIAspectRatioConstraint_3.AspectRatio = 2.869

        -- // CPU saving
        RunService:Set3dRenderingEnabled(false)
        settings().Rendering.QualityLevel = 1
        UserSettings().GameSettings.MasterVolume = 0
        
        -- // Removing map
        for i,v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end

        -- // Setting FPS cap (Only on attacker because too low FPS = hard time hitting)
        if UserID == getgenv().Settings.AttackerSettings.Attacker then

            task.wait(2) -- // Once again fixing errors with wait times
            setfpscap(15)

        end
    end

    -- // Destroying other accounts
    if table.find(getgenv().Settings.ALTSettings.ALTs, UserID) then

        -- // Setting FPS cap
        setfpscap(tonumber(getgenv().Settings.ALTSettings.FPS))

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Name ~= AttackerName and v.Name ~= HostName then
                for _, v in pairs(v.Character:GetChildren()) do
                    v:Destroy()
                end
            end
        end
    end
end
