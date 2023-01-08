local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua"))()
local Window = Library.CreateLib("Noboline", "Ocean") -- wtf it Nightbed
local colorbox
local function makeRainbowText(text)
spawn(function()
	colorbox = Color3.fromRGB(170,0,170)
	local x = 0
	while wait() do
	colorbox = Color3.fromHSV(x,1,1)
	x = x + 4.5/255
	if x >= 1 then
	x = 0
	end
	end
	end)
spawn(function()
	repeat
	wait()
	text.TextColor3 = colorbox
	until true == false
	end)
end

local players = game:GetService("Players")
local lplr = players.LocalPlayer
local body = lplr.Character

local MainToggle = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local ToggleBtn = Instance.new("ImageButton")

MainToggle.Name = "MainToggle"
MainToggle.Parent = game.CoreGui
MainToggle.ResetOnSpawn = false

Frame.Parent = MainToggle
Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
Frame.BackgroundTransparency = 0.200
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0109622413, 0, 0.0136186769, 0)
Frame.Size = UDim2.new(0, 149, 0, 149)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0402684584, 0, 0.798657715, 0)
TextLabel.Size = UDim2.new(0, 132, 0, 30)
TextLabel.Font = Enum.Font.SourceSansLight
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.Text = "Noboline | Nightbed"
makeRainbowText(TextLabel, true)

UICorner.Parent = Frame

ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundTransparency = 1.000
ToggleBtn.Position = UDim2.new(0.137143791, 0, 0.0700296983, 0)
ToggleBtn.Size = UDim2.new(0, 108, 0, 108)
ToggleBtn.Image = "rbxassetid://7211055081"
ToggleBtn.MouseButton1Down:connect(function()
	Library:ToggleUI()
	end)

-- Window --

local movemente = Window:NewTab("Movement")
local clientsided = Window:NewTab("Serversided")
local spawnsid = Window:NewTab("SpawnSided")
local credits = Window:NewTab("credits")

-- Section --

local serversec = clientsided:NewSection("Main")
local spawnsec = spawnsid:NewSection("Main")
local movesec = movemente:NewSection("Movement")
movesec:NewToggle("Speed", "", function(callback)
	if callback then
	body.Humanoid.Wallspeed = 35
	else
		body.Humanoid.WalkSpeed = 16
	end
	end)
movesec:NewButton("infjump", "", function()
	local InfiniteJumpEnabled = true
	game:GetService("UserInputService").JumpRequest:connect(function()
		if InfiniteJumpEnabled then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
		end
		end)
	end)

function slapple()
local args = {
	[1] = game:GetService("Players").LocalPlayer.Equipped
}

game:GetService("ReplicatedStorage").AdminGoldenSlappleSpawnEvent:FireServer(unpack(args))
end
spawnsec:NewButton("Slapple", "", function()
	slapple()
	end)
serversec:NewButton("BrazilGlove", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").BrazilEvent:FireServer(unpack(args))
	end)

serversec:NewButton("BOBBLE GLOVE", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").BOBBLEEvent:FireServer(unpack(args))

	end)

function spawn(wtf)
local args = {
	[1] = game:GetService("Players").LocalPlayer.Equipped
}

game:GetService("ReplicatedStorage").wtf:FireServer(unpack(args))
end

serversec:NewButton("SusGlove", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").SusEvent:FireServer(unpack(args))
	end)
serversec:NewButton("Clone() glove", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").CloneGloveEvent:FireServer(unpack(args))
	end)
serversec:NewButton("Goku", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").GokuEvent:FireServer(unpack(args))
	end)
serversec:NewButton("Minecraft", "", function()
	local args = {
		[1] = game:GetService("Players").LocalPlayer.Equipped
	}

	game:GetService("ReplicatedStorage").MineCraftEvent:FireServer(unpack(args))
	end)

function edge()
local args = {
	[1] = game:GetService("Players").LocalPlayer.Equipped
}

game:GetService("ReplicatedStorage").AdminEdgelordEvent:FireServer(unpack(args))
end
serversec:NewButton("AdminEdgelord", "", function()
	edge()
	end)
function AdminEventz()
local args = {
	[1] = game:GetService("Players").LocalPlayer.Equipped
}

game:GetService("ReplicatedStorage").AdminEvent:FireServer(unpack(args))

end
serversec:NewButton("AdminEvent", " ", function()
	AdminEventz()
	end)
function AbilityExploiter()
local args = {
	[1] = game:GetService("Players").LocalPlayer.Equipped
}

game:GetService("ReplicatedStorage").AbiliyEvent:FireServer(unpack(args))

end

serversec:NewButton("DIENT", "", function()
	spawn(DientEvent)
end)
serversec:NewButton("SoldierGlove", "", function()
	spawn(AdminsoldierEvent)
end)
serversec:NewButton("AbilityExploit", "Work at all glove", function()
	AbilityExploiter()
	end)
-- SpawnSided --
spawnsid:NewButton("EyeSpawn", "", function()
	spawn(AdminEyeSpawnEvent)
end)
spawnsid:NewButton("GlitchSpawn", "", function()
	spawn(AdminGlitchSpawnEvent)
end)
serversid:NewButton("SlateSpawn", "", function()
	spawn(AdminSlateSpawnEvent)
end)
-- Credits --

local cre = credits:NewSection("Credit To infinite yield")
local cre = credits:NewSection("Credit to engospy")
local cre = credits:NewSection("Owner : NTDCore (Monia#9266)")
local cre = credits:NewSection("Developer : MOONCoreDev (Moon | NightCore#6654)")