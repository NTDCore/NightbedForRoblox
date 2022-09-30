--[[in development everything try working on it lol
Credit -- infnite Yeild
-- xylex 7granddadpgn , Moerii , Everyone that i added ok?
]]


local kavo = shared.kavoU
local sha = shared.shaonline
local entity = shared.VapeEntity
local whitelists = shared.inlist
local players = game:GetService("Players")
local lplr = players.LocalPlayer


local UI = Instance.new("ScreenGui")
local boarderoutside = Instance.new("Frame")
local board = Instance.new("Frame")
local title = Instance.new("TextLabel")
local text = Instance.new("TextLabel")
UI.Name = "UI"
UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UI.ResetOnSpawn = false

local function notification(titlez, textz, timecount)
	boarderoutside.Name = "boarderoutside"
	boarderoutside.Parent = UI
	boarderoutside.BackgroundColor3 = Color3.fromRGB(153, 0, 255)
	boarderoutside.BorderColor3 = Color3.fromRGB(0, 0, 0)
	boarderoutside.LayoutOrder = 1
	boarderoutside.Position = UDim2.new(0.727, 0, 0.836, 0) --{0.727, 0},{0.836, 0}
	boarderoutside.Size = UDim2.new(0, 265, 0, 101)
	boarderoutside.ZIndex = 2
	UICorner.Parent = boarderoutside
	board.Name = "board"
	board.Parent = boarderoutside
	board.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	board.LayoutOrder = 1
	board.Position = UDim2.new(0.0230687559, 0, 0.0665573254, 0)
	board.Size = UDim2.new(0, 252, 0, 87)
	UICorner_2.Parent = board
	title.Name = "title"
	title.Parent = boarderoutside
	title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	title.BackgroundTransparency = 1.000
	title.Position = UDim2.new(-0.245283023, 0, 0.0665573254, 0)
	title.Size = UDim2.new(0, 217, 0, 39)
	title.Font = Enum.Font.SourceSans
	title.Text = titlez
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextSize = 22.000
	text.Name = "text"
	text.Parent = boarderoutside
	text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	text.BackgroundTransparency = 1.000
	text.Position = UDim2.new(-0.245283023, 0, 0.531903863, 0)
	text.Size = UDim2.new(0, 202, 0, 34)
	text.Font = Enum.Font.SourceSans
	text.Text = textz
	text.TextColor3 = Color3.fromRGB(255, 255, 255)
	text.TextSize = 22.000
	wait(timecount)
	boarderoutside.Visible = false
end

local function BindToRenderStep(name, num, func)
	if RenderStepTable[name] == nil then
		RenderStepTable[name] = game:GetService("RunService").RenderStepped:connect(func)
	end
end
local function UnbindFromRenderStep(name)
	if RenderStepTable[name] then
		RenderStepTable[name]:Disconnect()
		RenderStepTable[name] = nil
	end
end

local function BindToStepped(name, num, func)
	if StepTable[name] == nil then
		StepTable[name] = game:GetService("RunService").Stepped:connect(func)
	end
end
local function UnbindFromStepped(name)
	if StepTable[name] then
		StepTable[name]:Disconnect()
		StepTable[name] = nil
	end
end

