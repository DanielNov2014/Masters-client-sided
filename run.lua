--[[ ===========================================================================
     MASTERS — runner

     Starts Masters from the files the installer already downloaded. Use this
     after a rejoin; it does not touch the network.

         loadstring(readfile("MastersRun.lua"))()

     or, straight from GitHub:

         loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielNov2014/Masters-client-sided/main/run.lua?t="..tick()))()

     If Masters was never installed on this PC, run bootstrap.lua instead — it
     downloads everything and offers a Run button at the end.
   ========================================================================== ]]

local ENTRY = "MastersLoader.lua"
local NEEDED = {"MastersLoader.lua", "MastersLogic.lua", "Masters.rbxm"}

local function log(m) print("[MASTERS] " .. m) end

--[[ Loading twice in one session stacks a second UI, a second copy of the
     package in ReplicatedStorage and a second set of connections — after which
     every button fires twice. Cheaper to refuse than to untangle. ]]
local function alreadyRunning()
	if rawget(_G, "Queue") ~= nil then return true end
	if game:GetService("ReplicatedStorage"):FindFirstChild("Masters(Storage)") then return true end
	local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
	return pg ~= nil and pg:FindFirstChild("Masters") ~= nil
end

if alreadyRunning() then
	log("Masters is already running in this session — rejoin first if you want a clean start")
	return
end

local missing = {}
for _, f in ipairs(NEEDED) do
	if not isfile(f) then table.insert(missing, f) end
end

if #missing > 0 then
	warn("[MASTERS] not installed on this PC — missing " .. table.concat(missing, ", "))
	warn('[MASTERS] run the installer first:  loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielNov2014/Masters-client-sided/main/bootstrap.lua?t="..tick()))()')
	return
end

local run, err = loadstring(readfile(ENTRY), "=MastersLoader")
if not run then
	warn("[MASTERS] loader failed to compile: " .. tostring(err))
	return
end

log("starting Masters")
run()
