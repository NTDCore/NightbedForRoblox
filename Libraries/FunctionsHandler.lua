local Functions = {}

local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
shared.FuncsConnect = true
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 0 end

if shared.FuncsConnect then
	do
		Functions.runcode = function(func)
			func()
		end
		Functions.runFunction = function(func)
			func()
		end
		Functions.executor = identifyexecutor()
		function Functions.RobloxNotification(first, second, timewa)
			game.StarterGui:SetCore("SendNotification", {
    		Title = first;
    		Text = second;
  			Duration = timewa;
			})
		end
	end

	if Functions.executor:find("Arceus") then
		Functions.RobloxNotification("Detected", "you executor not support for FunctionsHandler game will shutdown in 5s\n Executor : Arceus", 5)
		wait(5)
		shared.FuncsConnect = false
		game:Shutdown()
	end

	if shared.FuncsConnect then
		print("Functions Has Been Connected!")
	end
else
	warn("Failed to Connected or shared.FuncsConnect = false")
end

return Functions