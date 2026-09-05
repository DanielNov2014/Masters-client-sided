--[[ ===========================================================================
     MASTERS — installer

     Run this on any PC:

         loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielNov2014/Masters-client-sided/main/bootstrap.lua?t="..tick()))()

     It downloads Masters into Real's Workspace folder, shows the progress, and
     gives you a Run button when it is done.

     Re-run it any time to update — only files that actually changed are
     downloaded. It also saves a runner as MastersRun.lua, so starting Masters
     after a rejoin is just:

         loadstring(readfile("MastersRun.lua"))()
   ========================================================================== ]]

local REPO   = "DanielNov2014/Masters-client-sided"
local BRANCH = "main"
local TOKEN  = ""    -- only needed if the repo is made private; see the note at the bottom

-- --------------------------------------------------------------------------

local FILES = {
	"MastersLoader.lua",      -- the injector: parents the package, starts the Handler
	"MastersLogic.lua",       -- the Handler itself
	"Masters.rbxm",           -- the UI + module package
	"MastersShareAPI.txt",    -- share / community-lyrics endpoint
	"MastersPresenceWS.txt",  -- presence relay endpoint (instant sync, cross-server)
}

local ENTRY  = "MastersLoader.lua"
local STATE  = "MastersSync.json"
local CONFIG = "MastersGitHub.json"
local SELF   = "MastersUpdate.lua"
local RUNNER = "MastersRun.lua"
local ADDONS = "MastersAddons.json"

local RAW = ("https://raw.githubusercontent.com/%s/%s/"):format(REPO, BRANCH)
local Http    = game:GetService("HttpService")
local Tween   = game:GetService("TweenService")
local Players = game:GetService("Players")

local function log(m) print("[MASTERS] " .. m) end

-- ------------------------------------------------------------------------ UI

local function E(class, props, kids)
	local o = Instance.new(class)
	local parent = props.Parent
	for k, v in pairs(props) do if k ~= "Parent" then o[k] = v end end
	if kids then for _, c in ipairs(kids) do c.Parent = o end end
	o.Parent = parent
	return o
end
local function corner(r) return E("UICorner", {CornerRadius = UDim.new(0, r)}) end

local host = (gethui and gethui()) or game:GetService("CoreGui")
local old = host:FindFirstChild("MastersInstaller")
if old then old:Destroy() end

local screen = E("ScreenGui", {Name = "MastersInstaller", IgnoreGuiInset = true,
	ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = host})

local card = E("Frame", {BackgroundColor3 = Color3.fromRGB(14, 16, 24), BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(430, 190), Parent = screen}, {
	corner(16),
	E("UIStroke", {Color = Color3.fromRGB(38, 41, 54), Thickness = 1}),
})
-- slide in rather than appear
card.Position = UDim2.new(0.5, 0, 0.5, 22)
card.BackgroundTransparency = 1
Tween:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad),
	{Position = UDim2.fromScale(0.5, 0.5), BackgroundTransparency = 0}):Play()

E("Frame", {BackgroundColor3 = Color3.fromRGB(122, 92, 255), BorderSizePixel = 0,
	Position = UDim2.fromOffset(26, 26), Size = UDim2.fromOffset(10, 10), Parent = card},
	{E("UICorner", {CornerRadius = UDim.new(1, 0)})})

E("TextLabel", {BackgroundTransparency = 1, Text = "Masters", Font = Enum.Font.GothamBold,
	TextSize = 17, TextColor3 = Color3.fromRGB(245, 246, 250),
	TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(46, 20),
	Size = UDim2.fromOffset(300, 22), Parent = card})

local status = E("TextLabel", {BackgroundTransparency = 1, Text = "Connecting to GitHub…",
	Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(139, 144, 160),
	TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	Position = UDim2.fromOffset(26, 52), Size = UDim2.new(1, -52, 0, 18), Parent = card})

local pct = E("TextLabel", {BackgroundTransparency = 1, Text = "", Font = Enum.Font.GothamMedium,
	TextSize = 12, TextColor3 = Color3.fromRGB(139, 144, 160),
	TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -26, 0, 52), Size = UDim2.fromOffset(120, 18), Parent = card})

