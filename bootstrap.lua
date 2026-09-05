--[[ ===========================================================================
     MASTERS — one-paste installer

     Paste this into your executor on any PC. It downloads Masters from GitHub
     into Real's Workspace folder and starts it. Nothing else to set up.

     Re-run it any time to update — it only downloads files that actually
     changed, and it saves itself as MastersUpdate.lua, so after the first run
     updating is just:

         loadstring(readfile("MastersUpdate.lua"))()
   ========================================================================== ]]

local REPO   = "DanielNov2014/Masters-client-sided"
local BRANCH = "main"

--[[ Only needed if you flip the repo to private. A public repo needs no token,
     and leaving this empty is the safer default — see the note at the bottom. ]]
local TOKEN  = ""

-- --------------------------------------------------------------------------

-- What to pull, and what each file is for. Named at the repo root so the repo
-- stays readable; these are the names Masters expects in the Workspace folder.
local FILES = {
	"MastersLoader.lua",      -- the injector: parents the package, starts the Handler
	"MastersLogic.lua",       -- the Handler itself
	"Masters.rbxm",           -- the UI + module package
	"MastersShareAPI.txt",    -- share / community-lyrics endpoint
	"MastersPresenceWS.txt",  -- presence relay endpoint (instant sync, cross-server)
}

local ENTRY  = "MastersLoader.lua"      -- run this once everything is on disk
local STATE  = "MastersSync.json"       -- what we already have, by sha
local CONFIG = "MastersGitHub.json"     -- repo + token, local to this PC
local SELF   = "MastersUpdate.lua"      -- this script, saved for later re-runs
local ADDONS = "MastersAddons.json"     -- seeded once, then yours to change

local Http = game:GetService("HttpService")

local function log(m)  print("[MASTERS] " .. m) end
local function fail(m) warn("[MASTERS] " .. m); return nil end

-- Inline settings win, then _G, then whatever a previous run saved.
do
	local saved = {}
	pcall(function()
		if isfile(CONFIG) then saved = Http:JSONDecode(readfile(CONFIG)) end
	end)
	if type(saved) ~= "table" then saved = {} end
	REPO   = (REPO  ~= "" and REPO)  or rawget(_G, "MastersRepo")        or saved.repo   or ""
	TOKEN  = (TOKEN ~= "" and TOKEN) or rawget(_G, "MastersGitHubToken") or saved.token  or ""
	BRANCH = BRANCH ~= "" and BRANCH or saved.branch or "main"
end

if REPO == "" or not REPO:find("/") then
	return fail('Set REPO at the top of this script — it looks like "user/repo".')
end

-- ------------------------------------------------------------------- GitHub

local function api(url)
	local res
	for attempt = 1, 3 do
		local headers = {
			["Accept"] = "application/vnd.github+json",
			["X-GitHub-Api-Version"] = "2022-11-28",
			["User-Agent"] = "Masters-Bootstrap",   -- GitHub rejects calls without one
		}
		if TOKEN ~= "" then headers["Authorization"] = "Bearer " .. TOKEN end

		local ok, r = pcall(request, {Url = url, Method = "GET", Headers = headers})
		if ok and type(r) == "table" then
			res = r
			if r.StatusCode ~= 502 and r.StatusCode ~= 503 then break end
		end
		task.wait(attempt)                            -- transient; back off
	end

	if type(res) ~= "table" then return nil, "no response from GitHub" end
	if res.StatusCode == 404 then
		--[[ GitHub answers 404, not 403, for a repo you cannot see — so a wrong
		     name and a missing token look identical. Name both. ]]
		return nil, "404 — check the repo name, the branch, and (if the repo is "
			.. "private) that TOKEN is set"
	elseif res.StatusCode == 401 then
		return nil, "401 — the token was rejected (expired or malformed)"
	elseif res.StatusCode == 403 then
		return nil, "403 — rate limited, or the token cannot read this repo"
	elseif res.StatusCode ~= 200 then
		return nil, tostring(res.StatusCode) .. " from GitHub"
	end

	local ok, decoded = pcall(function() return Http:JSONDecode(res.Body) end)
	if not ok then return nil, "could not parse GitHub's reply" end
	return decoded
end

local function b64(field) return crypt.base64_decode((field or ""):gsub("%s", "")) end

--[[ The Contents API inlines bytes as base64 — uniform for the Lua files and the
     binary .rbxm alike. Above 1MB `content` comes back empty and the blob has to
     be fetched separately, which matters: MastersLogic.lua is ~450KB and grows
     every time a block is appended to it. ]]
