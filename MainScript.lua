repeat task.wait() until game:IsLoaded()
local isfile = isfile or function(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end

local kavo
kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua", true))()
shared.kavogui = kavo
local Sections = {}
shared.SectionsLoaded = Sections

local entityLibrary =
loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua",
true))()
shared.vapeentity = entityLibrary
local FunctionsLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/FunctionsHandler.lua", true))()
shared.funcslib = FunctionsLibrary

local queueteleport = queue_on_teleport

local TeleportString = [[
  loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/MainScript.lua", true))
]]

queueteleport(TeleportString)

if isfolder("Nightbed") == false then
	makefolder("Nightbed")
end

if isfolder("Nightbed/assets") == false then
	makefolder("Nightbed/assets")
end

if isfolder("Nightbed/Profiles") == false then
  makefolder("Nightbed/Profiles")
end
local AnyGame = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua",
true))()
]]
if isfolder("Nightbed/CustomModules") == false then
	makefolder("Nightbed/CustomModules")
end

function MainLoaded()
  local customModuleURL = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"
  local customModuleScript = game:HttpGet(customModuleURL, true)
  if customModuleScript then
    local success, error = pcall(function()
      loadstring(customModuleScript)()
    end)
    if not success then
      warn("Failed To Loaded Modules: " .. tostring(error))
      --FunctionsLibrary.displayErrorPopup("Error", "CustomModules Not Found\nLaunch As AnyGame\n Error: .. tostring(error), "OK")
      loadstring(AnyGame)()
    end
  else
    loadstring(AnyGame)()
  end
end

--[[
function MainLoaded()
  if game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
  	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua", true))()
  elseif isfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
    loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
  else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
  end
end
--]]

task.spawn(function()
  MainLoaded()
end)

if not shared.FuncsConnect then
	repeat
		shared.FuncsConnect = true
	until shared.FuncsConnect
end
