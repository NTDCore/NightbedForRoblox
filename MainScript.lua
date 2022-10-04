repeat task.wait() until game:IsLoaded()
if not isfile("NightbedConfig.JSON") then writefile("NightbedConfig.JSON","{}")
end
local betterisfile = function(file)
local suc, res = pcall(function() return readfile(file) end)
return suc and res ~= nil
end
local function GetURL(scripturl)
if shared.NightbedDeveloper then
if not betterisfile("Nightbed/"..scripturl) then
error("File not found : Nightbed/"..scripturl)
end
return readfile("Nightbed/"..scripturl)
else
	local res = game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..scripturl, true)
assert(res ~= "404: Not Found", "File not found")
return res
end
end
local getasset = getsynasset or getshitmotherasset or getcustomasset or function(location) return "rbxasset://"..location end
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
	queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/MainScript.lua'))()")
	end
	end)
local GuiLibrary = loadstring(GetURL("GuiLibrary.lua"))()
shared.GuiLIbrary = GuiLibrary
local kavo = loadstring(GetURL("Libraries/kavo.lua"))()
local window = kavo.CreateLib("Nightbed " (shared.NightbedPrivate.. "PRIVATE" or ""), "Luna")
shared.kavo = kavo
local function getcustomassetfunc(path)
if not betterisfile(path) then
spawn(function()
	local textlabel = Instance.new("TextLabel")
	textlabel.Size = UDim2.new(1, 0, 0, 36)
	textlabel.Text = "Downloading "..path
	textlabel.BackgroundTransparency = 1
	textlabel.TextStrokeTransparency = 0
	textlabel.TextSize = 30
	textlabel.Font = Enum.Font.SourceSans
	textlabel.TextColor3 = Color3.new(1, 1, 1)
	textlabel.Position = UDim2.new(0, 0, 0, -36)
	textlabel.Parent = kavo["MainGui"]
	repeat task.wait() until betterisfile(path)
	textlabel:Remove()
	end)
local req = requestfunc({
	Url = "https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/"..path:gsub("Nightbed/assets", "assets"),
	Method = "GET"
})
writefile(path, req.Body)
end
return getasset(path)
end
local whitelists = loadstring(GetURL("Whitelisted/whitelisted.lua"))()
shared.inlist = whitelists
local shalib = loadstring(GetURL("Libraries/sha.lua"))()
shared.shaonline = shalib
local entity = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/Libraries/entityHandler.lua"))()
shared.VapeEntity = entity
if isfolder(customdir:gsub("/", "")) == false then
makefolder(customdir:gsub("/", ""))
end
if isfolder("Nightbed") == false then
makefolder("Nightbed")
end
if isfolder("Nightbed/CustomModules") == false then
makefolder("Nightbed/CustomModules")
end
if isfolder("Nightbed/Profiles") == false then
makefolder("Nightbed/Profiles")
end
if isfolder("Nightbed/assets") == false then
makefolder("Nightbed/assets")
end

if shared.NightbedPrivate then
	if isfolder("NightbedPrivate") == false then
makefolder("NightbedPrivate")
end
if isfolder("NightbedPrivate/CustomModules") == false then
makefolder("NightbedPrivate/CustomModules")
end
if isfolder("NightbedPrivate/Profiles") == false then
makefolder("NightbedPrivate/Profiles")
end
local tabs = function(tabName)
return kavo = window:NewTab(tabName.."")
end
--[[
local Combat = window:NewTab("Combat")
local Blatant = window:NewTab("Blatant")
local Render = window:NewTab("Render")
local Utility = window:NewTab("Utility")
local World = window:NewTab("World")
local hud = window:NewTab("Hud")
local Setting = window:NewTab("Settings")
local Credit = window:NewTab("Credits")
--]]
local Combat = tabs("Combat")
local Blatant = tabs("Blatant")
local Render = tabs("Render")
local Utility = tabs("Utility")
local World = tabs("World")
local hud = tabs("Hud")
local Setting = tabs("Settings")
local Credit = tabs("Credits")