local function bytesOf(entry)
	if entry.content and entry.content ~= "" then return b64(entry.content) end
	local blob, err = api(entry.git_url)
	if not blob then return nil, err end
	return b64(blob.content)
end

-- GitHub's `sha` is the git blob hash, so we can recompute it and prove the
-- download arrived intact before writing it.
local function blobSha(data)
	local ok, d = pcall(crypt.hash, "blob " .. #data .. "\0" .. data, "sha1")
	return ok and d or nil
end

-- --------------------------------------------------------------------- sync

log("checking " .. REPO .. "@" .. BRANCH)

local state = {}
pcall(function()
	if isfile(STATE) then
		local s = Http:JSONDecode(readfile(STATE))
		if type(s) == "table" and s.repo == REPO and type(s.files) == "table" then state = s.files end
	end
end)

local fetched, current, failed = 0, 0, 0

for _, name in ipairs(FILES) do
	local url = ("https://api.github.com/repos/%s/contents/%s?ref=%s"):format(REPO, name, BRANCH)
	local entry, err = api(url)

	if not entry then
		warn(("[MASTERS] %s: %s"):format(name, tostring(err)))
		failed += 1
	elseif state[name] == entry.sha and isfile(name) then
		current += 1
	else
		local data, derr = bytesOf(entry)
		if not data then
			warn(("[MASTERS] %s: %s"):format(name, tostring(derr)))
			failed += 1
		elseif blobSha(data) and blobSha(data) ~= entry.sha then
			warn(("[MASTERS] %s arrived corrupted (sha mismatch) — not written"):format(name))
			failed += 1
		else
			writefile(name, data)
			state[name] = entry.sha
			fetched += 1
			log(("downloaded %s (%d bytes)"):format(name, #data))
		end
	end
end

log(("%d downloaded, %d already current%s")
	:format(fetched, current, failed > 0 and (", " .. failed .. " FAILED") or ""))

if not isfile("MastersLogic.lua") or not isfile("Masters.rbxm") or not isfile(ENTRY) then
	return fail("a required file is missing — Masters cannot start")
end

-- remember the settings so a bare re-run works
pcall(function()
	writefile(STATE,  Http:JSONEncode({repo = REPO, branch = BRANCH, files = state}))
	writefile(CONFIG, Http:JSONEncode({repo = REPO, branch = BRANCH, token = TOKEN}))
end)

-- keep a copy of this script so updating later needs no pasting
pcall(function()
	local e = api(("https://api.github.com/repos/%s/contents/bootstrap.lua?ref=%s"):format(REPO, BRANCH))
	if e then
		local body = bytesOf(e)
		if body then writefile(SELF, body) end
	end
end)

--[[ Add-ons ship disabled and are gated on this file, which the setup UI would
     normally write. Without that UI in this install, seed it once so Local
     Stations is on; after that the file is yours and never touched again. ]]
if not isfile(ADDONS) then
	pcall(function()
		writefile(ADDONS, Http:JSONEncode({["Local Stations"] = true, ["Lyric Studio"] = false}))
	end)
end

-- -------------------------------------------------------------------- start

--[[ Running the loader twice in one session stacks a whole second UI, a second
     copy of the package in ReplicatedStorage and a second set of connections —
     everything then fires twice. Re-running this script to update is the normal
     way to hit that, so check before launching: new files are already on disk
     and a rejoin picks them up. ]]
local function alreadyRunning()
	if rawget(_G, "Queue") ~= nil then return true end
	if game:GetService("ReplicatedStorage"):FindFirstChild("Masters(Storage)") then return true end
	local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
	return pg ~= nil and pg:FindFirstChild("Masters") ~= nil
end

if alreadyRunning() then
	if fetched > 0 then
		log("Masters is already running — rejoin the game to load the update")
	else
		log("Masters is already running and up to date")
	end
	return
end

local run, err = loadstring(readfile(ENTRY), "=MastersLoader")
if not run then return fail("loader failed to compile: " .. tostring(err)) end

log("starting Masters")
run()

--[[ ---------------------------------------------------------------------------
     A note on TOKEN, worth reading once:

     This repo is PUBLIC, so no token is needed and none should be put here — a
     token pasted into a script in a public repo is readable by anyone.

     If you make the repo private, generate a FINE-GRAINED token
     (github.com/settings/personal-access-tokens) limited to this one repository
     with Contents: Read-only, and put that in TOKEN. Do not use a classic
     `repo`-scoped token: that one key can read and write every repository you
     own, so leaking it is an account-level problem, not a repo-level one.
   -------------------------------------------------------------------------- ]]
