--[[
Credit - kavo ( For Ui lib)
engospy
Infinite Yield
other etc
if your skid make sure to credit source to me or anyone
--]]
repeat task.wait() until game:IsLoaded()
local function GetURL(scripturl)
	return game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/'..scripturl, true)
end
local kavo
if (not shared.kavogui) then
	kavo = loadstring(GetURL('Core/kavo.lua'))()
else
	kavo = shared.kavogui
end
local function notify(Titlez, Textz, Dur)
	game.StarterGui:SetCore('SendNotification', {
		Title = Titlez;
		Text = Textz;
		Duration = Dur;
	})
end
local connectioninfjump
local cloneref = cloneref and not identifyexecutor():find('Xeno') or function(aaa) return aaa end
local players = cloneref(game:GetService('Players'))
local lplr = players.LocalPlayer
local oldchar = lplr.Character
local workspace = cloneref(game:GetService('Workspace'))
local cam = workspace.CurrentCamera
local replistorage = cloneref(game:GetService('ReplicatedStorage'))

local typeshit = {}
function typeshit:spawn(object)
	replistorage.SpawnObject:FireServer(object)
end
function typeshit:morehealth()
	replistorage.MoreHealth:FireServer()
end
function typeshit:weapon(weapon)
	replistorage.WeaponEvent:FireServer(weapon)
end
local uis = cloneref(game:GetService('UserInputService'))
local Tabs = shared.Tabs
local Sections = shared.Sections
Sections['AddonsExploit'] = Tabs['Utility'].CreateSection('AddonsExploit')
Sections['VoteClean'] = Tabs['Utility'].CreateSection('VoteClean')
Sections['HealthExploit'] = Tabs['Utility'].CreateSection('HealthExploit')
Sections['SpawnObj'] = Tabs['Utility'].CreateSection('Spawn Object')
Sections['SpawnIt'] = Tabs['Utility'].CreateSection('Weapons')

local VoteClean = Sections['VoteClean']
VoteClean.CreateButton({
	Name='VoteClean',
	HoverText='clean the map vote',
	Function=function()
		replistorage.VotingInProgress.VoteEvent:FireServer()
		for i = 1,#players:GetPlayers() + 1 do
			replistorage.VotingInProgress.VoteAdded:FireServer()
		end
	end
})
local HealthExploit = Sections['HealthExploit']
HealthExploit.CreateButton({
	Name = 'HealthExploit',
	HoverText = 'Much More HP Add to Bullet Proof',
	Function = function()
		for i = 1,200 do
			typeshit:morehealth()
		end
	end
})
local InfiniteHP = {Enabled = false}
InfiniteHP = HealthExploit.CreateToggle({
	Name = 'InfiniteHP',
	HoverText = 'Much More HP Add to Bullet Proof',
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
local AddonsExploit = Sections['AddonsExploit']
AddonsExploit.CreateButton({
	Name = 'AddonsExploit',
	Function = function()
		for i,v in replistorage.AddonStorage:GetChildren() do
			local cloned = v:Clone()
			cloned.Parent = lplr.PlayerGui.Spawner.SpawnFrame.Addons
		end
	end
})
local objecterenter = {['Value'] = ''}
Sections['SpawnObj'].CreateButton({
	Name = 'Object Spawn',
	HoverText = 'Object Give',
	Function = function()
		typeshit:spawn(objecterenter['Value'])
	end
})
Sections['SpawnObj'].CreateButton({
	Name = 'Disaster',
	HoverText = '',
	Function = function()
		typeshit:spawn('Flood')
		typeshit:spawn('bigbadblizzard')
		typeshit:spawn('Tornado')
		typeshit:spawn('Meteors')
	end
})
Sections['SpawnObj'].CreateButton({
	Name = 'HiroshimaBomber',
	HoverText = '',
	Function = function()
		for i = 1,50 do
			typeshit:spawn('Nuke')
		end
	end
})
Sections['SpawnObj'].CreateTextBox({
	Name = 'Object Name',
	HoverText = 'e',
	Function = function(val)
		objecterenter['Value'] = val
	end
})
local enterwea = {['Value'] = ''}
Sections['SpawnIt'].CreateButton({Name='Weapon Give',HoverText='e',Function=function()
	typeshit:weapon(enterwea['Value'])
end})
Sections['SpawnIt'].CreateTextBox({Name='Weapon Name',HoverText='e',Function=function(entername)
	enterwea['Value'] = entername
end})
Sections['SpawnIt'].CreateButton({Name='Give Crucifix',HoverText='OP',Function=function()
	typeshit:weapon('Crucifix')
end})
Sections['SpawnIt'].CreateButton({Name='Give Admin Revolver',HoverText='OP',Function=function()
	typeshit:weapon('Admin Revolver')
end})
Sections['SpawnIt'].CreateButton({Name='Give All Items',HoverText='OP',Function=function()
	for i,v in replistorage.Miscs.Viewmodels:GetChildren() do
		typeshit:weapon(v.Name:gsub('v_', ''))
	end
end})