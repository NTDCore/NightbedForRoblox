--[[
Credit to Moerii
Remake Little bit cuz yes
--]]
repeat task.wait() until game:IsLoaded()
if shared.injected  then
	error("Nightbed is Already Executed")
	return
else
	shared.injected = true
end

function betterisfile(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end

local kavo
if betterisfile("Nightbed/Libraries/kavo.lua") then
   kavo = loadstring(readfile("Nightbed/Libraries/kavo.lua"))()
else
   kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua", true))()
end
shared.kavogui = kavo

local entityLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()
shared.vapeentity = entityLibrary

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

if isfolder("Nightbed/CustomModules") == false then
	makefolder("Nightbed/CustomModules")
end

if betterisfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
    loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua", true))()
end
