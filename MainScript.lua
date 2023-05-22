repeat task.wait() until game:IsLoaded()
local isfile = isfile or function(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end

local kavo
kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua", true))()
shared.kavogui = kavo

local entityLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()
local FunctionsLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/FunctionsHandler.lua", true))()
shared.funcslib = FunctionsLibrary
local Settings = {}
shared.Settings = Settings

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

if isfolder("Nightbed/CustomModules") == false then
	makefolder("Nightbed/CustomModules")
end

function MainLoaded()
  if not shared.NightbedLoaded then
    if game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
  	  loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua", true))()
    elseif isfile("Nightbed/CustomModules/"..game.PlaceId..".lua") and game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
      loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
    else
    	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
    end
  end
end

if not shared.NightbedLoaded then
  MainLoaded()
  task.wait(0.2)
  shared.NightbedLoaded = true
end

if not shared.FuncsConnect then
	repeat
		shared.FuncsConnect = true
	until shared.FuncsConnect
end