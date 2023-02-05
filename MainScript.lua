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

local kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua", true))()
shared.kavogui = kavo
local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()
shared.vapeentity = entity

function betterisfile(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/MainScript.lua'))()")
    end
end)

if betterisfile("Nightbed/MainScript.lua") then
	loadstring(readfile("Nightbed/MainScript.lua"))()
end

if betterisfile("Nightbed/AnyGame.lua") then
	loadstring(readfile("Nightbed/AnyGame.lua"))()
elsek
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua", true))()
end
if betterisfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
    loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"))()
end