local Functions = {}

local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local errorPopupShown = false
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 0 end

Functions = {
	["runcode"] = function(func)
			func()
	end,
	["runFunction"] = function(func)
			func()
	end,
	["executor"] = identifyexecutor(),
	["Kick"] = function(title, text)
			lplr:Kick(title, text)
	end,
	["displayErrorPopup"] = function(title, text, button, fuclist)
		local oldidentity = getidentity()
		setidentity(8)
		local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
		local prompt = ErrorPrompt.new("Default")
		prompt._hideErrorCode = true
		local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
		prompt:setErrorTitle(title)
		local funcs = {}
		local num = 0
		for i,v in pairs(funclist) do 
			num = num + 1
			table.insert(funcs, {
				Text = i,
				Callback = function() 
					prompt:_close() 
					v()
				end,
				Primary = num == #funclist
			})
		end
		prompt:updateButtons(funcs or {{
			Text = button,
			Callback = function() 
				prompt:_close() 
			end,
			Primary = true
		}}, 'Default')
		prompt:setParent(gui)
		prompt:_open(text)
		setidentity(oldidentity)
	end
}

if Functions.executor:find("Arceus") then
		Functions.displayErrorPopup("Detected", "Your Executor not Support our Functions You Will Shutdown in 5s\n Executor : Arceus", "OK")
		wait(5)
		game:Shutdown()
end