local workspace = game:GetService("Workspace")
local cam = workspace.CurrentCamera
local GUI = GuiLibrary.CreateMainWindow()
local Combat = GuiLibrary.CreateWindow({
	["Name"] = "Combat" 
})
local Blatant = GuiLibrary.CreateWindow({
	["Name"] = "Blatant" 
})
local Render = GuiLibrary.CreateWindow({
	["Name"] = "Render" 
})
local Utility = GuiLibrary.CreateWindow({
	["Name"] = "Utility" 
})
local World = GuiLibrary.CreateWindow({
	["Name"] = "World" 
})
local Profiles = GuiLibrary.CreateWindow2({
	["Name"] = "Profiles"
})
GUI.CreateButton({
	["Name"] = "Combat", 
	["Function"] = function(callback) Combat.SetVisible(callback) end
})
GUI.CreateButton({
	["Name"] = "Blatant", 
	["Function"] = function(callback) Blatant.SetVisible(callback) end
})
GUI.CreateButton({
	["Name"] = "Render", 
	["Function"] = function(callback) Render.SetVisible(callback) end"
})
GUI.CreateButton({
	["Name"] = "Utility", 
	["Function"] = function(callback) Utility.SetVisible(callback) end
})
GUI.CreateButton({
	["Name"] = "World", 
	["Function"] = function(callback) World.SetVisible(callback) end
})
GUI.CreateButton({
	["Name"] = "Profiles", 
	["Function"] = function(callback) Profiles.SetVisible(callback) end, 
})
local ProfilesTextList = {["RefreshValues"] = function() end}
local profilesloaded = false
ProfilesTextList = Profiles.CreateTextList({
	["Name"] = "ProfilesList",
	["TempText"] = "Type name", 
	["NoSave"] = true,
	["AddFunction"] = function(user)
		GuiLibrary["Profiles"][user] = {["Keybind"] = "", ["Selected"] = false}
		local profiles = {}
		for i,v in pairs(GuiLibrary["Profiles"]) do 
			table.insert(profiles, i)
		end
		table.sort(profiles, function(a, b) return b == "default" and true or a:lower() < b:lower() end)
		ProfilesTextList["RefreshValues"](profiles)
	end, 
	["RemoveFunction"] = function(num, obj) 
		if obj ~= "default" and obj ~= GuiLibrary["CurrentProfile"] then 
			pcall(function() delfile(customdir.."Profiles/"..obj..(shared.CustomSaveVape or game.PlaceId)..".vapeprofile.txt") end)
			GuiLibrary["Profiles"][obj] = nil
		else
			table.insert(ProfilesTextList["ObjectList"], obj)
			ProfilesTextList["RefreshValues"](ProfilesTextList["ObjectList"])
		end
	end, 
	["CustomFunction"] = function(obj, profilename) 
		if GuiLibrary["Profiles"][profilename] == nil then
			GuiLibrary["Profiles"][profilename] = {["Keybind"] = ""}
		end
		obj.MouseButton1Click:Connect(function()
			GuiLibrary["SwitchProfile"](profilename)
		end)
		local newsize = UDim2.new(0, 20, 0, 21)
		local bindbkg = Instance.new("TextButton")
		bindbkg.Text = ""
		bindbkg.AutoButtonColor = false
		bindbkg.Size = UDim2.new(0, 20, 0, 21)
		bindbkg.Position = UDim2.new(1, -50, 0, 6)
		bindbkg.BorderSizePixel = 0
		bindbkg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		bindbkg.BackgroundTransparency = 0.95
		bindbkg.Visible = GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		bindbkg.Parent = obj
		local bindimg = Instance.new("ImageLabel")
		bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
		bindimg.BackgroundTransparency = 1
		bindimg.Size = UDim2.new(0, 12, 0, 12)
		bindimg.Position = UDim2.new(0, 4, 0, 5)
		bindimg.ImageTransparency = 0.2
		bindimg.Active = false
		bindimg.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] == "")
		bindimg.Parent = bindbkg
		local bindtext = Instance.new("TextLabel")
		bindtext.Active = false
		bindtext.BackgroundTransparency = 1
		bindtext.TextSize = 16
		bindtext.Parent = bindbkg
		bindtext.Font = Enum.Font.SourceSans
		bindtext.Size = UDim2.new(1, 0, 1, 0)
		bindtext.TextColor3 = Color3.fromRGB(85, 85, 85)
		bindtext.Visible = (GuiLibrary["Profiles"][profilename]["Keybind"] ~= "")
		local bindtext2 = Instance.new("TextLabel")
		bindtext2.Text = "PRESS A KEY TO BIND"
		bindtext2.Size = UDim2.new(0, 150, 0, 33)
		bindtext2.Font = Enum.Font.SourceSans
		bindtext2.TextSize = 17
		bindtext2.TextColor3 = Color3.fromRGB(201, 201, 201)
		bindtext2.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
		bindtext2.BorderSizePixel = 0
		bindtext2.Visible = false
		bindtext2.Parent = obj
		local bindround = Instance.new("UICorner")
		bindround.CornerRadius = UDim.new(0, 4)
		bindround.Parent = bindbkg
		bindbkg.MouseButton1Click:Connect(function()
			if GuiLibrary["KeybindCaptured"] == false then
				GuiLibrary["KeybindCaptured"] = true
				spawn(function()
					bindtext2.Visible = true
					repeat task.wait() until GuiLibrary["PressedKeybindKey"] ~= ""
					local key = (GuiLibrary["PressedKeybindKey"] == GuiLibrary["Profiles"][profilename]["Keybind"] and "" or GuiLibrary["PressedKeybindKey"])
					if key == "" then
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						newsize = UDim2.new(0, 20, 0, 21)
						bindbkg.Size = newsize
						bindbkg.Visible = true
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = true
						bindtext.Visible = false
						bindtext.Text = key
					else
						local textsize = game:GetService("TextService"):GetTextSize(key, 16, bindtext.Font, Vector2.new(99999, 99999))
						newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
						GuiLibrary["Profiles"][profilename]["Keybind"] = key
						bindbkg.Visible = true
						bindbkg.Size = newsize
						bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
						bindimg.Visible = false
						bindtext.Visible = true
						bindtext.Text = key
					end
					GuiLibrary["PressedKeybindKey"] = ""
					GuiLibrary["KeybindCaptured"] = false
					bindtext2.Visible = false
				end)
			end
		end)
		bindbkg.MouseEnter:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/PencilIcon.png") 
			bindimg.Visible = true
			bindtext.Visible = false
			bindbkg.Size = UDim2.new(0, 20, 0, 21)
			bindbkg.Position = UDim2.new(1, -50, 0, 6)
		end)
		bindbkg.MouseLeave:Connect(function() 
			bindimg.Image = getcustomassetfunc("vape/assets/KeybindIcon.png")
			if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then
				bindimg.Visible = false
				bindtext.Visible = true
				bindbkg.Size = newsize
				bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
			end
		end)
		obj.MouseEnter:Connect(function()
			bindbkg.Visible = true
		end)
		obj.MouseLeave:Connect(function()
			bindbkg.Visible = GuiLibrary["Profiles"][profilename] and GuiLibrary["Profiles"][profilename]["Keybind"] ~= ""
		end)
		if GuiLibrary["Profiles"][profilename]["Keybind"] ~= "" then

			bindtext.Text = GuiLibrary["Profiles"][profilename]["Keybind"]
			local textsize = game:GetService("TextService"):GetTextSize(GuiLibrary["Profiles"][profilename]["Keybind"], 16, bindtext.Font, Vector2.new(99999, 99999))
			newsize = UDim2.new(0, 13 + textsize.X, 0, 21)
			bindbkg.Size = newsize
			bindbkg.Position = UDim2.new(1, -(30 + newsize.X.Offset), 0, 6)
		end
		if profilename == GuiLibrary["CurrentProfile"] then
			obj.BackgroundColor3 = Color3.fromHSV(GuiLibrary["Settings"]["GUIObject"]["Color"], 0.7, 0.9)
			obj.ImageButton.BackgroundColor3 = Color3.fromHSV(GuiLibrary["Settings"]["GUIObject"]["Color"], 0.7, 0.9)
			obj.ItemText.TextColor3 = Color3.new(1, 1, 1)
			obj.ItemText.TextStrokeTransparency = 0.75
			bindbkg.BackgroundTransparency = 0.9
			bindtext.TextColor3 = Color3.fromRGB(214, 214, 214)
		end
	end
})
local TextGui = GuiLibrary.CreateCustomWindow({
	["Name"] = "Text GUI
})
local TextGuiCircleObject = {["CircleList"] = {}}
--GUI.CreateCustomButton("Text GUI", "vape/assets/TextGUIIcon2.png", UDim2.new(1, -23, 0, 15), function() TextGui.SetVisible(true) end, function() TextGui.SetVisible(false) end, "OptionsButton")
GUI.CreateCustomToggle({
	["Name"] = "Text GUI", 
	["Function"] = function(callback) TextGui.SetVisible(callback) end
})	
local rainbowval = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local rainbowval2 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0.42)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 0.42))})
local rainbowval3 = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 1)), ColorSequenceKeypoint.new(1, Color3.fromHSV(0, 0, 1))})
local guicolorslider = {["RainbowValue"] = false}
local textguiscaleslider = {["Value"] = 10}
local textguimode = {["Value"] = "Normal"}
local fontitems = {"SourceSans"}
local fontitems2 = {"GothamBold"}
local textguiframe = Instance.new("Frame")
textguiframe.BackgroundTransparency = 1
textguiframe.Size = UDim2.new(1, 0, 1, 0)
textguiframe.Parent = TextGui.GetCustomChildren()
local onething = Instance.new("ImageLabel")
onething.Parent = textguiframe
onething.Name = "Logo"
onething.Size = UDim2.new(0, 100, 0, 27)
onething.Position = UDim2.new(1, -140, 0, 3)
onething.BackgroundColor3 = Color3.new(0, 0, 0)
onething.BorderSizePixel = 0
onething.BackgroundTransparency = 1
onething.Visible = false
onething.Image = getcustomassetfunc(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
local onething2 = Instance.new("ImageLabel")
onething2.Parent = onething
onething2.Size = UDim2.new(0, 41, 0, 24)
onething2.Name = "Logo2"
onething2.Position = UDim2.new(1, 0, 0, 1)
onething2.BorderSizePixel = 0
onething2.BackgroundColor3 = Color3.new(0, 0, 0)
onething2.BackgroundTransparency = 1
onething2.Image = getcustomassetfunc("vape/assets/VapeLogo4.png")
local onething3 = onething:Clone()
onething3.ImageColor3 = Color3.new(0, 0, 0)
onething3.ImageTransparency = 0.5
onething3.ZIndex = 0
onething3.Position = UDim2.new(0, 1, 0, 1)
onething3.Visible = false
onething3.Parent = onething
onething3.Logo2.ImageColor3 = Color3.new(0, 0, 0)
onething3.Logo2.ZIndex = 0
onething3.Logo2.ImageTransparency = 0.5
local onethinggrad = Instance.new("UIGradient")
onethinggrad.Rotation = 90
onethinggrad.Parent = onething
local onethinggrad2 = Instance.new("UIGradient")
onethinggrad2.Rotation = 90
onethinggrad2.Parent = onething2
local onetext = Instance.new("TextLabel")
onetext.Parent = textguiframe
onetext.Size = UDim2.new(1, 0, 1, 0)
onetext.Position = UDim2.new(1, -154, 0, 35)
onetext.TextColor3 = Color3.new(1, 1, 1)
onetext.RichText = true
onetext.BackgroundTransparency = 1
onetext.TextXAlignment = Enum.TextXAlignment.Left
onetext.TextYAlignment = Enum.TextYAlignment.Top
onetext.BorderSizePixel = 0
onetext.BackgroundColor3 = Color3.new(0, 0, 0)
onetext.Font = Enum.Font.SourceSans
onetext.Text = ""
onetext.TextSize = 23
local onetext2 = Instance.new("TextLabel")
onetext2.Name = "ExtraText"
onetext2.Parent = onetext
onetext2.Size = UDim2.new(1, 0, 1, 0)
onetext2.Position = UDim2.new(0, 1, 0, 1)
onetext2.BorderSizePixel = 0
onetext2.Visible = false
onetext2.ZIndex = 0
onetext2.Text = ""
onetext2.BackgroundTransparency = 1
onetext2.TextTransparency = 0.5
onetext2.TextXAlignment = Enum.TextXAlignment.Left
onetext2.TextYAlignment = Enum.TextYAlignment.Top
onetext2.TextColor3 = Color3.new(0, 0, 0)
onetext2.Font = Enum.Font.SourceSans
onetext2.TextSize = 23
local onecustomtext = Instance.new("TextLabel")
onecustomtext.TextSize = 30
onecustomtext.Font = Enum.Font.GothamBold
onecustomtext.Size = UDim2.new(1, 0, 1, 0)
onecustomtext.BackgroundTransparency = 1
onecustomtext.Position = UDim2.new(0, 0, 0, 35)
onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
onecustomtext.TextYAlignment = Enum.TextYAlignment.Top
onecustomtext.Text = ""
onecustomtext.Parent = textguiframe
local onecustomtext2 = onecustomtext:Clone()
onecustomtext2.ZIndex = -1
onecustomtext2.Size = UDim2.new(1, 0, 1, 0)
onecustomtext2.TextTransparency = 0.5
onecustomtext2.TextColor3 = Color3.new(0, 0, 0)
onecustomtext2.Position = UDim2.new(0, 1, 0, 1)
onecustomtext2.Parent = onecustomtext
onecustomtext:GetPropertyChangedSignal("TextXAlignment"):Connect(function()
	onecustomtext2.TextXAlignment = onecustomtext.TextXAlignment
end)
local onebackground = Instance.new("Frame")
onebackground.BackgroundTransparency = 1
onebackground.BorderSizePixel = 0
onebackground.BackgroundColor3 = Color3.new(0, 0, 0)
onebackground.Size = UDim2.new(1, 0, 1, 0)
onebackground.Visible = false 
onebackground.Parent = textguiframe
onebackground.ZIndex = 0
local onebackgroundsort = Instance.new("UIListLayout")
onebackgroundsort.FillDirection = Enum.FillDirection.Vertical
onebackgroundsort.SortOrder = Enum.SortOrder.LayoutOrder
onebackgroundsort.Padding = UDim.new(0, 0)
onebackgroundsort.Parent = onebackground
local onescale = Instance.new("UIScale")
onescale.Parent = textguiframe
local textguirenderbkg = {["Enabled"] = false}
local textguimodeconnections = {}
local textguimodeobjects = {Logo = {}, Labels = {}, ShadowLabels = {}, Backgrounds = {}}
local function refreshbars(textlists)
	for i,v in pairs(onebackground:GetChildren()) do
		if v:IsA("Frame") then
			v:Remove()
		end
	end
	for i2,v2 in pairs(textlists) do
		local newstr = v2:gsub(":", " ")
		local textsize = game:GetService("TextService"):GetTextSize(newstr, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		local frame = Instance.new("Frame")
		frame.BorderSizePixel = 0
		frame.BackgroundTransparency = 0.62
		frame.BackgroundColor3 = Color3.new(0,0,0)
		frame.Visible = true
		frame.ZIndex = 0
		frame.LayoutOrder = i2
		frame.Size = UDim2.new(0, textsize.X + 8, 0, textsize.Y)
		frame.Parent = onebackground
		local colorframe = Instance.new("Frame")
		colorframe.Size = UDim2.new(0, 2, 1, 0)
		colorframe.Position = (onebackgroundsort.HorizontalAlignment == Enum.HorizontalAlignment.Left and UDim2.new(0, 0, 0, 0) or UDim2.new(1, -2, 0, 0))
		colorframe.BorderSizePixel = 0
		colorframe.Name = "ColorFrame"
		colorframe.Parent = frame
		local extraframe = Instance.new("Frame")
		extraframe.BorderSizePixel = 0
		extraframe.BackgroundTransparency = 0.96
		extraframe.BackgroundColor3 = Color3.new(0, 0, 0)
		extraframe.ZIndex = 0
		extraframe.Size = UDim2.new(1, 0, 0, 2)
		extraframe.Position = UDim2.new(0, 0, 1, -1)
		extraframe.Parent = frame
	end
end

onething.Visible = true onetext.Position = UDim2.new(0, 0, 0, 41)

local sortingmethod = "Alphabetical"
local textwithoutthing = ""
local function getSpaces(str)
		local strSize = game:GetService("TextService"):GetTextSize(str, onetext.TextSize, onetext.TextSize, Vector2.new(10000, 10000))
		return math.ceil(strSize.X / 3)
end
local function UpdateHud()
	if GuiLibrary["MainGui"].ScaledGui.Visible then
		local text = ""
		local text2 = ""
		local tableofmodules = {}
		local first = true
		
		for i,v in pairs(GuiLibrary["ObjectsThatCanBeSaved"]) do
			if v["Type"] == "OptionsButton" and v["Api"]["Name"] ~= "Text GUI" then
				if v["Api"]["Enabled"] then
					local blacklisted = table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"]) and TextGuiCircleObject["CircleList"]["ObjectListEnabled"][table.find(TextGuiCircleObject["CircleList"]["ObjectList"], v["Api"]["Name"])]
					if not blacklisted then
						table.insert(tableofmodules, {["Text"] = v["Api"]["Name"], ["ExtraText"] = v["Api"]["GetExtraText"]})
					end
				end
			end
		end
		if sortingmethod == "Alphabetical" then
			table.sort(tableofmodules, function(a, b) return a["Text"]:lower() < b["Text"]:lower() end)
		else
			table.sort(tableofmodules, function(a, b) 
				local textsize1 = (translations[a["Text"]] ~= nil and translations[a["Text"]] or a["Text"])..(a["ExtraText"]() ~= "" and " "..a["ExtraText"]() or "")
				local textsize2 = (translations[b["Text"]] ~= nil and translations[b["Text"]] or b["Text"])..(b["ExtraText"]() ~= "" and " "..b["ExtraText"]() or "")
				textsize1 = game:GetService("TextService"):GetTextSize(textsize1, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				textsize2 = game:GetService("TextService"):GetTextSize(textsize2, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
				return textsize1.X > textsize2.X 
			end)
		end
		local textlists = {}
		for i2,v2 in pairs(tableofmodules) do
			if first then
				text = (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
				first = false
			else
				text = text..'\n'..(translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or "")
			end
			table.insert(textlists, (translations[v2["Text"]] ~= nil and translations[v2["Text"]] or v2["Text"])..(v2["ExtraText"]() ~= "" and ":"..v2["ExtraText"]() or ""))
		end
		textwithoutthing = text
		onetext.Text = text
		onetext2.Text = text:gsub(":", " ")
		local newsize = game:GetService("TextService"):GetTextSize(text, onetext.TextSize, onetext.Font, Vector2.new(1000000, 1000000))
		if text == "" then
			newsize = Vector2.new(0, 0)
		end
		onetext.Size = UDim2.new(0, 154, 0, newsize.Y)
		if TextGui.GetCustomChildren().Parent then
			if (TextGui.GetCustomChildren().Parent.Position.X.Offset + TextGui.GetCustomChildren().Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2) then
				onetext.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.TextXAlignment = Enum.TextXAlignment.Right
				onetext2.Position = UDim2.new(0, 1, 0, 1)
				onething.Position = UDim2.new(1, -142, 0, 8)
				onetext.Position = UDim2.new(1, -154, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.Position = UDim2.new(0, 0, 0, onething.Visible and 35 or 0)
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Right
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Right
				onebackground.Position = onetext.Position + UDim2.new(0, -60, 0, 2)
			else
				onetext.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.TextXAlignment = Enum.TextXAlignment.Left
				onetext2.Position = UDim2.new(0, 5, 0, 1)
				onething.Position = UDim2.new(0, 2, 0, 8)
				onetext.Position = UDim2.new(0, 6, 0, (onething.Visible and (textguirenderbkg["Enabled"] and 41 or 35) or 5) + (onecustomtext.Visible and 25 or 0))
				onecustomtext.TextXAlignment = Enum.TextXAlignment.Left
				onebackgroundsort.HorizontalAlignment = Enum.HorizontalAlignment.Left
				onebackground.Position = onetext.Position + UDim2.new(0, -1, 0, 2)
			end
		end
		if textguimode["Value"] == "Drawing" then 
			for i,v in pairs(textguimodeobjects.Labels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.Labels[i] = nil
			end
			for i,v in pairs(textguimodeobjects.ShadowLabels) do 
				v.Visible = false
				v:Remove()
				textguimodeobjects.ShadowLabels[i] = nil
			end
			for i,v in pairs(textlists) do 
				local textdraw = Drawing.new("Text")
				textdraw.Text = v:gsub(":", " ")
				textdraw.Size = 23 * onescale.Scale
				textdraw.ZIndex = 2
				textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				textdraw.Visible = true
				local textdraw2 = Drawing.new("Text")
				textdraw2.Text = textdraw.Text
				textdraw2.Size = 23 * onescale.Scale
				textdraw2.Position = textdraw.Position + Vector2.new(1, 1)
				textdraw2.Color = Color3.new(0, 0, 0)
				textdraw2.Transparency = 0.5
				textdraw2.Visible = onetext2.Visible
				table.insert(textguimodeobjects.Labels, textdraw)
				table.insert(textguimodeobjects.ShadowLabels, textdraw2)
			end
		end
		refreshbars(textlists)
		GuiLibrary["UpdateUI"]()
	end
end

TextGui.GetCustomChildren().Parent:GetPropertyChangedSignal("Position"):Connect(UpdateHud)
onescale:GetPropertyChangedSignal("Scale"):Connect(function()
	local childrenobj = TextGui.GetCustomChildren()
	local check = (childrenobj.Parent.Position.X.Offset + childrenobj.Parent.Size.X.Offset / 2) >= (cam.ViewportSize.X / 2)
	childrenobj.Position = UDim2.new((check and -(onescale.Scale - 1) or 0), (check and 0 or -6 * (onescale.Scale - 1)), 1, -6 * (onescale.Scale - 1))
	UpdateHud()
end)
GuiLibrary["UpdateHudEvent"].Event:Connect(UpdateHud)
for i,v in pairs(Enum.Font:GetEnumItems()) do 
	if v ~= "SourceSans" then
		table.insert(fontitems, v.Name)
	end
	if v ~= "GothamBold" then
		table.insert(fontitems2, v.Name)
	end
end
textguimode = TextGui.CreateDropdown({
	["Name"] = "Mode",
	["List"] = {"Normal", "Drawing"},
	["Function"] = function(val)
		textguiframe.Visible = val == "Normal"
		for i,v in pairs(textguimodeconnections) do 
			v:Disconnect()
		end
		for i,v in pairs(textguimodeobjects) do 
			for i2,v2 in pairs(v) do 
				v2.Visible = false
				v2:Remove()
				v[i2] = nil
			end
		end
		if val == "Drawing" then
			local onethingdrawing = Drawing.new("Image")
			onethingdrawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onethingdrawing.Size = onething.AbsoluteSize
			onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
			onethingdrawing.ZIndex = 2
			onethingdrawing.Visible = onething.Visible
			local onething2drawing = Drawing.new("Image")
			onething2drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething2drawing.Size = onething2.AbsoluteSize
			onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
			onething2drawing.ZIndex = 2
			onething2drawing.Visible = onething.Visible
			local onething3drawing = Drawing.new("Image")
			onething3drawing.Data = readfile(translatedlogo and "vape/translations/"..GuiLibrary["Language"].."/VapeLogo3.png" or "vape/assets/VapeLogo3.png")
			onething3drawing.Size = onething.AbsoluteSize
			onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			onething3drawing.Transparency = 0.5
			onething3drawing.Visible = onething.Visible and onething3.Visible
			local onething4drawing = Drawing.new("Image")
			onething4drawing.Data = readfile("vape/assets/VapeLogo4.png")
			onething4drawing.Size = onething2.AbsoluteSize
			onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			onething4drawing.Transparency = 0.5
			onething4drawing.Visible = onething.Visible and onething3.Visible
			local onecustomdrawtext = Drawing.new("Text")
			onecustomdrawtext.Size = 30
			onecustomdrawtext.Text = onecustomtext.Text
			onecustomdrawtext.Color = onecustomtext.TextColor3
			onecustomdrawtext.ZIndex = 2
			onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
			onecustomdrawtext.Visible = onecustomtext.Visible
			local onecustomdrawtext2 = Drawing.new("Text")
			onecustomdrawtext2.Size = 30
			onecustomdrawtext2.Text = onecustomtext.Text
			onecustomdrawtext2.Transparency = 0.5
			onecustomdrawtext2.Color = Color3.new(0, 0, 0)
			onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			pcall(function()
				onething3drawing.Color = Color3.new(0, 0, 0)
				onething4drawing.Color = Color3.new(0, 0, 0)
				onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
			end)
			table.insert(textguimodeobjects.Logo, onethingdrawing)
			table.insert(textguimodeobjects.Logo, onething2drawing)
			table.insert(textguimodeobjects.Logo, onething3drawing)
			table.insert(textguimodeobjects.Logo, onething4drawing)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext)
			table.insert(textguimodeobjects.Logo, onecustomdrawtext2)
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onethingdrawing.Position = onething.AbsolutePosition + Vector2.new(0, 36)
				onething3drawing.Position = onething.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onethingdrawing.Size = onething.AbsoluteSize
				onething3drawing.Size = onething.AbsoluteSize
				onecustomdrawtext.Size = 30 * onescale.Scale
				onecustomdrawtext2.Size = 30 * onescale.Scale
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onething2drawing.Position = onething2.AbsolutePosition + Vector2.new(0, 36)
				onething4drawing.Position = onething2.AbsolutePosition + Vector2.new(1, 37)
			end))
			table.insert(textguimodeconnections, onething2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				onething2drawing.Size = onething2.AbsoluteSize
				onething4drawing.Size = onething2.AbsoluteSize
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onething3:GetPropertyChangedSignal("Visible"):Connect(function()
				onething3drawing.Visible = onething3.Visible
				onething4drawing.Visible = onething3.Visible
			end))
			table.insert(textguimodeconnections, onetext2:GetPropertyChangedSignal("Visible"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Visible = onetext2.Visible
				end
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onething:GetPropertyChangedSignal("Visible"):Connect(function()
				onethingdrawing.Visible = onething.Visible
				onething2drawing.Visible = onething.Visible
				onething3drawing.Visible = onething.Visible and onetext2.Visible
				onething4drawing.Visible = onething.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Visible"):Connect(function()
				onecustomdrawtext.Visible = onecustomtext.Visible
				onecustomdrawtext2.Visible = onecustomtext.Visible and onetext2.Visible
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("Text"):Connect(function()
				onecustomdrawtext.Text = onecustomtext.Text
				onecustomdrawtext2.Text = onecustomtext.Text
				onecustomdrawtext.Position = onecustomtext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onecustomtext.AbsoluteSize.X - onecustomdrawtext.TextBounds.X), 32)
				onecustomdrawtext2.Position = onecustomdrawtext.Position + Vector2.new(1, 1)
			end))
			table.insert(textguimodeconnections, onecustomtext:GetPropertyChangedSignal("TextColor3"):Connect(function()
				onecustomdrawtext.Color = onecustomtext.TextColor3
			end))
			table.insert(textguimodeconnections, onetext:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				for i,textdraw in pairs(textguimodeobjects.Labels) do 
					textdraw.Position = onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6)
				end
				for i,textdraw in pairs(textguimodeobjects.ShadowLabels) do 
					textdraw.Position = Vector2.new(1, 1) + (onetext.AbsolutePosition + Vector2.new(onetext.TextXAlignment == Enum.TextXAlignment.Right and (onetext.AbsoluteSize.X - textdraw.TextBounds.X), ((textdraw.Size - 3) * i) + 6))
				end
			end))
			table.insert(textguimodeconnections, onethinggrad:GetPropertyChangedSignal("Color"):Connect(function()
				pcall(function()
					onethingdrawing.Color = onethinggrad.Color.Keypoints[1].Value
				end)
			end))
		end
	end
})
TextGui.CreateDropdown({
	["Name"] = "Sort",
	["List"] = {"Alphabetical", "Length"},
	["Function"] = function(val)
		sortingmethod = val
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "Font",
	["List"] = fontitems,
	["Function"] = function(val)
		onetext.Font = Enum.Font[val]
		onetext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
TextGui.CreateDropdown({
	["Name"] = "CustomTextFont",
	["List"] = fontitems2,
	["Function"] = function(val)
		onecustomtext.Font = Enum.Font[val]
		onecustomtext2.Font = Enum.Font[val]
		GuiLibrary["UpdateHudEvent"]:Fire()
	end
})
textguiscaleslider = TextGui.CreateSlider({
	["Name"] = "Scale",
	["Min"] = 1,
	["Max"] = 50,
	["Default"] = 10,
	["Function"] = function(val)
		onescale.Scale = val / 10
	end
})
TextGui.CreateToggle({
	["Name"] = "Shadow", 
	["Function"] = function(callback) onetext2.Visible = callback onething3.Visible = callback end,
	["HoverText"] = "Renders shadowed text."
})
local TextGuiUseCategoryColor = TextGui.CreateToggle({
	["Name"] = "Use Category Color", 
	["Function"] = function(callback) GuiLibrary["UpdateUI"]() end
})
TextGui.CreateToggle({
	["Name"] = "Watermark", 
	["Function"] = function(callback) 
		onething.Visible = callback
		UpdateHud()
	end,
	["HoverText"] = "Renders a vape watermark"
})
local textguigradient = TextGui.CreateToggle({
	["Name"] = "Gradient Logo",
	["Function"] = function() 
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Alternate Text",
	["Function"] = function() 
		UpdateHud()
	end
})
textguirenderbkg = TextGui.CreateToggle({
	["Name"] = "Render background", 
	["Function"] = function(callback)
		onebackground.Visible = callback
		UpdateHud()
	end
})
TextGui.CreateToggle({
	["Name"] = "Blacklist",
	["Function"] = function(callback) 
		if TextGuiCircleObject["Object"] then
			TextGuiCircleObject["Object"].Visible = callback
		end
	end
})
TextGuiCircleObject = TextGui.CreateCircleWindow({
	["Name"] = "Blacklist",
	["Type"] = "Blacklist",
	["UpdateFunction"] = function()
		UpdateHud()
	end
})
TextGuiCircleObject["Object"].Visible = false
local CustomText = {["Value"] = "", ["Object"] = nil}
TextGui.CreateToggle({
	["Name"] = "Add custom text", 
	["Function"] = function(callback) 
		onecustomtext.Visible = callback
		if CustomText["Object"] then 
			CustomText["Object"].Visible = callback
		end
		GuiLibrary["UpdateHudEvent"]:Fire()
	end,
	["HoverText"] = "Renders a custom label"
})
CustomText = TextGui.CreateTextBox({
	["Name"] = "Custom text",
	["FocusLost"] = function(enter)
		onecustomtext.Text = CustomText["Value"]
		onecustomtext2.Text = CustomText["Value"]
	end
})
CustomText["Object"].Visible = false
local sec = function(secName)
return kavo = window:NewSection(secName.."")
end)
--[[
local bind = function(keytext, keyinf, first, callback)
return kavo = window:NewKeybind(keytext.."", keyinf.."", first.."", callback.."")
end
--]]
if game.PlaceId == 6872274481 or game.PlaceId == 8560631822 or game.PlaceId == 8444591321 then
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/6872274481.lua"))()
elseif game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua") then
loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/CustomModules/"..game.PlaceId..".lua"))()
elseif isfile("Nightbed/CustomModules/"..game.PlaceId..".lua") then
loadstring(readfile("Nightbed/CustomModules/"..game.PlaceId..".lua"))()
else
	if shared.NightbedPrivate then
		isfile("NightbedPrivate/CustomModules/"..game.PlaceId..".lua") then
loadstring(readfile("NightbedPrivate/CustomModules/"..game.PlaceId..".lua"))()
else
	loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/AnyGame.lua"))()
end