local track = E("Frame", {BackgroundColor3 = Color3.fromRGB(30, 33, 44), BorderSizePixel = 0,
	Position = UDim2.fromOffset(26, 86), Size = UDim2.new(1, -52, 0, 6), Parent = card}, {corner(3)})
local fill = E("Frame", {BackgroundColor3 = Color3.fromRGB(99, 217, 138), BorderSizePixel = 0,
	Size = UDim2.fromScale(0, 1), Parent = track}, {corner(3)})

local detail = E("TextLabel", {BackgroundTransparency = 1, Text = "", Font = Enum.Font.Gotham,
	TextSize = 12, TextColor3 = Color3.fromRGB(105, 110, 128),
	TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(26, 102),
	Size = UDim2.new(1, -52, 0, 16), Parent = card})

-- the action row only appears once there is something to press
local action = E("TextButton", {Text = "", AutoButtonColor = false, Visible = false,
	BackgroundColor3 = Color3.fromRGB(26, 116, 230), BorderSizePixel = 0,
	AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -22),
	Size = UDim2.fromOffset(378, 40), Parent = card}, {corner(10)})
local actionLabel = E("TextLabel", {BackgroundTransparency = 1, Text = "Run Masters",
	Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255, 255, 255),
	Size = UDim2.fromScale(1, 1), Parent = action})

local dismiss = E("TextButton", {Text = "✕", AutoButtonColor = false, Font = Enum.Font.GothamBold,
	TextSize = 13, TextColor3 = Color3.fromRGB(120, 126, 145), BackgroundTransparency = 1,
	AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -18, 0, 16),
	Size = UDim2.fromOffset(24, 24), Parent = card})

--[[ How to start Masters after a rejoin. Without this on the card the only way
     to find it out is to go and read the repo, which nobody does. ]]
local RUN_CMD = 'loadstring(readfile("MastersRun.lua"))()'

local hint = E("Frame", {BackgroundColor3 = Color3.fromRGB(20, 23, 32), BorderSizePixel = 0,
	Visible = false, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -20),
	Size = UDim2.fromOffset(378, 48), Parent = card},
	{corner(10), E("UIStroke", {Color = Color3.fromRGB(38, 41, 54), Thickness = 1})})

E("TextLabel", {BackgroundTransparency = 1, Text = "NEXT TIME, RUN THIS",
	Font = Enum.Font.GothamBold, TextSize = 9, TextColor3 = Color3.fromRGB(105, 110, 128),
	TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(12, 7),
	Size = UDim2.fromOffset(200, 11), Parent = hint})

E("TextLabel", {BackgroundTransparency = 1, Text = RUN_CMD, Font = Enum.Font.Code,
	TextSize = 12, TextColor3 = Color3.fromRGB(190, 196, 214),
	TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
	Position = UDim2.fromOffset(12, 21), Size = UDim2.fromOffset(290, 18), Parent = hint})

local copyBtn = E("TextButton", {Text = "Copy", AutoButtonColor = false,
	Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = Color3.fromRGB(215, 220, 235),
	BackgroundColor3 = Color3.fromRGB(38, 42, 56), BorderSizePixel = 0,
	AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0),
	Size = UDim2.fromOffset(58, 26), Parent = hint}, {corner(7)})

copyBtn.MouseButton1Click:Connect(function()
	local ok = pcall(function() setclipboard(RUN_CMD) end)
	copyBtn.Text = ok and "Copied" or "Ctrl+C"
	if not ok then log("copy unavailable in this executor — the command is: " .. RUN_CMD) end
	task.delay(1.4, function() if copyBtn.Parent then copyBtn.Text = "Copy" end end)
end)

-- shown once the install is done: makes room for the hint under the button
local function showRunHint()
	hint.Visible = true
	action.Position = UDim2.new(0.5, 0, 1, -78)
	Tween:Create(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad),
		{Size = UDim2.fromOffset(430, 248)}):Play()
	log("start Masters later with:  " .. RUN_CMD)
end

