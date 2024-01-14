getgenv().BountySettings = {
    stomper = 1234567890, -- // the account that gets the bounty.
    killer = 1234567890, -- // the account that buys a bat and knocks the alts.
    goal = 1000000, -- // the goal on how much bounty you want before you get auto-kicked.
    autoLeave = true -- // auto kick enabler / disabler (disconnect when stomper leaves)
}

--[[
Steps:
1. On stomper, put the id of the alt that gets the bounty.
2. On the killer, put the id of the alt that kills the other alts for stomps.
3. You can set a custom goal until you get kicked (avoid memory leaks).
4. Set auto leave to false if you don't want your other alts to get kicked when your stomper leaves the game.

Auto features:
- Already finds a mutual group to be in a crew.
- Auto buys bat if you have 1k+ dhc

Recommendations:
- 1 stomper, 1 killer, 14 alts (more or less then 14 will result in something bad)
- The killer needs 1k+ dhc to get a bat to efficiently kill the alts.
- 1m - 2m goal, sometimes more then that will result in the server crashing due to memory leaks.
- Recommend the alts being stomped to not have hats, wings, accessory that will flood the server RAM and cause a server crash, this does not avoid the crash still.
]]

-- // have fun skidding !!!
if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat wait(0.01) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)

local player = game:service"Players".LocalPlayer
local event = game:service"ReplicatedStorage".MainEvent
local location = CFrame.new(-217,-28,335)
local isStomper = player.UserId == getgenv().BountySettings["stomper"]
local isKiller = player.UserId == getgenv().BountySettings["killer"]

player.Idled:connect(function()
	game:service"VirtualUser":Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:service"VirtualUser":Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local remotes = {
    "CHECKER_1",
    "CHECKER_2",
    "TeleportDetect",
    "OneMoreTime",
    "BreathingHAMON",
    "VirusCough"
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

local function lowGFX(host, fps)
    host = host or false
    fps = fps or 3
    local fps_capper = setfpscap or set_fps_cap

    pcall(function() fps_capper(fps) end)
    settings().Physics.PhysicsEnvironmentalThrottle = 1
    settings().Rendering.QualityLevel = 'Level01'
    UserSettings():GetService("UserGameSettings").MasterVolume = 0
    if not host then
        game:service"RunService":Set3dRenderingEnabled(false)
    end
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then
            v.Material = Enum.Material.SmoothPlastic
            if not host then
                v.Transparency = 1
            end
        elseif v:IsA("Decal") then
            v:Destroy()
        elseif v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("MeshPart") then
            v.TextureID = 0
            if not host then
                v.Transparency = 1
            end
        elseif v.Name == "Terrian" then
            v.WaterReflectace = 1
            v.WaterTransparency = 1
        elseif v:IsA("SpotLight") then
            v.Range = 0
            v.Enabled = false
        elseif v:IsA("WedgePart") then
            if not host then
                v.Transparency = 1
            end
        elseif v:IsA("UnionOperation") then
            if not host then
                v.Transparency = 1
            end
        end
    end
end

if isStomper or isKiller then -- checks for mutual groups
    local killersGroups, stomperGroups = {}, {} 
    for i,v in pairs(game:service"GroupService":GetGroupsAsync(getgenv().BountySettings["killer"])) do
        table.insert(killersGroups, v.Id)
    end
    for i,v in pairs(game:service"GroupService":GetGroupsAsync(getgenv().BountySettings["stomper"])) do
        table.insert(stomperGroups, v.Id)
    end
    table.sort(killersGroups)
    table.sort(stomperGroups)

    event:FireServer("LeaveCrew")
    task.delay(3, function()
        pcall(function()
            player.PlayerGui.MainScreenGui.Crew.CrewFrame:Destroy()
        end)
        for i=1,#killersGroups do
            for c=1,#stomperGroups do
                if killersGroups[i] == stomperGroups[c] then
                    repeat -- dumb reason doesn't join first try lol
                        event:FireServer("JoinCrew", tostring(stomperGroups[c]))
                        wait(0.01)
                    until tostring(player.DataFolder.Information.Crew.Value) == tostring(stomperGroups[c])
                end
            end
        end 

        
    end)
end

local function findTool(baseName)
    baseName = tostring(baseName):lower()
    for i,v in pairs(workspace.Ignored.Shop:GetChildren()) do
        if v.Name:lower():sub(1,baseName:len()) == baseName:sub(1,baseName:len()) then
            return v
        end
    end
    return nil
end

game:service"Players".PlayerRemoving:Connect(function(child)
    if child.UserId == getgenv().BountySettings["stomper"] and getgenv().BountySettings["autoLeave"] then
        game:Shutdown()
    end
end)

if isStomper then
    local OldWanted = player.leaderstats.Wanted.Value
    player.leaderstats.Wanted.Changed:Connect(function()
        if player.leaderstats.Wanted.Value >= OldWanted + getgenv().BountySettings["goal"] then
            player:Kick("goal", getgenv().BountySettings["goal"], "reached")
        end
    end)

    task.spawn(function()
        lowGFX(true, 30)
        while true do wait(0.001)
            pcall(function()
                for i,v in pairs(game:service"Players":GetChildren()) do
                    if v.Name ~= player.Name and v.Character.BodyEffects:FindFirstChild("K.O").Value == true and v.Character.BodyEffects:FindFirstChild("Dead").Value == false then
                        repeat
                            player.Character.HumanoidRootPart.CFrame = CFrame.new(v.Character.UpperTorso.Position) + Vector3.new(0,1.6,0)
                            event:FireServer("Stomp")
                            wait(0.01)
                        until v.Character.BodyEffects:FindFirstChild("Dead").Value == true
                        pcall(function() workspace.Players:FindFirstChild(v.Name):Destroy() end)
                    end
                end
            end)
        end
    end)
elseif isKiller then
    local bat = findTool("[Bat]")
    task.spawn(function()
        lowGFX(false, 3)
        local weapon = ""
        while true do wait(0.01)
            pcall(function()
                if not player.Backpack:FindFirstChild("[Bat]") and not player.Character:FindFirstChild("[Bat]") and player.DataFolder.Currency.Value >= 1000 then
                    repeat
                        player.Character.HumanoidRootPart.CFrame = bat.Head.CFrame
                        fireclickdetector(bat:FindFirstChildWhichIsA("ClickDetector"))
                        wait(0.01)
                    until player.Backpack:FindFirstChild("[Bat]") or player.Character:FindFirstChild("[Bat]")
                    weapon = "[Bat]"
                elseif not player.Backpack:FindFirstChild("[Bat]") and not player.Character:FindFirstChild("[Bat]") and player.DataFolder.Currency.Value < 1000 then
                    weapon = "Combat"
                end

                if player.Backpack:FindFirstChild(weapon) then
                    player.Backpack:FindFirstChild(weapon).Parent = player.Character
                end
                player.Character.HumanoidRootPart.CFrame = location
                player.Character:FindFirstChild(weapon):Activate()
            end)
        end
    end)
else
    task.spawn(function()
        lowGFX(false, 3)
        while true do wait(0.001)
            pcall(function()
                player.Character.HumanoidRootPart.CFrame = location + Vector3.new(math.random(-1,1), 0, math.random(-1,1))
            end)
        end
    end)
end
