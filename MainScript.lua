repeat task.wait() until game:IsLoaded()
local watermaskScript = "-- Watermask When Updated\n"
local githubRequest = function(scripturl)
	if (not isfile("Nightbed/"..scripturl)) then
		local suc,res = pcall(function()
			return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/"..readfile("Nightbed/commit.txt").."/"..scripturl, true)
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

function MainLoaded()
  local customModuleURL = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/"..readfile("Nightbed/commit.txt").."/CustomModules/"..game.PlaceId..".lua"
  local customModuleScript = game:HttpGet(customModuleURL, true)
  if customModuleScript then
    local success, error = pcall(function()
      writefile("Nightbed/CustomModules/"..game.PlaceId..".lua", watermaskScript..customModuleScript)
      task.wait()
      loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
    end)
    if not success then
      warn("Failed To Loaded Modules: " .. tostring(error))
      loadstring(githubRequest("Universal.lua"))()
    end
  else
    loadstring(githubRequest("Universal.lua"))()
  end
end

MainLoaded()