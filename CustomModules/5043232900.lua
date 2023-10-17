--[[
Credit - kavo ( For Ui lib)
engospy
Infinite Yield
other etc
if your skid make sure to credit source to me or anyone
--]]
repeat task.wait() until game:IsLoaded()
local function GetURL(scripturl)
	return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
end
local kavo = shared.kavogui
local function notify(Titlez, Textz, Iconz, Dur)
game.StarterGui:SetCore("SendNotification", {
    Title = Titlez;
    Text = Textz;
    Icon = Iconz;
    Duration = Dur;
})
end
local connectioninfjump
local players = game:GetService("Players")
local lplr = players.LocalPlayer
local oldchar = lplr.Character
local cam = workspace.CurrentCamera
local replistorage = game:GetService("ReplicatedStorage")
function SpawnObject(object)
	replistorage.SpawnObject:FireServer(object)
end
local function AddHealth()
	replistorage.MoreHealth:FireServer()
end
local function WeaponEvent(weapon)
   replistorage.WeaponEvent:FireServer(weapon)
end
local uis = game:GetService("UserInputService")
local Tabs = shared.Tabs
local Sections = {
	["InfiniteJump"] = Tabs["Blatant"].CreateSection("InfiniteJump"),
	["Speed"] = Tabs["Blatant"].CreateSection("Speed")
}

local InfJump = {["Enabled"] = false}
InfJump = Sections["InfiniteJump"].CreateToggle({
	["Name"] = "InfJump",
	["HoverText"] = "Allows To Spam Jump",
	["Function"] = function(callback)
	  if callback then
			connectioninfjump = uis.JumpRequest:connect(function(jump)
				oldchar.Humanoid:ChangeState("Jumping")
			end)
		else
			connectioninfjump:Disconnect()
		end
	end
})

local speedval = {["Value"] = 23}
local Speed = {["Enabled"] = false}
Speed = Sections["Speed"].CreateToggle({
	["Name"] = "Speed",
	["HoverText"] = "BIMBIMBAMBAM",
	["Function"] = function(callback)
	  if callback then
	    oldchar.Humanoid.WalkSpeed = speedval["Value"]
	  else
	    oldchar.Humanoid.WalkSpeed = 16
		end
	end
})
speed:NewSlider("Speed Value", "Move Faster", 70, 0, function(s)
    speedval["Value"] = s
end)
local VoteClean = Utility:NewSection("VoteClean")
VoteClean:NewButton("VoteClean", "clean the map vote", function()
	game:GetService("ReplicatedStorage").VotingInProgress.VoteEvent:FireServer()
end)
local HealthExploit = Utility:NewSection("HealthExploit")
HealthExploit:NewButton("HealthExploit", "Much More HP Add to Bullet Proof", function()
	
end)
local objecterenter = {["Value"] = ""}
local ObjectGive = Utility:NewSection("Object Spawn")
ObjectGive:NewButton("Object Spawn", "Object Give", function()
	SpawnObject(objecterenter["Value"])
end)
ObjectGive:NewTextBox("Object Name", "e", function(val)
	objecterenter["Value"] = (val)
end)
local enterwea = {["Value"] = ""}
local WeaponGive = Utility:NewSection("Weapon Give")
WeaponGive:NewButton("Weapon Give", "e", function()
WeaponEvent(enterwea["Value"])
end)
WeaponGive:NewTextBox("Weapon Name", "e", function(entername)
	enterwea["Value"] = (entername)
end)
WeaponGive:NewButton("Give Admin Revolver", "OP", function()
	game:GetService("ReplicatedStorage").WeaponEvent:FireServer("Admin Revolver")
end)