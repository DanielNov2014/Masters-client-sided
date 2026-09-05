# Masters — client

A client-side music player for Roblox: full library, queue and now-playing UI,
synced community lyrics, listening presence with cross-server follow, and local
radio stations. Runs from an executor — no server code in the game.

## Install

Paste [`bootstrap.lua`](bootstrap.lua) into your executor and run it.

It downloads Masters into Real's Workspace folder, checks every file against
GitHub's own hash, and starts it. Nothing to configure.

## Update

The first run saves the script as `MastersUpdate.lua`, so after that:

```lua
loadstring(readfile("MastersUpdate.lua"))()
```

Only files whose hash changed are downloaded, so a no-op update is one request
per file and writes nothing.

## What lands in the Workspace folder

| File | |
| --- | --- |
| `MastersLoader.lua` | the injector — parents the package and starts the Handler |
| `MastersLogic.lua` | the Handler: all the UI logic, lyrics, queue, presence |
| `Masters.rbxm` | the UI + module package |
| `MastersShareAPI.txt` | share / community-lyrics endpoint |
| `MastersPresenceWS.txt` | presence relay endpoint |

The bootstrap never touches your own files — `MastersAddons.json` (seeded once,
then yours), `MastersData_<id>.json` (your library) and
`MastersRecent_<id>.json` (play history) all stay put across updates.
