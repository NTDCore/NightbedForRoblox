# Kavo Modded

just like kavo but i modified it

## UI

```lua
local UI = loadstring(game:HttpGet('https://raw.githubusercontent.com/NTDCore/NightbedForRoblox/main/Core/kavo.lua'))()
```

## Window

```lua
local Window = UI:CreateWindow({
	['Title'] = 'Name', -- string
	Theme = 'Ocean' -- string
})
```

### Themes

```
| LightTheme
| DarkTheme
| GrapeTheme
| BloodTheme
| Ocean
| Vape
| Luna
| Private
| Midnight
| Sentinel
| Synapse
```

## Tab

```lua
local tabName = Window.CreateTab('TabName') -- string
```

or

```lua
local Tabs = { -- table
	['Combat'] = Window.CreateTab('Combat') -- string
	Blatant = Window.CreateTab('Blatant') -- string
}
```

## Section

```lua
local SectionName = tabName.CreateSection('silly :3') -- string
local section2 = Tabs['Combat'].CreateSection('AimAssist') -- string
local silly3 = Tabs.Combat.CreateSection('AutoClicker') -- string
local section3 = Tabs.Blatant.CreateSection('hehe') -- string
```

### Section Function

Set Section Visible

```lua
SectionName.SetVisible(state) -- true or false or just use "SectionName.SetVisible()" | boolean
```

## Label

```lua
SectionName.CreateLabel({
	['Text'] = 'silly :3' -- string
})
local LableMuahhah = SectionName.CreateLabel({
	Text = 'help am so silly :3' -- am so silly during make this documents | string
})
```

### Label Function

Rename Label

```lua
LabelMuahhah.renameLabel('silly hehe :3') -- function, string
```

## Button

```lua
SectionName.CreateButton({
	['Name'] = 'Silly :3', -- string
	["HoverText"] = 'very silly :3', -- tooltip ig | string
	Function = function() -- function
		-- paste the script here or example:
		print('i feel so silly :3')
	end
})

local kickyoself = SectionName.CreateButton({
	['Name'] = 'Silly Kick :3', -- string
	["HoverText"] = 'very silly kick :3', -- tooltip ig | string
	Function = function() -- function
		cloneref(game:GetService('Players')).LocalPlayer:Kick('silly kick :3')
	end
})
```

### Button Function

Rename Button

```lua
kickyoself.renameButton('Kick :3')
```

## Toggle

```lua
SectionName.CreateToggle({
	['Name'] = 'silly toggle :3', -- string
	["Default"] = false, -- boolean | will auto toggle if set to true :3
	['HoverText'] = 'make a silly print', -- string
	Function = function(value)
		if value then
			print('enabled')
		else
			print('disabled')
		end
	end -- function
})

local haha = SectionName.CreateToggle({
	['Name'] = 'silly default :3', -- string
	["Default"] = true, -- boolean | will auto toggle if set to true :3
	['HoverText'] = 'make a silly print', -- string
	Function = function(value)
		if value then
			print('enabled')
		else
			print('disabled')
		end
	end -- function
})
```

toggle have auto table so, if you do
```lua
local haha = SectionName.CreateToggle({
	['Name'] = 'silly default :3', -- string
	["Default"] = true, -- boolean | will auto toggle if set to true :3
	['HoverText'] = 'make a silly print', -- string
	Function = function(value)
		if value then
			print('enabled')
		else
			print('disabled')
		end
	end -- function
})
```
then it will have a table like this
```
| Enabled: false
```
basically, `haha['Enabled']` or `haha.Enabled` ya (gosh, please help me am so fucking silly while making this shit :3)

### Toggle Functions

ToggleButton

```lua
haha.ToggleButton(state) -- state is boolean (ex. true or false)
```

replaceFunction

```lua
haha.replaceFunction(function(hehe)
	if hehe then
		print('silly yes :3')
	else
		print('silly no 3:')
	end
end)
```

## Slider

```lua
SectionName.CreateSlider({
	['Name'] = 'silly slider', -- string
	Min = 0, -- number
	["Max"] = 100, -- number
	Default = 1, -- number | or just remove this if you dont want to set it default hehe :3
	Function = function(val)
		print('current value is '..val)
	end
})
```

### Slider Function

Set Value
```lua
local sillyslider = SectionName.CreateSlider({
	['Name'] = 'silly slider', -- string
	Min = 0, -- number
	["Max"] = 100, -- number
	Default = 1, -- number | or just remove this if you dont want to set it default hehe :3
	Function = function(val)
		print('current value is '..val)
	end
})
sillyslider.SetValue(12) -- number | oh shit am getting silly :3 HELPQWDJQWI9DUQW0QWDUJOIDJQWKP
```

## Textbox

```lua
SectionName.CreateTextBox({
	Name = 'SILLY >:3',
	Function = function(val)
		print(val)
	end
})
```

## Keybind

do it tomorrow i feel very silly :3