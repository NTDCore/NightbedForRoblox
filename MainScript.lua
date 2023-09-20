repeat task.wait() until game:IsLoaded()
local githubRequest = function(scripturl)
	if (not isfile("Nightbed/"..scripturl)) then
		local suc,res = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
		end)
		if scripturl:find(".lua") then
			res = "-- Watermask When Updated\n"..res
		end
		writefile("Nightbed/"..scripturl, res)
	end
	return readfile("Nightbed/"..scripturl)
end
local isfile = isfile or function(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end
local kavo
kavo = loadstring(githubRequest("Core/kavo.lua"))()
shared.kavogui = kavo
local Sections = {}
shared.SectionsLoaded = Sections
local AnyGame = [[
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Universal.lua", true))()
]]

function MainLoaded()
--[[
  local customModuleURL = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"
  local customModuleScript = game:HttpGet(customModuleURL, true)
--]]
	local customModuleScript = loadstring(githubRequest("CustomModules/"..game.PlaceId..".lua"))()
  if customModuleScript then
    local success, error = pcall(function()
      loadstring(customModuleScript)()
    end)
    if not success then
      warn("Failed To Loaded Modules: " .. tostring(error))
      loadstring(githubRequest("Universal.lua"))()
    end
  else
    loadstring(githubRequest("Universal.lua"))()
  end
end

task.spawn(function()
  MainLoaded()
end)

if not shared.FuncsConnect then
  task.spawn(function()
  	repeat
  	  task.wait()
  		shared.FuncsConnect = true
  	until shared.FuncsConnect
  end)
end