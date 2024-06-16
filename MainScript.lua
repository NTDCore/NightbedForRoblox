-- credit to xylex (ty for isfile fix?)
repeat task.wait() until game:IsLoaded()
function githubRequest(scripturl)
	return game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/'..scripturl, true)
end
local isfile = isfile or function(path)
	local suc, res = pcall(function() return readfile(path) end)
	return suc and res ~= nil 
end
local nightbedStore = shared.NBStore
local kavo
kavo = nightbedStore['GuiLibrary'].Kavo
shared.kavogui = kavo
local win = kavo:CreateWindow({
	['Title'] = 'Nightbed v'..shared.NBService['Version'],
	['Theme'] = (shared.CustomTheme and shared.SetCustomTheme or 'Luna')
})
local Tabs = {
	['Combat'] = win.CreateTab('Combat'),
	['Blatant'] = win.CreateTab('Blatant'),
	['Render'] = win.CreateTab('Render'),
	['Utility'] = win.CreateTab('Utility'),
	['World'] = win.CreateTab('World')
}
shared.Tabs = Tabs

local cloneref = cloneref or function(obj) return obj end
local playersService = cloneref(game:GetService('Players'))
local lplr = playersService.LocalPlayer
local httpService = cloneref(game:GetService('HttpService'))
local starterUI = cloneref(game:GetService('StarterGui'))
local nightbedData

loadstring(githubRequest('Universal.lua'))()

task.spawn(function()
	nightbedData = httpService:JSONDecode(game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Core/data.json', true))
	for i,v in nightbedData.Blacklist do	
		if tonumber(v) == lplr.UserId then
			lplr:Kick(tostring(v[lplr.UserId].Reason))
		end
	end
	local nbAnnouncement = nightbedData.Announcement
	if nbAnnouncement.Activate then
		repeat
			starterUI:SetCore('SendNotification', {
				Title = 'Nightbed',
				Text = tostring(nbAnnouncement.Message),
				Duration = tonumber(nbAnnouncement.Wait)
			})
			task.wait(tonumber(nbAnnouncement.Wait))
		until (not nbAnnouncement.Activate)
	end
end)