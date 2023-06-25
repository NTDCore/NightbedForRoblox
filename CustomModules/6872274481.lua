local kavo = shared.kavogui
local entityLibrary = shared.vapeentity
local FunctionsLibrary = shared.funcslib

local runcode = function(func)
  func()
end

local runFunction = function(func)
  func()
end

local InputService = game:GetService("UserInputService")
local playersService = game:GetService("Players")
local lplr = playersService.LocalPlayer
local cam = game:GetService("Workspace").CurrentCamera
local mainchar = lplr.Character
local replicatedStorageService = game:GetService("ReplicatedStorage")

local bedwars = {}
local bedwarsData = {}

local function isAlive(plr)
  plr = plr or lplr
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
end

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

local function hashvec(vec)
	return {value = vec}
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end
runcode(function()
	local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
	local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
	local InventoryUtil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil
	bedwars = {
		AttackRemote = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController).attackEntity)),
		BlockController = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
		BlockController2 = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
		BlockEngine = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
		ChestController = KnitClient.Controllers.ChestController,
		ClientHandler = Client,
		getCurrentInventory = function(plr)
			local plr = plr or lplr
			local suc, result = pcall(function()
				return InventoryUtil.getInventory(plr)
			end)
			return (suc and result or {
				["items"] = {},
				["armor"] = {},
				["hand"] = nil
			})
		end,
		ItemMeta = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1),
		ItemTable = debug.getupvalue(require(replicatedStorageService.TS.item["item-meta"]).getItemMeta, 1),
		KnockbackUtil = require(game:GetService("ReplicatedStorage").TS.damage["knockback-util"]).KnockbackUtil,
		PickupMetdl = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.MetalDetectorController.KnitStart, 1))),
		PickupRemote = getremote(debug.getconstants(KnitClient.Controllers.ItemDropController.checkForPickup)),
		QueryUtil = require(replicatedStorageService["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
		QueueCard = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
		QueueMeta = require(replicatedStorageService.TS.game["queue-meta"]).QueueMeta,
		SprintCont = KnitClient.Controllers.SprintController,
		SwordController = KnitClient.Controllers.SwordController
	}
end)

local function targetCheck(plr, check)
	return (check and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil or check == false)
end

local function isPlayerTargetable(plr, target)
	return plr.Team ~= lplr.Team and plr and isAlive(plr) and targetCheck(plr, target)
end

