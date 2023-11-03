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
	["Speed"] = Tabs["Blatant"].CreateSection("Speed"),
	["VoteClean"] = Tabs["Utility"].CreateSection("VoteClean"),
	["HealthExploit"] = Tabs["Utility"].CreateSection("HealthExploit"),
	["SpawnObj"] = Tabs["Utility"].CreateSection["Spawn Object"]
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
speedval = Sections["Speed"].CreateSlider({
	["Name"] = "Speed Value",
	["HoverText"] = "Move Faster", 
	["Max"] = 70,
	["Min"] = 0,
	["Function"] = function(s)
    speedval["Value"] = s
	end
})

local VoteClean = Sections["VoteClean"]
VoteClean:NewButton("VoteClean", "clean the map vote", function()
	game:GetService("ReplicatedStorage").VotingInProgress.VoteEvent:FireServer()
end)
local HealthExploit = Sections["HealthExploit"]
HealthExploit:NewButton({
	Name = "HealthExploit", HoverText = "Much More HP Add to Bullet Proof", Function = function()
		for i = 1,200 do
			AddHealth()
		end
	end
})
local objecterenter = {["Value"] = ""}
local ObjectGive = Sections["SpawnObj"]
ObjectGive.CreateButton({
	Name = "Object Spawn", HoverText = "Object Give", Function = function()
	SpawnObject(objecterenter["Value"])
end})
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