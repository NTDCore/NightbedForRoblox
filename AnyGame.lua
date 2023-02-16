--[[
Testing AnyGame
--]]

repeat task.wait() until game:IsLoaded()
local function GetURL(scripturl)
	local res = game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
assert(res ~= "404: Not Found", "File not found")
return res
end
local getasset = getsynasset or getcustomassetfunction or getcustomasset or function(location) return "rbxasset://"..location end
local kavo = shared.kavogui --loadstring(GetURL("Libraries/kavo.lua"))()
local entityLibrary = shared.vapeentity
local win = kavo:creategui({
	["Title"] = "Nightbed",
	["Theme"] = "Luna"
})

local Tabs = {
	["Combat"] = win.NewTab("Combat"),
	["Blatant"] = win.NewTab("Blatant"),
	["Render"] = win.NewTab("Render"),
	["Utility"] = win.NewTab("Utility"),
	["World"] = win.NewTab("World"),
	["Settings"] = win.NewTab("Settings")
}

local Sections = {
	["Infinite Jump"] = Tabs["Blatant"].NewSection("Infinite Jump"),
	["Speed"] = Tabs["Blatant"].NewSection("Speed"),
	["Cape"] = Tabs["Render"].NewSection("Cape"),
	["Toggle Gui"] = Tabs["Settings"].NewSection("Toggle Gui")
}

function createnotification(Titlez, Textz, Iconz, Dur)
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
local uis = game:GetService("UserInputService")

function runcode(func)
	func()
end)

runcode(function()
Sections["Infinite Jump"].NewToggle({
	["Name"] = "InfiniteJump",
	["Function"] = function(callback)
  if callback then
    local InfJump = {["Enabled"] = true}
		connectioninfjump = uis.JumpRequest:connect(function(jump)
			if InfJump["Enabled"] then
				lplr.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
			end
		end)
	else
		connectioninfjump:Disconnect()
	end
end,
 ["InfoText"] = "Make you can jump any place",
})
end)

runcode(function()
local speed = {["Enabled"] = false}
local speedval = {["Value"] = 23}
local speedmode = {["Value"] = "Normal"}
Sections["Speed"].NewToggle({
	["Name"] = "Speed",
	["Function"] = function(callback)
	speed["Enabled"] = callback
  if speed["Enabled"] then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedval["Value"]
  else
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
end,
["InfoText"] = "Make you Faster"
end)

runcode(function()
	function Cape(char, texture)
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
	local Cape {["Enabled"] = false}
	Sections["Cape"].NewToggle({
		["Name"] = "Cape",
		["Function"] = function(callback)
			Cape["Enabled"] = callback
			if Cape["Enabled"] then
				lplr.CharacterAdded:Connect(function(char)
					spawn(function()
						pcall(function() 
							Cape(char, ("rbxthumb://type=Asset&id=" .. 11121170269 .. "&w=420&h=420"))
						end)
					end)
				end)
				if lplr.Character then
					spawn(function()
						pcall(function() 
							Cape(lplr.Character, ("rbxthumb://type=Asset&id=" .. 11121170269 .. "&w=420&h=420"))
						end)
					end)
				end
			else
				if lplr.Character then
				 for i,v in pairs(lplr.Character:GetDescendants()) do
					if v.Name == "Cape" then
						v:Remove()
					end
				end
			end
		end
	end,
["InfoText"] = "cool cape"
	})
end)

Sections["Toggle Gui"].NewKeybind({
	["Name"] = "Toggle Gui",
	["Keybind"] = Enum.KeyCode.RightShift,
	["Function"] = function()
		kavo:ToggleGui()
	end,
	["InfoText"] = "toggle ui keybind"
})