local function GetAllNearestHumanoidToPosition(distance, amount)
	local returnedplayer = {}
	local currentamount = 0
	if isAlive(lplr) then -- alive check
		for i,v in pairs(game.Players:GetChildren()) do -- loop through players
			if isPlayerTargetable((v), true, true, v.Character ~= nil) and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Head") and currentamount < amount then -- checks
				local mag = (lplr.Character.HumanoidRootPart.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude
				if mag <= distance then -- mag check
					table.insert(returnedplayer, v)
					currentamount = currentamount + 1
				end
			end
		end
		for i2,v2 in pairs(game:GetService("CollectionService"):GetTagged("Monster")) do -- monsters
			if v2:FindFirstChild("HumanoidRootPart") and currentamount < amount and v2.Name ~= "Duck" then -- no duck
				local mag = (lplr.Character.HumanoidRootPart.Position - v2.HumanoidRootPart.Position).magnitude
				if mag <= distance then -- magcheck
					table.insert(returnedplayer, {Name = (v2 and v2.Name or "Monster"), UserId = 1443379645, Character = v2}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
				end
			end
		end
		for i2,v2 in
		pairs(game:GetService("CollectionService"):GetTagged("DiamondGuardian")) do --monsters
			if v2:FindFirstChild("HumanoidRootPart") and currentamount < amount and
			v2.Name ~= "DiamondGuardian" then -- no duck
				local mag = (lplr.Character.HumanoidRootPart.Position - v2.HumanoidRootPart.Position).magnitude
				if mag <= distance then -- magcheck
					table.insert(returnedplayer, {Name = (v2 and v2.Name or "DiamondGuardian"), UserId = 1443379645, Character = v2}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
				end
			end
		end
	end
	return returnedplayer -- table of attackable entities
end

local function playSound(id, volume) 
	local sound = Instance.new("Sound")
	sound.Parent = workspace
	sound.SoundId = id
	sound.PlayOnRemove = true 
	if volume then 
		sound.Volume = volume
	end
	sound:Destroy()
end

function SwitchTool(tool)
  replicatedStorageService.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SetInvItem:InvokeServer({
    ["hand"] = tool,
  })
  repeat task.wait() until lplr.Character.HandInvItem == tool
end

local function playAnimation(id) 
	if lplr.Character.Humanoid.Health > 0 then 
		local animation = Instance.new("Animation")
		animation.AnimationId = id
		local animatior = lplr.Character.Humanoid.Animator
		animatior:LoadAnimation(animation):Play()
	end
end

local function getCurrentSword()
	local sword, swordslot, swordrank = nil, nil, 0
	for i5, v5 in pairs(bedwars.getCurrentInventory().items) do
		if v5.itemType:lower():find("sword") or v5.itemType:lower():find("blade") or v5.itemType:lower():find("dao") then
			if bedwars.ItemMeta[v5.itemType].sword.damage > swordrank then
				sword = v5
				swordslot = i5
				swordrank = bedwars.ItemMeta[v5.itemType].sword.damage
			end
		end
	end
	return sword, swordslot
end

local win = kavo:CreateWindow({
  ["Title"] = "Nightbed"..(shared.NightbedPrivate and " PRIVATE" or ""),
  ["Theme"] = "Luna"
})

local Tabs = {
  ["Combat"] = win.CreateTab("Combat"),
  ["Blatant"] = win.CreateTab("Blatant"),
  ["Render"] = win.CreateTab("Render"),
  ["Utility"] = win.CreateTab("Utility"),
  ["World"] = win.CreateTab("World")
}

local Sections = shared.SectionsLoaded
Sections = {
	["HitFix"] = Tabs["Combat"].CreateSection("HitFix"),
  ["NoClickDelay"] = Tabs["Combat"].CreateSection("NoClickDelay"),
  ["Sprint"] = Tabs["Combat"].CreateSection("Sprint"),
  ["Velocity"] = Tabs["Combat"].CreateSection("Velocity"),
  ["InfiniteJump"] = Tabs["Blatant"].CreateSection("InfiniteJump"),
  ["Killaura"] = Tabs["Blatant"].CreateSection("Killaura"),
  ["NoFall"] = Tabs["Blatant"].CreateSection("NoFall"),
  ["BreathExploit"] = Tabs["Utility"].CreateSection("BreathExploit"),
  ["PartyExploit"] = Tabs["Utility"].CreateSection("PartyExploit"),
    --["AntiVoid"] = Tabs["World"].CreateSection("AntiVoid"),
  ["Breaker"] = Tabs["World"].CreateSection("Breaker")
}

local Settings = {
	Velocity = false,
	HitFix = false,
	NoClickDelay = false,
	Sprint = false,
	["InfiniteJump"] = false,
	Killaura = {
	  Enabled = false,
	  Range = 23,
	  NoSwing = false,
	  NoSound = false
	},
	NoFall = false,
	BreathExploit = false,
	PartyExploit = false,
	AntiVoid = false,
	Breaker = false
}

runcode(function()
	local func
	local func2
	local Velocity = {Enabled = false}
	Velocity = Sections["Velocity"].CreateToggle({
		Name = "Velocity",
		Function = function(callback)
			Velocity.Enabled = callback
			if Velocity.Enabled then
				Settings.Velocity = true
				func = bedwars.KnockbackUtil.applyKnockbackDirection
				func2 = bedwars.KnockbackUtil.applyKnockback
				bedwars.KnockbackUtil.applyKnockbackDirection = function(...) end
				bedwars.KnockbackUtil.applyKnockback = function(...) end
			else
				Settings.Velocity = false
				bedwars.KnockbackUtil.applyKnockbackDirection = func
				bedwars.KnockbackUtil.applyKnockback = func2
			end
		end,
		HoverText = "Remove knockbacks."
	})
end)

runcode(function()
	local HitFix = {Enabled = false}
	HitFix = Sections["HitFix"].CreateToggle({
		Name = "HitFix",
		HoverText = "Fixes the raycast function used for extra reach",
		Function = function(callback)
			HitFix.Enabled = callback
			if HitFix.Enabled then
				Settings.HitFix = true
				debug.setconstant(bedwars.SwordController.swingSwordAtMouse, 27, "raycast")
				debug.setupvalue(bedwars.SwordController.swingSwordAtMouse, 4, bedwars.QueryUtil)
			else
				Settings.HitFix = false
				debug.setconstant(bedwars.QueueCard.render, 9, 0.01)
				debug.setconstant(bedwars.SwordController.swingSwordAtMouse, 27, "Raycast")
			end
		end
	})
end)

runcode(function()
	local func
	local NoClickDelay = {Enabled = false}
	NoClickDelay = Sections["NoClickDelay"].CreateToggle({
		Name = "NoClickDelay",
		Function = function(callback)
			NoClickDelay.Enabled = callback
			if NoClickDelay.Enabled then
				Settings.NoClickDelay = true
				func = bedwars.SwordController.isClickingTooFast
				bedwars.SwordController.isClickingTooFast = function(self)
					self.lastSwing = tick()
					return false
				end
			else
				Settings.NoClickDelay = false
				bedwars.SwordController.isClickingTooFast = func
			end
		end,
		HoverText = "Bypass cps limit."
	})
end)

runcode(function()
	local Sprint = {Enabled = false}
	Sprint = Sections["Sprint"].CreateToggle({
		Name = "Sprint",
		Function = function(callback)
			Sprint.Enabled = callback
			if Sprint.Enabled then
				Settings.Sprint = true
				task.spawn(function()
					repeat
						task.wait()
						if (not bedwars.SprintCont.sprinting) then
							bedwars.SprintCont:startSprinting()
						end
					until (not Sprint.Enabled)
				end)
			else
				Settings.Sprint = false
				bedwars.SprintCont:stopSprinting()
			end
		end,
		HoverText = "Set sprint to true."
	})
end)

runFunction(function()
  local InfiniteJumpConnection
	local InfiniteJump = {Enabled = false}
	local InfJump = true
	InfiniteJump = Sections["InfiniteJump"].CreateToggle({
		Name = "InfiniteJump",
		Function = function(callback)
			InfiniteJump.Enabled = callback
	  	if InfiniteJump.Enabled then
	  	  Settings["InfiniteJump"] = true
	  	  spawn(function()
    			InfiniteJumpConnection = InputService.JumpRequest:connect(function(jump)
		    		if InfJump then
		    			mainchar:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    				end
		    	end)
				end)
			else
			  Settings["InfiniteJump"] = false
				InfiniteJumpConnection:Disconnect()
			end
		end,
		HoverText = "Make you can jump any place"
	})
end)

runcode(function()
	local KillauraNoSwing = {Enabled = false}
	local KillauraNoSound = {Enabled = false}
	local killaurarange = {Value = 23}
	local Killaura = {Enabled = false}
	local killauraremote = bedwars.ClientHandler:Get(bedwars.AttackRemote)
	local function attackEntity(plr)
		local root = plr.Character.HumanoidRootPart
		if not root then
			return nil
		end
		local selfrootpos = lplr.Character.HumanoidRootPart.Position
		local selfpos = selfrootpos + (killaurarange.Value > 14 and (selfrootpos - root.Position).magnitude > 14 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * 4) or Vector3.zero)
		local sword = getCurrentSword()
		killauraremote:SendToServer({
			["weapon"] = sword ~= nil and sword.tool,
			["entityInstance"] = plr.Character,
			["validate"] = {
				["raycast"] = {
					["cameraPosition"] = hashvec(cam.CFrame.Position),
					["cursorDirection"] = hashvec(Ray.new(cam.CFrame.Position, root.CFrame.Position).Unit.Direction)
				},
				["targetPosition"] = hashvec(root.CFrame.Position),
				["selfPosition"] = hashvec(selfpos)
			},
			["chargedAttack"] = {
				["chargeRatio"] = 0}
		})
		if not KillauraNoSwing.Enabled then
			if Killaura.Enabled then
				playAnimation("rbxassetid://4947108314")
			end
		end
		if not KillauraNoSound.Enabled then
			if Killaura.Enabled then
				playSound("rbxassetid://6760544639", 0.5)
			end
		end
	end
	Killaura = Sections["Killaura"].CreateToggle({
		Name = "Killaura",
		Function = function(callback)
			Killaura.Enabled = callback
			if Killaura.Enabled then
				Settings.Killaura.Enabled = true
				RunLoops:BindToHeartbeat("Killaura", 1, function()
					local plrs = GetAllNearestHumanoidToPosition(killaurarange.Value - 0.0001, 1)
					SwitchTool(getCurrentSword().tool)
					for i,plr in pairs(plrs) do
						task.spawn(attackEntity, plr)
					end
				end)
			else
				Settings.Killaura.Enabled = false
				RunLoops:UnbindFromHeartbeat("Killaura")
			end
		end,
		HoverText = "Attack players/enemies that are near."
	})
	KillauraNoSound = Sections["Killaura"].CreateToggle({
		Name = "No Sound",
		Function = function(val)
			Settings.Killaura.NoSound = val
			KillauraNoSound.Enabled = val
		end,
		HoverText = "Removes the swinging sound."
	})
	KillauraNoSwing = Sections["Killaura"].CreateToggle({
		Name = "No Swing",
		Function = function(val)
			Settings.Killaura.NoSwing = val
			KillauraNoSwing.Enabled = val
		end,
		HoverText = "Removes the swinging animation."
	})
end)

runcode(function()
	local NoFall = {Enabled = false}
	NoFall = Sections["NoFall"].CreateToggle({
		Name = "NoFall",
		Function = function(callback)
			NoFall.Enabled = callback
			if NoFall.Enabled then
				Settings.NoFall = true
				task.spawn(function()
					repeat
						task.wait()
						game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.GroundHit:FireServer()
					until (not NoFall.Enabled)
				end)
			else
				Settings.NoFall = false
			end
		end,
		HoverText = "Prevents taking fall damage."
	})
end)

--[[
runFunction(function()
	local SomethingWeird = {SecretEnabled = false}
	SomethingWeird = Sections["???"].CreateButton({
		Name = "???",
		Function = function()
			
		end
	})
end)
--]]

runFunction(function()
  local BreathExploit = {Enabled = false}
  BreathExploit = Sections["BreathExploit"].CreateToggle({
		Name = "BreathExploit",
		Function = function(callback)
			BreathExploit.Enabled = callback
			if BreathExploit.Enabled then
				Settings.BreathExploit = true
				task.spawn(function()
					repeat
						task.wait()
						game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.DragonBreath:FireServer({
							["player"] = lplr
						})
					until (not BreathExploit.Enabled)
				end)
			else
				Settings.BreathExploit = false
			end
		end,
		HoverText = "Prevents taking fall damage."
	})
end)

runcode(function()
	local PartyExploit = {Enabled = false}
  PartyExploit = Sections["PartyExploit"].CreateToggle({
		Name = "PartyExploit",
		Function = function(callback)
			PartyExploit.Enabled = callback
		--	Settings.PartyExploit = callback
			if PartyExploit.Enabled then
				Settings.PartyExploit = true
				task.spawn(function()
					repeat
						task.wait()
						game:GetService("ReplicatedStorage")["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].useAbility:FireServer("PARTY_POPPER")
					until (not PartyExploit.Enabled)
				end)
			else
				Settings.BreathExploit = false
			end
		end,
		HoverText = "Prevents taking fall damage."
	})
end)

--[[
runcode(function()
	local antivoidpart
	local antivoidconnection
	local antivoiding = false
	local antitransparent = {Value = 50}
	local anticolor = {["Hue"] = 0.44, ["Sat"] = 1, ["Value"] = 1}
	local AntiVoid = {Enabled = false}
	AntiVoid = Sections["AntiVoid"].CreateToggle({
		Name = "AntiVoid",
		Function = function(callback)
			AntiVoid.Enabled = callback
			if AntiVoid.Enabled then
				task.spawn(function()
					Settings.AntiVoid = true
					antivoidpart = Instance.new("Part")
					antivoidpart.CanCollide = false
					antivoidpart.Size = Vector3.new(10000, 1, 10000)
					antivoidpart.Anchored = true
					antivoidpart.Material = Enum.Material.Neon
					antivoidpart.Color = Color3.fromHSV(anticolor["Hue"], anticolor["Sat"], anticolor["Value"])
					antivoidpart.Transparency = 1 - (antitransparent.Value / 100)
					antivoidpart.Position = lplr.Character.HumanoidRootPart.Position - Vector3.new(0, 21, 0)
					antivoidpart.Parent = workspace
					antivoidconnection = antivoidpart.Touched:Connect(function(touched)
						if touched.Parent == lplr.Character and isAlive(lplr) then
							if (not antivoiding) and lplr.Character.Humanoid.Health > 0 then
								antivoiding = true
								lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 150, 0)
								antivoiding = false
							end
						end
					end)
				end)
			else
				Settings.AntiVoid = false
				if antivoidconnection then antivoidconnection:Disconnect() end
					if antivoidpart then
						antivoidpart:Remove()
					end
				end
			end,
		HoverText = "Prevents falling in void\nit will create the part."
	})
	antitransparent = Sections["AntiVoid"].CreateSlider({
		Name = "Transparency",
		Min = 1,
		Max = 100,
		Default = 50,
		Function = function(val)
			antitransparent.Value = val
			if antivoidpart then
				antivoidpart.Transparency = 1 - (antitransparent.Value / 100)
			end
		end
	})
	anticolor = Sections["AntiVoid"].CreateColorPicker({
		Name = "Color",
		Default = Color3.fromHSV(anticolor["Hue"], anticolor["Sat"], anticolor["Value"]),
		Function = function(col)
			if antivoidpart then
				antivoidpart.Color = col
			end
		end
	})
end)
--]]

runcode(function()
  local params = RaycastParams.new()
  params.IgnoreWater = true
  function BreakFunction(part)
    local raycastResult = game:GetService("Workspace"):Raycast(part.Position + Vector3.new(0,24,0),Vector3.new(0,-27,0),params)
    if raycastResult then
      local targetblock = raycastResult.Instance
      for i,v in pairs(targetblock:GetChildren()) do
        if v:IsA("Texture") then
          v:Destroy()
        end
      end
      replicatedStorageService.rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock:InvokeServer({
        ["blockRef"] = {
          ["blockPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
        },
        ["hitPosition"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3)),
        ["hitNormal"] = Vector3.new(math.round(targetblock.Position.X/3),math.round(targetblock.Position.Y/3),math.round(targetblock.Position.Z/3))
      })
    end
  end
  function GetBeds()
    local beds = {}
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
      if string.lower(v.Name) == "bed" and v:FindFirstChild("Covers") ~= nil and v:FindFirstChild("Covers").BrickColor ~= lplr.Team.TeamColor then
        table.insert(beds,v)
      end
    end
    return beds
  end
  local BreakerRange = {Value = 30}
  local Breaker = {Enabled = false}
  Breaker = Sections["Breaker"].CreateToggle({
    Name = "Breaker",
    Function = function(callback)
      Breaker.Enabled = callback
      if Breaker.Enabled then
        task.spawn(function()
          while task.wait() do
            if not Breaker.Enabled then return end
            task.spawn(function()
              if lplr:GetAttribute("DenyBlockBreak") == true then
                lplr:SetAttribute("DenyBlockBreak",nil)
              end
            end)
            if isAlive() then
              local beds = GetBeds()
              for i,v in pairs(beds) do
                local mag = (v.Position - lplr.Character.PrimaryPart.Position).Magnitude
                if mag < BreakerRange.Value then
                  BreakFunction(v)
                end
              end
            end
          end
        end)
      else
        Settings.Breaker = false
      end
    end
  })
end)
spawn(function()
	repeat
	  wait(0.5)
		writefile("Nightbed/Profiles/6872274481.json",game:GetService("HttpService"):JSONEncode(Settings))
	until false
end)
local suc, res = pcall(function()
	return game:GetService("HttpService"):JSONDecode(readfile("Nightbed/Profiles/6872274481.json"))
end)
 if suc and type(res) == "table" then 
  Settings = res
  if Velocity then
  	Velocity.ToggleButton(Settings.Velocity)
  end
  if HitFix then
  	HitFix.ToggleButton(Settings.HitFix)
  end
  if NoClickDelay then
  	NoClickDelay.ToggleButton(Settings.NoClickDelay)
  end
  if Sprint then
  	Sprint.ToggleButton(Settings.Sprint)
  end
  if Killaura then
  	Killaura.ToggleButton(Settings.Killaura.Enabled)
  end
  if KillauraNoSound then
  	KillauraNoSound.ToggleButton(Settings.Killaura.NoSound)
  end
  if KillauraNoSwing then
  	KillauraNoSwing.ToggleButton(Settings.Killaura.NoSwing)
  end
  if NoFall then
  	NoFall.ToggleButton(Settings.NoFall)
  end
  if BreathExploit then
  	BreathExploit.ToggleButton(Settings.BreathExploit)
  end
  if PartyExploit then
  	PartyExploit.ToggleButton(Settings.PartyExploit)
  end
  --if AntiVoid then
  --	AntiVoid.ToggleButton(Settings.AntiVoid)
  --end
  if Breaker then
  	Breaker.ToggleButton(Settings.Breaker)
  end
end