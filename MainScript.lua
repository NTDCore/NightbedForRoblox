--[[
Credit to Moerii
Remake Little bit cuz yes
--]]
repeat task.wait() until game:IsLoaded()
local dev = "Nice try niggas imagine trying to get Dev version" --lol idk why cuz yes XD
if shared.injected  then
	error("Nightbed is Already Executed")
	return
else
	shared.injected = true
end

local kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Libraries/kavo.lua", true))()
shared.kavogui = kavo

local entityLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()
shared.vapeentity = entityLibrary

function betterisfile(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end

if isfolder("Nightbed") == false then
	makefolder("Nightbed")
end

if isfolder("Nightbed/assets") == false then
	makefolder("Nightbed/assets")
end

if isfolder("Nightbed/CustomModules") == false then
	makefolder("Nightbed/CustomModules")
end

if shared.NightbedDeveloper and isfolder("Nightbed/Profiles") or betterisfile("Nightbed/MainScript.lua") then
	writefile("Nightbed/Dev.lua", dev)
end

if betterisfile("Nightbed/MainScript.lua") then
	loadstring(readfile("Nightbed/MainScript.lua"))()
end

if betterisfile("Nightbed/AnyGame.lua") then
	loadstring(readfile("Nightbed/AnyGame.lua"))()
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua", true))()
end
if betterisfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
    loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"))()
end