repeat task.wait() until game:IsLoaded()
if not isfile("NightbedConfig.JSON") then writefile("NightbedConfig.JSON","{}")
end
local betterisfile = function(file)
local suc, res = pcall(function() return readfile(file) end)
return suc and res ~= nil
end
local function GetURL(scripturl)
if shared.NightbedDeveloper then
if not betterisfile("Nightbed/"..scripturl) then
error("File not found : Nightbed/"..scripturl)
end
return readfile("Nightbed/"..scripturl)
else
	local res = game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
assert(res ~= "404: Not Found", "File not found")
return res
end
end
local getasset = getsynasset or getshitmotherasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/MainScript.lua'))()")
	end
	end)
local kavo = loadstring(GetURL("Libraries/kavo.lua"))()
local window = kavo.CreateLib("Nightbed", "Luna")
shared.kavo = kavo
local function getcustomassetfunc(path)
if not betterisfile(path) then
spawn(function()
	local textlabel = Instance.new("TextLabel")
	textlabel.Size = UDim2.new(1, 0, 0, 36)
	textlabel.Text = "Downloading "..path
	textlabel.BackgroundTransparency = 1
	textlabel.TextStrokeTransparency = 0
	textlabel.TextSize = 30
	textlabel.Font = Enum.Font.SourceSans
	textlabel.TextColor3 = Color3.new(1, 1, 1)
	textlabel.Position = UDim2.new(0, 0, 0, -36)
	textlabel.Parent = kavo["MainGui"]
	repeat task.wait() until betterisfile(path)
	textlabel:Remove()
	end)
local req = requestfunc({
	Url = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..path:gsub("Nightbed/assets", "assets"),
	Method = "GET"
})
writefile(path, req.Body)
end
return getasset(path)
end

local shalib = loadstring(GetURL("Libraries/sha.lua"))()
shared.shaonline = shalib
local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua"))()
shared.VapeEntity = entity
if isfolder(customdir:gsub("/", "")) == false then
makefolder(customdir:gsub("/", ""))
end
if isfolder("Nightbed") == false then
makefolder("Nightbed")
end
if isfolder("Nightbed/CustomModules") == false then
makefolder("Nightbed/CustomModules")
end
if isfolder("Nightbed/Profiles") == false then
makefolder("Nightbed/Profiles")
end
if isfolder("Nightbed/assets") == false then
makefolder("Nightbed/assets")
end

local tabs = function(tabName)
return kavo = window:NewTab(tabName.."")
end
local Combat = tabs("Combat")
local Blatant = tabs("Blatant")
local Render = tabs("Render")
local Utility = tabs("Utility")
local World = tabs("World")
local Setting = tabs("Settings")
local Credit = tabs("Credits")

local sec = function(secName)
return kavo = window:NewSection(secName.."")
end)
--[[
local bind = function(keytext, keyinf, first, callback)
return kavo = window:NewKeybind(keytext.."", keyinf.."", first.."", callback.."")
end
--]]
if game.PlaceId == 6872274481 or game.PlaceId == 8560631822 or game.PlaceId == 8444591321 then
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/6872274481.lua"))()
elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"))()
elseif isfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
end