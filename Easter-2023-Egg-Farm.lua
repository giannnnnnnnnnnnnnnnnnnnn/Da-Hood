local function getClosestEasterEgg()
	local egg,maxDist = nil,math.huge
	for i,v in pairs(game:GetService("Workspace").Ignored:GetChildren()) do
		if string.find(v.Name,"Egg") then
			local dist = (v:GetPivot().Position - game.Players.LocalPlayer.Character:GetPivot().Position).Magnitude
			if dist < maxDist then
				maxDist = dist
				egg = v
			end
		end
	end
	return egg
end
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

repeat game:GetService("RunService").Heartbeat:Wait() until game:GetService("StarterGui"):GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) == true
while task.wait() do
    pcall(function()
        local closestEgg = getClosestEasterEgg()
        if closestEgg ~= nil then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, closestEgg, 1)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, closestEgg, 0)
        else
            Teleport()
            task.wait(1e9)
        end
    end)
end
