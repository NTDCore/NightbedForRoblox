-- nightbed test log
--[[
  Version Info
    a = alpha
    pr = pre release
    fr = full release
    bt = beta test
    b = beta
    dl = dev log
    d = demo
    t = test
--]]
local githubRequest = function(scripturl)
  return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
end
local Service = function(name)
  return game:GetService(name)
end
local nightbedService = {
  ["Version"] = "1.0t",
  ["Injected"] = true,
  ["Assets"] = {
    ["Nightbed/assets/Cape.png"] = "rbxthumb://type=Asset&id=" .. 14391871286 .. "&w=420&h=420"
  }
}
local nightbedStore = {
  ["GuiLibrary"] = {
  	["Kavo"] = loadstring(githubRequest("Libraries/kavo.lua"))()
  },
  ["Core"] = {
  	["FunctionsLibrary"] = loadstring(githubRequest("Libraries/FunctionsHandler.lua"))(),
  	["entity"] = (isfile("vape/Libraries/entityHandler.lua") and loadstring(readfile("vape/Libraries/entityHandler.lua"))() or loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua", true))()),
  	["sha"] = loadstring(githubRequest("Libraries/sha.lua"))()
  }
}
local robloxService = {
  ["InputService"] = Service("UserInputService"),
  ["ReplicatedStorage"] = Service("ReplicatedStorage"),
  ["Game"] = {
    ["PlaceId"] = game.PlaceId
  }
}
local executorService = {
  ["queueteleport"] = queue_on_teleport
}

shared.NBStore = nightbedStore
shared.rblxService = robloxService
shared.executorService = executorService
shared.NBService = nightbedService
shared.NBAssets = nightbedService["Assets"]
local customasset = function(asset)
  return nightbedService["Assets"][asset] or ""
end
getgenv().loadAsset = customasset
local nightbedConsole = function(message)
  print("[NIGHTBED]: "..message)
end

local NBFolder = function(folder)
  if isfolder(folder) == false then
    makefolder(folder)
  end
end

if isfolder("Nightbed") == false then
  makefolder("Nightbed")
  NBFolder("Nightbed/CustomModules")
  NBFolder("Nightbed/Core")
  NBFolder("Nightbed/assets")
  NBFolder("Nightbed/Profiles")
else
  task.wait()
  nightbedConsole("Loading...")
  task.wait(1)
  nightbedConsole("Success! Loaded")
end
return loadstring(githubRequest("MainScript.lua"))()