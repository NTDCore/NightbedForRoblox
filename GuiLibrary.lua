--soon!
local api = {
  ["ToggleUI"] = RightShift,
  ["RainbowUI"] = false,
  ["Notification"] = true,
  ["AnimationUI"] = true,
  ["ObjectsThatCanBeSaved"] = {}
}

local GuiCount = {["Value"] = 0}
local ToggleC = {["Value"] = 0}

local gui = game:GetService("CoreGui")
gui = api
Api["MainGui"] = gui

api["CreateWindow"] = function(argstable)
  local TabName = argstable.Name or argstable["Name"]
  GuiCount["Value"] += 0.5
end
api["ObjectsThatCanBeSaved"].createoptionsbutton = function(argstable)
   local NameBu = argstable.Name or argstable["Name"]
   local callback = argstable.Function or argstable["Function"]
   local HoverText = argstable.HoverText or argstable["HoverText"]
     ToggleC["Value"] += 0.5
end
api.CreateSlider = function(argstable)
   local NameSlide = argstable.Name or argstable["Name"]
   local Min = argstable.Min or argstable["Min"]
   local Max = argstable.Max or argstable["Max"]
    local Callback = argstable.Function or argstable["Function"]
    local Default = argstable.Default or argstable["Default"]
end
api.createnotification = function(Name1, Text1, time1)
   print("e")
end
