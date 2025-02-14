--[[
	Credits
	Infinite Yield - InfJump
	engospy - RemoteEvent
	Kavo Owner - kavo ui
	7GrandDadPGN (xylex) - Vape Entity
--]]
local entityLibrary = shared.vapeentity
local kavo = shared.kavogui
local FunctionsLibrary = shared.funcslib
local nightbedStore = shared.NBStore
local nightbedService = shared.NBService
local robloxService = shared.rblxService
local nightbedData
-- local Settings = {
-- 	['InfiniteJump'] = false,
-- 	['Speed'] = {
-- 		['Enabled'] = false,
-- 		['Value'] = 16
-- 	},
-- 	['Cape'] = false,
-- 	['InstantInteract'] = false
-- }

local run = function(func) func() end

local Tabs = shared.Tabs
if not shared.nightbedopen then
	local Sections = {
		['InfiniteJump'] = Tabs['Blatant'].CreateSection('InfiniteJump'),
		['Speed'] = Tabs['Blatant'].CreateSection('Speed'),
		['InstantInteract'] = Tabs['Utility'].CreateSection('InstantInteract')
	}
	shared.Sections = Sections
else
	shared.Sections = {}
end

local cloneref = cloneref or function(obj) return obj end
local httpService = cloneref(game.GetService(game, 'HttpService'))
local githubRequest = function(scripturl)
	return game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/NTDCore/NightbedForRoblox/commits'))[1].sha..'/'..scripturl, true)
end
local InfiniteJumpConnection
local InstantInteractConnection
local playersService = cloneref(game:GetService('Players'))
local lplr = playersService.LocalPlayer
local oldchar = lplr.Character
local workspace = cloneref(game:GetService('Workspace'))
local gameCamera = workspace.CurrentCamera
local InputService = cloneref(game:GetService('UserInputService'))
local proximityPromptService = cloneref(game:GetService('ProximityPromptService'))

run(function()
	if not shared.nightbedopen then
		local InfiniteJump = {Enabled = false}
		InfiniteJump = Sections['InfiniteJump'].CreateToggle({
			Name = 'InfiniteJump',
			Function = function(callback)
				if callback then
					Settings['InfiniteJump'] = true
					task.spawn(function()
						InfiniteJumpConnection = InputService.JumpRequest:connect(function(jump)
							oldchar.Humanoid:ChangeState('Jumping')
						end)
					end)
				else
					Settings['InfiniteJump'] = false
					InfiniteJumpConnection:Disconnect()
				end
			end,
			HoverText = 'Make you can jump any place'
		})
		local Speed = {Enabled = false}
		local speedval = {Value = 16}
		Speed = Sections['Speed'].CreateToggle({
			Name = 'Speed',
			Function = function(callback)
				Settings['Speed']['Enabled'] = callback
				if callback then
					Settings['Speed']['Enabled'] = true
					oldchar.Humanoid.WalkSpeed = speedval.Value
				else
					Settings['Speed']['Enabled'] = false
					oldchar.Humanoid.WalkSpeed = 16
				end
			end,
			HoverText = 'Make you Faster'
		})
		speedval = Sections['Speed'].CreateSlider({
			['Name'] = 'Speed Value',
			['HoverText'] = 'Move Faster', 
			['Max'] = 100,
			['Min'] = 0,
			['Function'] = function(s)
				speedval['Value'] = s
				Settings['Speed']['Value'] = s
				Speed.ToggleButton()
				Speed.ToggleButton()
			end,
			['Default'] = 16
		})
		local InstantInteract = {Enabled = false}
		InstantInteract = Sections['InstantInteract'].CreateToggle({
			['Name'] = 'InstantInteract',
			['Function'] = function(callback)
				Settings['InstantInteract'] = callback
				if callback then
					InstantInteractConnection = proximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
						fireproximityprompt(prompt)
					end)
				else
					InstantInteractConnection:Disconnect()
				end
			end
		})
	end
	-- function SaveSettings()
	-- 	writefile('Nightbed/Profiles/Universal.json',game:GetService('HttpService'):JSONEncode(Settings))
	-- end
	-- spawn(function()
	-- 	repeat
	-- 		--writefile('Nightbed/Profiles/Universal.json',game:GetService('HttpService'):JSONEncode(Settings))
	-- 		SaveSettings()
	-- 		task.wait(1.3)
	-- 	until not shared.NBInjected
	-- end)
	-- local suc, res = pcall(function() return game:GetService('HttpService'):JSONDecode(readfile('Nightbed/Profiles/Universal.json')) end)
	-- if suc and type(res) == 'table' then 
	-- 	Settings = res
	-- 	task.wait()
	-- 	if InfiniteJump then
	-- 		InfiniteJump.ToggleButton(Settings['InfiniteJump'])
	-- 	end
	-- 	if Speed then
	-- 		Speed.ToggleButton(Settings['Speed']['Enabled'])
	-- 		speedval.SetSlider(Settings['Speed']['Value'])
	-- 		--speedval.Value = Settings['Speed']['Value']
	-- 	end
	-- 	if InstantInteract then
	-- 		InstantInteract.ToggleButton(Settings['InstantInteract'])
	-- 	end
	-- end
	local MainLoaded = function()
		local customModuleURL = 'https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/NTDCore/NightbedForRoblox/commits'))[1].sha..'/CustomModules/'..game.PlaceId..'.lua'
		local customModuleScript = game:HttpGet(customModuleURL, true)
		if customModuleScript then
			local success, error = pcall(function()
				loadstring(customModuleScript)()
			end)
			if not success then
				warn('Failed To Loaded Modules: ' .. tostring(error))
				--loadstring(githubRequest('Universal.lua'))()
			end
		end
	end
	MainLoaded()
end)