--[[
Credit to Moerii
--]]
repeat task.wait() until game:IsLoaded()
if shared.injected  then
	error("Nightbed is Already Executed")
	return
else
	shared.injected = true
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
elseif readfile("Nightbed/CustomModules/"..placeid..".lua") then
    loadstring(readfile("Nightbed/CustomModules/"..placeid..".lua"))()
else    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
end
