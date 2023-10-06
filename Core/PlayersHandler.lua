local players = game:GetService("Players")
local lplr = players.LocalPlayer
local PlayersHandler = {
	["Alive"] = false,
	["mainchar"] = {
		["Head"] = {},
		["Humanoid"] = {},
		["RootPart"] = {}
	}
}

PlayersHandler.isAlive = function(plr, check)
	plr = plr or lplr
	check = check or true
	if plr and check then
		PlayersHandler.Alive = check
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character.HumanoidRootPart and plr.Character.Head and plr.Character.Humanoid
	end
end
return PlayersHandler