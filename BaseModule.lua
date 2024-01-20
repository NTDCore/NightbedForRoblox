--[[
	Credits
	Infinite Yield - InfJump
	engospy - RemoteEvent
	Kavo Owner - kavo ui
	7GrandDadPGN (xylex) - Vape Entity
--]]
local entityLibrary = shared.vapeentity
local kavo = shared.kavogui
local FunctionsLibrary = shared.funcslib
local nightbedStore = shared.NBStore
local nightbedService = shared.NBService
local robloxService = shared.rblxService
local Settings = {}

local runFunction = function(func) func() end

local Tabs = shared.Tabs
local Sections = {}
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local oldchar = lplr.Character
local gameCamera = workspace.CurrentCamera
local InputService = game:GetService("UserInputService")