-- nightbed test log
local nightbedInjected = true
local nightbedAssets = {
  ["Nightbed/assets/Cape.png"] = "rbxthumb://type=Asset&id=" .. 14391871286 .. "&w=420&h=420"
}
shared.NBAssets = nightbedAssets
local baseDirectionFile = (shared.NightbedDeveloper and "NightbedDev/" or "Nightbed/")
local nightbedConsole = function(message)
  print("[NIGHTBED]: "..message)
end

local githubRequest = function(scripturl)
  return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
end

local NBFolder = function(folder)
  if isfolder(folder) == false then
    makefolder(folder)
  end
end

if isfolder(baseDirectionFile) == false then
  makefolder(baseDirectionFile)
  NBFolder(baseDirectionFile.."/CustomModules")
  NBFolder(baseDirectionFile.."/Core")
  NBFolder(baseDirectionFile.."/assets")
  NBFolder(baseDirectionFile.."/Profiles")
else
  task.wait()
  nightbedConsole("Loading...")
  task.wait(1)
  nightbedConsole("Success! Loaded")
end
return loadstring(githubRequest("MainScript.lua"))()