local NBFolder = function(folder)
	if isfolder(folder) == false then
		makefolder(folder)
	end
end

if isfolder('nightbed') == false then
	makefolder('nightbed')
end
NBFolder('nightbed/CustomModules')
NBFolder('nightbed/Core')
NBFolder('nightbed/assets')
NBFolder('nightbed/Profiles')

local cloneref = cloneref or function(obj)
	return obj
end

local httpService = cloneref(game.GetService(game, 'HttpService'))
local githubRequest = function(scripturl)
	return game:HttpGet('https://raw.githubusercontent.com/NTDCore/nightbedForRoblox/'..httpService:JSONDecode(game:HttpGet('https://api.github.com/repos/NTDCore/nightbedForRoblox/commits'))[1].sha..'/'..scripturl, true)
end

local Service = function(name)
	return cloneref(game:GetService(name))
end
local Data = Service('HttpService'):JSONDecode(githubRequest('Core/data.json')) -- lol
local nightbedService = {
	['Version'] = Data.Version,
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
		['entity'] = loadstring(game:HttpGet('https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/libraries/entity.lua', true))(),
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
	print('[nightbed]: '..message)
end

local NBFolder = function(folder)
	if isfolder(folder) == false then
		makefolder(folder)
	end
end

return loadstring(githubRequest('MainScript.lua'))()