-- [[ THE MASTERS: NAMED-CHUNK DIAGNOSTIC ]]
local RBXM = "Masters.rbxm"
local LUA = "MastersLogic.lua"
local function rawconsoleprint(text)
	consoleprint(text .. "\n")
end
rawconsoleprint("Injecting Masters... ")
task.wait(2)
rawconsoleprint("Injection Succesful.")
task.wait(0.5)
rawconsoleprint("🔍 [DIAGNOSTIC]: ADDING MASTERS... \n")
rawconsoleprint("---------------------------------------")
rawconsoleprint("")

-- 1. SAVE THE REAL ENGINE CALLS
local RealRequire = require 
local Registry = {}

-- 2. LOAD ASSETS
local assets = game:GetObjects(getcustomasset(RBXM))
local Package = assets[1]
local Storage = Package:FindFirstChild("Masters(Storage)")
local UI = Package:FindFirstChild("Masters")

Storage.Parent = game:GetService("ReplicatedStorage")
UI.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- 2a. NO-REMOTES: convert every RemoteFunction/RemoteEvent under the package into a
-- Bindable of the same name/parent. The Handler then wires each Bindable straight to
-- the backend (no __namecall hook), so nothing an anticheat watches for is installed.
-- Skips instances already Bindable. Until the rbxm is re-exported as Bindables this
-- runs on load; afterwards it simply finds nothing to convert.
do
	local converted = 0
	local function convertUnder(root)
		if not root then return end
		for _, inst in ipairs(root:GetDescendants()) do
			if inst:IsA("RemoteFunction") or inst:IsA("RemoteEvent") then
				local bind = Instance.new(inst:IsA("RemoteFunction") and "BindableFunction" or "BindableEvent")
				bind.Name = inst.Name
				for _, child in ipairs(inst:GetChildren()) do child.Parent = bind end
				bind.Parent = inst.Parent
				inst:Destroy()
				converted += 1
			end
		end
	end
	convertUnder(Storage)
	convertUnder(UI)
	rawconsoleprint("🔌 [NO-REMOTES]: converted " .. converted .. " remote(s) to Bindables")
end

-- 2b. HOTFIX until the next rbxm export: the Queue module's end-of-song hook must
-- stop (not wrap into a replay) when repeat is off and there is nothing else to play.
-- Skips itself once the exported module already contains MastersStopGuard.
do
	local q = Storage:FindFirstChild("Modules") and Storage.Modules:FindFirstChild("Queue")
	local hs = q and q:FindFirstChild("HiddenSource")
	if hs and not hs.Value:find("MastersStopGuard", 1, true) then
		local guard = 'if State.Settings.RepeatMode ~= "Song" and not State.Settings.Shuffle and #State.MasterList <= 1 and #State.Queue == 0 then return end -- MastersStopGuard\n\t\t\t'
		local patched, n = hs.Value:gsub(
			'(if State%.IsLoading or State%.IsCrossfading then return end%s*\n%s*if State%.IsPaused then return end%s*\n%s*)module%.Next%(%)',
			'%1' .. guard .. 'module.Next()', 1)
		if n == 1 then
			hs.Value = patched
			rawconsoleprint("🩹 [HOTFIX]: Queue stop-guard applied")
		else
			rawconsoleprint("⚠️ [HOTFIX]: Queue stop-guard needle not found (module changed?)")
		end
	end
end

