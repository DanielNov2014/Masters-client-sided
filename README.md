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

## Notes

**Updates take up to ~5 minutes to reach you.** GitHub's raw CDN caches branch
paths and ignores cache-busting query strings, so a freshly published change is
not visible immediately. The installer works around the ugly part of this: the
manifest pins the exact commit the payload landed in and every file is fetched
from that commit, so you always get a *consistent* release — never a new
`MastersLogic.lua` against an old `Masters.rbxm`. Worst case you install a
release a few minutes old; run it again later to pick up the newest.

**Every file is verified.** GitHub's `sha` is the git blob hash, and the
installer recomputes it before writing anything to disk. This is not decoration:
`game:HttpGet` returns the string `404: Not Found` instead of erroring, so
without the check a missing file would be saved as its own contents.

## Updating from inside Masters

Masters checks for a new release every 5 minutes. When one lands it slides a
card in at the bottom-right showing what changed, with **Update** and **Later**.

Pressing Update does not update yet — it asks first, because applying one
teleports you out of the server you are in. The button becomes **Rejoin and
update** with the warning spelled out; pressing it again queues the installer to
run after the teleport, rejoins you, installs, starts Masters, and shows what
changed.

It has to work that way: the Handler is already loaded, and re-running the loader
in place would stack a second UI, a second copy of the package and a second set
of connections, after which every control fires twice.
