--soon!
local api = {
  ["ToggleUI"] = RightShift,
  ["RainbowUI"] = false,
  ["Notification"] = true,
  ["AnimationUI"] = true,
  ["ObjectsThatCanBeSaved"] = {}
}
local uicount = 0
api["CreateWindow"] = function()
  uicount += 0.5
 end
