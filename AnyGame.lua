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
local kavo = loadstring(GetURL("Libraries/kavo.lua"))()
local window = kavo.CreateLib("Nightbed", "Luna")
local tabs = function(tabName)
return NewTab(tabName.."")
end
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
local uis = game:GetService("UserInputService")
notify("Notification", "Prees RightShift to Toggle UI", 5)

local Combat = window:NewTab("Combat")
local Blatant = window:NewTab("Blatant")
local Render = window:NewTab("Render")
local Utility = window:NewTab("Utility")
local World = window:NewTab("World")
local hud = window:NewTab("Hud")
local Setting = window:NewTab("Settings")
local Credit = window:NewTab("Credits")

local InfJump = {["Enabled"] = false}
local InfJump = Blatant:NewSection("InfJump")
InfJump:NewToggle("InfJump", "Spam Jumping", function(tog)
  if tog then
    local InfJump = {["Enabled"] = true}
		connectioninfjump = uis.JumpRequest:connect(function(jump)
			if InfJump["Enabled"] then
				lplr.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
			end
		end)
	else
		connectioninfjump:Disconnect()
	end
end)

local speedval = {["Value"] = 23}
local speed = Blatant:NewSection("Speed")
speed:NewToggle("Speed", "Speedy", function(tog)
  if tog then
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedval["Value"]
  else
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end
end)
