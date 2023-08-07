-- nightbee test log
local nightbedInjected = true
local nightbedConsole = function(message)
  print("[NIGHTBED]: "..message)
end
task.wait()
nightbedConsole("Loading...")
task.wait(1)
nightbedConsole("Success! Loaded")
if isfile("Nightbed/Profiles/"..game.PlaceId..".json") or isfile("Nightbed/Profiles/Universal.json") then
  nightbedConsole("Loaded Config ("..game.PlaceId..".json")
end
