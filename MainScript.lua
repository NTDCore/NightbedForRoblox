repeat task.wait() until game:IsLoaded()
function githubRequest(scripturl)
	return game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
end
local isfile = isfile or function(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end
local nightbedStore = shared.NBStore
local kavo
kavo = nightbedStore["GuiLibrary"].Kavo
shared.kavogui = kavo
local win = kavo:CreateWindow({
	["Title"] = "Nightbed",
	["Theme"] = (shared.CustomTheme and shared.SetCustomTheme or "Luna")
})
local Tabs = {
	["Combat"] = win.CreateTab("Combat"),
	["Blatant"] = win.CreateTab("Blatant"),
	["Render"] = win.CreateTab("Render"),
	["Utility"] = win.CreateTab("Utility"),
	["World"] = win.CreateTab("World")
}
shared.Tabs = Tabs

function MainLoaded()
	local customModuleURL = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"
	local customModuleScript = game:HttpGet(customModuleURL, true)
	if customModuleScript then
		local success, error = pcall(function()
			loadstring(customModuleScript)()
		end)
		if not success then
			warn("Failed To Loaded Modules: " .. tostring(error))
			loadstring(githubRequest("Universal.lua"))()
		end
	end
end

MainLoaded()