-- 2c. HOTFIX until the next rbxm export: the share sheet also lists cross-server
-- Masters listeners from the presence relay. Skips itself once the exported
-- module already contains MastersCrossShare.
do
	local m = Storage:FindFirstChild("Modules") and Storage.Modules:FindFirstChild("Main")
	local hs = m and m:FindFirstChild("HiddenSource")
	if hs and not hs.Value:find("MastersCrossShare", 1, true) then
		local needle = "\t\tItem.MouseButton1Click:Connect(function()\n\t\t\tReceiverChosen = Player.UserId\n\t\t\tSharingCompleted = true\n\t\tend)\n\tend\n"
		local insert = table.concat({
			"\t",
			"\t-- cross-server Masters listeners from the presence relay (MastersCrossShare)",
			"\tpcall(function()",
			"\t\tlocal fetch = rawget(_G, \"MastersOnlineListeners\")",
			"\t\tif not fetch then return end",
			"\t\tfor i, entry in ipairs(fetch()) do",
			"\t\t\tlocal uid = entry.UserId",
			"\t\t\tif uid and uid ~= client.UserId and not Players:GetPlayerByUserId(uid) then",
			"\t\t\t\tlocal Item = ui.Storage.Items.ShareSheetPlayerList:Clone()",
			"\t\t\t\tItem.Name = \"zz\" .. tostring(uid)",
			"\t\t\t\tItem.Display.Text = entry.Name",
			"\t\t\t\tItem.Username.Text = \"\\u{266B} listening now\"",
			"\t\t\t\tItem.Photo.Image = Utilities.GetPlayerThumbnail(uid)",
			"\t\t\t\tItem.Parent = ShareSheet.MainFrame.Frame.Container.Players",
			"\t\t\t\tItem.MouseButton1Click:Connect(function()",
			"\t\t\t\t\tReceiverChosen = uid",
			"\t\t\t\t\tSharingCompleted = true",
			"\t\t\t\tend)",
			"\t\t\tend",
			"\t\tend",
			"\tend)",
			"",
		}, "\n")
		local s = hs.Value:find(needle, 1, true)
		if s then
			hs.Value = hs.Value:sub(1, s - 1) .. needle .. insert .. hs.Value:sub(s + #needle)
			rawconsoleprint("🩹 [HOTFIX]: cross-server share sheet applied")
		else
			rawconsoleprint("⚠️ [HOTFIX]: share sheet needle not found (module changed?)")
		end
	end
end

-- 3. THE NAMED COMPILER
local function LoadModuleManual(mod)
    local hidden = mod:FindFirstChild("HiddenSource")
    if not hidden then return nil end

    local chunkName = "=" .. mod.Name
    -- NO-REMOTES: modules call the Events with remote method names; rewrite them to the
    -- Bindable API so they hit the converted instances (no-op once the rbxm is re-exported)
    local body = hidden.Value:gsub(":InvokeServer%(", ":Invoke("):gsub(":FireServer%(", ":Fire(")
    local source = "local script = ...; local require = _G.MastersRequire;\n" .. body

    local func, err = loadstring(source, chunkName)
    if not func then
        rawconsoleprint("❌ Syntax Error in [" .. mod.Name .. "]: " .. tostring(err))
        return nil
    end

    local ok, result = xpcall(function()
        return func(mod)
    end, function(e)
        return debug.traceback(e)
    end)

    if ok then
        Registry[mod] = result
        Registry[mod.Name] = result
        rawconsoleprint("✅ [LOADED]: " .. mod.Name)
        return result
    else
        rawconsoleprint("‼️ [CRITICAL CRASH] inside Module: " .. mod.Name)
        rawconsoleprint(result)
        Registry[mod] = {} 
        return {}
    end
end

-- 4. THE MASTER BYPASS
_G.MastersRequire = function(target)
    if Registry[target] then return Registry[target] end
    if typeof(target) == "Instance" and target:IsA("ModuleScript") then
        return LoadModuleManual(target)
    end
    return RealRequire(target)
end

-- 5. LAUNCH 8K LOGIC (Named "MainLogic")
if isfile(LUA) then
    rawconsoleprint("🚀 [DIAGNOSTIC]: Launching 8k Main Logic...")
    local mainCode = readfile(LUA)
    local mainFunc, err = loadstring(mainCode, "=MainLogic")
    
    if mainFunc then
        local env = setmetatable({
            require = _G.MastersRequire,
            script = UI
        }, {__index = getfenv()})
        setfenv(mainFunc, env)
        
        task.spawn(function()
            local ok, runErr = xpcall(mainFunc, function(e) return debug.traceback(e) end)
            if not ok then 
                warn("❌ [8K LOGIC CRASHED]:")
                print(runErr)
            end
        end)
    else
        warn("❌ [8K SYNTAX ERROR]: " .. tostring(err))
    end
end

rawconsoleprint("---------------------------------------")