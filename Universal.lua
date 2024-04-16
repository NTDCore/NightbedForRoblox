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
local Settings = {
	['InfiniteJump'] = false,
	['Speed'] = {
		['Enabled'] = false,
		['Value'] = 54,
	},
	['Cape'] = false,
	['InstantInteract'] = false
}

local runFunction = function(func) func() end

local Tabs = shared.Tabs
local Sections = {
	['InfiniteJump'] = Tabs['Blatant'].CreateSection('InfiniteJump'),
	['Speed'] = Tabs['Blatant'].CreateSection('Speed'),
	['Cape'] = Tabs['Render'].CreateSection('Cape'),
	['InstantInteract'] = Tabs['Utility'].CreateSection('InstantInteract')
}

function createnotification(Titlez, Textz, Dur)
	game.StarterGui:SetCore('SendNotification', {
		Title = Titlez;
		Text = Textz;
		Duration = Dur;
	})
end
local cloneref = cloneref or function(obj) return obj end
local InfiniteJumpConnection
local InstantInteractConnection
local playersService = cloneref(game:GetService('Players'))
local lplr = playersService.LocalPlayer
local oldchar = lplr.Character
local workspace = cloneref(game:GetService('Workspace'))
local gameCamera = workspace.CurrentCamera
local InputService = cloneref(game:GetService('UserInputService'))

runFunction(function()
	local InfiniteJump = {Enabled = false}
	InfiniteJump = Sections['InfiniteJump'].CreateToggle({
		Name = 'InfiniteJump',
		Function = function(callback)
			if callback then
				Settings['InfiniteJump'] = true
				spawn(function()
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
			Speed.ToggleButton()
			Speed.ToggleButton()
		end,
		['Default'] = 16
	})
	function Cape(char, texture)
		for i,v in pairs(char:GetDescendants()) do
			if v.Name == 'Cape' then
				v:Remove()
			end
		end
		local hum = char:WaitForChild('Humanoid')
		if char:FindFirstChild('Torso') then
			torso = char.Torso
		else
			torso = char.UpperTorso
		end
		local p = Instance.new('Part', torso.Parent)
		p.Name = 'Cape'
		p.Anchored = false
		p.CanCollide = false
		p.TopSurface = 0
		p.BottomSurface = 0
		p.FormFactor = 'Custom'
		p.Size = Vector3.new(0.2,0.2,0.2)
		p.Transparency = 1
		local decal = Instance.new('Decal', p)
		decal.Texture = texture
		decal.Face = 'Back'
		local msh = Instance.new('BlockMesh', p)
		msh.Scale = Vector3.new(9,17.5,0.5)
		local motor = Instance.new('Motor', p)
		motor.Part0 = p
		motor.Part1 = torso
		motor.MaxVelocity = 0.01
		motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
		motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
		local wave = false
		repeat wait(1/44)
			decal.Transparency = torso.Transparency
			local ang = 0.1
			local oldmag = torso.Velocity.magnitude
			local mv = 0.002
			if wave then
				ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
				wave = false
			else
				wave = true
			end
			ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
			motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
			motor.DesiredAngle = -ang
			if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
				motor.MaxVelocity = 0.04
			end
			repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
			if torso.Velocity.magnitude < 0.1 then
				wait(0.1)
			end
		until not p or p.Parent ~= torso.Parent
	end
	local Cape = {Enabled = false}
	local capeConnection
	Cape = Sections['Cape'].CreateToggle({
		Name = 'Cape',
		Function = function(callback)
			if callback then
				Settings['Cape'] = true
				capeConnection = lplr.CharacterAdded:Connect(function(char)
					spawn(function()
						pcall(function() 
							Cape(char, nightbedStore['Assets']['Cape.png'])
						end)
					end)
				end)
				if lplr.Character then
					spawn(function()
						pcall(function() 
							Cape(lplr.Character, nightbedStore['Assets']['Cape.png'])
						end)
					end)
				end
			else
				Settings['Cape'] = false
				if lplr.Character then
					for i,v in pairs(lplr.Character:GetDescendants()) do
						if v.Name == 'Cape' then
							v:Remove()
						end
					end
				end
				if capeConnection then
					capeConnection:Disconnect()
					capeConnection = nil
				end
			end
		end,
		HoverText = 'cool cape'
	})
	local InstantInteract = {Enabled = false}
	InstantInteract = Sections['InstantInteract'].CreateToggle({
		['Name'] = 'InstantInteract',
		['Function'] = function(callback)
			Settings['InstantInteract'] = callback
			if callback then
				InstantInteractConnection = game:GetService('ProximityPromptService').PromptButtonHoldBegan:Connect(function(prompt)
					fireproximityprompt(prompt)
				end)
			else
				InstantInteractConnection:Disconnect()
			end
		end
	})

	function SaveSettings()
		writefile('Nightbed/Profiles/Universal.json',game:GetService('HttpService'):JSONEncode(Settings))
	end
	spawn(function()
		repeat
			--writefile('Nightbed/Profiles/Universal.json',game:GetService('HttpService'):JSONEncode(Settings))
			SaveSettings()
			task.wait(1.3)
		until not shared.NBInjected
	end)
	local suc, res = pcall(function() return game:GetService('HttpService'):JSONDecode(readfile('Nightbed/Profiles/Universal.json')) end)
	if suc and type(res) == 'table' then 
		Settings = res
		task.wait()
		if InfiniteJump then
			InfiniteJump.ToggleButton(Settings['InfiniteJump'])
		end
		if Speed then
			Speed.ToggleButton(Settings['Speed']['Enabled'])
			speedval.Value = Settings['Speed']['Value']
		end
		if InstantInteract then
			InstantInteract.ToggleButton(Settings['InstantInteract'])
		end
	end
end)