local function Cape(char, texture)
	for i,v in pairs(char:GetDescendants()) do
		if v.Name == "Cape" then
			v:Remove()
		end
	end
	local hum = char:WaitForChild("Humanoid")
	if char:FindFirstChild("Torso") then
		torso = char.Torso
	else
		torso = char.UpperTorso
	end
	local p = Instance.new("Part", torso.Parent)
	p.Name = "Cape"
	p.Anchored = false
	p.CanCollide = false
	p.TopSurface = 0
	p.BottomSurface = 0
	p.FormFactor = "Custom"
	p.Size = Vector3.new(0.2,0.2,0.2)
	p.Transparency = 1
	local decal = Instance.new("Decal", p)
	decal.Texture = texture
	decal.Face = "Back"
	local msh = Instance.new("BlockMesh", p)
	msh.Scale = Vector3.new(9,17.5,0.5)
	local motor = Instance.new("Motor", p)
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
local function isAlive(plr)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return lplr and lplr.Character and lplr.Character.Parent ~= nil and lplr.Character:FindFirstChild("HumanoidRootPart") and lplr.Character:FindFirstChild("Head") and lplr.Character:FindFirstChild("Humanoid")
end
local SpeedT = {["Enabled"] = false}
local speedval = {["Value"] = 1}
local speedmode = {["Value"] = "Normal"}
local speedtick = tick()
local bodyvelo
local doingfunny = false
local didboosttick = tick()
local timesdone = 0
local boosttimes = 0
local raycastparameters = RaycastParams.new()
local funni = false
local speedcheck
local Speed = Blatant:NewSection("Speed")
Speed:NewToggle("Speed", "More Speed Walking Set", function(y)
	if y then
		if speedmode["Value"] == "CFrame" then
					speedtick = tick() + 5
				else
					speedtick = 0
				end
			local newlongjumpvelo = longjumpvelo.Unit * math.max((Vector3.zero - longjumpvelo).magnitude - entity.character.Humanoid.WalkSpeed, 0)
			newlongjumpvelo = newlongjumpvelo == newlongjumpvelo and newlongjumpvelo or Vector3.zero
			local newpos = spidergoinup and Vector3.zero or (longjump["Enabled"] and newlongjumpvelo or (entity.character.Humanoid.MoveDirection * (((speedval["Value"] + (speedspeedup["Enabled"] and killauranear and speedtick >= tick() and (48 - speedval["Value"]) or 0)) * getSpeedMultiplier(true)) - 20))) * delta * (GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] and 0 or 1)
			local movevec = entity.character.Humanoid.MoveDirection.Unit * allowedvelo
			movevec = movevec == movevec and movevec or Vector3.zero
			local velocheck = not (longjump["Enabled"] and newlongjumpvelo == Vector3.zero)
			raycastparameters.FilterDescendantsInstances = {lplr.Character}
			local ray = workspace:Raycast(entity.character.HumanoidRootPart.Position, newpos, raycastparameters)
			if ray then newpos = (ray.Position - entity.character.HumanoidRootPart.Position) end
			if networkownerfunc(entity.character.HumanoidRootPart) then
				if slowdowntick <= tick() then
					entity.character.HumanoidRootPart.CFrame = entity.character.HumanoidRootPart.CFrame + newpos
				end
				entity.character.HumanoidRootPart.Velocity = vec3(velocheck and movevec.X or 0, entity.character.HumanoidRootPart.Velocity.Y, velocheck and movevec.Z or 0)
			end
		elseif speedmode["Value"] == "Normal" then 
			if (bodyvelo == nil or bodyvelo ~= nil and bodyvelo.Parent ~= entity.character.HumanoidRootPart) then
				bodyvelo = Instance.new("BodyVelocity")
				bodyvelo.Parent = entity.character.HumanoidRootPart
				bodyvelo.MaxForce = vec3(9e9, 0, 9e9)
			else
				bodyvelo.MaxForce = ((entity.character.Humanoid:GetState() == Enum.HumanoidStateType.Climbing or entity.character.Humanoid.Sit or spidergoinup or antivoiding or GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] or uninjectflag) and Vector3.zero or (longjump["Enabled"] and vec3(9e9, 0, 9e9) or vec3(9e9, 0, 9e9)))
				bodyvelo.Velocity = longjump["Enabled"] and longjumpvelo or entity.character.Humanoid.MoveDirection * ((GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"] and 0 or ((longjumpticktimer >= tick() or slowdowntick >= tick()) and allowedvelo) or speedval["Value"]) * 1) * getSpeedMultiplier(true) * (slowdownspeed and slowdownspeedval or 1) * (bedwars["RavenTable"]["spawningRaven"] and 0 or 1) * ((combatcheck or combatchecktick >= tick()) and AnticheatBypassCombatCheck["Enabled"] and (not longjump["Enabled"]) and (not GuiLibrary["ObjectsThatCanBeSaved"]["FlyOptionsButton"]["Api"]["Enabled"]) and 0.84 or 1)
				print(bodyvelo.Velocity.Magnitude)
			end
		end
else
	RunLoops:UnbindFromHeartbeat("Speed")
	doingfunny = false
	if speedcheck then 
		speedcheck:Disconnect()
	end
	if bodyvelo then
		bodyvelo:Remove()
	end
	if entity.isAlive then 
		for i,v in pairs(entity.character.HumanoidRootPart:GetChildren()) do 
			if v:IsA("BodyVelocity") then 
				v:Remove()
			end
		end
	end
end
end)
Speed:NewSlider("Speed Value", "Adjust CFrame speed", 1000, 1, function(s)
	speedval["Value"] = s
end)
Speed:NewDropdown("SpeedMode", "e", {"CFrame", "Normal"}, function(currentOption)
    speedmode["Value"] = (currentOption)
end)

local Cape = Render:NewSection("Cape")
Cape:NewToggle("Cape", "Cape Behind U torse", function(callback)
	if callback then
		notification("Notification", "Cape : Enabled", 5)
		lplr.CharacterAdded:Connect(function(char)
			spawn(function()
				pcall(function() 
					Cape(char, ("http://www.roblox.com/asset/?id=11121170269"))
				end)
			end)
		end)
		if lplr.Character then
			spawn(function()
				pcall(function() 
					Cape(lplr.Character, ("http://www.roblox.com/asset/?id=11121170269"))
				end)
			end)
		end
	else
		notification("Notification", "Cape : Disabled", 5)
		if lplr.Character then
			for i,v in pairs(lplr.Character:GetDescendants()) do
				if v.Name == "Cape" then
					v:Remove()
				end
			end
		end
	end
end)
