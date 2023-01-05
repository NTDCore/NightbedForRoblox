--[[
Credit to Moerii
--]]
repeat task.wait() until game:IsLoaded()
if shared.injected then
error("Nightbed is Already Executed")
return
else
	shared.injected = true
end

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
local gameteleport = false
local teleportfunc = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
	if (not gameteleport) then
	local stringtp = 'shared.VapeSwitchServers = true if shared.NightbedDeveloper then loadstring(readfile("Nightbed/MainScript.lua"))() else loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/MainScript.lua", true))() end'
	queueteleport(stringtp)
	end
	end
	function betterfile(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil
	end

	local placeid = game.PlaceId
	if placeId == 6872274481 or placeid == 8560631822 or placeid == 8444591321 then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/6872274481.lua"))()
	elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..placeid..".lua") then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..placeid..".lua"))()
	elseif betterfile("Nightbed/CustomModules/"..placeid..".lua") then
	loadstring(betterfile("Nightbed/CustomModules/"..placeid..".lua"))()
	else
		loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
	end