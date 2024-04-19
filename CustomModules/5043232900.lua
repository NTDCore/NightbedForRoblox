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
local kavo
if (not shared.kavogui) then
	kavo = loadstring(GetURL("Core/kavo.lua"))()
else
	kavo = shared.kavogui
end
local function notify(Titlez, Textz, Dur)
game.StarterGui:SetCore("SendNotification", {
    Title = Titlez;
    Text = Textz;
    Duration = Dur;
})
end
local connectioninfjump
local cloneref = cloneref or function(aaa) return aaa end
local players = cloneref(game:GetService("Players"))
local lplr = players.LocalPlayer
local oldchar = lplr.Character
local workspace = cloneref(game:GetService('Workspace'))
local cam = workspace.CurrentCamera
local replistorage = cloneref(game:GetService("ReplicatedStorage"))
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
	['AddonsExploit'] = Tabs['Utility'].CreateSection('AddonsExploit'),
	["VoteClean"] = Tabs["Utility"].CreateSection("VoteClean"),
	["HealthExploit"] = Tabs["Utility"].CreateSection("HealthExploit"),
	["SpawnObj"] = Tabs["Utility"].CreateSection("Spawn Object"),
	["SpawnIt"] = Tabs["Utility"].CreateSection("Weapons")
}

local VoteClean = Sections["VoteClean"]
VoteClean.CreateButton({
	Name="VoteClean",
	HoverText="clean the map vote",
	Function=function()
		game:GetService("ReplicatedStorage").VotingInProgress.VoteEvent:FireServer()
	end
})
local HealthExploit = Sections["HealthExploit"]
HealthExploit.CreateButton({
	Name = "HealthExploit",
	HoverText = "Much More HP Add to Bullet Proof",
	Function = function()
		for i = 1,200 do
			AddHealth()
		end
	end
})
local InfiniteHP = {Enabled = false}
InfiniteHP = HealthExploit.CreateToggle({
	Name = "InfiniteHP",
	HoverText = "Much More HP Add to Bullet Proof",
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat
					task.wait(0)
					-- for some stupid reason it not working lawl
					local argument = {
						[1] = -math.huge
					}
					lplr.Character.FallDamage.RemoteEvent:FireServer(unpack(argument))
				until (not InfiniteHP.Enabled)
			end)
		end
	end
})
local AddonsExploit = Sections["AddonsExploit"]
AddonsExploit.CreateButton({
	Name = 'AddonsExploit',
	Function = function()
		for i,v in replistorage.AddonStorage:GetChildren() do
			local cloned = v:Clone()
			cloned.Parent = lplr.PlayerGui.Spawner.SpawnFrame.Addons
			--cloned.Visible = true
		end
	end
})
local objecterenter = {["Value"] = ""}
Sections["SpawnObj"].CreateButton({
	Name = "Object Spawn",
	HoverText = "Object Give",
	Function = function()
		SpawnObject(objecterenter["Value"])
	end
})
Sections["SpawnObj"].CreateTextBox({
	Name = "Object Name",
	HoverText = "e",
	Function = function(val)
		objecterenter["Value"] = val
	end
})
local enterwea = {["Value"] = ""}
Sections["SpawnIt"].CreateButton({Name="Weapon Give",HoverText="e",Function=function()
	WeaponEvent(enterwea["Value"])
end})
Sections["SpawnIt"].CreateTextBox({Name="Weapon Name",HoverText="e",Function=function(entername)
	enterwea["Value"] = entername
end})
Sections["SpawnIt"].CreateButton({Name="Give Admin Revolver",HoverText="OP",Function=function()
	WeaponEvent("Admin Revolver")
end})