local function close()
	Tween:Create(card, TweenInfo.new(0.22),
		{Position = UDim2.new(0.5, 0, 0.5, 18), BackgroundTransparency = 1}):Play()
	task.delay(0.25, function() screen:Destroy() end)
end
dismiss.MouseButton1Click:Connect(close)

local function setProgress(done, total)
	local a = total > 0 and math.clamp(done / total, 0, 1) or 0
	Tween:Create(fill, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(a, 1)}):Play()
	pct.Text = ("%d%%"):format(math.floor(a * 100 + 0.5))
end
local function kb(n) return ("%.0f KB"):format(n / 1024) end

local function finish(title, note, buttonText, colour, onClick)
	status.Text = title
	detail.Text = note or ""
	Tween:Create(fill, TweenInfo.new(0.25), {BackgroundColor3 = colour}):Play()
	if buttonText then
		actionLabel.Text = buttonText
		action.BackgroundColor3 = colour
		action.Visible = true
		Tween:Create(card, TweenInfo.new(0.25), {Size = UDim2.fromOffset(430, 190)}):Play()
		action.MouseButton1Click:Connect(onClick)
		action.MouseEnter:Connect(function()
			Tween:Create(action, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
		end)
		action.MouseLeave:Connect(function()
			Tween:Create(action, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
		end)
	else
		card.Size = UDim2.fromOffset(430, 140)
	end
end
card.Size = UDim2.fromOffset(430, 140)   -- no button while downloading

-- -------------------------------------------------------------------- GitHub

local function ghHeaders()
	local h = {
		["Accept"] = "application/vnd.github+json",
		["X-GitHub-Api-Version"] = "2022-11-28",
		["User-Agent"] = "Masters-Bootstrap",   -- GitHub rejects calls without one
	}
	if TOKEN ~= "" then h["Authorization"] = "Bearer " .. TOKEN end
	return h
end

local function apiJson(url)
	local res
	for attempt = 1, 3 do
		local ok, r = pcall(request, {Url = url, Method = "GET", Headers = ghHeaders()})
		if ok and type(r) == "table" then
			res = r
			if r.StatusCode ~= 502 and r.StatusCode ~= 503 then break end
		end
		task.wait(attempt)
	end
	if type(res) ~= "table" then return nil, "no response from GitHub" end
	if res.StatusCode == 404 then
		return nil, "404 — check the repo name and branch (and TOKEN, if it is private)"
	elseif res.StatusCode == 401 or res.StatusCode == 403 then
		return nil, res.StatusCode .. " — the token was rejected or is rate limited"
	elseif res.StatusCode ~= 200 then
		return nil, res.StatusCode .. " from GitHub"
	end
	local ok, decoded = pcall(function() return Http:JSONDecode(res.Body) end)
	if not ok then return nil, "could not parse GitHub's reply" end
	return decoded
end

-- GitHub's `sha` is the git blob hash, so the download can be proven intact.
local function blobSha(data)
	local ok, d = pcall(crypt.hash, "blob " .. #data .. "\0" .. data, "sha1")
	return ok and d or nil
end

--[[ HttpGet does NOT throw on a missing file — it hands back the string
     "404: Not Found" like it were content. Without a hash to check against that
     lands on disk as the file, so every download is verified and this is the
     backstop for the ones fetched before the listing is known. ]]
local function isNotFound(body)
	return type(body) ~= "string" or (#body < 64 and body:find("404", 1, true) == 1)
end

--[[ raw.githubusercontent is the fast path — no base64, a third less to transfer,
     and verified byte-identical to the API for the binary .rbxm. But it sits
     behind a CDN, so just after a publish it can still serve stale bytes or a
     404. If it does not verify we fall back to the Contents API, which is always
     current, rather than calling a perfectly good file corrupt. ]]
--[[ Set once the manifest is read. raw.githubusercontent caches a BRANCH path for
     ~5 minutes and ignores query strings entirely — a cache-buster does nothing,
     measured. A COMMIT path is immutable, so pinning to the commit the manifest
     names is what actually guarantees the right bytes. ]]
local pinned = nil

local function download(name, expectSha)
	local url = (pinned
		and ("https://raw.githubusercontent.com/%s/%s/%s"):format(REPO, pinned, name)
		or (RAW .. name))

	local ok, body = pcall(function() return game:HttpGet(url, true) end)
	if ok and not isNotFound(body) and (not expectSha or blobSha(body) == expectSha) then
		return body, "raw"
	end
	local entry, err = apiJson(
		("https://api.github.com/repos/%s/contents/%s?ref=%s"):format(REPO, name, BRANCH))
	if not entry then return nil, err end
	local data
	if entry.content and entry.content ~= "" then
		data = crypt.base64_decode(entry.content:gsub("%s", ""))
	else
		local blob, berr = apiJson(entry.git_url)      -- >1MB files live in the blob API
		if not blob then return nil, berr end
		data = crypt.base64_decode(blob.content:gsub("%s", ""))
	end
	if expectSha and blobSha(data) and blobSha(data) ~= expectSha then
		return nil, "hash mismatch"
	end
	return data, "api"
end

-- --------------------------------------------------------------------- sync

log("checking " .. REPO .. "@" .. BRANCH)

-- One listing call gives every file's size and sha, so progress can be weighted
-- by bytes and unchanged files skipped without asking about them individually.
--[[ The manifest is published next to the files and read straight off raw, so the
     normal path never touches the GitHub API at all. That matters: anonymous API
     calls are capped at 60 an hour and the cap is shared by everyone on your IP,
     so a handful of reinstalls could lock you out with a 403. The API stays only
     as the fallback inside download(). ]]
local meta = {}
do
	local ok, body = pcall(function() return game:HttpGet(RAW .. "manifest.json", true) end)
	if ok and not isNotFound(body) then
		local decoded
		ok, decoded = pcall(function() return Http:JSONDecode(body) end)
		if ok and type(decoded) == "table" and type(decoded.files) == "table" then
			meta = decoded.files
			--[[ Everything else is then pulled from this exact commit. The manifest
			     itself can be up to ~5 minutes behind the branch, so a install
			     started in that window is simply a slightly older release — but a
			     WHOLE one, never a mix of new and old files. ]]
			pinned = decoded.commit
			if pinned then log("pinned to commit " .. tostring(pinned):sub(1, 8)) end
		end
	end
end

if next(meta) == nil then
	status.Text = "Reading the file list…"
	local listing = apiJson(("https://api.github.com/repos/%s/contents/?ref=%s"):format(REPO, BRANCH))
	for _, e in ipairs(listing or {}) do
		if e.type == "file" then meta[e.name] = {sha = e.sha, size = e.size} end
	end
end

if next(meta) == nil then
	finish("Couldn't reach GitHub", "no manifest, and the API is unavailable or rate limited",
		"Close", Color3.fromRGB(226, 92, 92), close)
	return
end

local state = {}
pcall(function()
	if isfile(STATE) then
		local s = Http:JSONDecode(readfile(STATE))
		if type(s) == "table" and s.repo == REPO and type(s.files) == "table" then state = s.files end
	end
end)

local todo, totalBytes = {}, 0
for _, name in ipairs(FILES) do
	local e = meta[name]
	if not e then
		finish("Missing from the repo", name .. " is not published", "Close",
			Color3.fromRGB(226, 92, 92), close)
		return
	end
	if state[name] ~= e.sha or not isfile(name) then
		table.insert(todo, name)
		totalBytes += (e.size or 0)
	end
end

local doneBytes, failed = 0, 0

if #todo == 0 then
	setProgress(1, 1)
	status.Text = "Already up to date"
	detail.Text = #FILES .. " files, nothing to download"
else
	for i, name in ipairs(todo) do
		status.Text = ("Downloading %s"):format(name)
		detail.Text = ("file %d of %d   ·   %s / %s"):format(i, #todo, kb(doneBytes), kb(totalBytes))
		task.wait()          -- let the frame paint before the request blocks

		local data, how = download(name, meta[name].sha)
		if not data then
			warn(("[MASTERS] %s failed: %s"):format(name, tostring(how)))
			failed += 1
		else
			writefile(name, data)
			state[name] = meta[name].sha
			doneBytes += #data
			log(("downloaded %s (%d bytes, %s)"):format(name, #data, how))
		end
		setProgress(doneBytes, totalBytes)
		detail.Text = ("file %d of %d   ·   %s / %s"):format(i, #todo, kb(doneBytes), kb(totalBytes))
	end
end

if failed > 0 then
	finish("Download failed", failed .. " file(s) could not be fetched — check the console",
		"Close", Color3.fromRGB(226, 92, 92), close)
	return
end

for _, name in ipairs(FILES) do
	if not isfile(name) then
		finish("Install incomplete", name .. " is missing", "Close",
			Color3.fromRGB(226, 92, 92), close)
		return
	end
end

pcall(function()
	writefile(STATE,  Http:JSONEncode({repo = REPO, branch = BRANCH, files = state}))
	writefile(CONFIG, Http:JSONEncode({repo = REPO, branch = BRANCH, token = TOKEN}))
end)

--[[ Keep local copies so updating and running need no pasting. Both are verified
     against the sha from the listing like everything else — an unverified write
     here is how "404: Not Found" ends up saved as your runner. ]]
for local_name, saved_as in pairs({["bootstrap.lua"] = SELF, ["run.lua"] = RUNNER}) do
	local entry = meta[local_name]
	if entry then
		local ok, body = pcall(download, local_name, entry.sha)
		if ok and body then
			pcall(function() writefile(saved_as, body) end)
		else
			warn(("[MASTERS] could not save %s locally (%s)"):format(saved_as, tostring(body)))
		end
	end
end

--[[ Add-ons ship disabled and are gated on this file, which the full setup UI
     would normally write. Seed it once so Local Stations is on; after that it is
     yours and never touched again. ]]
if not isfile(ADDONS) then
	pcall(function()
		writefile(ADDONS, Http:JSONEncode({["Local Stations"] = true, ["Lyric Studio"] = false}))
	end)
end

-- ------------------------------------------------------------------- finish

--[[ Running the loader twice in one session stacks a second UI, a second copy of
     the package and a second set of connections, so everything fires twice.
     Re-running this to update is the normal way to hit that. ]]
local function alreadyRunning()
	if rawget(_G, "Queue") ~= nil then return true end
	if game:GetService("ReplicatedStorage"):FindFirstChild("Masters(Storage)") then return true end
	local pg = Players.LocalPlayer:FindFirstChild("PlayerGui")
	return pg ~= nil and pg:FindFirstChild("Masters") ~= nil
end

local function startMasters()
	action.Visible = false
	status.Text = "Starting Masters…"
	detail.Text = ""
	task.wait(0.15)

	local run, err = loadstring(readfile(ENTRY), "=MastersLoader")
	if not run then
		finish("Failed to start", tostring(err):sub(1, 90), "Close", Color3.fromRGB(226, 92, 92), close)
		return
	end
	local ok, rerr = pcall(run)
	if not ok then
		finish("Failed to start", tostring(rerr):sub(1, 90), "Close", Color3.fromRGB(226, 92, 92), close)
		return
	end
	log("Masters started")
	close()
end

if alreadyRunning() then
	finish(#todo > 0 and "Updated — rejoin to apply" or "Already running and up to date",
		"Masters is already loaded in this session",
		"Close", Color3.fromRGB(99, 217, 138), close)
else
	finish(#todo > 0 and "Download complete" or "Ready",
		#todo > 0 and ("%d file(s) downloaded   ·   ready to run"):format(#todo)
		           or "everything already up to date",
		"Run Masters", Color3.fromRGB(26, 116, 230), startMasters)
end
showRunHint()

--[[ ---------------------------------------------------------------------------
     TOKEN: this repo is PUBLIC, so none is needed and none belongs here — a
     token in a script in a public repo is readable by anyone.

     If you make the repo private, generate a FINE-GRAINED token
     (github.com/settings/personal-access-tokens) limited to this one repository
     with Contents: Read-only. Do not use a classic `repo`-scoped token: that one
     key reads and writes every repository you own.
   -------------------------------------------------------------------------- ]]
