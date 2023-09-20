local hook; hook = syn.oth.hook(game, '__index', function(self, key)
    if (game.Players.LocalPlayer.Character:FindFirstChild(self) and key == 'Velocity') then
        return Vector3.new(0, 0, 0)
    end
    return hook(self, key)
end)
