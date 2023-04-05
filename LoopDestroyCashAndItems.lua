local jordan1 = workspace.Ignored.Drop
local jordan11 = workspace.Ignored.ItemsDrop
local jordan2 = "MoneyDrop"

getgenv().LoopDel = true
while LoopDel ~= false do
    task.wait(0.2)
    coroutine.resume(coroutine.create(function()
        for i,v in pairs(jordan1:GetChildren()) do
            if v.Name == tostring(jordan2) or v:isA("Part") or v:IsA("MeshPart") then
                v:Destroy()
                for i,e in ipairs(jordan11:GetChildren()) do
                    if e:IsA("Part") then
                        e:Destroy()
                    end
                end
            end
        end
    end))
end
