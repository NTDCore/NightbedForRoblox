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
local NBFolder = function(folder)
	if isfolder(folder) == false then
		makefolder(folder)
	end
end

if isfolder('Nightbed') == false then
	makefolder('Nightbed')
end
NBFolder('Nightbed/CustomModules')
NBFolder('Nightbed/Core')
NBFolder('Nightbed/assets')
NBFolder('Nightbed/Profiles')

--[[
local githubRequest = function(scripturl)
	local suc,res = pcall(function()
		return game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/'..readfile('Nightbed/commit.txt')..'/'..scripturl, true)
	end)
	res = '-- Watermask When Updated\n'..res
	writefile('Nightbed/'..scripturl, res)
	return readfile('Nightbed/'..scripturl)
end
--]]
function githubRequest(scripturl)
	return game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/'..scripturl, true)
end
local cloneref = cloneref or function(obj)
	return obj
end
local Service = function(name)
	return cloneref(game:GetService(name))
end
local nightbedService = {
	['Version'] = '1.0.0r',
	['Assets'] = {
		['Cape.png'] = 'rbxthumb://type=Asset&id=' .. 14391871286 .. '&w=420&h=420'
	}
}
shared.NBInjected = true
local nightbedStore = {
	['GuiLibrary'] = {
		['Kavo'] = loadstring(githubRequest('Core/kavo.lua'))(),
		['Neverlose'] = loadstring(game:HttpGet('https://raw.githubusercontent.com/3345-c-a-t-s-u-s/NEVERLOSE-UI-Nightly/main/source.lua'))()
	},
	['Core'] = {
		['FunctionsLibrary'] = loadstring(githubRequest('Core/FunctionsHandler.lua'))(),
		['entity'] = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua', true))(),
		['sha'] = loadstring(githubRequest('Core/sha.lua'))()
	}
}
local robloxService = {
	['InputService'] = Service('UserInputService'),
	['ReplicatedStorage'] = Service('ReplicatedStorage'),
	['Game'] = {
		['PlaceId'] = game.PlaceId,
		['JobId'] = game.JobId,
		['GameId'] = game.GameId
	}
}
local executorService = {
	['queueteleport'] = queue_on_teleport
}
local getStore = function(store, store1)
	return nightbedStore[store][store1]
end

shared.NBStore = nightbedStore
shared.rblxService = robloxService
shared.executorService = executorService
shared.NBService = nightbedService
shared.NBAssets = nightbedService['Assets']
shared.funcslib = getStore('Core', 'FunctionsLibrary')
shared.vapeentity = getStore('Core', 'entity')
shared.shalib = getStore('Core', 'sha')
local customasset = function(asset)
	return nightbedService['Assets'][asset] or ''
end
getgenv().loadAsset = customasset
local nightbedConsole = function(message)
	print('[NIGHTBED]: '..message)
end

local NBFolder = function(folder)
	if isfolder(folder) == false then
		makefolder(folder)
	end
end

if isfolder('Nightbed') then
	task.wait()
	nightbedConsole('Loading...')
	task.wait(1)
	nightbedConsole('Success! Loaded')
end

return loadstring(githubRequest('MainScript.lua'))()