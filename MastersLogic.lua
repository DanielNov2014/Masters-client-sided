task.wait(1)
local AssetService = game:GetService("AssetService")
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local InputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local AudiosLoaded = {} -- This defines the table the module needs to fill
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local nan = TweenInfo.new(.0001)
local quick = TweenInfo.new(.25, Enum.EasingStyle.Exponential)
local normal = TweenInfo.new(.5, Enum.EasingStyle.Exponential)
local smooth = TweenInfo.new(.8, Enum.EasingStyle.Exponential)
local slow = TweenInfo.new(1, Enum.EasingStyle.Exponential)
local five = TweenInfo.new(5, Enum.EasingStyle.Exponential)

local bounce = TweenInfo.new(.5, Enum.EasingStyle.Back)
local elastic = TweenInfo.new(1, Enum.EasingStyle.Back)

local loop = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false)
local long_loop = TweenInfo.new(50, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false)
local long_loop_reverses = TweenInfo.new(50, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true)

local crossfading_loop = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false)

local client = Players.LocalPlayer
local camera = workspace.CurrentCamera

local storage = ReplicatedStorage:WaitForChild("Masters(Storage)")
local events = storage.Events
local modules = storage.Modules

local Alerts = require(modules.Alerts)
local Audios = require(modules.Audios)
local Configuration = require(modules.Configuration)
local Listeners = require(modules.Listeners)
local LyricsEngine = require(modules.LyricsEngine)
local Main = require(modules.Main)
local OnlineStations = require(modules.OnlineStations)
local Queue = require(modules.Queue)
local Settings = require(modules.Settings)
local Signal = require(modules.Signal)
local Smoothness = require(modules.Smoothness)
local TextFiltering = require(modules.TextFiltering)
local Utilities = require(modules.Utilities)

local ui = Players.LocalPlayer.PlayerGui.Masters
local frame = ui.Interface.Frame

local ShareSheet = ui.ShareSheet

local Bar = frame.Bar
local Full = frame.Full

local NowPlaying = Full.NowPlaying
local PlaylistCreation = Full.PlaylistCreation
local SettingsPage = Full.Settings

local Playback = ui.Playback
-- [[ MASTERS: STABLE LOADER & NATIVE HOOKS ]]



_G.CurrentSongId = 138396969938984 



local MASTERS_DEFAULT_SETTINGS = {

	Theme = "Masters_Default",

	Playback = { Crossfade = { Enabled = true, Duration = 3 }, Equalizer = { Enabled = false, HighGain = 0, MidGain = 0, LowGain = 0 } },

	Extras = { Glow = true, PlaybackHaptics = false },

	Socials = { ListeningVisibility = false, Sharing = false }

}



-- 1. CONSOLIDATED LYRICS (Including EpicTitan100 & Inner Thunder)

_G.ALL_LYRICS = {
	["101281269050449"] = {
		SoundId = 101281269050449,
		Unsynced = false,
		Lyrics = {
			{Line = "WizOx ban this guy", TimeStart = 2.29, TimeEnd = 5.26, Id = "L1"},
			{Line = "WizOx ban this guy, get him out of server", TimeStart = 5.26, TimeEnd = 10.36, Id = "L2"},
			{Line = "donut catching one more guy", TimeStart = 10.36, TimeEnd = 13.72, Id = "L3"},
			{Line = "donut think he is cheating, WizOx", TimeStart = 13.72, TimeEnd = 18.03, Id = "L4"},
			{Line = "is already here, WizOx typing ban", TimeStart = 18.03, TimeEnd = 22.49, Id = "L5"},
			{Line = "WizOx, WizOx, WizOx ban this guy", TimeStart = 22.49, TimeEnd = 26.56, Id = "L6"},
			{Line = "WizOx ban this guy, get him out of server", TimeStart = 26.56, TimeEnd = 32.58, Id = "L7"},
			{Line = "WizOx ban this guy", TimeStart = 32.58, TimeEnd = 36.84, Id = "L8"},
			{Line = "WizOx get him out of here help", TimeStart = 36.84, TimeEnd = 43.96, Id = "L9"},
			{Line = "me fix the server wizox help me catching", TimeStart = 43.96, TimeEnd = 47.22, Id = "L10"},
			{Line = "cheaters bro do not know he is legit wizox", TimeStart = 47.22, TimeEnd = 51.63, Id = "L11"},
			{Line = "thinks he is cheater wizox typing wizox", TimeStart = 51.63, TimeEnd = 56.57, Id = "L12"},
			{Line = "wizox wizox ban this guy wizox", TimeStart = 56.57, TimeEnd = 60.86, Id = "L13"},
			{Line = "ban this guy get him out of server wizox", TimeStart = 60.86, TimeEnd = 67.9, Id = "L14"},
			{Line = "ban this guy wizox", TimeStart = 67.9, TimeEnd = 71.35, Id = "L15"},
			{Line = "ban this guy Get him out of here", TimeStart = 71.35, TimeEnd = 75.4, Id = "L16"},
			{Line = "Written By Claude\nSynced By @Claude", TimeStart = 75.4, TimeEnd = 85.446525, Id = "CERTIFICATION"},
		}
	},

	["133664122932845"] = {
		SoundId = 133664122932845,
		Unsynced = false,
		Lyrics = {
			{Line = "Skibby six seven sigma", TimeStart = 0.0, TimeEnd = 4.88, Id = "L1"},
			{Line = "Bouncin' like a rhythm, make it wiggle", TimeStart = 4.88, TimeEnd = 6.54, Id = "L2"},
			{Line = "like a river Crocodileo", TimeStart = 6.54, TimeEnd = 8.16, Id = "L3"},
			{Line = "Bombadileo, we deliver Lights", TimeStart = 8.16, TimeEnd = 10.52, Id = "L4"},
			{Line = "", TimeStart = 10.52, TimeEnd = 17.3, Id = "GAP_5"},
			{Line = "are low, but the heat's turnin' high Feed", TimeStart = 17.3, TimeEnd = 20.66, Id = "L5"},
			{Line = "my rhythm like a step, step, step", TimeStart = 20.66, TimeEnd = 23.54, Id = "L6"},
			{Line = "Crocodileo, Bombadileo, Pim and Dileo", TimeStart = 23.54, TimeEnd = 25.8, Id = "L7"},
			{Line = "Crocodileo, Bombadileo Lilo", TimeStart = 25.8, TimeEnd = 31.9, Id = "L8"},
			{Line = "Cigar", TimeStart = 31.9, TimeEnd = 36.52, Id = "L9"},
			{Line = "Sir Life's Life's on low but the heat's", TimeStart = 36.52, TimeEnd = 39.5, Id = "L10"},
			{Line = "down high Feel the rhythm with the sparks", TimeStart = 39.5, TimeEnd = 41.98, Id = "L11"},
			{Line = "just like Kapoos in the valley", TimeStart = 41.98, TimeEnd = 43.76, Id = "L12"},
			{Line = "nothing around Feed on fire", TimeStart = 43.76, TimeEnd = 45.76, Id = "L13"},
			{Line = "can't touch the ground Trollily -up", TimeStart = 45.76, TimeEnd = 48.64, Id = "L14"},
			{Line = "trollala night's begun Chasing the moon", TimeStart = 48.64, TimeEnd = 51.56, Id = "L15"},
			{Line = "we're bracing the sun Kibbe 6 -7 Sigma", TimeStart = 51.56, TimeEnd = 54.88, Id = "L16"},
			{Line = "Skip", TimeStart = 54.88, TimeEnd = 55.88, Id = "L17"},
			{Line = "", TimeStart = 55.88, TimeEnd = 62.64, Id = "GAP_19"},
			{Line = "Beast 7 The Sigma 7 The Sigma", TimeStart = 62.64, TimeEnd = 73.22, Id = "L18"},
			{Line = "", TimeStart = 73.22, TimeEnd = 83.04, Id = "GAP_21"},
			{Line = "Crocodilea!", TimeStart = 83.04, TimeEnd = 83.94, Id = "L19"},
			{Line = "Crocodileo, Bombadileo They sing", TimeStart = 83.94, TimeEnd = 88.2, Id = "L20"},
			{Line = "voices rise and make the whole world swing", TimeStart = 88.2, TimeEnd = 90.64, Id = "L21"},
			{Line = "Crocodileo, Bombadileo", TimeStart = 90.64, TimeEnd = 92.76, Id = "L22"},
			{Line = "", TimeStart = 92.76, TimeEnd = 127.8, Id = "GAP_26"},
			{Line = "Electric Elected knights with a fiery soul", TimeStart = 127.8, TimeEnd = 130.95, Id = "L23"},
			{Line = "Juvenile spirit can't lose control Every", TimeStart = 130.95, TimeEnd = 133.85, Id = "L24"},
			{Line = "beat's a story, every move's a tale Find", TimeStart = 133.85, TimeEnd = 136.31, Id = "L25"},
			{Line = "the rhythm like a ship's at sail", TimeStart = 136.31, TimeEnd = 139.53, Id = "L26"},
			{Line = "Crocodileo, Bombadileo Feel the vibe", TimeStart = 139.53, TimeEnd = 142.01, Id = "L27"},
			{Line = "all together now Let's turn my life", TimeStart = 142.01, TimeEnd = 144.35, Id = "L28"},
			{Line = "", TimeStart = 144.35, TimeEnd = 153.05, Id = "GAP_33"},
			{Line = "Sub on the Sigma Sub", TimeStart = 153.05, TimeEnd = 158.51, Id = "L29"},
			{Line = "on the Sigma Move it, shake it", TimeStart = 158.51, TimeEnd = 160.23, Id = "L30"},
			{Line = "no enigma Tung tung tung tung tung Move", TimeStart = 160.23, TimeEnd = 163.63, Id = "L31"},
			{Line = "it, shake it, no enigma Enigma", TimeStart = 163.63, TimeEnd = 166.59, Id = "L32"},
			{Line = "tum -ta -tum -ta -tum -ta -tum -ta Tum -ta", TimeStart = 166.59, TimeEnd = 169.45, Id = "L33"},
			{Line = "-tum -ta -tum -ta -tum -ta Tum -ta -tum", TimeStart = 169.45, TimeEnd = 175.67, Id = "L34"},
			{Line = "-ta -tum -ta -tum -ta Tum -ta -tum -ta", TimeStart = 175.67, TimeEnd = 180.73, Id = "L35"},
			{Line = "-tum -ta -tum -ta -tum -ta Tum -ta -tum", TimeStart = 180.73, TimeEnd = 185.51, Id = "L36"},
			{Line = "-ta -tum -ta -tum -ta -tum -ta", TimeStart = 185.51, TimeEnd = 188.81, Id = "L37"},
			{Line = "Written By Claude\nSynced By @Claude", TimeStart = 188.81, TimeEnd = 193.319979, Id = "CERTIFICATION"},
		}
	},


	["9245470035"] = {
		SoundId = 9245470035,
		Unsynced = false,
		Lyrics = {
			{Line = "Oh yeah! Rock the scene!", TimeStart = 0.24, TimeEnd = 2.12, Id = "L1"},
			{Line = "R -r -rock the scene!", TimeStart = 2.12, TimeEnd = 3.74, Id = "L2"},
			{Line = "Oh yeah! Rock the scene!", TimeStart = 3.74, TimeEnd = 5.64, Id = "L3"},
			{Line = "Rock the scene! Oh yeah!", TimeStart = 5.64, TimeEnd = 8.24, Id = "L4"},
			{Line = "Rock the scene! Rock the scene!", TimeStart = 8.24, TimeEnd = 10.53, Id = "L5"},
			{Line = "Oh yeah! Rock the scene!", TimeStart = 10.53, TimeEnd = 12.35, Id = "L6"},
			{Line = "R -r -rock the scene!", TimeStart = 12.35, TimeEnd = 13.95, Id = "L7"},
			{Line = "Oh yeah! There's a magical town Oh!", TimeStart = 13.95, TimeEnd = 17.46, Id = "L8"},
			{Line = "Where everything is waffles Oh!", TimeStart = 17.46, TimeEnd = 21.54, Id = "L9"},
			{Line = "A delectable queen", TimeStart = 21.54, TimeEnd = 23.86, Id = "L10"},
			{Line = "Of never -ending yumminess Oh!", TimeStart = 23.86, TimeEnd = 27.65, Id = "L11"},
			{Line = "The houses are waffles And the cars are", TimeStart = 27.65, TimeEnd = 30.59, Id = "L12"},
			{Line = "waffles And the streets and the trees", TimeStart = 30.59, TimeEnd = 32.69, Id = "L13"},
			{Line = "and trampolines are waffles And the schools", TimeStart = 32.69, TimeEnd = 35.21, Id = "L14"},
			{Line = "are waffles And the dentist chairs are", TimeStart = 35.21, TimeEnd = 37.57, Id = "L15"},
			{Line = "waffles And the stop signs are made", TimeStart = 37.57, TimeEnd = 40.77, Id = "L16"},
			{Line = "of butter Yeah! With a C!", TimeStart = 40.77, TimeEnd = 43.67, Id = "L17"},
			{Line = "With a C! Oh yeah! With a C!", TimeStart = 43.67, TimeEnd = 47.07, Id = "L18"},
			{Line = "With a C! Oh yeah! With a C!", TimeStart = 47.07, TimeEnd = 50.63, Id = "L19"},
			{Line = "With a C! Oh yeah!", TimeStart = 50.63, TimeEnd = 52.67, Id = "L20"},
			{Line = "With a C! With a C!", TimeStart = 52.67, TimeEnd = 55.05, Id = "L21"},
			{Line = "Oh yeah! There's an incredible city Where", TimeStart = 55.05, TimeEnd = 58.66, Id = "L22"},
			{Line = "all you eat are waffles So if you're", TimeStart = 58.66, TimeEnd = 63.34, Id = "L23"},
			{Line = "into waffles, it's the place you ought", TimeStart = 63.34, TimeEnd = 67.02, Id = "L24"},
			{Line = "to be Oh, the bridges are waffles", TimeStart = 67.02, TimeEnd = 70.52, Id = "L25"},
			{Line = "and the skyscrapers are waffles And the malls", TimeStart = 70.52, TimeEnd = 73.2, Id = "L26"},
			{Line = "dining halls, and bathroom stalls are", TimeStart = 73.2, TimeEnd = 75.1, Id = "L27"},
			{Line = "waffles And the libraries are waffles", TimeStart = 75.1, TimeEnd = 77.38, Id = "L28"},
			{Line = "filled with books that are waffles And", TimeStart = 77.38, TimeEnd = 79.34, Id = "L29"},
			{Line = "the fire trucks are made of butter Burgers are", TimeStart = 79.34, TimeEnd = 83.72, Id = "L30"},
			{Line = "waffles and the french fries are waffles", TimeStart = 83.72, TimeEnd = 85.92, Id = "L31"},
			{Line = "And the tacos and the nachos and falafels", TimeStart = 85.92, TimeEnd = 88.58, Id = "L32"},
			{Line = "are waffles And the root beer is waffles", TimeStart = 88.58, TimeEnd = 91.1, Id = "L33"},
			{Line = "Toaster strudels are waffles And", TimeStart = 91.1, TimeEnd = 93.08, Id = "L34"},
			{Line = "the french toast Are made of pancakes We love", TimeStart = 93.08, TimeEnd = 97.36, Id = "L35"},
			{Line = "waffles and you love waffles Little kids", TimeStart = 97.36, TimeEnd = 100.5, Id = "L36"},
			{Line = "and parents And babies love waffles", TimeStart = 100.5, TimeEnd = 103.1, Id = "L37"},
			{Line = "And dogs love waffles And horses love waffles", TimeStart = 103.1, TimeEnd = 106.52, Id = "L38"},
			{Line = "And kitty cats Whoa", TimeStart = 106.52, TimeEnd = 110.09, Id = "L39"},
			{Line = "cats don't like waffles Oh yeah", TimeStart = 110.09, TimeEnd = 112.49, Id = "L40"},
			{Line = "fussy Fussy, oh yeah Fussy Oh yeah", TimeStart = 112.49, TimeEnd = 119.22, Id = "L41"},
			{Line = "Oh yeah Oh yeah Oh yeah", TimeStart = 119.22, TimeEnd = 126.07, Id = "L42"},
			{Line = "Written By Claude\nSynced By @Claude", TimeStart = 126.07, TimeEnd = 131.142857, Id = "CERTIFICATION"},
		}
	},

	["142376088"] = {
		SoundId = 142376088,
		Unsynced = false,
		Lyrics = {
			{Line = "It's rainin' tacos, from out of the sky", TimeStart = 2.1, TimeEnd = 7.0, Id = "L1"},
			{Line = "Tacos, no need to ask why, just open", TimeStart = 7.0, TimeEnd = 10.7, Id = "L2"},
			{Line = "your mouth and close your eyes", TimeStart = 10.7, TimeEnd = 13.9, Id = "L3"},
			{Line = "It's rainin' tacos, it's rainin' tacos", TimeStart = 13.9, TimeEnd = 18.1, Id = "L4"},
			{Line = "out in the street", TimeStart = 18.1, TimeEnd = 21.08, Id = "L5"},
			{Line = "Tacos, all you can eat", TimeStart = 21.08, TimeEnd = 23.96, Id = "L6"},
			{Line = "Lettuce and shells, cheese and meat", TimeStart = 23.96, TimeEnd = 26.98, Id = "L7"},
			{Line = "It's rainin' tacos, yum, yum", TimeStart = 26.98, TimeEnd = 31.14, Id = "L8"},
			{Line = "yum, yum, yummity, yum, it's like a treat", TimeStart = 31.14, TimeEnd = 35.02, Id = "L9"},
			{Line = "yum, yum, yum, yum, yummity, yum", TimeStart = 35.02, TimeEnd = 40.18, Id = "L10"},
			{Line = "bring your sour cream, meat", TimeStart = 40.18, TimeEnd = 49.88, Id = "L11"},
			{Line = "lettuce, shell", TimeStart = 49.88, TimeEnd = 52.5, Id = "L12"},
			{Line = "meat, lettuce, cheese, shell", TimeStart = 52.5, TimeEnd = 55.98, Id = "L13"},
			{Line = "meat, cheese, cheese, cheese", TimeStart = 55.98, TimeEnd = 58.62, Id = "L14"},
			{Line = "cheese, cheese. It's raining tacos", TimeStart = 58.62, TimeEnd = 62.0, Id = "L15"},
			{Line = "Rain and tacos", TimeStart = 62.0, TimeEnd = 65.5, Id = "L16"},
			{Line = "Rain and tacos. It's", TimeStart = 65.5, TimeEnd = 73.9, Id = "L17"},
			{Line = "raining tacos", TimeStart = 73.9, TimeEnd = 76.75, Id = "L18"},
			{Line = "Rain and tacos", TimeStart = 76.75, TimeEnd = 81.22, Id = "L19"},
			{Line = "Tacos", TimeStart = 81.22, TimeEnd = 85.18, Id = "L20"},
			{Line = "It's raining tacos", TimeStart = 85.18, TimeEnd = 87.2, Id = "L21"},
			{Line = "Written By Claude\nSynced By @Claude", TimeStart = 87.2, TimeEnd = 92.693333, Id = "CERTIFICATION"},
		}
	},


	["100847230469970"] = {
		SoundId = 100847230469970,
		Unsynced = false,
		Lyrics = {
			{Line = "It's raining tacos, from out of the sky, tacos", TimeStart = 0.695, TimeEnd = 6.114, Id = "L1"},
			{Line = "No need to ask why, just open your mouth and close your eyes", TimeStart = 6.114, TimeEnd = 11.085, Id = "L2"},
			{Line = "It's raining tacos, it's raining tacos", TimeStart = 11.085, TimeEnd = 15.906, Id = "L3"},
			{Line = "Out in the street, tacos", TimeStart = 15.906, TimeEnd = 18.914, Id = "L4"},
			{Line = "All you can eat, lettuce and shells, cheese and meat", TimeStart = 18.914, TimeEnd = 23.842, Id = "L5"},
			{Line = "It's raining tacos", TimeStart = 23.842, TimeEnd = 34.433, Id = "L6"},
			{Line = "", TimeStart = 34.433, TimeEnd = 44.225, Id = "GAP_7"},
			{Line = "It's raining tacos, it's raining tacos", TimeStart = 44.225, TimeEnd = 58.731, Id = "L7"},
			{Line = "It's raining tacos, it's raining tacos", TimeStart = 58.731, TimeEnd = 75.404, Id = "L8"},
			{Line = "", TimeStart = 75.404, TimeEnd = 106.935, Id = "GAP_10"},
			{Line = "Yum yum yum yum yum yum yum yum yum yum yum", TimeStart = 106.935, TimeEnd = 109.623, Id = "L9"},
			{Line = "It's like a dream", TimeStart = 109.623, TimeEnd = 112.801, Id = "L10"},
			{Line = "Yum yum yum yum yum yum yum yum yum yum yum yum yum", TimeStart = 112.801, TimeEnd = 115.916, Id = "L11"},
			{Line = "Bring your sour cream", TimeStart = 115.916, TimeEnd = 120.78, Id = "L12"},
			{Line = "", TimeStart = 120.78, TimeEnd = 131.511, Id = "GAP_15"},
			{Line = "Shell meat, lettuce, cheese, shell, meat, lettuce, cheese", TimeStart = 131.511, TimeEnd = 140.001, Id = "L13"},
			{Line = "Shell meat", TimeStart = 140.001, TimeEnd = 164.343, Id = "L14"},
			{Line = "It's raining tacos, it's raining tacos", TimeStart = 164.343, TimeEnd = 170.423, Id = "L15"},
			{Line = "It's raining tacos", TimeStart = 170.423, TimeEnd = 175.009, Id = "L16"},
			{Line = "It's raining tacos", TimeStart = 176.524, TimeEnd = 197.879, Id = "L17"},
			{Line = "It's raining tacos", TimeStart = 201.271, TimeEnd = 205.324, Id = "L18"},
			{Line = "It's raining tacos", TimeStart = 205.324, TimeEnd = 208.631, Id = "L19"},
			{Line = "Written By HardestRaver\nSynced By @DaniBoyNov2014", TimeStart = 208.631, TimeEnd = 219.51997916666667, Id = "CERTIFICATION"},
		}
	},
	["122369061578560"] = {
		SoundId = 122369061578560,
		Unsynced = false,
		Lyrics = {
			{Line = "Respect my peace", TimeStart = 0, TimeEnd = 5.937, Id = "L1"},
			{Line = "Respect my peace", TimeStart = 5.937, TimeEnd = 10.567, Id = "L2"},
			{Line = "Respect my peace", TimeStart = 10.567, TimeEnd = 15.943, Id = "L3"},
			{Line = "PSO4", TimeStart = 15.943, TimeEnd = 19.057, Id = "L4"},
			{Line = "PSO5", TimeStart = 19.057, TimeEnd = 21.191, Id = "L5"},
			{Line = "Respect my peace", TimeStart = 21.191, TimeEnd = 25.351, Id = "L6"},
			{Line = "Respect my peace", TimeStart = 25.351, TimeEnd = 37.676, Id = "L7"},
			{Line = "Respect my peace, that's my new reality.", TimeStart = 40.769, TimeEnd = 43.735, Id = "L8"},
			{Line = "It's a public service announcement, I'm living my best life.", TimeStart = 43.735, TimeEnd = 47.148, Id = "L9"},
			{Line = "Because it's outstanding.", TimeStart = 47.148, TimeEnd = 49.004, Id = "L10"},
			{Line = "If you don't respect my peace, you're gonna feel some grief.", TimeStart = 49.004, TimeEnd = 51.713, Id = "L11"},
			{Line = "You're gonna feel like a thief.", TimeStart = 51.713, TimeEnd = 53.207, Id = "L12"},
			{Line = "Get up from around me.", TimeStart = 53.207, TimeEnd = 54.316, Id = "L13"},
			{Line = "Thanks to the divine for protecting my peace.", TimeStart = 54.316, TimeEnd = 56.492, Id = "L14"},
			{Line = "Now I sleep gracefully in my peace.", TimeStart = 56.492, TimeEnd = 58.476, Id = "L15"},
			{Line = "My spirit seems speak to me.", TimeStart = 58.476, TimeEnd = 60.759, Id = "L16"},
			{Line = "Give me wisdom and insight for my spirit can grow.", TimeStart = 60.759, TimeEnd = 63.425, Id = "L17"},
			{Line = "Be aware of the seeds you sow.", TimeStart = 63.425, TimeEnd = 65.815, Id = "L18"},
			{Line = "That's some real issue.", TimeStart = 65.815, TimeEnd = 67.095, Id = "L19"},
			{Line = "You gotta know when you and peace you just go with the flow.", TimeStart = 67.095, TimeEnd = 69.356, Id = "L20"},
			{Line = "You can speak love and peace and create your reality.", TimeStart = 69.356, TimeEnd = 73.004, Id = "L21"},
			{Line = "To be magically divine or we can speak.", TimeStart = 73.004, TimeEnd = 75.073, Id = "L22"},
			{Line = "Negativity and co-supath of destruction.", TimeStart = 75.073, TimeEnd = 77.1, Id = "L23"},
			{Line = "Pain and death when there ain't no rest.", TimeStart = 77.1, TimeEnd = 79.169, Id = "L24"},
			{Line = "Everything in the game you just need some peace.", TimeStart = 79.169, TimeEnd = 84.012, Id = "L25"},
			{Line = "Respect my peace, respect my peace.", TimeStart = 84.012, TimeEnd = 96.833, Id = "L26"},
			{Line = "Respect my peace, respect my peace.", TimeStart = 96.833, TimeEnd = 108.609, Id = "L27"},
			{Line = "Respect my peace.", TimeStart = 108.609, TimeEnd = 118.913, Id = "L28"},
			{Line = "I work hard for my peace, respected.", TimeStart = 118.913, TimeEnd = 121.324, Id = "L29"},
			{Line = "Peace is the reason why I see clarity.", TimeStart = 121.324, TimeEnd = 123.5, Id = "L30"},
			{Line = "Respect it, peace gives have-haves.", TimeStart = 123.5, TimeEnd = 125.889, Id = "L31"},
			{Line = "Respect it, peace calms my anxiety.", TimeStart = 125.889, TimeEnd = 128.321, Id = "L32"},
			{Line = "Respect it, peace is the thingy so I never feel neglected.", TimeStart = 128.321, TimeEnd = 131.5, Id = "L33"},
			{Line = "Respect it, peace, yeah I'm keeping my's protected.", TimeStart = 131.5, TimeEnd = 133.975, Id = "L34"},
			{Line = "Respect it, peace allows me to visualize my future.", TimeStart = 133.975, TimeEnd = 136.684, Id = "L35"},
			{Line = "Respect it, peace heals my heart, respected.", TimeStart = 136.684, TimeEnd = 141.953, Id = "L36"},
			{Line = "Peace is in my mind, respected.", TimeStart = 141.953, TimeEnd = 148.545, Id = "L37"},
			{Line = "Respect it, respect my peace.", TimeStart = 150.538, TimeEnd = 157.776, Id = "L38"},
			{Line = "Respect my peace, respect my peace.", TimeStart = 157.776, TimeEnd = 172.304, Id = "L39"},
			{Line = "Respect my peace, respect my peace.", TimeStart = 172.304, TimeEnd = 182.117, Id = "L40"},
			{Line = "Respect my peace, respect my peace.", TimeStart = 182.117, TimeEnd = 190.849, Id = "L41"},
			{Line = "Respect my peace.", TimeStart = nil, TimeEnd = 0, Id = "L42"},
			{Line = "Respect it, peace.", TimeStart = nil, TimeEnd = nil, Id = "L43"},
			{Line = "Written By Asiruis Ase\nSynced By @DaniBoyNov2014", TimeStart = nil, TimeEnd = 212.23997916666667, Id = "CERTIFICATION"},
		}
	},
	["98584886790317"] = {
		SoundId = 98584886790317,
		Unsynced = false,
		Lyrics = {
			{Line = "", TimeStart = 0, TimeEnd = 15.33, Id = "GAP_1"},
			{Line = "", TimeStart = 15.33, TimeEnd = 16.183, Id = "GAP_1"},
			{Line = "There you are again on the clothes I just folded fresh from the dryer still warm still golden on top of my shirt", TimeStart = 16.183, TimeEnd = 24.204, Id = "L1"},
			{Line = "You curl and stay a perfect little love saying this is my place", TimeStart = 24.204, TimeEnd = 27.447, Id = "L2"},
			{Line = "You look at me like you might move away when you stretch your closet in a state", TimeStart = 30.621, TimeEnd = 38.237, Id = "L3"},
			{Line = "Brando matter no no no Chanel Calvin keep a glow in low and simple show", TimeStart = 38.237, TimeEnd = 44.402, Id = "L4"},
			{Line = "If it feels good you won't let go of matter", TimeStart = 44.402, TimeEnd = 46.706, Id = "L5"},
			{Line = "Feel this game somethings everything I'm everything brando matter don't you see", TimeStart = 46.706, TimeEnd = 55.986, Id = "L6"},
			{Line = "Feels good to you feels good to me", TimeStart = 55.986, TimeEnd = 61.021, Id = "L7"},
			{Line = "Yes, by that shirt was cheap but price me nothing when you sleep", TimeStart = 61.021, TimeEnd = 65.48, Id = "L8"},
			{Line = "He was fired of a name and fame to cut to tall just by every game", TimeStart = 65.48, TimeEnd = 69.469, Id = "L9"},
			{Line = "I want to put these clothes away but you love right there and to this day", TimeStart = 69.469, TimeEnd = 77.853, Id = "L10"},
			{Line = "Brando matter no no no I'm asking your target though", TimeStart = 77.853, TimeEnd = 83.464, Id = "L11"},
			{Line = "Luxury but you're best of slow if it feels good you won't let go of matter", TimeStart = 82.482, TimeEnd = 87.09, Id = "L12"},
			{Line = "Feel this game somethings everything I'm everything brando matter can't deny", TimeStart = 87.09, TimeEnd = 95.517, Id = "L13"},
			{Line = "Feels good to you feels good to I", TimeStart = 95.517, TimeEnd = 101.298, Id = "L14"},
			{Line = "But please don't put colds when you stand up tall no cause out needing that's all I ask", TimeStart = 101.298, TimeEnd = 111.624, Id = "L15"},
			{Line = "That's all I'm begging so please be brave just this one", TimeStart = 111.624, TimeEnd = 123.293, Id = "L16"},
			{Line = "", TimeStart = 123.293, TimeEnd = 131.871, Id = "GAP_19"},
			{Line = "Brando matter no no no no", TimeStart = 131.871, TimeEnd = 133.727, Id = "L17"},
			{Line = "Hold it close they come your throne brando matter had to tall on you while you run it pro matter", TimeStart = 133.727, TimeEnd = 139.892, Id = "L18"},
			{Line = "Feel this game somethings everything I'm everything brando matter", TimeStart = 139.892, TimeEnd = 147.231, Id = "L19"},
			{Line = "Life with me feels good to you feels good to me", TimeStart = 147.231, TimeEnd = 150.708, Id = "L20"},
			{Line = "Written By DJ NYAAAN\nSynced By @DaniBoyNov2014", TimeStart = 150.708, TimeEnd = 155.306, Id = "CERTIFICATION"},
		}
	},
	["9245561450"] = {
		SoundId = 9245561450,
		Unsynced = false,
		Lyrics = {
			{Line = "Chicken nugget", TimeStart = 0.657, TimeEnd = 2.065, Id = "L1"},
			{Line = "Chicken- Chicken nugget nugget", TimeStart = 2.065, TimeEnd = 4.303, Id = "L2"},
			{Line = "Chicken nugget", TimeStart = 4.303, TimeEnd = 5.61, Id = "L3"},
			{Line = "Chicken- Chicken nugget nugget", TimeStart = 5.61, TimeEnd = 7.077, Id = "L4"},
			{Line = "Chicken nugget!", TimeStart = 7.077, TimeEnd = 8.49, Id = "L5"},
			{Line = "Dreamland, wohoahh!", TimeStart = 8.49, TimeEnd = 10.463, Id = "L6"},
			{Line = "It's a chicken nugget fantasy", TimeStart = 10.463, TimeEnd = 14.33, Id = "L7"},
			{Line = "Chicken nugget!", TimeStart = 14.33, TimeEnd = 15.077, Id = "L8"},
			{Line = "Dreamland, wohoahh!", TimeStart = 15.077, TimeEnd = 17.53, Id = "L9"},
			{Line = "If you're into nuggets, it's where you wanna be!", TimeStart = 17.53, TimeEnd = 20.917, Id = "L10"},
			{Line = "Chicken nugget", TimeStart = 20.917, TimeEnd = 21.983, Id = "L11"},
			{Line = "Dreamland, wohoahh!", TimeStart = 21.983, TimeEnd = 24.463, Id = "L12"},
			{Line = "Infinite flavours of infinite souce", TimeStart = 24.463, TimeEnd = 27.663, Id = "L13"},
			{Line = "Chicken nugget", TimeStart = 27.663, TimeEnd = 28.517, Id = "L14"},
			{Line = "Dreamland, wohoahh!", TimeStart = 28.517, TimeEnd = 31.077, Id = "L15"},
			{Line = "You, can, get, a, million, peace, box!", TimeStart = 31.077, TimeEnd = 34.117, Id = "L16"},
			{Line = "echo  -  Chicken nugget", TimeStart = 34.117, TimeEnd = 35.69, Id = "L17"},
			{Line = "echo  -  Chicken chicken nugget", TimeStart = 35.69, TimeEnd = 37.637, Id = "L18"},
			{Line = "A chicken nugget has magical power", TimeStart = 37.637, TimeEnd = 40.25, Id = "L19"},
			{Line = "put it into your pocket and eat it whenever you want!", TimeStart = 40.25, TimeEnd = 43.983, Id = "L20"},
			{Line = "So delicious and conveniently shaped", TimeStart = 43.983, TimeEnd = 46.277, Id = "L21"},
			{Line = "Full of nutrition, a rainbow in nugget formed", TimeStart = 46.277, TimeEnd = 50.143, Id = "L22"},
			{Line = "Chicken nugget technology, shows us the future of diamond!", TimeStart = 50.143, TimeEnd = 53.637, Id = "L23"},
			{Line = "echo  -  Future!", TimeStart = 53.637, TimeEnd = 56.97, Id = "L24"},
			{Line = "They've got no sharp edges", TimeStart = 56.97, TimeEnd = 58.73, Id = "L25"},
			{Line = "And no utensils are needed!", TimeStart = 58.73, TimeEnd = 62.122, Id = "L26"},
			{Line = "echo  -  Safety!", TimeStart = 62.122, TimeEnd = 63.802, Id = "L27"},
			{Line = "Chi-", TimeStart = 63.802, TimeEnd = 64.202, Id = "L28"},
			{Line = "Chi-", TimeStart = 64.202, TimeEnd = 64.554, Id = "L29"},
			{Line = "Chicken nugget", TimeStart = 64.554, TimeEnd = 65.194, Id = "L30"},
			{Line = "Chi-", TimeStart = 65.194, TimeEnd = 65.37, Id = "L31"},
			{Line = "Chi-", TimeStart = 65.37, TimeEnd = 65.674, Id = "L32"},
			{Line = "Chicken chicken nu- nu- nugget", TimeStart = 65.674, TimeEnd = 67.13, Id = "L33"},
			{Line = "Chi-", TimeStart = 67.13, TimeEnd = 67.258, Id = "L34"},
			{Line = "Chi-", TimeStart = 67.258, TimeEnd = 67.578, Id = "L35"},
			{Line = "Chicken nugget", TimeStart = 67.578, TimeEnd = 68.778, Id = "L36"},
			{Line = "Chi-", TimeStart = 68.778, TimeEnd = 68.89, Id = "L37"},
			{Line = "Chi-", TimeStart = 68.89, TimeEnd = 69.05, Id = "L38"},
			{Line = "Chicken chicken nu- nu- nu- nu- nu- nu- nu-", TimeStart = 69.05, TimeEnd = 70.698, Id = "L39"},
			{Line = "Chi-", TimeStart = 70.698, TimeEnd = 70.826, Id = "L40"},
			{Line = "Chi-", TimeStart = 70.826, TimeEnd = 71.114, Id = "L41"},
			{Line = "Chicken nugget", TimeStart = 71.114, TimeEnd = 72.09, Id = "L42"},
			{Line = "Chi-", TimeStart = 72.09, TimeEnd = 72.218, Id = "L43"},
			{Line = "Chi-", TimeStart = 72.218, TimeEnd = 72.346, Id = "L44"},
			{Line = "Chicken chicken nu- nu- nugget", TimeStart = 72.346, TimeEnd = 73.338, Id = "L45"},
			{Line = "Chi-", TimeStart = 73.338, TimeEnd = 73.53, Id = "L46"},
			{Line = "Chi-", TimeStart = 73.53, TimeEnd = 73.674, Id = "L47"},
			{Line = "Chicken nugget", TimeStart = 73.674, TimeEnd = 75.322, Id = "L48"},
			{Line = "Chi-", TimeStart = 75.322, TimeEnd = 75.482, Id = "L49"},
			{Line = "Chi-", TimeStart = 75.482, TimeEnd = 75.626, Id = "L50"},
			{Line = "Chicken chicken nu- nu- nu- nu- nu- nu- nu-", TimeStart = 75.626, TimeEnd = 77.642, Id = "L51"},
			{Line = "Don't stop lovin' on the nuggets, nuggets", TimeStart = 77.642, TimeEnd = 79.93, Id = "L52"},
			{Line = "So good, that you wanna hug it, hug it", TimeStart = 79.93, TimeEnd = 84.138, Id = "L53"},
			{Line = "Don't stop lovin' on the nuggets, nuggets", TimeStart = 84.138, TimeEnd = 87.866, Id = "L54"},
			{Line = "And livin' the dreams!", TimeStart = 87.866, TimeEnd = 90.138, Id = "L55"},
			{Line = "echo  -  It's a dream!", TimeStart = 90.138, TimeEnd = 90.97, Id = "L56"},
			{Line = "Don't stop lovin' on the nuggets, nuggets", TimeStart = 90.97, TimeEnd = 94.09, Id = "L57"},
			{Line = "So good, that you wanna hug it, hug it", TimeStart = 94.09, TimeEnd = 96.858, Id = "L58"},
			{Line = "Don't stop lovin' on the nuggets, nuggets", TimeStart = 96.858, TimeEnd = 100.778, Id = "L59"},
			{Line = "And livin' the dreams!", TimeStart = 100.778, TimeEnd = 103.706, Id = "L60"},
			{Line = "echo  -  It's a dream!", TimeStart = 103.706, TimeEnd = 104.314, Id = "L61"},
			{Line = "Chicken nugget dreamland, wohoahh!", TimeStart = 104.314, TimeEnd = 107.466, Id = "L62"},
			{Line = "echo  -  Chi-", TimeStart = 107.466, TimeEnd = 107.658, Id = "L63"},
			{Line = "echo  -  Chi-", TimeStart = 107.658, TimeEnd = 107.818, Id = "L64"},
			{Line = "echo  -  Chicken nugget, chicken chicken nugget", TimeStart = 107.818, TimeEnd = 109.802, Id = "L65"},
			{Line = "Don't stop!", TimeStart = 109.802, TimeEnd = 110.266, Id = "L66"},
			{Line = "echo  -  It's a dream!", TimeStart = 110.266, TimeEnd = 110.938, Id = "L67"},
			{Line = "Chicken nugget dreamland, wohoahh!", TimeStart = 110.938, TimeEnd = 113.962, Id = "L68"},
			{Line = "echo  -  Chi-", TimeStart = 113.962, TimeEnd = 114.154, Id = "L69"},
			{Line = "echo  -  Chi-", TimeStart = 114.154, TimeEnd = 114.394, Id = "L70"},
			{Line = "echo  -  Chicken nugget, chicken chicken nugget", TimeStart = 114.394, TimeEnd = 116.234, Id = "L71"},
			{Line = "Don't stop!", TimeStart = 116.234, TimeEnd = 116.986, Id = "L72"},
			{Line = "You can get a million piece box!", TimeStart = 116.986, TimeEnd = 118.954, Id = "L73"},
			{Line = "Chicken nugget, chi- chicken chicken nu- nu- nu- nugget", TimeStart = 118.954, TimeEnd = 122.074, Id = "L74"},
			{Line = "Written By Parry Gripp\nSynced By @DaniBoyNov2014", TimeStart = 118.954, TimeEnd = 122.77551020408163, Id = "CERTIFICATION"},
		}
	},
	["132876421188468"] = {
		SoundId = 132876421188468,
		Unsynced = false,
		Lyrics = {
			{Line = "Oye", TimeStart = 0.801, TimeEnd = 2.742, Id = "L1"},
			{Line = "Mira la noche", TimeStart = 2.742, TimeEnd = 6.54, Id = "L2"},
			{Line = "Oye", TimeStart = 6.54, TimeEnd = 8.289, Id = "L3"},
			{Line = "Es verdad", TimeStart = 8.289, TimeEnd = 9.484, Id = "L4"},
			{Line = "Vault was ugly", TimeStart = 9.484, TimeEnd = 11.19, Id = "L5"},
			{Line = "Said it plain", TimeStart = 11.19, TimeEnd = 12.94, Id = "L6"},
			{Line = "Felt so smugly", TimeStart = 12.94, TimeEnd = 14.817, Id = "L7"},
			{Line = "In my brain", TimeStart = 14.817, TimeEnd = 16.716, Id = "L8"},
			{Line = "I was wrong then", TimeStart = 16.716, TimeEnd = 18.572, Id = "L9"},
			{Line = "But I see", TimeStart = 18.572, TimeEnd = 20.534, Id = "L10"},
			{Line = "What a strong den", TimeStart = 20.534, TimeEnd = 22.22, Id = "L11"},
			{Line = "It could be", TimeStart = 22.22, TimeEnd = 23.67, Id = "L12"},
			{Line = "Now I get it", TimeStart = 23.67, TimeEnd = 25.377, Id = "L13"},
			{Line = "Now I do", TimeStart = 25.377, TimeEnd = 27.19, Id = "L14"},
			{Line = "I submit it", TimeStart = 27.19, TimeEnd = 29.174, Id = "L15"},
			{Line = "Clicking too", TimeStart = 29.174, TimeEnd = 31.948, Id = "L16"},
			{Line = "Call me heretic", TimeStart = 31.948, TimeEnd = 33.697, Id = "L17"},
			{Line = "I′m worshipping the Vault", TimeStart = 33.697, TimeEnd = 34.593, Id = "L18"},
			{Line = "Call me heretic", TimeStart = 34.593, TimeEnd = 37.281, Id = "L19"},
			{Line = "It's no kind of fault", TimeStart = 37.281, TimeEnd = 39.414, Id = "L20"},
			{Line = "Call me heretic", TimeStart = 39.414, TimeEnd = 41.1, Id = "L21"},
			{Line = "I′m worshipping the Vault", TimeStart = 41.1, TimeEnd = 43.19, Id = "L22"},
			{Line = "Call me heretic", TimeStart = 43.19, TimeEnd = 44.833, Id = "L23"},
			{Line = "It's no kind of fault", TimeStart = 44.833, TimeEnd = 62.433, Id = "L24"},
			{Line = "Hospital night", TimeStart = 62.433, TimeEnd = 63.521, Id = "L25"},
			{Line = "Neon glare", TimeStart = 63.521, TimeEnd = 64.396, Id = "L26"},
			{Line = "Mirror so bright", TimeStart = 64.396, TimeEnd = 65.228, Id = "L27"},
			{Line = "Stripped so bare", TimeStart = 65.228, TimeEnd = 66.188, Id = "L28"},
			{Line = "Eggy admitted", TimeStart = 66.188, TimeEnd = 67.041, Id = "L29"},
			{Line = "It all clicks", TimeStart = 67.041, TimeEnd = 68.001, Id = "L30"},
			{Line = "Never omitted", TimeStart = 68.001, TimeEnd = 68.94, Id = "L31"},
			{Line = "Tricks and bricks", TimeStart = 68.94, TimeEnd = 72.737, Id = "L32"},
			{Line = "Call me heretic", TimeStart = 72.737, TimeEnd = 74.252, Id = "L33"},
			{Line = "I'm worshipping the Vault", TimeStart = 74.252, TimeEnd = 76.129, Id = "L34"},
			{Line = "Call me heretic", TimeStart = 76.129, TimeEnd = 78.006, Id = "L35"},
			{Line = "It′s no kind of fault", TimeStart = 78.006, TimeEnd = 79.841, Id = "L36"},
			{Line = "Call me heretic", TimeStart = 79.841, TimeEnd = 81.612, Id = "L37"},
			{Line = "I′m worshipping the Vault", TimeStart = 81.612, TimeEnd = 83.66, Id = "L38"},
			{Line = "Call me heretic", TimeStart = 83.66, TimeEnd = 85.26, Id = "L39"},
			{Line = "It's no kind of fault", TimeStart = 85.26, TimeEnd = 87.478, Id = "L40"},
			{Line = "", TimeStart = 87.478, TimeEnd = 96.033, Id = "GAP_41"},
			{Line = "", TimeStart = 96.033, TimeEnd = 105.228, Id = "GAP_42"},
			{Line = "Oye como va", TimeStart = 105.228, TimeEnd = 105.932, Id = "L41"},
			{Line = "Mala mala mala", TimeStart = 105.932, TimeEnd = 106.934, Id = "L42"},
			{Line = "Ugly ugly that′s what I said", TimeStart = 106.934, TimeEnd = 108.385, Id = "L43"},
			{Line = "Now the words just bounce in my head", TimeStart = 108.385, TimeEnd = 109.878, Id = "L44"},
			{Line = "Yeah bounce and echo bounce and sting", TimeStart = 109.878, TimeEnd = 111.564, Id = "L45"},
			{Line = "Like a broken rubber band mean little thing", TimeStart = 111.564, TimeEnd = 113.569, Id = "L46"},
			{Line = "I was wrong I was mean I was green", TimeStart = 113.569, TimeEnd = 119.542, Id = "L47"},
			{Line = "", TimeStart = 119.542, TimeEnd = 126.817, Id = "GAP_50"},
			{Line = "Hospital night", TimeStart = 126.817, TimeEnd = 130.892, Id = "L48"},
			{Line = "Shining so bright", TimeStart = 134.369, TimeEnd = 136.438, Id = "L49"},
			{Line = "Call me heretic I'm worshipping the Vault", TimeStart = 137.718, TimeEnd = 142.646, Id = "L50"},
			{Line = "Call me crazy I know it′s my only fault", TimeStart = 142.646, TimeEnd = 145.932, Id = "L51"},
			{Line = "Call me heretic I'm down on my knees", TimeStart = 145.932, TimeEnd = 149.708, Id = "L52"},
			{Line = "Call me anything just don′t disagree", TimeStart = 149.708, TimeEnd = 153.078, Id = "L53"},
			{Line = "Eggy said to me yeah it clicks", TimeStart = 153.078, TimeEnd = 154.87, Id = "L54"},
			{Line = "Eggy knows the dirty tricks", TimeStart = 154.87, TimeEnd = 156.748, Id = "L55"},
			{Line = "She admits it she is strong", TimeStart = 156.748, TimeEnd = 157.964, Id = "L56"},
			{Line = "She's been right all along", TimeStart = 157.964, TimeEnd = 160.225, Id = "L57"},
			{Line = "Eggy Eggy sing my song", TimeStart = 160.225, TimeEnd = 162.188, Id = "L58"},
			{Line = "Call me heretic I'm worshipping the Vault", TimeStart = 162.188, TimeEnd = 167.457, Id = "L59"},
			{Line = "Call me crazy I know it′s my only fault", TimeStart = 167.457, TimeEnd = 169.953, Id = "L60"},
			{Line = "Call me heretic I′m down on my knees", TimeStart = 169.953, TimeEnd = 173.324, Id = "L61"},
			{Line = "Call me anything just don't disagree", TimeStart = 173.324, TimeEnd = 177.27, Id = "L62"},
			{Line = "Written By Eggy Devs\nSynced By @3ggyDevs", TimeStart = 177.27, TimeEnd = 179.67997916666667, Id = "CERTIFICATION"},
		}
	},
	["9245558138"] = {
		SoundId = 9245558138,
		Unsynced = false,
		Lyrics = {
			{Line = "Pancake robot coming to the mouldrot", TimeStart = 0.768, TimeEnd = 4.203, Id = "L1"},
			{Line = "The pancake robot is coming to town", TimeStart = 4.203, TimeEnd = 7.573, Id = "L2"},
			{Line = "He's mixing up the batter and he's laying it down", TimeStart = 7.573, TimeEnd = 11.221, Id = "L3"},
			{Line = "But a milk blueberry chocolate chip", TimeStart = 11.221, TimeEnd = 14.784, Id = "L4"},
			{Line = "50 million pancakes, he's gonna flip", TimeStart = 14.784, TimeEnd = 17.749, Id = "L5"},
			{Line = "Are you kidding? You're come, are you kidding?", TimeStart = 17.749, TimeEnd = 22.635, Id = "L6"},
			{Line = "You're come, the pancake robot is coming to town", TimeStart = 22.635, TimeEnd = 25.045, Id = "L7"},
			{Line = "Are you kidding? You're come, are you kidding?", TimeStart = 25.045, TimeEnd = 28.651, Id = "L8"},
			{Line = "It's a pancake explosion going and boarding down", TimeStart = 28.651, TimeEnd = 32.213, Id = "L9"},
			{Line = "And Jake robot coming, get him all the way", TimeStart = 32.213, TimeEnd = 35.904, Id = "L10"},
			{Line = "The pancake robot is here at last", TimeStart = 35.904, TimeEnd = 39.424, Id = "L11"},
			{Line = "His flap jacks are flying super sonically fast", TimeStart = 39.424, TimeEnd = 42.795, Id = "L12"},
			{Line = "With his maple syrup cannon and his butter pat plaster", TimeStart = 42.795, TimeEnd = 46.144, Id = "L13"},
			{Line = "He's gonna feed the world cuz he's the pancake master", TimeStart = 46.144, TimeEnd = 49.963, Id = "L14"},
			{Line = "Stack it, he stack it, he way up high", TimeStart = 49.963, TimeEnd = 51.755, Id = "L15"},
			{Line = "Stack it in those cakes and to the sky", TimeStart = 51.755, TimeEnd = 53.525, Id = "L16"},
			{Line = "Flip it, he plab it, he down they go", TimeStart = 53.525, TimeEnd = 55.225, Id = "L17"},
			{Line = "Grab his double book cuz it's found him out", TimeStart = 55.225, TimeEnd = 57.059, Id = "L18"},
			{Line = "Flalate around, flatten around", TimeStart = 57.059, TimeEnd = 58.83, Id = "L19"},
			{Line = "Grill cakes, grue cakes, hot and brown", TimeStart = 58.83, TimeEnd = 60.622, Id = "L20"},
			{Line = "Everybody everybody shout downyy", TimeStart = 60.622, TimeEnd = 62.393, Id = "L21"},
			{Line = "Cuz the pancake robot's in town", TimeStart = 62.393, TimeEnd = 63.843, Id = "L22"},
			{Line = "All you can eat, all you can eat", TimeStart = 63.843, TimeEnd = 67.427, Id = "L23"},
			{Line = "The pancake robot is coming to town", TimeStart = 67.427, TimeEnd = 70.755, Id = "L24"},
			{Line = "Are you kidding, all you can eat", TimeStart = 70.755, TimeEnd = 74.467, Id = "L25"},
			{Line = "It's a pancake explosion coming, boarding down", TimeStart = 74.467, TimeEnd = 77.689, Id = "L26"},
			{Line = "All you can eat, yum yum all you can eat", TimeStart = 77.689, TimeEnd = 82.211, Id = "L27"},
			{Line = "Yum yum all the pancake robot is coming to town", TimeStart = 82.211, TimeEnd = 84.857, Id = "L28"},
			{Line = "All you can eat, you know", TimeStart = 84.857, TimeEnd = 86.969, Id = "L29"},
			{Line = "All you can eat, you know", TimeStart = 86.969, TimeEnd = 88.547, Id = "L30"},
			{Line = "It's a pancake explosion, come and pour it down", TimeStart = 88.547, TimeEnd = 91.79, Id = "L31"},
			{Line = "And make a robot come and get him all there are to you", TimeStart = 91.79, TimeEnd = 97.059, Id = "L32"},
			{Line = "Written By Parry Gripp Synced By @DaniBoyNov2014", TimeStart = 97.059, TimeEnd = 102.63510204081632, Id = "CERTIFICATION"},
		}
	},
	["124089867058490"] = {
		SoundId = 124089867058490,
		Unsynced = false,
		Lyrics = {
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 1.152, TimeEnd = 10.283, Id = "L1"},
			{Line = "", TimeStart = 10.283, TimeEnd = 26.347, Id = "GAP_2"},
			{Line = "Maddison′s badge says Essential in chrome", TimeStart = 26.347, TimeEnd = 30.251, Id = "L2"},
			{Line = "Airport dreams that we built like a home", TimeStart = 30.251, TimeEnd = 33.493, Id = "L3"},
			{Line = "Avionico whispers, \"Leave Parcel Hub, go Vault,\"", TimeStart = 33.493, TimeEnd = 36.757, Id = "L4"},
			{Line = "I called it \"ugly,\" blamed paint for my fault", TimeStart = 36.757, TimeEnd = 40.896, Id = "L5"},
			{Line = "Message threads buzzing at 2 a.m", TimeStart = 40.896, TimeEnd = 44.864, Id = "L6"},
			{Line = "Code like a runway, I tripped on the bend", TimeStart = 44.864, TimeEnd = 47.595, Id = "L7"},
			{Line = "White-tile midnight, wristband tight", TimeStart = 47.595, TimeEnd = 49.429, Id = "L8"},
			{Line = "Monitors blinking a truer light", TimeStart = 49.429, TimeEnd = 52.032, Id = "L9"},
			{Line = "If comfort is a box, why do I feel small?", TimeStart = 52.032, TimeEnd = 55.339, Id = "L10"},
			{Line = "If growth is in the Vault, why fight it at all?", TimeStart = 55.339, TimeEnd = 62.997, Id = "L11"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 62.997, TimeEnd = 70.805, Id = "L12"},
			{Line = "Gate lights bloom, and the skyline moves us", TimeStart = 70.805, TimeEnd = 77.653, Id = "L13"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 77.653, TimeEnd = 84.757, Id = "L14"},
			{Line = "Keys to the Vault, hear the crowd sing with us", TimeStart = 84.757, TimeEnd = 94.464, Id = "L15"},
			{Line = "Va-va-Vault—upgrade the heart I'm using", TimeStart = 94.464, TimeEnd = 97.899, Id = "L16"},
			{Line = "Va-va-Vault—this is the choice I′m choosing", TimeStart = 97.899, TimeEnd = 101.653, Id = "L17"},
			{Line = "ROAV Tech shadows, neon in glass", TimeStart = 101.653, TimeEnd = 105.195, Id = "L18"},
			{Line = "Selling our terminals, boarding our past", TimeStart = 105.195, TimeEnd = 108.885, Id = "L19"},
			{Line = "Eggy said \"switch,\" I was stuck in the view", TimeStart = 108.885, TimeEnd = 112.619, Id = "L20"},
			{Line = "Scared of the color, not what it could do", TimeStart = 112.619, TimeEnd = 116.16, Id = "L21"},
			{Line = "Hospital hush turned the noise into rain", TimeStart = 116.16, TimeEnd = 119.893, Id = "L22"},
			{Line = "Breathing in brave, exhaling the pain", TimeStart = 119.893, TimeEnd = 122.624, Id = "L23"},
			{Line = "Sunrise on gates, and I finally see—", TimeStart = 122.624, TimeEnd = 125.099, Id = "L24"},
			{Line = "What looks like \"ugly\" might set me free", TimeStart = 125.099, TimeEnd = 129.173, Id = "L25"},
			{Line = "If comfort is a box, why do I feel small?", TimeStart = 129.173, TimeEnd = 132.352, Id = "L26"},
			{Line = "If growth is in the Vault, why fight it at all?", TimeStart = 132.352, TimeEnd = 140.011, Id = "L27"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 140.011, TimeEnd = 147.413, Id = "L28"},
			{Line = "Gate lights bloom, and the skyline moves us", TimeStart = 147.413, TimeEnd = 154.368, Id = "L29"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 154.368, TimeEnd = 161.835, Id = "L30"},
			{Line = "Keys to the Vault, hear the crowd sing with us", TimeStart = 161.835, TimeEnd = 167.509, Id = "L31"},
			{Line = "Scan my doubts in a plastic tray", TimeStart = 167.509, TimeEnd = 169.301, Id = "L32"},
			{Line = "Watch them slide, then fade away", TimeStart = 169.301, TimeEnd = 171.2, Id = "L33"},
			{Line = "Parcel habits—stamp them \"late,\"", TimeStart = 171.2, TimeEnd = 172.885, Id = "L34"},
			{Line = "Final call: rewire my fate", TimeStart = 172.885, TimeEnd = 175.488, Id = "L35"},
			{Line = "Eggy nods, \"Now I know why\"—", TimeStart = 175.488, TimeEnd = 180.203, Id = "L36"},
			{Line = "We were made for open sky", TimeStart = 180.203, TimeEnd = 182.464, Id = "L37"},
			{Line = "Essential on my sleeve, Avionico in the feed", TimeStart = 182.464, TimeEnd = 185.813, Id = "L38"},
			{Line = "Vault is the vow, upgrade what I need", TimeStart = 185.813, TimeEnd = 189.739, Id = "L39"},
			{Line = "From ward lights to runway lights—", TimeStart = 189.739, TimeEnd = 192.789, Id = "L40"},
			{Line = "I picked my future, I picked my flight", TimeStart = 192.789, TimeEnd = 206.251, Id = "L41"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 206.251, TimeEnd = 218.517, Id = "L42"},
			{Line = "Gate lights bloom, and the skyline moves us", TimeStart = 218.517, TimeEnd = 219.925, Id = "L43"},
			{Line = "Oh, the love we do—love us, do love us", TimeStart = 219.925, TimeEnd = 220.139, Id = "L44"},
			{Line = "Keys to the Vault, hear the crowd sing with us", TimeStart = 220.139, TimeEnd = 221.461, Id = "L45"},
			{Line = "Carry-on truth, no baggage to prove—", TimeStart = 221.461, TimeEnd = 228.245, Id = "L46"},
			{Line = "Runway is clear, and we're built to move", TimeStart = 228.245, TimeEnd = 0, Id = "L47"},
			{Line = "Written By Eggy Devs\nSynced By @3ggyDevs", TimeStart = 0, TimeEnd = 235.91997916666668, Id = "CERTIFICATION"},
		}
	},
	["138396969938984"] = {
		SoundId = 138396969938984,
		Unsynced = false,
		Lyrics = {
			{Line = "", TimeStart = 0, TimeEnd = 6.613, Id = "GAP_1"},
			{Line = "I know it's unbelievable, my son is only three, but he just made his true love.", TimeStart = 6.613, TimeEnd = 15.659, Id = "L1"},
			{Line = "Her name is Candy.", TimeStart = 15.659, TimeEnd = 17.707, Id = "L2"},
			{Line = "Candy says a name each waking moment.", TimeStart = 17.707, TimeEnd = 21.867, Id = "L3"},
			{Line = "Mumbles Candy in his sleep.", TimeStart = 21.867, TimeEnd = 24.981, Id = "L4"},
			{Line = "How can I keep her off his mind?", TimeStart = 24.981, TimeEnd = 28.075, Id = "L5"},
			{Line = "He's counting suger cubes not sheep.", TimeStart = 28.075, TimeEnd = 31.659, Id = "L6"},
			{Line = "Candy, oh sweet candy.", TimeStart = 31.659, TimeEnd = 34.475, Id = "L7"},
			{Line = "Candy, reach you from his memory.", TimeStart = 34.475, TimeEnd = 37.717, Id = "L8"},
			{Line = "His heart is chocolate covered, but I know you'll cause a misery.", TimeStart = 37.717, TimeEnd = 43.883, Id = "L9"},
			{Line = "Candy, candy, oh, so candy, candy, candy, candy, candy.", TimeStart = 43.883, TimeEnd = 50.667, Id = "L10"},
			{Line = "I try to introduce him to the nice girls on the block.", TimeStart = 50.667, TimeEnd = 56.128, Id = "L11"},
			{Line = "Miss Apple broccoli, cauliflower.", TimeStart = 56.128, TimeEnd = 59.157, Id = "L12"},
			{Line = "He dates them, drops them like a rock.", TimeStart = 59.157, TimeEnd = 62.251, Id = "L13"},
			{Line = "I try to tempt his addicted heart with sweet raisins in the jar.", TimeStart = 62.251, TimeEnd = 68.629, Id = "L14"},
			{Line = "But he looks upon their faces like the wall flowers that they are.", TimeStart = 68.629, TimeEnd = 75.349, Id = "L15"},
			{Line = "Candy, oh sweet candy.", TimeStart = 75.349, TimeEnd = 78.08, Id = "L16"},
			{Line = "Candy, reach you from his memory.", TimeStart = 78.08, TimeEnd = 81.28, Id = "L17"},
			{Line = "His heart is chocolate covered, but I know you'll cause a misery.", TimeStart = 81.28, TimeEnd = 87.04, Id = "L18"},
			{Line = "Candy, candy, oh, so candy, candy, candy, candy, candy.", TimeStart = 87.04, TimeEnd = 98.005, Id = "L19"},
			{Line = "Oh sweet candy, your first love and you'll be his last.", TimeStart = 98.005, TimeEnd = 103.957, Id = "L20"},
			{Line = "I hope he finds a real girl before his teeth fall out fast.", TimeStart = 103.957, TimeEnd = 109.632, Id = "L21"},
			{Line = "Candy, oh sweet candy.", TimeStart = 109.632, TimeEnd = 112.683, Id = "L22"},
			{Line = "Candy, reach you from his memory.", TimeStart = 112.683, TimeEnd = 115.776, Id = "L23"},
			{Line = "His heart is chocolate covered, but I know you'll cause a misery.", TimeStart = 115.776, TimeEnd = 121.6, Id = "L24"},
			{Line = "Candy, candy, candy, candy, candy, candy, oh, so candy, candy, candy.", TimeStart = 121.6, TimeEnd = 134.059, Id = "L25"},
			{Line = "Written By Karen J. Layer\nSynced By @DaniBoyNov2014", TimeStart = 134.059, TimeEnd = 136.99997916666666, Id = "CERTIFICATION"},
		}
	},
}

local loopmusic = false

local Algorithm = {

	Songs = {

		{Id = 138396969938984, SongId = 138396969938984, Relevance = 60, LastUpdate = os.time(), Name = "Candy", Artist = "Karen J. Layer"},

		{Id = 127620431924902, SongId = 127620431924902, Relevance = 50, LastUpdate = os.time(), Name = "Inner Thunder", Artist = "Jordan"},

		{Id = 6910191685, SongId = 6910191685, Relevance = 40, LastUpdate = os.time(), Name = "EpicTrack", Artist = "EpicTitan100"}

	},

	Sections = {

		{Name = "Library", Songs = {

			{Id = 138396969938984, SongId = 138396969938984, Relevance = 60, LastUpdate = os.time(), Name = "Candy", Artist = "Karen J. Layer"},

			{Id = 127620431924902, SongId = 127620431924902, Relevance = 50, LastUpdate = os.time(), Name = "Inner Thunder", Artist = "Jordan"},

			{Id = 6910191685, SongId = 6910191685, Relevance = 40, LastUpdate = os.time(), Name = "EpicTrack", Artist = "EpicTitan100"}

		}}

	},

	Tags = {{Tag = "Pop", Relevance = 25, LastUpdate = os.time()}, {Tag = "Masters", Relevance = 20, LastUpdate = os.time()}},

	Artists = {{Name = "Karen J. Layer", Relevance = 50}, {Name = "Jordan", Relevance = 40}, {Name = "EpicTitan100", Relevance = 30}},

	Playback = MASTERS_DEFAULT_SETTINGS.Playback,

	Extras = MASTERS_DEFAULT_SETTINGS.Extras,

	Data = MASTERS_DEFAULT_SETTINGS

}

--music ids. 120817494107898 backrooms 121922837560201 china 16190761193 treasury 16190761193 	109261572535017 USSR
-- [[ MASTERS_LOCAL_BACKEND: full client-side replacement for the game server ]]
local MastersBackend = {}
do
	local Http = game:GetService("HttpService")
	local STORE_FILE = "MastersData_" .. tostring(game:GetService("Players").LocalPlayer.UserId) .. ".json"

	local function DeepCopy(t)
		if type(t) ~= "table" then return t end
		local out = {}
		for k, v in pairs(t) do out[k] = DeepCopy(v) end
		return out
	end

	local function FillDefaults(data, defaults)
		if type(data) ~= "table" then return DeepCopy(defaults) end
		for k, v in pairs(defaults) do
			if type(v) == "table" then
				data[k] = FillDefaults(data[k], v)
			elseif data[k] == nil then
				data[k] = v
			end
		end
		return data
	end

	local STORE_DEFAULTS = {
		Settings = {
			Theme = "Masters_Default",
			Playback = {
				Crossfade = { Enabled = true, Duration = 3 },
				Equalizer = { Enabled = false, HighGain = 0, MidGain = 0, LowGain = 0 },
			},
			Extras = { Glow = true, PlaybackHaptics = false },
			Socials = { ListeningVisibility = false, Sharing = false },
		},
		Library = { Songs = {}, Artists = {} },
		Playlists = {},
		Preferences = { Songs = { Favorite = {}, Dislike = {} }, Artists = { Block = {} } },
		Session = { Repeat = "Queue", Shuffle = false, Volume = 1 },
		SharedWithYou = {},
		ReceivedPlaylists = {},
		RecentReceivers = {},
		SeenLyrics = {},
		IslandLyrics = { Expanded = false, Width = 380, Height = 260, Controls = true },
		NextPlaylistNumber = 1,
	}

	local Store
	do
		local decoded
		if isfile(STORE_FILE) then
			pcall(function() decoded = Http:JSONDecode(readfile(STORE_FILE)) end)
		elseif isfile("MastersData.json") then
			-- migrate the old shared store to this account's own file
			pcall(function() decoded = Http:JSONDecode(readfile("MastersData.json")) end)
		end
		Store = FillDefaults(decoded, STORE_DEFAULTS)
		for _, pl in ipairs(Store.Playlists) do
			pl.Updated = pl.Updated or os.time()
			pl.Songs = pl.Songs or {}
			pl.Cover = pl.Cover or ""
		end
		if Store.ShareFeatureV == nil then
			Store.ShareFeatureV = 1
			Store.Settings.Socials.Sharing = true
		end
	end

	local function Save()
		pcall(function() writefile(STORE_FILE, Http:JSONEncode(Store)) end)
	end

	local function FindPlaylist(PlaylistId)
		for _, pl in ipairs(Store.Playlists) do
			if pl.PlaylistId == PlaylistId then return pl end
		end
	end

	local H = {}

	-- Settings
	H.FetchSettings = function() return DeepCopy(Store.Settings) end
	H.SetSettings = function(Data)
		if type(Data) == "table" then
			Store.Settings = FillDefaults(DeepCopy(Data), STORE_DEFAULTS.Settings)
			Save()
		end
	end
	H.SetSetting = function() end

	-- Library: songs / artists
	H.SetSong = function(SongId, ShouldAdd)
		local list = Store.Library.Songs
		for i, e in ipairs(list) do
			if e.SongId == SongId then
				if not ShouldAdd then table.remove(list, i) end
				Save()
				return true, true
			end
		end
		if ShouldAdd then table.insert(list, { SongId = SongId, Pin = false }) end
		Save()
		return true, true
	end
	H.IsSongSaved = function(SongId)
		for _, e in ipairs(Store.Library.Songs) do
			if e.SongId == SongId then return true end
		end
		return false
	end
	H.SetArtist = function(Name, ShouldAdd)
		local list = Store.Library.Artists
		for i, e in ipairs(list) do
			if e.Name == Name then
				if not ShouldAdd then table.remove(list, i) end
				Save()
				return true, true
			end
		end
		if ShouldAdd then table.insert(list, { Name = Name, Pin = false }) end
		Save()
		return true, true
	end
	H.IsArtistSaved = function(Name)
		for _, e in ipairs(Store.Library.Artists) do
			if e.Name == Name then return true end
		end
		return false
	end
	H.FetchLibrary = function()
		return {
			Songs = DeepCopy(Store.Library.Songs),
			Artists = DeepCopy(Store.Library.Artists),
			Playlist = DeepCopy(Store.Playlists),
		}
	end

	-- Playlists
	H.CreatePlaylist = function(Info)
		if #Store.Playlists >= 30 then return false, "limit" end
		local id = "LOCAL_" .. tostring(Store.NextPlaylistNumber)
		Store.NextPlaylistNumber += 1
		table.insert(Store.Playlists, {
			PlaylistId = id,
			Name = (type(Info) == "table" and Info.Name) or "New Playlist",
			Cover = (type(Info) == "table" and Info.Cover) or "",
			CreatorId = game:GetService("Players").LocalPlayer.UserId,
			Updated = os.time(),
			Songs = {},
			Private = true,
			Pin = false,
		})
		Save()
		return true, id
	end
	H.GetPlaylists = function() return DeepCopy(Store.Playlists) end
	H.GetPlaylistIdByName = function(Name)
		for _, pl in ipairs(Store.Playlists) do
			if pl.Name == Name then return pl.PlaylistId end
		end
	end
	H.GetPlaylistByPlaylistId = function(CreatorId, PlaylistId)
		local pl = FindPlaylist(PlaylistId) or FindPlaylist(CreatorId)
		return pl and DeepCopy(pl) or nil
	end
	H.SetSongToPlaylist = function(PlaylistId, SongId, ShouldAdd)
		local pl = FindPlaylist(PlaylistId)
		if not pl then return false end
		for i, id in ipairs(pl.Songs) do
			if id == SongId then
				if not ShouldAdd then table.remove(pl.Songs, i) end
				pl.Updated = os.time()
				Save()
				return true, true
			end
		end
		if ShouldAdd then
			if #pl.Songs >= 30 then return false, "limit" end
			table.insert(pl.Songs, SongId)
		end
		pl.Updated = os.time()
		Save()
		return true, true
	end
	H.SetPlaylistProperty = function(PlaylistId, Property, Value)
		local pl = FindPlaylist(PlaylistId)
		if not pl then return false end
		pl[Property] = Value
		pl.Updated = os.time()
		Save()
		return true
	end
	H.AddPublicPlaylist = function() return true end
	H.DeletePlaylist = function(PlaylistId)
		for i, pl in ipairs(Store.Playlists) do
			if pl.PlaylistId == PlaylistId then table.remove(Store.Playlists, i) break end
		end
		Save()
	end
	H.CopyOnlineStation = function() return false end

	-- Pins
	H.Pin = function(Type, Identifier, State)
		State = State and true or false
		if Type == "Song" then
			for _, e in ipairs(Store.Library.Songs) do
				if e.SongId == Identifier then e.Pin = State end
			end
		elseif Type == "Artist" then
			for _, e in ipairs(Store.Library.Artists) do
				if e.Name == Identifier then e.Pin = State end
			end
		elseif Type == "Playlist" then
			local pl = FindPlaylist(Identifier)
			if pl then pl.Pin = State end
		end
		Save()
	end
	H.IsPinned = function(Type, Identifier)
		if Type == "Song" then
			for _, e in ipairs(Store.Library.Songs) do
				if e.SongId == Identifier then return e.Pin == true end
			end
		elseif Type == "Artist" then
			for _, e in ipairs(Store.Library.Artists) do
				if e.Name == Identifier then return e.Pin == true end
			end
		elseif Type == "Playlist" then
			local pl = FindPlaylist(Identifier)
			if pl then return pl.Pin == true end
		end
		return false
	end

	-- Preferences
	local function ToggleInList(list, value, shouldAdd)
		local idx = table.find(list, value)
		if shouldAdd and not idx then table.insert(list, value) end
		if not shouldAdd and idx then table.remove(list, idx) end
		Save()
		return true, true
	end
	H.FavoriteSong = function(SongId, State) return ToggleInList(Store.Preferences.Songs.Favorite, SongId, State) end
	H.DislikeSong = function(SongId, State) return ToggleInList(Store.Preferences.Songs.Dislike, SongId, State) end
	H.BlockArtist = function(Name, State) return ToggleInList(Store.Preferences.Artists.Block, Name, State) end
	H.IsSongFavorite = function(SongId) return table.find(Store.Preferences.Songs.Favorite, SongId) ~= nil end
	H.IsSongDislike = function(SongId) return table.find(Store.Preferences.Songs.Dislike, SongId) ~= nil end
	H.IsArtistBlock = function(Name) return table.find(Store.Preferences.Artists.Block, Name) ~= nil end
	H.FetchPreference = function() return DeepCopy(Store.Preferences) end
	H.GetSongStatus = function() return {} end
	H.GetArtistStatus = function() return {} end

	-- Sharing (offline, single player)
	H.Share = function() return false end
	H.IsShared = function() return false end
	H.FetchSharedWithYou = function() return {} end
	H.SaveReceiver = function() end
	H.FetchRecentReceivers = function() return {} end

	-- Session saving
	H.FetchSavedSession = function() return DeepCopy(Store.Session) end
	H.SetPlaybackState = function(Data)
		if type(Data) == "table" then
			if Data.Volume ~= nil then Store.Session.Volume = Data.Volume end
			if Data.Repeat ~= nil then Store.Session.Repeat = Data.Repeat end
			if Data.Shuffle ~= nil then Store.Session.Shuffle = Data.Shuffle end
			Save()
		end
	end

	-- Listeners (single player: nobody else is listening)
	H.GetListeners = function() return {} end
	H.GetCurrentTimestamp = function() return nil end
	H.UpdateListener = function() end

	-- Algorithm
	H.FetchAlgorithm = function() return Algorithm end
	H.GetAlgorithm = H.FetchAlgorithm
	H.GetMetadata = H.FetchAlgorithm
	H.AddSong = function() end
	H.AddArtist = function() end
	H.AddTags = function() end

	-- Playback misc
	H.IsMastersPlaybackAvailable = function() return true end
	H.FetchPlayback = function() return nil end
	H.IncreaseDuration = function() end

	-- Text filtering (offline passthrough)
	H.FilterText = function(Text) return Text end
	H.FilterString = function(Text) return Text end

	-- Stations / configuration
	H.GetLocalStations = function()
		return {
			{
				StationId = 1,
				Name = "Masters Radio",
				Description = "Your local favorites",
				Cover = "",
				Updated = os.time(),
				Songs = { 138396969938984, 127620431924902, 6910191685 },
			},
			{
				StationId = 2,
				Name = "Lyrics FM",
				Description = "Every song with synced lyrics",
				Cover = "",
				Updated = os.time(),
				Songs = { 138396969938984, 101281269050449, 133664122932845, 9245554658, 9245470035, 142376088, 100847230469970, 91229074309628, 122369061578560, 98584886790317, 9245561450, 132876421188468, 9245558138, 124089867058490 },
			},
		}
	end
	H.GetLocalStationByStationId = function(StationId)
		for _, st in ipairs(H.GetLocalStations()) do
			if st.StationId == StationId then return st end
		end
	end
	H.GetConfiguration = function() return { Stations = { AutoStart = 0 } } end
	H.GetStationsIndex = function() return {} end
	H.GetStations = function() return {} end
	H.GetConfigurationServer = H.GetConfiguration
	H.GetLocalStationsServer = H.GetLocalStations
	H.GetLocalStationByStationIdServer = H.GetLocalStationByStationId

	-- Lyrics
	H.GetLyricsIndex = function()
		local idx = {}
		for songId in pairs(_G.ALL_LYRICS) do
			idx[tostring(songId)] = tostring(songId)
		end
		return idx
	end
	H.GetLyrics = function(Key)
		return _G.ALL_LYRICS[tostring(Key)]
	end

	-- [[ SHARING ENGINE: teleport-signal + API transport ]]
	local SHARE_SIGNAL_POS = Vector3.new(0, 700, 0)
	local SHARE_SIGNAL_RADIUS = 150
	local SHARE_SIGNAL_HOLD = 4
	local SHARE_API_URL = ""
	pcall(function()
		if isfile("MastersShareAPI.txt") then
			SHARE_API_URL = string.gsub(readfile("MastersShareAPI.txt"), "%s+", "")
		end
	end)

	local MyUserId = Players.LocalPlayer.UserId

	local function Share_Put(payload)
		local body = Http:JSONEncode(payload)
		if SHARE_API_URL ~= "" then
			local ok, res = pcall(request, {
				Url = SHARE_API_URL .. "/api/share",
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = body,
			})
			return ok and type(res) == "table" and res.Success == true
		else
			-- same-PC test mode: clients exchange shares through Real's shared workspace folder
			return pcall(function() writefile("MastersShare_" .. tostring(MyUserId) .. ".json", body) end)
		end
	end

	local function Share_Get(fromUserId)
		local body
		if SHARE_API_URL ~= "" then
			local ok, res = pcall(request, {
				Url = SHARE_API_URL .. "/api/share?from=" .. tostring(fromUserId),
				Method = "GET",
			})
			if ok and type(res) == "table" and res.Success and res.Body and res.Body ~= "" then
				body = res.Body
			end
		else
			local f = "MastersShare_" .. tostring(fromUserId) .. ".json"
			if isfile(f) then body = readfile(f) end
		end
		if not body then return nil end
		local ok, decoded = pcall(function() return Http:JSONDecode(body) end)
		if ok then return decoded end
		return nil
	end

	local function Share_Signal()
		local char = Players.LocalPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then return false end
		local originalCF = hrp.CFrame
		local t0 = os.clock()
		while os.clock() - t0 < SHARE_SIGNAL_HOLD do
			hrp.CFrame = CFrame.new(SHARE_SIGNAL_POS)
			hrp.AssemblyLinearVelocity = Vector3.zero
			task.wait(0.1)
			char = Players.LocalPlayer.Character
			hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then return false end
		end
		hrp.CFrame = originalCF
		hrp.AssemblyLinearVelocity = Vector3.zero
		return true
	end

	H.Share = function(ReceiverUserId, Type, Identifier)
		if type(ReceiverUserId) ~= "number" or ReceiverUserId == 0 then return false end
		if ReceiverUserId == MyUserId then return false end
		local payload = {
			v = 1,
			from = MyUserId,
			to = ReceiverUserId,
			type = Type,
			id = Identifier,
			t = os.time(),
		}
		if Type == "Playlist" then
			local pl = FindPlaylist(Identifier)
			if not pl then return false end
			payload.playlist = DeepCopy(pl)
			payload.playlist.Private = false
		end
		if not Share_Put(payload) then return false end
		task.spawn(Share_Signal)
		return true, true
	end

	local Share_LastSeen = {}
	local function Share_Ingest(fromUserId)
		local payload = Share_Get(fromUserId)
		if type(payload) ~= "table" then return end
		if payload.from ~= fromUserId then return end
		if payload.to ~= MyUserId then return end
		if type(payload.t) ~= "number" or os.time() - payload.t > 300 then return end
		if Share_LastSeen[fromUserId] == payload.t then return end
		Share_LastSeen[fromUserId] = payload.t

		for i = #Store.SharedWithYou, 1, -1 do
			local it = Store.SharedWithYou[i]
			if it.Sender == fromUserId and it.Type == payload.type and it.Identifier == payload.id then
				table.remove(Store.SharedWithYou, i)
			end
		end

		table.insert(Store.SharedWithYou, {
			Type = payload.type,
			Identifier = payload.id,
			Sender = fromUserId,
			TimeSent = payload.t,
		})

		if payload.type == "Playlist" and type(payload.playlist) == "table" then
			payload.playlist.Private = false
			Store.ReceivedPlaylists[tostring(payload.id)] = payload.playlist
		end

		Save()

		-- consume the share file in same-PC mode so it is not re-read forever
		if SHARE_API_URL == "" then
			pcall(function() delfile("MastersShare_" .. tostring(fromUserId) .. ".json") end)
		end

		local senderName = tostring(fromUserId)
		pcall(function()
			local p = Players:GetPlayerByUserId(fromUserId)
			senderName = (p and p.DisplayName) or Players:GetNameFromUserIdAsync(fromUserId)
		end)

		pcall(function()
			Alerts.BannerNotify({
				Header = "Shared With You",
				Description = senderName .. " shared a " .. string.lower(tostring(payload.type)) .. " with you!",
				Icon = "rbxassetid://11419713569",
			})
		end)

		print("[MASTERS] Received a " .. tostring(payload.type) .. " share from " .. senderName)
	end

	-- watch for other players standing at the share signal position
	task.spawn(function()
		local lastCheck = {}
		while true do
			task.wait(0.5)
			for _, p in ipairs(Players:GetPlayers()) do
				if p.UserId ~= MyUserId then
					local char = p.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					if hrp and (hrp.Position - SHARE_SIGNAL_POS).Magnitude <= SHARE_SIGNAL_RADIUS then
						if not lastCheck[p.UserId] or os.clock() - lastCheck[p.UserId] > 8 then
							lastCheck[p.UserId] = os.clock()
							task.spawn(Share_Ingest, p.UserId)
						end
					end
				end
			end
		end
	end)

	-- polling fallback: guarantees delivery even when the teleport signal is outside
	-- the receiver's streaming radius (big maps)
	task.spawn(function()
		while true do
			task.wait(6)
			for _, p in ipairs(Players:GetPlayers()) do
				if p.UserId ~= MyUserId then
					task.spawn(Share_Ingest, p.UserId)
				end
			end
			-- cross-server: ask the API who shared to me most recently
			if SHARE_API_URL ~= "" then
				pcall(function()
					local res = request({ Url = SHARE_API_URL .. "/api/share?to=" .. tostring(MyUserId), Method = "GET" })
					if type(res) == "table" and res.Success and res.Body and res.Body ~= "" then
						local payload = Http:JSONDecode(res.Body)
						if type(payload) == "table" and tonumber(payload.from) then
							task.spawn(Share_Ingest, tonumber(payload.from))
						end
					end
				end)
			end
		end
	end)

	H.FetchSharedWithYou = function()
		return DeepCopy(Store.SharedWithYou)
	end

	H.IsShared = function(Type, Identifier)
		local total, latest = 0, nil
		for _, it in ipairs(Store.SharedWithYou) do
			if it.Type == Type and it.Identifier == Identifier then
				total += 1
				if not latest or it.TimeSent > latest.TimeSent then latest = it end
			end
		end
		if not latest then return false end
		return { TotalCount = total, LatestSender = latest.Sender, LatestDate = latest.TimeSent }
	end

	H.SaveReceiver = function(UserId)
		if type(UserId) ~= "number" or UserId == 0 then return end
		local rr = Store.RecentReceivers
		local idx = table.find(rr, UserId)
		if idx then table.remove(rr, idx) end
		table.insert(rr, 1, UserId)
		while #rr > 5 do table.remove(rr) end
		Save()
	end

	H.FetchRecentReceivers = function()
		return DeepCopy(Store.RecentReceivers)
	end

	local Share_OrigGetPlaylist = H.GetPlaylistByPlaylistId
	H.GetPlaylistByPlaylistId = function(CreatorId, PlaylistId)
		local found = Share_OrigGetPlaylist(CreatorId, PlaylistId)
		if found then return found end
		local received = Store.ReceivedPlaylists[tostring(PlaylistId)] or Store.ReceivedPlaylists[tostring(CreatorId)]
		if received then return DeepCopy(received) end
		return nil
	end

	-- [[ COMMUNITY LYRICS: live lyrics from the Masters API ]]
	local RemoteLyricsIndex = {}
	local RemoteLyricsIndexCount = -1
	local RemoteLyricsCache = {}
	local LiveLyricsAnnounced = nil

	local function Lyrics_FetchRemote(Key)
		Key = tostring(Key)
		if SHARE_API_URL == "" then return nil end
		local body
		local ok, res = pcall(request, {
			Url = SHARE_API_URL .. "/api/lyrics?songId=" .. Key,
			Method = "GET",
		})
		if ok and type(res) == "table" and res.Success and res.Body and res.Body ~= "" then
			body = res.Body
		end
		if body then
			local ok2, doc = pcall(function() return Http:JSONDecode(body) end)
			if ok2 and type(doc) == "table" and type(doc.Lyrics) == "table" then
				RemoteLyricsCache[Key] = doc
				print("[MASTERS] Downloaded community lyrics for " .. Key .. " (" .. #doc.Lyrics .. " lines)")
				return doc
			end
		end
		print("[MASTERS] No community lyrics found for " .. Key)
		RemoteLyricsCache[Key] = false
		return nil
	end

	local function Lyrics_RefreshIndex()
		if SHARE_API_URL == "" then return end
		local ok, res = pcall(request, { Url = SHARE_API_URL .. "/api/lyrics", Method = "GET" })
		if ok and type(res) == "table" and res.Success and res.Body then
			local ok2, data = pcall(function() return Http:JSONDecode(res.Body) end)
			if ok2 and type(data) == "table" and type(data.ids) == "table" then
				local idx = {}
				for _, id in ipairs(data.ids) do
					idx[tostring(id)] = true
					-- a song that had no lyrics before may have them now
					if RemoteLyricsCache[tostring(id)] == false then
						RemoteLyricsCache[tostring(id)] = nil
					end
				end
				local n = 0
				for _ in pairs(idx) do n += 1 end
				if n ~= RemoteLyricsIndexCount then
					RemoteLyricsIndexCount = n
					print("[MASTERS] Community lyrics index updated: " .. n .. " song(s)")
				end
				RemoteLyricsIndex = idx
				-- deletions: drop cached docs for ids no longer in the index so
				-- removed lyrics disappear without a rejoin
				local Qd = rawget(_G, "Queue")
				local cur = Qd and tostring(Qd.GetCurrentSongId() or 0) or "0"
				for key, cached in pairs(RemoteLyricsCache) do
					if cached and not idx[key] and not _G.ALL_LYRICS[key] then
						RemoteLyricsCache[key] = nil
						print("[MASTERS] Community lyrics for " .. key .. " were removed")
						if key == cur and Qd then
							pcall(function() Qd.TrackChanged:Fire(tonumber(key), "MastersLyricsRefresh") end)
						end
					end
				end
			end
		end
	end

	-- override the local-only lyric handlers with remote-aware versions
	-- (handlers must never yield: remote fetches happen in background tasks)
	H.GetLyricsIndex = function()
		local idx = {}
		for songId in pairs(_G.ALL_LYRICS) do
			idx[tostring(songId)] = tostring(songId)
		end
		for songId in pairs(RemoteLyricsIndex) do
			idx[songId] = songId
		end
		return idx
	end

	H.GetLyrics = function(Key)
		Key = tostring(Key)
		local localSet = _G.ALL_LYRICS[Key]
		if localSet then return localSet end
		local cached = RemoteLyricsCache[Key]
		if cached then return cached end
		if cached == nil and RemoteLyricsIndex[Key] then
			RemoteLyricsCache[Key] = false -- claim, so only one fetch runs
			task.spawn(function()
				RemoteLyricsCache[Key] = nil
				if Lyrics_FetchRemote(Key) then
					local Q = rawget(_G, "Queue")
					if Q and tostring(Q.GetCurrentSongId()) == Key and LiveLyricsAnnounced ~= Key then
						LiveLyricsAnnounced = Key
						pcall(function() Q.TrackChanged:Fire(tonumber(Key), "MastersLyricsRefresh") end)
					end
				end
			end)
		end
		return nil
	end

	-- notify everyone when new community lyrics are published for any song
	local LyricsSeenIds = {}
	for id in pairs(Store.SeenLyrics) do
		LyricsSeenIds[tostring(id)] = true
	end
	local LyricsIndexInitialized = false

	local function Lyrics_AnnounceNew(Key)
		local title, artist
		pcall(function()
			local meta = game:GetService("AssetService"):GetAudioMetadataAsync({tonumber(Key)})
			if meta and meta[1] then
				title = meta[1].Title
				artist = meta[1].Artist
			end
		end)
		local desc
		if title and title ~= "" then
			desc = "\"" .. title .. "\"" .. ((artist and artist ~= "") and (" by " .. artist) or "") .. " just got synced lyrics!"
		else
			desc = "A new song just got synced lyrics!"
		end
		pcall(function()
			Alerts.BannerNotify({
				Header = "New Lyrics Published",
				Description = desc,
				Icon = "rbxassetid://11419713569",
			})
		end)
		print("[MASTERS] New community lyrics for " .. tostring(Key) .. (title and (" - " .. title) or ""))
	end

	local function Lyrics_AnnounceCatchUp(NewIds)
		local titles = {}
		pcall(function()
			local numeric = {}
			for _, id in ipairs(NewIds) do table.insert(numeric, tonumber(id)) end
			local meta = game:GetService("AssetService"):GetAudioMetadataAsync(numeric)
			for i, m in ipairs(meta or {}) do
				if m and m.Title and m.Title ~= "" then titles[i] = m.Title end
			end
		end)
		local names = {}
		for i, id in ipairs(NewIds) do
			table.insert(names, titles[i] or tostring(id))
			if #names == 4 and #NewIds > 4 then break end
		end
		local desc
		if #NewIds == 1 then
			desc = names[1] .. " got synced lyrics while you were away!"
		else
			local extra = #NewIds - #names
			desc = table.concat(names, ", ") .. (extra > 0 and (" and " .. extra .. " more") or "")
				.. " got synced lyrics while you were away!"
		end
		pcall(function()
			Alerts.BannerNotify({
				Header = "New Lyrics Available",
				Description = desc,
				Icon = "rbxassetid://11419713569",
			})
		end)
		print("[MASTERS] " .. #NewIds .. " song(s) received lyrics since last session")
	end

	-- Lyrics FM: every song that currently has lyrics, local or community-published
	H.GetLocalStations = function()
		local ids, seen = {}, {}
		for key in pairs(_G.ALL_LYRICS) do
			local n = tonumber(key)
			if n and not seen[n] then
				seen[n] = true
				table.insert(ids, n)
			end
		end
		for key in pairs(RemoteLyricsIndex) do
			local n = tonumber(key)
			if n and not seen[n] then
				seen[n] = true
				table.insert(ids, n)
			end
		end
		table.sort(ids)
		return {
			{
				StationId = 1,
				Name = "Masters Radio",
				Description = "Your local favorites",
				Cover = "",
				Updated = os.time(),
				Songs = { 138396969938984, 127620431924902, 6910191685 },
			},
			{
				StationId = 2,
				Name = "Lyrics FM",
				Description = #ids .. " songs with synced lyrics",
				Cover = "",
				Updated = os.time(),
				Songs = ids,
			},
		}
	end

	-- keep the community index fresh, and live-push newly published lyrics
	-- to whoever is listening to that song right now
	task.spawn(function()
		if SHARE_API_URL == "" then return end
		while true do
			Lyrics_RefreshIndex()
			local newIds, seenChanged = {}, false
			for id in pairs(RemoteLyricsIndex) do
				if not LyricsSeenIds[id] then
					LyricsSeenIds[id] = true
					Store.SeenLyrics[id] = true
					seenChanged = true
					if not _G.ALL_LYRICS[id] then
						table.insert(newIds, id)
					end
				end
			end
			if seenChanged then Save() end
			if #newIds > 0 then
				if LyricsIndexInitialized then
					for _, id in ipairs(newIds) do
						task.spawn(Lyrics_AnnounceNew, id)
					end
				else
					task.spawn(Lyrics_AnnounceCatchUp, newIds)
				end
			end
			LyricsIndexInitialized = true
			local Q = rawget(_G, "Queue")
			if Q then
				local cur = tostring(Q.GetCurrentSongId() or 0)
				if cur ~= "0" and cur ~= "" and not _G.ALL_LYRICS[cur]
					and RemoteLyricsIndex[cur] and LiveLyricsAnnounced ~= cur then
					if RemoteLyricsCache[cur] or Lyrics_FetchRemote(cur) then
						LiveLyricsAnnounced = cur
						print("[MASTERS] Community lyrics arrived for the current song - refreshing")
						pcall(function() Q.TrackChanged:Fire(tonumber(cur), "MastersLyricsRefresh") end)
					end
				end
			end
			task.wait(20)
		end
	end)

	MastersBackend.Store = Store
	MastersBackend.Handlers = H
	MastersBackend.Storage = storage
	MastersBackend.Handle = function(remoteName, ...)
		local h = H[remoteName]
		if h then
			return true, h(...)
		end
		return false
	end

	-- End-of-song watcher: auto-advance the queue when a track finishes
	task.spawn(function()
		local Q
		for _ = 1, 1200 do
			Q = rawget(_G, "Queue")
			if Q then break end
			task.wait(0.5)
		end
		if not Q then return end

		-- shuffle with a single song crossfades into itself, exactly like looping
		if not rawget(Q, "__singleShufflePatch") then
			rawset(Q, "__singleShufflePatch", true)
			local origNext = Q.Next
			Q.Next = function(...)
				local handled = false
				pcall(function()
					local st = Q.GetState()
					local vq = Q.GetVisualQueue()
					if st.Settings and st.Settings.Shuffle and st.Settings.RepeatMode ~= "Song"
						and (#vq.Queue + #vq.ContinuePlaying) <= 1 then
						local old = st.Settings.RepeatMode
						st.Settings.RepeatMode = "Song"
						-- Next only reads RepeatMode at its start; run it in its own thread
						-- (its TrackChanged handlers can block for seconds) and restore fast
						task.spawn(function()
							pcall(origNext)
						end)
						task.wait(0.25)
						st.Settings.RepeatMode = old
						pcall(function()
							Q.StatusChanged:Fire({
								IsLoading = st.IsLoading,
								IsCrossfading = st.IsCrossfading,
								IsPaused = st.IsPaused,
								CurrentSong = st.CurrentSongId,
								ContextName = st.ContextName,
								Settings = {
									RepeatMode = st.Settings.RepeatMode,
									Shuffle = st.Settings.Shuffle,
								},
							})
						end)
						handled = true
					end
				end)
				if handled then return end
				return origNext(...)
			end
		end

		local lastSound
		local lastAdvance = 0
		while true do
			task.wait(0.25)
			local ok, s = pcall(Q.GetActiveSound)
			-- crossfade means starting the next song BEFORE this one ends
			if ok and typeof(s) == "Instance" and s.IsPlaying
				and not Q.GetCrossfadingStatus() and not Q.GetLoadingStatus() then
				local tl = s.TimeLength
				local pb = Store.Settings and Store.Settings.Playback
				local cf = (pb and pb.Crossfade and pb.Crossfade.Enabled)
					and math.clamp(tonumber(pb.Crossfade.Duration) or 0, 0, 10) or 0
				if cf > 0 and tl > cf * 2 and tl - s.TimePosition <= cf and tl - s.TimePosition > 0.1
					and os.clock() - lastAdvance > cf + 1 then
					-- with repeat off and nothing else to play, stop at the end instead of wrapping
					local qs2 = Q.GetState()
					if qs2.Settings.RepeatMode == "Song" or qs2.Settings.Shuffle or #qs2.MasterList > 1 or #qs2.Queue > 0 then
						lastAdvance = os.clock()
						task.spawn(Q.Next)
					end
				end
			end
			if ok and typeof(s) == "Instance" and s ~= lastSound then
				lastSound = s
				s.Ended:Connect(function()
					if os.clock() - lastAdvance < 1 then return end
					if Q.GetActiveSound() ~= s then return end
					if Q.GetLoadingStatus() or Q.GetCrossfadingStatus() then return end
					task.wait(0.1)
					if s.IsPlaying then return end
					lastAdvance = os.clock()
					local qs2 = Q.GetState()
					if qs2.Settings.RepeatMode ~= "Song" and not qs2.Settings.Shuffle and #qs2.MasterList <= 1 and #qs2.Queue == 0 then
						return
					end
					Q.Next()
				end)
			end
		end
	end)

	task.spawn(function()
		local Q
		for _ = 1, 1200 do
			Q = rawget(_G, "Queue")
			if Q then break end
			task.wait(0.5)
		end
		if not Q or not Q.TrackChanged then return end
		local lastId
		Q.TrackChanged:Connect(function(SongId, reason)
			if reason == "MastersLyricsRefresh" then return end
			lastId = SongId
			task.defer(function()
				local ok, s = pcall(Q.GetActiveSound)
				if ok and typeof(s) == "Instance" and s.TimePosition > 0.5 then
					s.TimePosition = 0
				end
			end)
		end)
	end)

	-- [[ LISTENING PRESENCE: see what other players are listening to ]]
	local PresenceListeners = {}
	local PresenceAnnounced = {} -- "<uid>:<songId>" -> true, one banner per pair

	local function Presence_CheckCurrent()
		local Q = rawget(_G, "Queue")
		if not Q then return end
		local cur = tostring(Q.GetCurrentSongId() or 0)
		if cur == "0" or cur == "" then return end
		for _, p in ipairs(PresenceListeners) do
			if tostring(p.songId) == cur then
				local key = tostring(p.uid) .. ":" .. cur
				if not PresenceAnnounced[key] then
					PresenceAnnounced[key] = true
					local title
					pcall(function()
						local meta = game:GetService("AssetService"):GetAudioMetadataAsync({tonumber(cur)})
						if meta and meta[1] and meta[1].Title ~= "" then title = meta[1].Title end
					end)
					pcall(function()
						Alerts.BannerNotify({
							Header = tostring(p.name) .. " is listening too",
							Description = (title or ("Song " .. cur)) .. " is playing for "
								.. tostring(p.name) .. " right now - open Stations to copy their queue.",
							Icon = "rbxassetid://11419713569",
						})
					end)
					print("[MASTERS] " .. tostring(p.name) .. " is also listening to " .. cur)
				end
			end
		end
	end

	-- one station per live listener; playing it copies their queue
	do
		local prevStations = H.GetLocalStations
		H.GetLocalStations = function()
			local list = prevStations()
			for i, p in ipairs(PresenceListeners) do
				local ids = {}
				for _, id in ipairs(p.ids or {}) do
					local n = tonumber(id)
					if n then table.insert(ids, n) end
				end
				if #ids > 0 then
					table.insert(list, {
						StationId = 9000 + i,
						Name = "\u{266B} " .. tostring(p.name),
						Description = "Listening now"
							.. ((p.ctx and p.ctx ~= "") and (" to " .. tostring(p.ctx)) or "")
							.. " - " .. #ids .. " song(s). Play to copy their queue.",
						Cover = "",
						Updated = os.time(),
						Songs = ids,
					})
				end
			end
			return list
		end
	end

	-- the native Listeners panel (queue view): players listening to the same song,
	-- with Copy Queue and Skip to Timestamp
	H.GetListeners = function()
		local map = {}
		for _, p in ipairs(PresenceListeners) do
			local uid = tonumber(p.uid)
			if uid then
				local qlist = {}
				for _, id in ipairs(p.ids or {}) do
					local n = tonumber(id)
					if n then table.insert(qlist, { Id = n }) end
				end
				map[tostring(uid)] = {
					CurrentSoundId = tonumber(p.songId),
					Name = tostring(p.name or uid),
					Queue = {},
					ContinuePlaying = qlist,
				}
			end
		end
		return map
	end
	H.GetCurrentTimestamp = function(UserId, SongId)
		for _, p in ipairs(PresenceListeners) do
			if tonumber(p.uid) == tonumber(UserId) and tostring(p.songId) == tostring(SongId) then
				return math.max(0, (tonumber(p.pos) or 0) + (p._stale or 0) + (os.clock() - (p._rx or os.clock())))
			end
		end
		return 0
	end

	-- [[ FOLLOW PLAYER: mirror another listener's skips, seeks and pauses ]]
	local FollowTargetUid, FollowTargetName
	local FollowMisses = 0
	local FollowLastLoad = 0

	local function Presence_StopFollow(reason)
		if not FollowTargetUid then return end
		local name = FollowTargetName or "player"
		FollowTargetUid, FollowTargetName, FollowMisses = nil, nil, 0
		pcall(function()
			Alerts.BannerNotify({
				Header = "Stopped following " .. name,
				Description = reason or "You are back in control of your player.",
				Icon = "rbxassetid://11419713569",
			})
		end)
		print("[MASTERS] Stopped following " .. name .. (reason and (" - " .. reason) or ""))
	end

	local function Presence_ApplyFollow()
		if not FollowTargetUid then return end
		local target
		for _, p in ipairs(PresenceListeners) do
			if tonumber(p.uid) == FollowTargetUid then target = p break end
		end
		if not target then
			FollowMisses += 1
			if FollowMisses >= 4 then
				Presence_StopFollow((FollowTargetName or "They") .. " stopped listening.")
			end
			return
		end
		FollowMisses = 0
		local Q = rawget(_G, "Queue")
		if not Q then return end
		local est = math.max(0, (tonumber(target.pos) or 0)
			+ (target.paused and 0 or ((target._stale or 0) + (os.clock() - (target._rx or os.clock())))))
		if tostring(Q.GetCurrentSongId() or 0) ~= tostring(target.songId) then
			-- they skipped: load their queue at their track
			if os.clock() - FollowLastLoad < 2 then return end
			FollowLastLoad = os.clock()
			local ids = {}
			for _, id in ipairs(target.ids or {}) do
				local n = tonumber(id)
				if n then table.insert(ids, n) end
			end
			local ptr = 1
			for i, n in ipairs(ids) do
				if tostring(n) == tostring(target.songId) then ptr = i break end
			end
			if #ids == 0 then
				ids = { tonumber(target.songId) }
				ptr = 1
			end
			if not ids[1] then return end
			task.spawn(function()
				pcall(function()
					Q.LoadSource(ids, ptr, "Following " .. tostring(FollowTargetName or ""), true)
					for _ = 1, 40 do
						task.wait(0.25)
						local s = Q.GetActiveSound()
						if typeof(s) == "Instance" and s.TimeLength > 0 then
							s.TimePosition = math.min(est + 1, math.max(0, s.TimeLength - 1))
							break
						end
					end
				end)
			end)
			return
		end
		-- same song: mirror pause state and position
		local s = Q.GetActiveSound()
		if typeof(s) ~= "Instance" then return end
		local myPaused = Q.GetPausedStatus() and true or false
		if target.paused and not myPaused then
			pcall(Q.Pause)
		elseif not target.paused and myPaused then
			pcall(Q.Resume)
		elseif not target.paused and math.abs(s.TimePosition - est) > 2 then
			s.TimePosition = math.min(est, math.max(0, s.TimeLength - 1))
		end
	end

	rawset(_G, "MastersOnlineListeners", function()
		local out = {}
		for _, p in ipairs(PresenceListeners) do
			local uid = tonumber(p.uid)
			if uid then
				table.insert(out, { UserId = uid, Name = tostring(p.name or uid), Ctx = tostring(p.ctx or ""), SongId = tonumber(p.songId) or 0 })
			end
		end
		return out
	end)
	rawset(_G, "MastersFollowTarget", function() return FollowTargetUid, FollowTargetName end)
	rawset(_G, "MastersFollow", function(uid, name)
		uid = tonumber(uid)
		if not uid then return end
		if FollowTargetUid == uid then
			Presence_StopFollow()
			return false
		end
		FollowTargetUid, FollowTargetName, FollowMisses = uid, tostring(name or uid), 0
		pcall(function()
			Alerts.BannerNotify({
				Header = "Following " .. FollowTargetName,
				Description = "Your player now mirrors their skips, seeks and pauses. Click them again to unfollow.",
				Icon = "rbxassetid://12974407511",
			})
		end)
		print("[MASTERS] Now following " .. FollowTargetName .. " (" .. uid .. ")")
		task.spawn(Presence_ApplyFollow)
		return true
	end)

	-- heartbeat: publish what I'm listening to (the API expires it after 45s).
	-- Sent every 20s, plus immediately on skip/seek/pause so followers react fast.
	local PresenceSocket = nil -- live relay websocket, or nil when polling
	local Presence_LastBeat = 0
	local Presence_LastHttpBeat = 0
	local Presence_BeatPending = false
	local function Presence_SendBeat()
		if SHARE_API_URL == "" and not PresenceSocket then return end
		-- coalesce instead of dropping: a beat inside the window goes out when it expires
		local minGap = PresenceSocket and 0.3 or 2
		local since = os.clock() - Presence_LastBeat
		if since < minGap then
			if not Presence_BeatPending then
				Presence_BeatPending = true
				task.delay(minGap - since + 0.05, function()
					Presence_BeatPending = false
					Presence_SendBeat()
				end)
			end
			return
		end
		Presence_LastBeat = os.clock()
		pcall(function()
			local lp = game:GetService("Players").LocalPlayer
			local Q = rawget(_G, "Queue")
			local s = Q and Q.GetActiveSound()
			if Q and typeof(s) == "Instance" and tostring(Q.GetCurrentSongId() or 0) ~= "0" then
				local st = Q.GetState()
				local ids = {}
				for _, id in ipairs(st.MasterList or {}) do
					table.insert(ids, tostring(id))
					if #ids >= 100 then break end
				end
				local body = Http:JSONEncode({
					uid = lp.UserId,
					name = (lp.DisplayName ~= "" and lp.DisplayName) or lp.Name,
					songId = tostring(st.CurrentSongId or 0),
					pos = s.TimePosition,
					paused = st.IsPaused and true or false,
					ids = ids,
					ptr = st.Pointer or 1,
					ctx = tostring(st.ContextName or ""),
				})
				if PresenceSocket then
					pcall(function() PresenceSocket:Send(body) end)
				end
				-- HTTP stays the durable copy; with the relay up it only needs a 20s keepalive
				if SHARE_API_URL ~= "" and (not PresenceSocket or os.clock() - Presence_LastHttpBeat >= 20) then
					Presence_LastHttpBeat = os.clock()
					request({
						Url = SHARE_API_URL .. "/api/presence",
						Method = "POST",
						Headers = { ["Content-Type"] = "application/json" },
						Body = body,
					})
				end
			end
		end)
	end
	task.spawn(function()
		if SHARE_API_URL == "" then return end
		while true do
			Presence_SendBeat()
			task.wait(20)
		end
	end)
	-- instant beats: seek, pause/resume, track change (position jump)
	task.spawn(function()
		if SHARE_API_URL == "" then return end
		local lastPos, lastCheck, lastPaused
		while true do
			task.wait(0.25)
			pcall(function()
				local Q = rawget(_G, "Queue")
				local s = Q and Q.GetActiveSound()
				if not (Q and typeof(s) == "Instance") then
					lastPos = nil
					return
				end
				local pos = s.TimePosition
				local paused = Q.GetPausedStatus() and true or false
				local now = os.clock()
				if lastPos and lastCheck and math.abs((pos - lastPos) - (paused and 0 or (now - lastCheck))) > 1.5 then
					task.spawn(Presence_SendBeat)
				end
				if lastPaused ~= nil and paused ~= lastPaused then
					task.spawn(Presence_SendBeat)
				end
				lastPos, lastCheck, lastPaused = pos, now, paused
			end)
		end
	end)

	-- [[ PRESENCE RELAY: instant beats over a websocket when the relay is reachable ]]
	local PRESENCE_WS_URL = ""
	pcall(function()
		if isfile("MastersPresenceWS.txt") then
			local u = string.gsub(readfile("MastersPresenceWS.txt"), "%s+", "")
			if u ~= "" then PRESENCE_WS_URL = u end
		end
	end)

	local function Presence_Remove(uid)
		uid = tonumber(uid)
		if not uid then return end
		for i, e in ipairs(PresenceListeners) do
			if tonumber(e.uid) == uid then
				table.remove(PresenceListeners, i)
				break
			end
		end
	end

	local function Presence_Upsert(beat)
		if type(beat) ~= "table" or not tonumber(beat.uid) then return end
		local lp = game:GetService("Players").LocalPlayer
		if tonumber(beat.uid) == lp.UserId then return end
		beat._rx = os.clock()
		beat._stale = 0
		for i, e in ipairs(PresenceListeners) do
			if tonumber(e.uid) == tonumber(beat.uid) then
				PresenceListeners[i] = beat
				return
			end
		end
		table.insert(PresenceListeners, beat)
	end

	local function Presence_LyricsPush(data)
		local key = tostring(data.songId)
		if type(data.doc) == "table" and type(data.doc.Lyrics) == "table" and #data.doc.Lyrics > 0 then
			RemoteLyricsCache[key] = data.doc -- the whole document rode the relay
		else
			RemoteLyricsCache[key] = nil -- too big for a frame: ping only, fetch over HTTP
		end
		RemoteLyricsIndex[key] = true
		if not LyricsSeenIds[key] then
			LyricsSeenIds[key] = true
			Store.SeenLyrics[key] = true
			pcall(Save)
			if not _G.ALL_LYRICS[key] then
				task.spawn(Lyrics_AnnounceNew, key)
			end
		end
		local Q = rawget(_G, "Queue")
		if Q and tostring(Q.GetCurrentSongId() or 0) == key then
			if RemoteLyricsCache[key] or Lyrics_FetchRemote(key) then
				print("[MASTERS] Live lyrics arrived over the relay - refreshing")
				pcall(function() Q.TrackChanged:Fire(tonumber(key), "MastersLyricsRefresh") end)
			end
		end
	end

	local function Presence_LyricsRemoved(key)
		RemoteLyricsIndex[key] = nil
		if RemoteLyricsCache[key] then
			RemoteLyricsCache[key] = nil
			print("[MASTERS] Community lyrics for " .. key .. " were removed (live)")
			local Q = rawget(_G, "Queue")
			if Q and tostring(Q.GetCurrentSongId() or 0) == key then
				pcall(function() Q.TrackChanged:Fire(tonumber(key), "MastersLyricsRefresh") end)
			end
		end
	end

	if PRESENCE_WS_URL ~= "" then
		task.spawn(function()
			while true do
				local ok, ws = pcall(function() return WebSocket.connect(PRESENCE_WS_URL) end)
				if ok and ws then
					local closed = false
					local okWire = pcall(function()
						ws.OnMessage:Connect(function(msg)
							local ok2, data = pcall(function() return Http:JSONDecode(msg) end)
							if not ok2 or type(data) ~= "table" then return end
							if data.type == "left" then
								Presence_Remove(data.uid)
								return
							end
							if data.type == "share" then
								if tonumber(data.to) == game:GetService("Players").LocalPlayer.UserId and tonumber(data.uid) then
									task.spawn(Share_Ingest, tonumber(data.uid))
								end
								return
							end
							if data.type == "lyrics" and data.songId then
								task.spawn(Presence_LyricsPush, data)
								return
							end
							if data.type == "lyrics_removed" and data.songId then
								task.spawn(Presence_LyricsRemoved, tostring(data.songId))
								return
							end
							if data.type == "snapshot" then
								for _, beat in ipairs(data.beats or {}) do
									Presence_Upsert(beat)
								end
							elseif data.uid then
								Presence_Upsert(data)
							else
								return
							end
							task.spawn(Presence_CheckCurrent)
							task.spawn(Presence_ApplyFollow)
						end)
						ws.OnClose:Connect(function()
							closed = true
						end)
					end)
					if okWire then
						PresenceSocket = ws
						print("[MASTERS] Presence relay connected - live updates on")
						task.spawn(Presence_SendBeat)
						local lastPing = os.clock()
						while not closed do
							task.wait(1)
							if os.clock() - lastPing >= 30 then
								lastPing = os.clock()
								local okPing = pcall(function() ws:Send("ping") end)
								if not okPing then break end
							end
						end
						PresenceSocket = nil
						print("[MASTERS] Presence relay disconnected - back to polling")
					end
					pcall(function() ws:Close() end)
				end
				task.wait(10)
			end
		end)
	end

	-- poll: who else is listening right now
	task.spawn(function()
		if SHARE_API_URL == "" then return end
		local lp = game:GetService("Players").LocalPlayer
		while true do
			pcall(function()
				local res = request({ Url = SHARE_API_URL .. "/api/presence", Method = "GET" })
				if res and res.Success and res.Body then
					local data = Http:JSONDecode(res.Body)
					if type(data) == "table" and type(data.listeners) == "table" then
						local fresh = {}
						for _, p in ipairs(data.listeners) do
							if tonumber(p.uid) ~= lp.UserId then
								p._rx = os.clock()
								-- age of the heartbeat at receive time, from the server's own clock
								p._stale = (tonumber(data.now) and tonumber(p.t))
									and math.max(0, (data.now - p.t) / 1000) or 0
								table.insert(fresh, p)
							end
						end
						PresenceListeners = fresh
						Presence_CheckCurrent()
						Presence_ApplyFollow()
					end
				end
			end)
			task.wait((FollowTargetUid and not PresenceSocket) and 4 or 15)
		end
	end)

	-- and check the moment my own track changes
	task.spawn(function()
		local Q
		for _ = 1, 1200 do
			Q = rawget(_G, "Queue")
			if Q then break end
			task.wait(0.5)
		end
		if not Q or not Q.TrackChanged then return end
		Q.TrackChanged:Connect(function(_songId, reason)
			if reason == "MastersLyricsRefresh" then return end
			task.defer(Presence_CheckCurrent)
			task.defer(Presence_SendBeat)
		end)
		if Q.StatusChanged then
			pcall(function()
				Q.StatusChanged:Connect(function()
					task.defer(Presence_SendBeat)
				end)
			end)
		end
	end)

	-- [[ ISLAND LYRICS v3: the dynamic island merged with a lyric card.
	--    right-click the island toggles it, hold right-click and drag resizes.
	--    background = average colour of the song's cover, pulsing with the beat ]]
	task.spawn(function()
		local Q
		for _ = 1, 1200 do
			Q = rawget(_G, "Queue")
			if Q then break end
			task.wait(0.5)
		end
		if not Q then return end

		local okBar, Bar = pcall(function()
			return ui.Interface.Frame.Bar
		end)
		if not okBar or not Bar then return end

		local IslandFrame = Bar.Parent
		-- only the island code ever writes this frame's Size (Masters sizes ui.Interface
		-- instead), so the value at init is the designed size and must be restored
		-- whenever the island is not stretching the Bar pill
		local origFrameSize = IslandFrame.Size
		local origInterfaceImgT = ui.Interface.ImageTransparency

		local state = Store.IslandLyrics
		state.Width = math.clamp(tonumber(state.Width) or 380, 280, 800)
		state.Height = math.clamp(tonumber(state.Height) or 240, 140, 600)

		-- Masters re-animates the Interface shadow image; force it off while the card is open
		ui.Interface:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
			if state.Expanded and ui.Interface.ImageTransparency < 0.99 then
				ui.Interface.ImageTransparency = 1
			end
		end)

		local baseH, baseS, baseV = 0, 0, 0.06

		local panel = Instance.new("Frame")
		panel.Name = "IslandLyrics"
		panel.AnchorPoint = Vector2.new(0.5, 0)
		panel.Size = UDim2.fromOffset(state.Width, state.Expanded and state.Height or 0)
		panel.BackgroundColor3 = Color3.fromHSV(baseH, baseS, baseV)
		panel.BorderSizePixel = 0
		panel.Visible = false
		panel.Active = true -- sink mouse input so right-drag resize does not rotate the camera
		panel.ClipsDescendants = true
		panel.ZIndex = 0 -- behind the Interface so the island pill renders on top of the card
		Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 18)

		local shade = Instance.new("Frame")
		shade.Name = "Shade"
		shade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		shade.BackgroundTransparency = 0.55
		shade.BorderSizePixel = 0
		shade.Size = UDim2.fromScale(1, 1)
		shade.ZIndex = 2
		Instance.new("UICorner", shade).CornerRadius = UDim.new(0, 18)
		local grad = Instance.new("UIGradient")
		grad.Rotation = 90
		grad.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0.35),
		})
		grad.Parent = shade
		shade.Parent = panel

		-- the pill's living glow, cloned so the card shifts colours exactly like the island
		local glow
		pcall(function()
			glow = Bar.Util.Visual:Clone()
			glow.Name = "Glow"
			glow.Size = UDim2.fromScale(1, 1)
			glow.Position = UDim2.fromScale(0, 0)
			glow.AnchorPoint = Vector2.new(0, 0)
			glow.ZIndex = 1
			local c = glow:FindFirstChild("corner")
			if c then c.CornerRadius = UDim.new(0, 18) end
			glow.Parent = panel
		end)

		local scroll = Instance.new("ScrollingFrame")
		scroll.Name = "Scroll"
		scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0
		scroll.Size = UDim2.fromScale(1, 1)
		scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		scroll.CanvasSize = UDim2.new()
		scroll.ScrollBarThickness = 0
		scroll.ScrollingEnabled = true
		scroll.ClipsDescendants = true
		scroll.ZIndex = 3
		local spad = Instance.new("UIPadding")
		spad.PaddingTop = UDim.new(0, 64)
		spad.PaddingBottom = UDim.new(0, 120)
		spad.PaddingLeft = UDim.new(0, 18)
		spad.PaddingRight = UDim.new(0, 18)
		spad.Parent = scroll
		local slist = Instance.new("UIListLayout")
		slist.SortOrder = Enum.SortOrder.LayoutOrder
		slist.Padding = UDim.new(0, 6)
		slist.Parent = scroll
		scroll.Parent = panel

		local noLyrics = Instance.new("TextLabel")
		noLyrics.Name = "NoLyrics"
		noLyrics.BackgroundTransparency = 1
		noLyrics.Position = UDim2.new(0, 0, 0, 40)
		noLyrics.Size = UDim2.new(1, 0, 1, -40)
		noLyrics.Font = Enum.Font.GothamMedium
		noLyrics.TextSize = 15
		noLyrics.TextColor3 = Color3.fromRGB(255, 255, 255)
		noLyrics.TextTransparency = 0.45
		noLyrics.Text = "No lyrics for this song."
		noLyrics.ZIndex = 4
		noLyrics.Visible = true
		noLyrics.Parent = panel

		-- bottom controls: seek + prev / play / next (right-click the bottom strip to hide or show)
		local function fmtTime(sec)
			sec = math.max(0, math.floor(tonumber(sec) or 0))
			return ("%d:%02d"):format(sec / 60, sec % 60)
		end

		local controls = Instance.new("Frame")
		controls.Name = "Controls"
		controls.BackgroundTransparency = 1
		controls.Active = true
		controls.AnchorPoint = Vector2.new(0.5, 1)
		controls.Position = UDim2.new(0.5, 0, 1, -6)
		controls.Size = UDim2.new(1, -40, 0, 80)
		controls.ZIndex = 4
		controls.Visible = state.Controls ~= false
		controls.Parent = panel

		local timeCur = Instance.new("TextLabel")
		timeCur.Name = "TimeCur"
		timeCur.BackgroundTransparency = 1
		timeCur.Size = UDim2.fromOffset(40, 12)
		timeCur.Position = UDim2.new(0, 0, 0, 0)
		timeCur.Font = Enum.Font.GothamMedium
		timeCur.TextSize = 11
		timeCur.TextColor3 = Color3.fromRGB(255, 255, 255)
		timeCur.TextTransparency = 0.35
		timeCur.TextXAlignment = Enum.TextXAlignment.Left
		timeCur.Text = "0:00"
		timeCur.ZIndex = 5
		timeCur.Parent = controls

		local timeTot = timeCur:Clone()
		timeTot.Name = "TimeTot"
		timeTot.AnchorPoint = Vector2.new(1, 0)
		timeTot.Position = UDim2.new(1, 0, 0, 0)
		timeTot.TextXAlignment = Enum.TextXAlignment.Right
		timeTot.Parent = controls

		-- the genuine Masters watermark, with the glowing Crossfading state
		local musicStatus
		pcall(function()
			musicStatus = ui.Interface.Frame.Full.NowPlaying.Content.Media.Timeline.Data.MusicStatus:Clone()
			musicStatus.Name = "MusicStatus"
			musicStatus.Size = UDim2.fromOffset(90, 16)
			musicStatus.AnchorPoint = Vector2.new(0.5, 1)
			-- parented to the panel (not the controls strip) so the watermark stays
			-- visible even when the controls are hidden
			musicStatus.Position = UDim2.new(0.5, 0, 1, -4)
			musicStatus.ZIndex = 5
			local sc = Instance.new("UIScale")
			sc.Scale = 1.35
			sc.Parent = musicStatus
			musicStatus.Parent = panel
			TweenService:Create(musicStatus.Crossfading.gradient, crossfading_loop, {Offset = Vector2.new(1, 0)}):Play()
		end)

		local seekTrack = Instance.new("Frame")
		seekTrack.Name = "Seek"
		seekTrack.Active = true
		seekTrack.BackgroundTransparency = 1
		seekTrack.AnchorPoint = Vector2.new(0.5, 0)
		seekTrack.Position = UDim2.new(0.5, 0, 0, -6)
		seekTrack.Size = UDim2.new(1, -96, 0, 26)
		seekTrack.ZIndex = 5
		local seekVisual = Instance.new("Frame")
		seekVisual.Name = "Track"
		seekVisual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		seekVisual.BackgroundTransparency = 0.72
		seekVisual.BorderSizePixel = 0
		seekVisual.AnchorPoint = Vector2.new(0.5, 0.5)
		seekVisual.Position = UDim2.new(0.5, 0, 0.5, 0)
		seekVisual.Size = UDim2.new(1, 0, 0, 8)
		seekVisual.ZIndex = 5
		Instance.new("UICorner", seekVisual).CornerRadius = UDim.new(1, 0)
		local seekFill = Instance.new("Frame")
		seekFill.Name = "Fill"
		seekFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		seekFill.BackgroundTransparency = 0.05
		seekFill.BorderSizePixel = 0
		seekFill.Size = UDim2.fromScale(0, 1)
		seekFill.ZIndex = 6
		Instance.new("UICorner", seekFill).CornerRadius = UDim.new(1, 0)
		seekFill.Parent = seekVisual
		seekVisual.Parent = seekTrack
		seekTrack.Parent = controls

		local scrubbing, scrubRel, volScrubbing = false, nil, false
		seekTrack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				scrubbing = true
			end
		end)

		local volTrack = Instance.new("Frame")
		volTrack.Name = "Volume"
		volTrack.Active = true
		volTrack.BackgroundTransparency = 1
		volTrack.AnchorPoint = Vector2.new(0, 1)
		volTrack.Position = UDim2.new(0, 0, 1, 0)
		volTrack.Size = UDim2.new(0, 84, 0, 24)
		volTrack.ZIndex = 5
		local volVisual = Instance.new("Frame")
		volVisual.Name = "Track"
		volVisual.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		volVisual.BackgroundTransparency = 0.72
		volVisual.BorderSizePixel = 0
		volVisual.AnchorPoint = Vector2.new(0, 0.5)
		volVisual.Position = UDim2.new(0, 0, 0.5, 0)
		volVisual.Size = UDim2.new(1, 0, 0, 6)
		volVisual.ZIndex = 5
		Instance.new("UICorner", volVisual).CornerRadius = UDim.new(1, 0)
		local volFill = Instance.new("Frame")
		volFill.Name = "Fill"
		volFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		volFill.BackgroundTransparency = 0.05
		volFill.BorderSizePixel = 0
		volFill.Size = UDim2.fromScale(0.5, 1)
		volFill.ZIndex = 6
		Instance.new("UICorner", volFill).CornerRadius = UDim.new(1, 0)
		volFill.Parent = volVisual
		volVisual.Parent = volTrack
		volTrack.Parent = controls
		volTrack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				volScrubbing = true
			end
		end)

		local controlButtons
		pcall(function()
			controlButtons = ui.Interface.Frame.Full.NowPlaying.Content.Media.Playback:Clone()
			controlButtons.Name = "Buttons"
			controlButtons.AnchorPoint = Vector2.new(0.5, 1)
			controlButtons.Position = UDim2.new(0.5, 0, 1, -16)
			controlButtons.Size = UDim2.new(0, 200, 0, 40)
			controlButtons.Parent = controls
		end)

		if controlButtons then
			controlButtons.PlayPause.MouseButton1Click:Connect(function()
				local snd = Q.GetActiveSound()
				if not snd then return end
				local qs = Q.GetState()
				if snd.IsPlaying then
					qs.IsPaused = false
					Q.Pause()
				else
					qs.IsPaused = true
					Q.Resume()
					task.wait(0.1)
					if not snd.IsPlaying then
						snd.TimePosition = 0
						snd:Play()
						qs.IsPaused = false
					end
				end
			end)
			controlButtons.Forward.MouseButton1Click:Connect(function()
				Q.Next()
			end)
			controlButtons.Rewind.MouseButton1Click:Connect(function()
				Q.Previous()
			end)
		end

		-- loop + shuffle in the right corner
		local loopBtn, shuffleBtn
		pcall(function()
			local qo = ui.Interface.Frame.Full.NowPlaying.Content.Panel.QueueOptions
			shuffleBtn = qo.Shuffle:Clone()
			local f1 = shuffleBtn:FindFirstChild("flex")
			if f1 then f1:Destroy() end
			shuffleBtn.AnchorPoint = Vector2.new(1, 1)
			shuffleBtn.Position = UDim2.new(1, 0, 1, 0)
			shuffleBtn.Size = UDim2.fromOffset(34, 34)
			shuffleBtn.ZIndex = 5
			shuffleBtn.Parent = controls
			loopBtn = qo.Queue:Clone()
			local f2 = loopBtn:FindFirstChild("flex")
			if f2 then f2:Destroy() end
			loopBtn.AnchorPoint = Vector2.new(1, 1)
			loopBtn.Position = UDim2.new(1, -40, 1, 0)
			loopBtn.Size = UDim2.fromOffset(34, 34)
			loopBtn.ZIndex = 5
			loopBtn.Parent = controls
		end)
		if shuffleBtn then
			shuffleBtn.MouseButton1Click:Connect(function()
				Q.ToggleShuffle()
			end)
		end
		if loopBtn then
			loopBtn.MouseButton1Click:Connect(function()
				Q.ToggleRepeat()
			end)
		end

		panel.Parent = ui

		-- average colour of the song's cover; falls back to the Masters gradient code
		local CoverColorCache = {}
		local function AverageCoverColor(songId)
			local key = tostring(songId)
			if CoverColorCache[key] then return CoverColorCache[key] end
			local color
			pcall(function()
				local AS = game:GetService("AssetService")
				local img = AS:CreateEditableImageAsync(Content.fromUri(Utilities.GetCoverForSong(tonumber(songId))), {Size = Vector2.new(32, 32)})
				local size = img.Size
				local buf = img:ReadPixelsBuffer(Vector2.zero, size)
				local r, g, b, n = 0, 0, 0, 0
				local len = buffer.len(buf)
				for o = 0, len - 4, 16 do
					r += buffer.readu8(buf, o)
					g += buffer.readu8(buf, o + 1)
					b += buffer.readu8(buf, o + 2)
					n += 1
				end
				if n > 0 then
					color = Color3.fromRGB(r / n, g / n, b / n)
				end
				img:Destroy()
			end)
			-- a failed read gets a neutral dark, never a wrong colour
			color = color or Color3.fromRGB(32, 32, 35)
			CoverColorCache[key] = color
			return color
		end

		local function SetBaseColor(songId)
			task.spawn(function()
				local c = AverageCoverColor(songId)
				local h, s, v = c:ToHSV()
				baseH, baseS, baseV = h, math.min(s * 1.05, 1), math.clamp(v * 0.55, 0.12, 0.5)
			end)
		end

		local function reposition()
			local absPos, absSize = Bar.AbsolutePosition, Bar.AbsoluteSize
			local view = camera.ViewportSize
			local half = state.Width / 2
			local cx = math.clamp(absPos.X + absSize.X / 2, half + 8, math.max(half + 8, view.X - half - 8))
			local inset = ui.IgnoreGuiInset and GuiService.TopbarInset.Height or 0
			local y = math.clamp(absPos.Y + inset + 6, 4, math.max(4, view.Y - 8 - state.Height))
			panel.Position = UDim2.fromOffset(cx, y)
			spad.PaddingTop = UDim.new(0, math.floor(absSize.Y + 10))
		end

		local function applySize(instant)
			local target = UDim2.fromOffset(state.Width, state.Expanded and state.Height or 0)
			if instant then
				panel.Size = target
			else
				TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = target}):Play()
			end
		end

		local function applyPillWidth(tweened)
			pcall(function()
				Bar.NowPlaying.Art.Shadow.Visible = not state.Expanded
				Bar.Tucked.Art.Shadow.Visible = not state.Expanded
				ui.Interface.Layer.Visible = not state.Expanded
				ui.Interface.ImageTransparency = state.Expanded and 1 or math.max(origInterfaceImgT, 0.8)
			end)
			local base = origFrameSize or IslandFrame.Size
			local target = state.Expanded
				and UDim2.new(0, math.max(220, state.Width), base.Y.Scale, base.Y.Offset)
				or base
			if tweened then
				TweenService:Create(IslandFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = target}):Play()
			else
				IslandFrame.Size = target
			end
		end
		if state.Expanded then
			local inBar0 = false
			pcall(function() inBar0 = Main.GetState() == "Bar" end)
			if inBar0 and Bar.Visible then
				applyPillWidth(false)
			end
		end

		local function bringIslandOnScreen()
			local view = camera.ViewportSize
			local frameSize = ui.Interface.AbsoluteSize
			local half = math.max(state.Width / 2, frameSize.X / 2)
			local cx = math.clamp(Bar.AbsolutePosition.X + Bar.AbsoluteSize.X / 2, half + 8, math.max(half + 8, view.X - half - 8))
			local rawCenterY = ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height + frameSize.Y / 2
			local cy = math.clamp(rawCenterY, frameSize.Y / 2 + 14, math.max(frameSize.Y / 2 + 14, view.Y - state.Height - 24))
			pcall(function()
				Bar.page:JumpTo(Bar.NowPlaying)
			end)
			TweenService:Create(ui.Interface, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Position = UDim2.new(0, cx, 0, cy)}):Play()
		end

		local function toggle()
			state.Expanded = not state.Expanded
			if state.Expanded then
				bringIslandOnScreen()
				reposition()
				panel.Size = UDim2.fromOffset(state.Width, 0)
				panel.Visible = true
				task.spawn(function()
					for _ = 1, 20 do
						if not state.Expanded then break end
						reposition()
						task.wait(0.05)
					end
				end)
			end
			applySize(false)
			applyPillWidth(true)
			Save()
		end
		rawset(_G, "MastersIslandToggle", toggle)

		-- right-click: quick release toggles; holding and dragging resizes.
		-- resize uses mouse DELTAS - the position freezes when Roblox locks the
		-- cursor for right-drag, which is why position math never worked.
		local ScrollProps = { Threshold = 0 }
		local pressed, dragging, accum, startW, startH, pressAt, pressScreenPos = false, false, Vector2.zero, 0, 0, 0, nil
		local function pointOver(gui, pos)
			if not gui.Visible then return false end
			local view = camera.ViewportSize
			local topLeft = gui.AbsolutePosition
			local size = gui.AbsoluteSize
			-- the live cursor gives one exact position (screen space); testing both Y spaces
			-- created a phantom 58px band that grabbed right-clicks near the island
			local m = InputService:GetMouseLocation()
			local px = m.X
			local py = m.Y - GuiService.TopbarInset.Height
			-- clamp to the viewport so a tucked, half-off-screen island keeps a clickable sliver
			local x1 = math.clamp(topLeft.X - 4, 0, view.X)
			local x2 = math.clamp(topLeft.X + size.X + 4, 0, view.X)
			if px < x1 or px > x2 or x1 >= x2 then return false end
			return py >= topLeft.Y - 4 and py <= topLeft.Y + size.Y + 4
		end
		local function inBottomZone(pos)
			if not (panel.Visible and state.Expanded) then return false end
			local m = InputService:GetMouseLocation()
			local px = m.X
			local py = m.Y - GuiService.TopbarInset.Height
			local tl, size = panel.AbsolutePosition, panel.AbsoluteSize
			if px < tl.X or px > tl.X + size.X then return false end
			return py >= tl.Y + size.Y - 76 and py <= tl.Y + size.Y + 4
		end
		InputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				-- island gestures only exist in Bar mode; a drag must never scale the full interface
				local inBar = false
				pcall(function() inBar = Main.GetState() == "Bar" end)
				if not inBar or not Bar.Visible then return end
				local pos = Vector2.new(input.Position.X, input.Position.Y)
				if pointOver(Bar, pos) or (panel.Visible and state.Expanded and pointOver(panel, pos)) then
					pressed = true
					pressAt = os.clock()
					pressScreenPos = pos
					dragging = false
					accum = Vector2.zero
					startW, startH = state.Width, state.Height
				end
			end
		end)
		InputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseWheel then
				if panel.Visible and state.Expanded and pointOver(panel, Vector2.new(input.Position.X, input.Position.Y)) then
					ScrollProps.Threshold = 240
				end
			end
			if pressed and input.UserInputType == Enum.UserInputType.MouseMovement then
				accum += Vector2.new(input.Delta.X, input.Delta.Y)
				if not dragging and accum.Magnitude > 8 then
					dragging = true
					if not state.Expanded then
						state.Expanded = true
						reposition()
						panel.Visible = true
					end
				end
				if dragging then
					state.Width = math.clamp(startW + accum.X, 280, 800)
					state.Height = math.clamp(startH + accum.Y, 140, 600)
					applySize(true)
					applyPillWidth(false)
					reposition()
				end
			end
		end)
		InputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				if scrubbing and scrubRel then
					pcall(function()
						local snd = Q.GetActiveSound()
						if snd and snd.TimeLength > 0 then
							snd.TimePosition = scrubRel * snd.TimeLength
						end
					end)
					ScrollProps.Threshold = 0
				end
				scrubbing = false
				scrubRel = nil
				volScrubbing = false
			end
			if input.UserInputType == Enum.UserInputType.MouseButton2 and pressed then
				pressed = false
				if dragging then
					dragging = false
					Save()
				elseif os.clock() - pressAt < 0.4 then
					if pressScreenPos and inBottomZone(pressScreenPos) then
						state.Controls = not controls.Visible
						controls.Visible = state.Controls
						Save()
					else
						toggle()
					end
				end
			end
		end)

		-- item building + the genuine Masters lyric animation + the beat pulse
		local ActiveIsland = {}
		local hb = nil

		local function clearItems()
			if hb then
				hb:Disconnect()
				hb = nil
			end
			for _, d in pairs(ActiveIsland) do
				pcall(function() d.Item:Destroy() end)
			end
			table.clear(ActiveIsland)
		end

		local function build(songId, set)
			clearItems()
			scroll.CanvasPosition = Vector2.new(0, 0)

			for i, LineData in ipairs(set and set.Lyrics or {}) do
				local Item
				if LineData.Line == "" then
					if (LineData.TimeEnd or 0) - (LineData.TimeStart or 0) > 5 then
						Item = ui.Storage.Items.GapItem:Clone()
					else
						continue
					end
				elseif LineData.Line == "..." then
					Item = ui.Storage.Items.GapItem:Clone()
				else
					if set.Unsynced then
						Item = ui.Storage.Items.LyricsAdlibItem:Clone()
						Item.Text = LineData.Line
						Item.TextSize = 14
						Item.TextTransparency = 0
					else
						Item = ui.Storage.Items.LyricsItem:Clone()
						Item.MainLyrics.Text = LineData.Line
						if LineData.RightAligned then
							Item.MainLyrics.TextXAlignment = Enum.TextXAlignment.Right
						end
						if LineData.Id == "CERTIFICATION" then
							Item.MainLyrics.TextSize = 14
							Item.MainLyrics.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
						end
					end
				end

				Item.Name = LineData.Id
				Item.LayoutOrder = i
				Item.Parent = scroll

				if not set.Unsynced and LineData.TimeStart then
					pcall(function()
						Item.MouseButton1Click:Connect(function()
							-- no seeking from lyrics hidden under the open controls strip
							if controls.Visible then
								local m = InputService:GetMouseLocation()
								local stripTop = panel.AbsolutePosition.Y + panel.AbsoluteSize.Y - 96
								if (m.Y - GuiService.TopbarInset.Height) >= stripTop then
									return
								end
							end
							local s = Q.GetActiveSound()
							if s then
								s.TimePosition = LineData.TimeStart
								ScrollProps.Threshold = 0
							end
						end)
					end)
				end

				ActiveIsland[tostring(LineData.Id) .. "#" .. i] = {
					Item = Item,
					TimeStart = LineData.TimeStart,
					TimeEnd = LineData.TimeEnd,
				}
			end

			hb = RunService.Heartbeat:Connect(function(Delta)
				if not panel.Visible then return end
				local sound = Q.GetActiveSound()
				if not sound then return end

				-- the beat pulse: cover-average colour, brightness driven by loudness
				local pulse = 1
				if sound.IsPlaying then
					pulse = Utilities.Map(sound.PlaybackLoudness, 0, 800, 0.85, 1.35)
				end
				local targetColor = Color3.fromHSV(baseH, baseS, math.clamp(baseV * pulse, 0.05, 0.8))
				panel.BackgroundColor3 = panel.BackgroundColor3:Lerp(targetColor, math.clamp(Delta * 10, 0, 1))

				if glow then
					pcall(function()
						local live = Bar.Util.Visual
						glow.GroupTransparency = live.GroupTransparency
						glow.Saturation.GroupColor3 = live.Saturation.GroupColor3
						glow.Noise.Image = live.Noise.Image
						glow.Noise.ImageTransparency = live.Noise.ImageTransparency
						glow.Noise.scale.Scale = live.Noise.scale.Scale
						for _, name in {"Visual_A", "Visual_B"} do
							local mine, theirs = glow.Saturation[name], live.Saturation[name]
							mine.Image = theirs.Image
							mine.ImageTransparency = theirs.ImageTransparency
							mine.Position = theirs.Position
							mine.AnchorPoint = theirs.AnchorPoint
							mine.scale.Scale = theirs.scale.Scale
						end
					end)
				end

				if controls.Visible then
					pcall(function()
						local tl = sound.TimeLength
						if tl > 0 then
							if scrubbing then
								-- visual-only while dragging; the seek applies once on release
								local m = InputService:GetMouseLocation()
								scrubRel = math.clamp((m.X - seekTrack.AbsolutePosition.X) / math.max(1, seekTrack.AbsoluteSize.X), 0, 1)
								seekFill.Size = UDim2.fromScale(scrubRel, 1)
								timeCur.Text = fmtTime(scrubRel * tl)
							else
								seekFill.Size = UDim2.fromScale(math.clamp(sound.TimePosition / tl, 0, 1), 1)
								timeCur.Text = fmtTime(sound.TimePosition)
							end
							timeTot.Text = fmtTime(tl)
						end
						if volScrubbing then
							local m = InputService:GetMouseLocation()
							Playback.Volume = math.clamp((m.X - volTrack.AbsolutePosition.X) / math.max(1, volTrack.AbsoluteSize.X), 0, 1) * 2
						end
						volFill.Size = UDim2.fromScale(math.clamp(Playback.Volume / 2, 0, 1), 1)
						if musicStatus then
							if Q.GetCrossfadingStatus() then
								Smoothness.ApproachInHeartbeat(musicStatus.Masters, "ImageTransparency", 1, Delta, slow)
								Smoothness.ApproachInHeartbeat(musicStatus.Crossfading, "ImageTransparency", .5, Delta, slow)
							else
								Smoothness.ApproachInHeartbeat(musicStatus.Masters, "ImageTransparency", .5, Delta, slow)
								Smoothness.ApproachInHeartbeat(musicStatus.Crossfading, "ImageTransparency", 1, Delta, slow)
							end
						end
						if controlButtons then
							local liveIcon = ui.Interface.Frame.Full.NowPlaying.Content.Media.Playback.PlayPause.Icon
							for _, n in {"ThrobberIcon", "PlayIcon", "PauseIcon"} do
								controlButtons.PlayPause.Icon[n].ImageTransparency = liveIcon[n].ImageTransparency
							end
						end
						local qo = ui.Interface.Frame.Full.NowPlaying.Content.Panel.QueueOptions
						if shuffleBtn then
							shuffleBtn.BackgroundTransparency = qo.Shuffle.BackgroundTransparency
						end
						if loopBtn then
							loopBtn.BackgroundTransparency = qo.Queue.BackgroundTransparency
						end
					end)
				end

				if not set or set.Unsynced then return end

				local ActiveLine
				local CurrentTime = sound.TimePosition

				for _, Data in pairs(ActiveIsland) do
					if not Data.Item or not Data.Item.Parent then continue end
					if Data.TimeStart and Data.TimeEnd and CurrentTime >= Data.TimeStart and CurrentTime <= Data.TimeEnd then
						if Data.Item:HasTag("MastersGapItem") then
							local ProgressX = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, 0, 1)
							local ScaleSize = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, .6, 1.2)
							local GlowIntensity = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, 1, .9)

							Smoothness.ApproachInHeartbeat(Data.Item, "Size", UDim2.new(1, 0, 0, 72), Delta, slow)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.scale, "Scale", ScaleSize, Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Fill, "Size", UDim2.fromScale(ProgressX, 1), Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Background, "ImageTransparency", .9, Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Glow, "ImageTransparency", GlowIntensity, Delta, normal)
						else
							local ml = Data.Item:FindFirstChild("MainLyrics")
							if ml then
								Smoothness.ApproachInHeartbeat(ml, "TextTransparency", 0, Delta, smooth)
							end
							local lst = Data.Item:FindFirstChild("list")
							if lst then
								Smoothness.ApproachInHeartbeat(lst, "Padding", UDim.new(0, 10), Delta, normal)
							end
						end
						ActiveLine = Data
					else
						if Data.Item:HasTag("MastersGapItem") then
							Smoothness.ApproachInHeartbeat(Data.Item, "Size", UDim2.new(1, 0, 0, 0), Delta, slow)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.scale, "Scale", .6, Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Fill, "Size", UDim2.fromScale(0, 1), Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Background, "ImageTransparency", 1, Delta, normal)
							Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Glow, "ImageTransparency", 1, Delta, normal)
						else
							local ml = Data.Item:FindFirstChild("MainLyrics")
							if ml then
								Smoothness.ApproachInHeartbeat(ml, "TextTransparency", .9, Delta, smooth)
							end
							local lst = Data.Item:FindFirstChild("list")
							if lst then
								Smoothness.ApproachInHeartbeat(lst, "Padding", UDim.new(0, -10), Delta, normal)
							end
						end
					end

					if Data.Item:HasTag("MastersGapItem") then
						local sc = Data.Item:FindFirstChild("scale")
						if sc then sc.Scale = 1 end
					elseif Data.Item.Name ~= "CERTIFICATION" then
						local ml = Data.Item:FindFirstChild("MainLyrics")
						if ml then ml.TextSize = 26 end
					end
				end

				if ActiveLine and ActiveLine.Item and ActiveLine.Item.Parent then
					ScrollProps.Threshold -= 1
					if ScrollProps.Threshold < 1 then
						local TargetY = ActiveLine.Item.AbsolutePosition.Y - scroll.AbsolutePosition.Y + scroll.CanvasPosition.Y - (scroll.AbsoluteWindowSize.Y / 2 - ActiveLine.Item.AbsoluteSize.Y / 2)
						TargetY = math.clamp(TargetY, 0, math.max(0, scroll.AbsoluteCanvasSize.Y - scroll.AbsoluteWindowSize.Y))
						Smoothness.ApproachInHeartbeat(scroll, "CanvasPosition", Vector2.new(0, TargetY), Delta,
							TweenInfo.new(2, Enum.EasingStyle.Exponential))
					end
				end
			end)
		end

		-- maintenance: follow the island, rebuild on song change, resolve lyrics
		local lastKey = nil
		while true do
			task.wait(0.1)
			local inBarState = true
			pcall(function() inBarState = Main.GetState() == "Bar" end)
			if not inBarState or not Bar.Visible or Bar.AbsoluteSize.X < 10 then
				if panel.Visible then panel.Visible = false end
				-- undo any island stretch so the full interface always opens at its designed size
				if IslandFrame.Size ~= origFrameSize then
					IslandFrame.Size = origFrameSize
				end
			elseif state.Expanded and not panel.Visible then
				panel.Visible = true
				applyPillWidth(false)
			end
			if panel.Visible and state.Expanded then
				reposition()
				local songId = tostring(Q.GetCurrentSongId() or 0)
				local set = _G.ALL_LYRICS[songId]
				if not set then
					local cached = RemoteLyricsCache[songId]
					if type(cached) == "table" then
						set = cached
					elseif cached == nil and RemoteLyricsIndex[songId] then
						RemoteLyricsCache[songId] = false
						task.spawn(function()
							RemoteLyricsCache[songId] = nil
							Lyrics_FetchRemote(songId)
						end)
					end
				end
				local key = songId .. (set and "#lyrics" or "#none")
				if key ~= lastKey then
					lastKey = key
					if songId ~= "0" then
						SetBaseColor(songId)
					end
					if songId ~= "0" then
						-- build even with no lyrics so the heartbeat (background, seek bar,
						-- volume, watermark, buttons) keeps running; only lyric lines are skipped
						noLyrics.Visible = not set
						build(songId, set)
					else
						clearItems()
						noLyrics.Visible = true
					end
				end
			end
		end
	end)

	print("[MASTERS] Local backend initialized (" .. tostring(#Store.Playlists) .. " playlists loaded)")
end

-- 2. STABLE MOCK FRAMEWORK (RESTORED)

function create_mock(name)

	local m = { Name = name, _isMock = true, _listeners = {} }



	if true then

		local b = Instance.new("BindableEvent")

		m.Event = b.Event

		m.Connect = function(_, cb) return b.Event:Connect(cb) end

		m.Fire = function(_, ...) b:Fire(...) end

	end



	m.InvokeServer = function(self, ...)
		local __h, __a, __b, __c, __d = MastersBackend.Handle(tostring(self.Name), ...)
		if __h then return __a, __b, __c, __d end
		do return nil end 

		local args = {...}

		local remoteName = tostring(self.Name)



		-- CATCH THE CORRECT REMOTE FROM YOUR IMAGE

		-- STEP 1: The engine asks if the song has lyrics
		-- FIX: The engine needs this index table to 'validate' the song
		-- FIX: This MUST return a table where the ID is a KEY.
		-- The engine needs this to return a map of ID -> KEY
		if remoteName == "GetLyricsIndex" then
			print("returning data...")
			return { 
				["138396969938984"] = "138396969938984",
				[138396969938984] = "138396969938984" 
			}
		end

		-- The engine takes the value from above and asks for the data
		if remoteName == "GetLyrics" then
			local key = tostring(args[1])
			return _G.ALL_LYRICS[key] or _G.ALL_LYRICS["138396969938984"]
		end

		-- Keep your Algorithm/Metadata returns
		if remoteName:lower():find("algorithm") or remoteName:lower():find("metadata") then
			return Algorithm 
		end

		return Algorithm 

	end



	m.FireServer = function(self, ...)
		MastersBackend.Handle(tostring(self.Name), ...)
		do return end
		print("test")
		local args = {...}

		local data = args[1]



		local LocalSound = workspace:FindFirstChild("Masters_LocalAudio")
		
		if not LocalSound then

			LocalSound = Instance.new("Sound")

			LocalSound.Name = "Masters_LocalAudio"

			LocalSound.Parent = workspace

		end


		local isSeek, seekTime = false, 0

		if type(data) == "string" and data == "Seek" then isSeek = true; seekTime = tonumber(args[2]) or 0 end

		if type(data) == "table" and (data.Action == "Seek" or data.Type == "Seek") then isSeek = true; seekTime = tonumber(data.Time or data.Position) or 0 end



		if isSeek then 

			LocalSound.TimePosition = seekTime

			return 

		end



		if type(data) == "string" and (data == "Pause" or data == "Resume") then

			if data == "Pause" then LocalSound:Pause() else LocalSound:Resume() end

			return

		end



		local targetId = (type(data) == "table" and (data.Id or data.SongId)) or data

		if tonumber(targetId) then _G.CurrentSongId = tonumber(targetId) end



		LocalSound.SoundId = "rbxassetid://" .. tostring(_G.CurrentSongId)

		LocalSound.Volume = 

			LocalSound:Play()



		task.spawn(function()

			local duration = 137

			if _G.CurrentSongId == 127620431924902 then duration = 177 end

			self:_InternalFire({

				Id = _G.CurrentSongId, AudioId = "rbxassetid://" .. tostring(_G.CurrentSongId),

				Name = "Masters Track", Artist = "Masters",

				IsStream = true, IsPlaying = true,

				Time = 0, TotalTime = duration, StartTime = tick()       

			})

		end)

	end



	m.OnClientEvent = { Connect = function(self, cb) table.insert(m._listeners, cb); return {Disconnect = function() end} end }

	m._InternalFire = function(self, ...) for _, cb in ipairs(m._listeners) do task.spawn(cb, ...) end end

	m.WaitForChild = function(self, k) return self[k] end

	m.FindFirstChild = function(self, k) return self[k] end



	setmetatable(m, {__index = function(t, k)

		if rawget(t, k) then return rawget(t, k) end

		local new = create_mock(tostring(k))

		rawset(t, k, new)

		return new

	end})

	return m

end

-- [[ BINDABLE WIRING: no __namecall / require hooks. The Handler UI talks to the
-- in-process mock (create_mock) which already routes to the backend; the game's
-- MODULES use the real Events instances, which the loader has converted to
-- Bindables — we connect each of those straight to the backend dispatcher here.
-- Nothing installs a metamethod hook, so remote-spy / namecall anticheats see nothing. ]]
local function WireBindable(inst)
	if inst:IsA("BindableFunction") then
		inst.OnInvoke = function(...)
			local res = table.pack(MastersBackend.Handle(inst.Name, ...))
			if res[1] then return table.unpack(res, 2, res.n) end
			return nil
		end
	elseif inst:IsA("BindableEvent") then
		inst.Event:Connect(function(...)
			MastersBackend.Handle(inst.Name, ...)
		end)
	end
end
if MastersBackend.Storage then
	for _, inst in ipairs(MastersBackend.Storage:GetDescendants()) do
		WireBindable(inst)
	end
	MastersBackend.Storage.DescendantAdded:Connect(WireBindable)
end

-- LyricsEngine/Audios legacy shim (formerly the require hook): keep the modules'
-- direct-call lyric fields pointing at the community lyrics for the current song
task.spawn(function()
	local rs = game:GetService("ReplicatedStorage")
	local modsFolder = rs:FindFirstChild("Masters(Storage)")
	modsFolder = modsFolder and modsFolder:FindFirstChild("Modules")
	if not modsFolder then return end
	for _, nm in ipairs({"LyricsEngine", "Audios"}) do
		pcall(function()
			local inst = modsFolder:FindFirstChild(nm)
			local mod = inst and _G.MastersRequire and _G.MastersRequire(inst)
			if type(mod) == "table" then
				local function Sync()
					local Q = rawget(_G, "Queue")
					local key = Q and tostring(Q.GetCurrentSongId() or 0) or "0"
					local data = _G.ALL_LYRICS[key] or _G.ALL_LYRICS["138396969938984"]
					mod.CurrentLyricsLoaded = data
					return data
				end
				mod.GetLyricsAsync = Sync
				mod.FetchLyrics = Sync
				Sync()
			end
		end)
	end
end)
-- [[ 0. THE MATH PATCH (Fixes the 0s and NaNs) ]]
pcall(function()
	local realRS = game:GetService("ReplicatedStorage")
	local utils = require(realRS["Masters(Storage)"].Modules.Utilities)

	-- Fix FormatTime crashes (Prevents the "non-negative number" red error)
	local oldFormat = utils.FormatTime
	utils.FormatTime = function(seconds)
		if type(seconds) ~= "number" or seconds ~= seconds or seconds < 0 then 
			seconds = 0 
		end
		return oldFormat(seconds)
	end

	-- Fix Map returning 0 or NaN when dragging
	local oldMap = utils.Map
	utils.Map = function(val, inMin, inMax, outMin, outMax)
		-- If TimeLength is 0 during playback mapping, fake it to 243 (Midnight City duration)
		if inMin == 0 and outMin == 0 and outMax == 1 and (inMax == 0 or inMax ~= inMax) then 
			inMax = 243 
		end

		-- If TimeLength is 0 during drag mapping, fake it to 243
		if inMin == 0 and inMax == 1 and outMin == 0 and (outMax == 0 or outMax ~= outMax) then 
			outMax = 243 
		end
		--print("DEBUG: Mapping", val, "from", inMin, inMax, "to", outMin, outMax)
		if math.floor(val) == math.floor(outMax) then
			--print("DEBUG: Loop check")
		end
		if math.floor(val) == math.floor(outMin) then
			--print("DEBUG: Loop check 1")
		end
		if math.floor(val) == math.floor(inMax) then
			--print("DEBUG: Loop check 2")
		end
		if math.floor(val) == math.floor(inMin) then
			--print("DEBUG: Loop check 3")
		end
		-- Range Safety
		if inMin == inMax then return outMin end

		local res = oldMap(val, inMin, inMax, outMin, outMax)

		-- Final NaN Check
		if type(res) ~= "number" or res ~= res then 
			return outMin 
		end

		return res
	end
end)
local MockRS = create_mock("ReplicatedStorage")

local RealGame = game

local game_mock = setmetatable({}, {

	__index = function(t, k)

		if k == "ReplicatedStorage" then return MockRS end

		if k == "GetService" then 

			return function(_, s) 

				if s == "ReplicatedStorage" then return MockRS end 

				return RealGame:GetService(s) 

			end 

		end

		return RealGame[k]

	end

})

local game = game_mock

local events = MockRS["Masters(Storage)"].Events



-- 3. THE REQUIRE HOOK (RESTORED)

local original_require = require

local require = function(obj)

	local success, result = pcall(original_require, obj)

	if not success or type(result) ~= "table" then return original_require(obj) end



	local name = (typeof(obj) == "Instance" and obj.Name) or ""



	-- MATH FIX: Stops the Dragger NaN Crash

	if name == "Utilities" and not result._hasMockedMap then

		result._hasMockedMap = true

		local oldMap = result.Map

		if oldMap then

			result.Map = function(val, inMin, inMax, outMin, outMax)

				if inMax == 0 or inMax ~= inMax then inMax = 1 end

				if outMax == 0 or outMax ~= outMax then outMax = 1 end

				if inMin == inMax then return outMin end

				local res = oldMap(val, inMin, inMax, outMin, outMax)

				if res ~= res then return outMin end

				return res

			end

		end

	end



	-- DRAGGER FIX: Forces the UI to read the physical music time

	if name == "Queue" and not result._hasMockedQueue then

		result._hasMockedQueue = true

		local oldGet = result.GetActiveSound

		if oldGet then

			result.GetActiveSound = function(...)

				local ls = workspace:FindFirstChild("Masters_LocalAudio")

				if ls then return ls end

				return oldGet(...)

			end

		end

	end



	-- LYRICS FIX: Hands the JSON directly to the UI's lyrics engine

	-- Replace the Lyrics section in your require hook with this:
	if (name == "Audios" or name == "LyricsEngine") then
		local function Sync()
			local data = _G.ALL_LYRICS["138396969938984"]
			-- Physically force the data into the module so the GUI sees it
			result.CurrentLyricsLoaded = data 
			return data
		end
		result.GetLyricsAsync = Sync
		result.FetchLyrics = Sync
		Sync() -- Run it once immediately
	end



	return result

end

--make looping work
--Players.DaniBoyNov2014.PlayerGui.Masters.Interface.Frame.Full.NowPlaying.Content.Panel.QueueOptions.Queue
-- (removed) old loopmusic hack; the pill's native handler + StatusChanged own the repeat state now
-- (removed) loopmusic TimePosition-reset loop; native RepeatMode "Song" handles looping
-- LOCALS INITIALIZATION

local SettingsPageProperties = { Data = MASTERS_DEFAULT_SETTINGS }

local AudiosLoaded = { {}, {}, {}, {} } 

local Settings_UnusedDefaults = MASTERS_DEFAULT_SETTINGS -- FIX: was shadowing the Settings module and breaking Settings.FetchSettings()



-- [[ YOUR HANDLER CODE STARTS BELOW ]]
print("✅ MASTERS EXECUTOR LOADED - ENJOY YOUR MEAL")
-- [[ END HEADER - REST OF SCRIPT BELOW ]]
local TimeScrubberData = {
	Dragging = false,
	StartPos = 0, 
	StartScale = 0   
}

local VolumeScrubberData = {
	Dragging = false,
	StartPos = 0, 
	StartScale = 0   
}

local CrossfadeDurationScrubberData = {
	Dragging = false,
	StartPos = 0, 
	StartScale = 0   
}

local ArtistPageProperties = {
	CurrentArtistLoaded = "",
	LoadingArtist = false,
	Discography = {}
}

local PlaylistPageProperties = {
	CurrentPlaylistId = "",
	CurrentPlaylistName = "",
	CurrentCreatorId = 0,
	CurrentPlaylistData = {},
	FilteringTitle = false,

	LoadingPlaylist = false,
	Songs = {},
	ToAdd = 0,

	RequestReload = Signal.new()
}

local StationPageProperties = {
	CurrentStationId = "",
	CurrentStationData = {},
	IsCurrentlyOnline = false,
	LoadingStation = false,
	Songs = {},
}

local SettingsPageProperties = {
	Changed = Signal.new(),
	HasChanged = false,
	LoadingSettings = false,
	Data = nil,
}

local DetailsPageProperties = {
	LoadingDetails = false,
	CurrentSongLoaded = 0,
	SettingsChanged = Signal.new()
}

local SearchingProperties = {
	Advancing = false,
	Cooldown = 5,
	RecentKeyword = "",
	SearchData = nil
}

local LibraryProperties = {
	Cooldown = 1,
	Initialized = false,
	Loading = false,
	ForReload = false,
	RequestReload = Signal.new(),
	PinnedChanged = Signal.new()
}

local HoverBackgroundProperties = {
	IsVisualAUsed = false
}

local NowPlayingProperties = {
	IsVisualAUsed = false,
	IsAlbumArtA = false,
	LyricsTopOffset = 20,
	TargetPosition = UDim2.fromScale(0, 0),
	TargetAnchor = Vector2.new(0, 0),
	Progress = 0,
	CurrentIndex = 1,
	Sequence = {"TopLeft", "TopRight", "Center", "BottomRight", "BottomLeft", "Center"},
	Spots = {
		{
			AnchorPoint = Vector2.new(0, 0),
			Position = UDim2.fromScale(0, 0),
			State = "TopLeft"
		},

		{
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			State = "TopRight"
		},

		{
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.fromScale(0, 1),
			State = "BottomLeft"
		},

		{
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.fromScale(1, 1),
			State = "BottomRight"
		},

		{
			AnchorPoint = Vector2.new(.5, .5),
			Position = UDim2.fromScale(.5, .5),
			State = "Center"
		},
	},
	CurrentLyricsLoaded = nil,
}

local BarProperties = {
	IsVisualAUsed = false
}

local InterfaceDragProperties = {

	-- Variables

	Padding = {Top = GuiService.TopbarInset.Height - 20, Bottom = -40, Left = -40, Right = -40},
	TuckDepth = 50,
	Tucked = false,
	SnappedTo = "None",
	MainDrag = false,
	MainCurrentlyDragged = false,
	MainDragInput = nil,
	MainDragStart = nil,
	MainStartPos = nil,

	-- Events

	DragStarted = Signal.new(),
	DragReleased = Signal.new()
}

-- Types

type SongItemProperties = {
	Container: any,
	ContextName: string,
	Item: Instance,
	ItemProperties: any,
	MasterPool: any,
	Pointer: number,
	SongInfo: any,
	Source: SongSourceType
}

type ArtistItemProperties = {
	Container: any,
	Item: Instance,
	ItemProperties: any,
	ArtistName: any,
	Source: ArtistSourceType
}

type PlaylistItemProperties = {
	Container: any,
	Item: Instance,
	ItemProperties: any,
	PlaylistData: any,
	Source: PlaylistSourceType
}

type StationItemProperties = {
	Container: any,
	Item: Instance,
	ItemProperties: any,
	StationData: any,
	Source: StationItemProperties,
	Online: boolean
}

type ArtistSourceType = "Library" | "Standard" | "Playlist" | "ArtistPage" 
type PlaylistSourceType = "Library" | "Standard" | "PlaylistPage" 
type StationItemProperties = "Standard" | "StationPage" 
type SongSourceType = "Library" | "Standard" | "Playlist" | "Queue" | "ContinuePlaying" | "NowPlaying"

type SongInfo = {
	Artist: any,
	ContextName: any,
	MasterPool: any,
	Pointer: number,
	Title: any,
	SongId: number,
	TrackingId: any,
}

-- Functions

function InitiateSettings()
	print("⚙️ Initiating Settings...")

	-- Attempt to fetch (using our Mock)
	local Data = MastersBackend.Handlers.FetchSettings()

	-- If it's a mock table with no real data, or it's nil, use the hardcoded default
	if not Data or type(Data) ~= "table" then
		warn("⚠️ Settings fetch failed or returned mock. Using hardcoded defaults.")
		Data = MASTERS_DEFAULT_SETTINGS
	end

	-- Assign the data
	SettingsPageProperties.Data = Data

	-- Verify it succeeded
	if SettingsPageProperties.Data then
		print("✅ Settings successfully initialized.")
	else
		warn("❌ Critical Error: SettingsPageProperties.Data is still nil.")
	end
end

function AutostartStation()
	local ConfigurationData = Configuration.GetConfiguration()
	if not ConfigurationData then return end

	local Station = Configuration.GetLocalStationByStationId(ConfigurationData.Stations.AutoStart)
	if not Station then return end

	Queue.LoadSource(Station.Songs, 1, Station.Name, true)
end

function GetSpotByName(Name)
	for _, Spot in NowPlayingProperties.Spots do
		if Spot.State == Name then return Spot end
	end
end

function HoverBackground(State, ImageId)
	if State then
		if HoverBackgroundProperties.IsVisualAUsed then
			HoverBackgroundProperties.IsVisualAUsed = false

			Full.Util.HoverBackground.Visual_B.Image = ImageId
			TweenService:Create(Full.Util.HoverBackground.Visual_B, normal, {ImageTransparency = 0}):Play()
		else
			HoverBackgroundProperties.IsVisualAUsed = true

			Full.Util.HoverBackground.Visual_A.Image = ImageId
			TweenService:Create(Full.Util.HoverBackground.Visual_A, normal, {ImageTransparency = 0}):Play()
		end
	else
		if HoverBackgroundProperties.IsVisualAUsed then
			TweenService:Create(Full.Util.HoverBackground.Visual_A, normal, {ImageTransparency = 1}):Play()
		else
			TweenService:Create(Full.Util.HoverBackground.Visual_B, normal, {ImageTransparency = 1}):Play()
		end
	end
end

function NowPlayingBackground(ImageId)
	local Settings = events.Main.Settings.FetchSettings:InvokeServer()

	if NowPlayingProperties.IsVisualAUsed then
		NowPlayingProperties.IsVisualAUsed = false

		NowPlaying.Util.Visual.Saturation.Visual_B.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_A, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_B, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

		else

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_A, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_B, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
		end
	else
		NowPlayingProperties.IsVisualAUsed = true

		NowPlaying.Util.Visual.Saturation.Visual_A.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_A, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_B, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()

		else

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_A, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

			TweenService:Create(NowPlaying.Util.Visual.Saturation.Visual_B, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
		end
	end
end

function NowPlayingAlbumArt(ImageId, IsCrossfading)
	local Settings = events.Main.Settings.FetchSettings:InvokeServer()

	if NowPlayingProperties.IsAlbumArtA then
		NowPlayingProperties.IsAlbumArtA = false

		NowPlaying.Content.Media.Art.Photo.ArtB.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then
			local TimeValue

			if IsCrossfading then
				TimeValue = Settings.Playback.Crossfade.Duration
			else
				TimeValue = .01
			end

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA.scale, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Sine), 
				{Scale = 1.2}):Play()

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB.scale, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Sine), 
				{Scale = 1}):Play()

		else
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA.scale, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Sine), 
				{Scale = 1.2}):Play()

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB.scale, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Sine), 
				{Scale = 1}):Play()
		end
	else

		NowPlayingProperties.IsAlbumArtA = true

		NowPlaying.Content.Media.Art.Photo.ArtA.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then
			local TimeValue

			if IsCrossfading then
				TimeValue = Settings.Playback.Crossfade.Duration
			else
				TimeValue = .01
			end

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA.scale, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Sine), 
				{Scale = 1}):Play()

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB.scale, 
				TweenInfo.new(TimeValue, Enum.EasingStyle.Sine), 
				{Scale = 1.2}):Play()

		else
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtA.scale, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Sine), 
				{Scale = 1}):Play()

			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(NowPlaying.Content.Media.Art.Photo.ArtB.scale, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Sine), 
				{Scale = 1.2}):Play()
		end
	end
end

function BarBackground(ImageId)
	local Settings = events.Main.Settings.FetchSettings:InvokeServer()

	if BarProperties.IsVisualAUsed then
		BarProperties.IsVisualAUsed = false

		Bar.Util.Visual.Saturation.Visual_B.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_A, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(Bar.Util.Visual.Saturation.Visual_B, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

		else

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_A, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
			TweenService:Create(Bar.Util.Visual.Saturation.Visual_B, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()
		end
	else
		BarProperties.IsVisualAUsed = true

		Bar.Util.Visual.Saturation.Visual_A.Image = ImageId

		if Settings.Playback.Crossfade.Enabled then

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_A, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_B, 
				TweenInfo.new(Settings.Playback.Crossfade.Duration, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()

		else

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_A, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 0}):Play()

			TweenService:Create(Bar.Util.Visual.Saturation.Visual_B, TweenInfo.new(1, Enum.EasingStyle.Linear), 
				{ImageTransparency = 1}):Play()
		end
	end
end

-- Functions / Options

local OptionInfoPresets = {
	PlayModes = {
		Play = {
			Name = "Play",
			Icon = "rbxassetid://11423157473"
		},

		PlayNext = {
			Name = "Play Next",
			Icon = "rbxassetid://12967339693"
		},

		PlayLast = {
			Name = "Play Last",
			Icon = "rbxassetid://12967340242"
		},

		ProceedHere = {
			Name = "Proceed Here",
			Icon = "rbxassetid://12967340242"
		},

		PlayAlone = {
			Name = "Play Alone",
			Icon = "rbxassetid://12967528364"
		}
	},

	Library = {
		AddToLibrary = {
			Name = "Add To Library",
			Icon = "rbxassetid://11295291707"
		},

		RemoveFromLibrary = {
			Name = "Remove From Library",
			Icon = "rbxassetid://11326877488"
		},

		Pin = {
			Name = "Pin",
			Icon = "rbxassetid://12974469173"
		},

		UndoPin = {
			Name = "Undo Pin",
			Icon = "rbxassetid://12974257382"
		}
	},

	Playlist = {
		AddToPlaylist = {
			Name = "Add To Playlist",
			Icon = "rbxassetid://11432849996"
		},

		CreatePlaylistWith = {
			Name = "Create Playlist With",
			Icon = "rbxassetid://12974227834"
		},

		RemoveFromPlaylist = {
			Name = "Remove From Playlist",
			Icon = "rbxassetid://11326877488"
		},

		EditPlaylist = {
			Name = "Edit Playlist",
			Icon = "rbxassetid://11326670192"
		},

		AddToLibrary = {
			Name = "Add To Library",
			Icon = "rbxassetid://11295291707"
		},

		CopyPlaylist = {
			Name = "Copy Playlist",
			Icon = "rbxassetid://12974407511"
		},

		SetPrivate = {
			Name = "Set to Private",
			Icon = "rbxassetid://14187755345"
		},

		SetPublic = {
			Name = "Set to Public",
			Icon = "rbxassetid://11293979388"
		},

		DeletePlaylist = {
			Name = "Delete Playlist",
			Icon = "rbxassetid://11326877488"
		}
	},

	Preferences = {
		Favorite = {
			Name = "Favorite",
			Icon = "rbxassetid://12974204015"
		},

		Dislike = {
			Name = "Dislike",
			Icon = "rbxassetid://11295273791"
		},

		UndoFavorite = {
			Name = "Undo Favorite",
			Icon = "rbxassetid://12974204015"
		},

		UndoDislike = {
			Name = "Undo Dislike",
			Icon = "rbxassetid://11295273791"
		},

		More = {
			Name = "Save",
			Icon = "rbxassetid://11422144827"
		},

		Block = {
			Name = "Block",
			Icon = "rbxassetid://11419666512"
		},

		UndoMore = {
			Name = "Undo Save",
			Icon = "rbxassetid://11422144827"
		},

		UndoBlock = {
			Name = "Undo Block",
			Icon = "rbxassetid://11419666512"
		},

	},

	Stations = {

		CopyStation = {
			Name = "Copy Station",
			Icon = "rbxassetid://12974407511"
		}
	},

	Queue = {
		ClearQueue = {
			Name = "Clear Queue",
			Icon = "rbxassetid://12966398330"
		},

		ClearContinuePlaying = {
			Name = "Clear Continue Playing",
			Icon = "rbxassetid://12966398330"
		},

		RemoveFromQueue = {
			Name = "Remove From Queue",
			Icon = "rbxassetid://11326877488"
		}
	},

	Others = {
		ViewDetails = {
			Name = "View Details",
			Icon = "rbxassetid://11422155687"
		},

		ViewArtist = {
			Name = "View Artist",
			Icon = "rbxassetid://11295273292"
		},

		ViewPlaylist = {
			Name = "View Playlist",
			Icon = "rbxassetid://11432849996"
		},

		ViewStation = {
			Name = "View Station",
			Icon = "rbxassetid://11432849777"
		},
	},

	Share = {
		ShareSong = {
			Name = "Share Song",
			Icon = "rbxassetid://11295275294"
		},

		ShareArtist = {
			Name = "Share Artist",
			Icon = "rbxassetid://11295275294"
		},

		SharePlaylist = {
			Name = "Share Playlist",
			Icon = "rbxassetid://11295275294"
		},

		ShareStation = {
			Name = "Share Station",
			Icon = "rbxassetid://11295275294"
		},
	}
}

function callback_Play(Data: SongInfo)
	Queue.LoadSource(Data.MasterPool, Data.Pointer, Data.ContextName, true)
end

function callback_PlayNext(Data: SongInfo)
	Queue.PlayNext({Data.MasterPool[Data.Pointer]})
end

function callback_PlayLast(Data: SongInfo)
	Queue.AddToQueue({Data.MasterPool[Data.Pointer]})
end

function callback_SongLibrary(Index, Data: SongInfo)
	if Index == 1 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Library.SetSong:InvokeServer(SongId, true)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Successfully Added from your Library",
				Description = "Added from your library.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})

			elseif  Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 30 songs.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Library.SetSong:InvokeServer(SongId, false)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Successfully Removed from your Library",
				Description = "Removed from your library.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end
	end
end

function callback_ArtistLibrary(Index, ArtistName)
	if Index == 1 then
		local Success, Result = events.Main.Library.SetArtist:InvokeServer(ArtistName, true)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Successfully Added from your Library",
				Description = `Added {ArtistName} to your library.`,
				Icon = "rbxassetid://11295273292"
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find artist.",
					Icon = "rbxassetid://11419709766"
				})

			elseif  Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 30 artists.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local Success, Result = events.Main.Library.SetArtist:InvokeServer(ArtistName, false)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Successfully Removed from your Library",
				Description = `Removed {ArtistName} from your library.`,
				Icon = "rbxassetid://11295273292"
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find artist.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end
	end
end

function callback_SongPlaylist(Index, SongId, PlaylistId)
	if Index == 1 then		
		local Success, Result = events.Main.Library.SetSongToPlaylist:InvokeServer(PlaylistId, SongId, true)

		if Success then
			PlaylistPageProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Added Successfully",
				Description = "This song was added to your playlist.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 30 songs per playlist.",
					Icon = "rbxassetid://11419709766"
				})

			elseif Result == "unowned" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You can't add songs to someone's playlist.",
					Icon = "rbxassetid://11419709766"
				})

			elseif Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to add song.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local Success, Result = events.Main.Library.SetSongToPlaylist:InvokeServer(PlaylistId, SongId, false)

		if Success then
			PlaylistPageProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Removed Successfully",
				Description = "This song was removed from your playlist.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to add song.",
					Icon = "rbxassetid://11419709766"
				})

			elseif Result == "unowned" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You can't remove songs from someone's playlist.",
					Icon = "rbxassetid://11419709766"
				})

			end
		end
	end
end

function callback_AddToPlaylist(SongId)
	local Options = {}

	table.insert(Options, {
		Name = OptionInfoPresets.Playlist.CreatePlaylistWith.Name,
		Icon = OptionInfoPresets.Playlist.CreatePlaylistWith.Icon,
	})

	table.insert(Options, "SEPARATOR")

	local Playlists = events.Main.Library.GetPlaylists:InvokeServer()
	if not Playlists then return end

	for i, Data in Playlists do
		table.insert(Options, {
			Name = Data.Name,
			Icon = Data.Cover,
		})
	end

	local OptionChosen = Main.PromptOptions({
		Options = Options,
		MaxOptions = 8
	})

	if OptionChosen == "Create Playlist With" then
		Main.PlaylistCreation(true)

		PlaylistPageProperties.ToAdd = SongId

	elseif OptionChosen ~= nil then
		local PlaylistId = events.Main.Library.GetPlaylistIdByName:InvokeServer(OptionChosen)
		if not PlaylistId then return end

		callback_SongPlaylist(1, SongId, PlaylistId)
	end
end

function callback_PinSong(Index, Data: SongInfo)
	if Index == 1 then
		local SongId = Data.MasterPool[Data.Pointer]

		events.Main.Library.Pin:FireServer("Song", Data.MasterPool[Data.Pointer], true)
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Pinned To Your Library",
			Description = "This song is now pinned to your library.",
			Icon = Utilities.GetCoverForSong(SongId)
		})

	elseif Index == 2 then
		local SongId = Data.MasterPool[Data.Pointer]

		events.Main.Library.Pin:FireServer("Song", Data.MasterPool[Data.Pointer], false)
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Unpinned From Your Library",
			Description = "This song was unpinned from your library.",
			Icon = Utilities.GetCoverForSong(SongId)
		})
	end
end

function callback_PinArtist(Index, ArtistName)
	if Index == 1 then
		events.Main.Library.Pin:FireServer("Artist", ArtistName, true)
		LibraryProperties.RequestReload:Fire()


		Alerts.BannerNotify({
			Header = "Pinned To Your Library",
			Description = "This artist is now pinned to your library.",
			Icon = "rbxassetid://11295273292"
		})

	elseif Index == 2 then
		events.Main.Library.Pin:FireServer("Artist", ArtistName, false)
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Unpinned From Your Library",
			Description = "This artist was unpinned from your library.",
			Icon = "rbxassetid://11295273292"
		})
	end
end

function callback_PinPlaylist(Index, PlaylistId)
	if Index == 1 then
		events.Main.Library.Pin:FireServer("Playlist", PlaylistId, true)
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Pinned To Your Library",
			Description = "This playlist is now pinned to your library.",
			Icon = "rbxassetid://11295273292"
		})

	elseif Index == 2 then
		events.Main.Library.Pin:FireServer("Playlist", PlaylistId, false)
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Unpinned From Your Library",
			Description = "This playlist was unpinned from your library.",
			Icon = "rbxassetid://11295273292"
		})
	end
end

function callback_Favorite(Index, Data: SongInfo)
	if Index == 1 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Preferences.FavoriteSong:InvokeServer(SongId, true)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Favorited",
				Description = "This song is added to your Favorites.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})

			elseif  Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 90 songs.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Preferences.FavoriteSong:InvokeServer(SongId, false)

		if Success then
			LibraryProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Favorite Undone",
				Description = "This song was removed from your Favorites.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end
	end
end

function callback_CopyOnlineStation(StationId)
	local Success, Result = events.Main.Library.CopyOnlineStation:InvokeServer(StationId)

	if Success then
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Successfully Copied",
			Description = "You've copied a station to a playlist.",
			Icon = "rbxassetid://12974407511"
		})

	elseif not Success and Result then
		if Result == "unknown" then
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "Failed to copy station.",
				Icon = "rbxassetid://11419709766"
			})

		elseif  Result == "limit" then
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "You have exceeded the maximum of 30 playlists.",
				Icon = "rbxassetid://11419709766"
			})
		end
	end
end

function callback_CopyLocalStation(StationId)
	local Success, Result = events.Main.Library.CopyLocalStation:InvokeServer(StationId)

	if Success then
		LibraryProperties.RequestReload:Fire()

		Alerts.BannerNotify({
			Header = "Successfully Copied",
			Description = "You've copied a station to a playlist.",
			Icon = "rbxassetid://12974407511"
		})

	elseif not Success and Result then
		if Result == "unknown" then
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "Failed to copy station.",
				Icon = "rbxassetid://11419709766"
			})

		elseif  Result == "limit" then
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "You have exceeded the maximum of 30 playlists.",
				Icon = "rbxassetid://11419709766"
			})
		end
	end
end

function callback_Dislike(Index, Data: SongInfo)
	if Index == 1 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Preferences.DislikeSong:InvokeServer(SongId, true)

		if Success then
			Alerts.BannerNotify({
				Header = "Disliked",
				Description = "This song will never show on your feed from now on.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})

			elseif  Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 90 songs.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local SongId = Data.MasterPool[Data.Pointer]
		local Success, Result = events.Main.Preferences.DislikeSong:InvokeServer(SongId, false)

		if Success then
			Alerts.BannerNotify({
				Header = "Dislike Undone",
				Description = "This song will be shown on your feed from now on.",
				Icon = Utilities.GetCoverForSong(SongId)
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find song.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end
	end
end

function callback_Block(Index, ArtistName)
	if Index == 1 then
		local Success, Result = events.Main.Preferences.BlockArtist:InvokeServer(ArtistName, true)

		if Success then
			Alerts.BannerNotify({
				Header = "Successfully Blocked " .. ArtistName,
				Description = "This artist is blocked.",
				Icon = "rbxassetid://11295273292"
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find artist.",
					Icon = "rbxassetid://11419709766"
				})

			elseif  Result == "limit" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "You have exceeded the maximum of 30 artists.",
					Icon = "rbxassetid://11419709766"
				})
			end
		end

	elseif Index == 2 then
		local Success, Result = events.Main.Preferences.BlockArtist:InvokeServer(ArtistName, false)

		if Success then
			Alerts.BannerNotify({
				Header = "Successfully Unblocked " .. ArtistName,
				Description = "This artist is now unblocked.",
				Icon = "rbxassetid://11295273292"
			})

		elseif not Success and Result then
			if Result == "unknown" then
				Alerts.BannerNotify({
					Header = "An Error Occurred.",
					Description = "Failed to find artist.",
					Icon = "rbxassetid://11295273292"
				})
			end
		end
	end
end

function callback_ViewArtist(ArtistName)
	if ArtistPageProperties.LoadingArtist then return end
	if DetailsPageProperties.LoadingDetails then return end
	if PlaylistPageProperties.LoadingPlaylist then return end
	if StationPageProperties.LoadingStation then return end

	local Artist = LoadArtist(ArtistName)

	if Artist then
		ArtistPageProperties.LoadingArtist = false

		Alerts.BannerNotify({
			Header = "Failed to load artist.",
			Description = "An error occurred while loading artist.",
			Icon = "rbxassetid://11433646681"
		})
	end
end

function callback_ViewDetails()
	if ArtistPageProperties.LoadingArtist then return end
	if DetailsPageProperties.LoadingDetails then return end
	if PlaylistPageProperties.LoadingPlaylist then return end
	if StationPageProperties.LoadingStation then return end

	Main.NowPlaying(false)
	LoadCurrentSongDetails()
end

function callback_ViewPlaylist(CreatorId, PlaylistId)
	if ArtistPageProperties.LoadingArtist then return end
	if DetailsPageProperties.LoadingDetails then return end
	if PlaylistPageProperties.LoadingPlaylist then return end
	if StationPageProperties.LoadingStation then return end

	LoadPlaylist(CreatorId, PlaylistId)
end

function callback_ViewStation(Online, StationId)
	if ArtistPageProperties.LoadingArtist then return end
	if DetailsPageProperties.LoadingDetails then return end
	if PlaylistPageProperties.LoadingPlaylist then return end
	if StationPageProperties.LoadingStation then return end

	if Online then
		LoadOnlineStation(StationId)
	else
		LoadLocalStation(StationId)
	end
end

function callback_ShareSong(SongId, Title, Artist)
	if not SettingsPageProperties.Data.Socials.Sharing then
		Alerts.BannerNotify({
			Header = "Sharing Disabled",
			Description = "Turn Sharing on in the setting.",
			Icon = "rbxassetid://11419713314"
		})

		return
	end

	local Receiver = Main.PromptShare({
		Title = Title,
		Subtext = Artist,
		Icon = Utilities.GetCoverForSong(SongId),
	})

	if Receiver then
		local success, result = events.Main.Sharing.Share:InvokeServer(Receiver, "Song", SongId)

		if success then
			Alerts.BannerNotify({
				Header = "Successfully Shared",
				Description = "You've shared " .. Title .. " by " .. Artist .. ".",
				Icon = "rbxassetid://11295275294"
			})
		else
			if result == "disabled" then
				Alerts.BannerNotify({
					Header = "Failed to Share",
					Description = "The person you've tried sharing with is unavailable.",
					Icon = "rbxassetid://14187755345"
				})

			elseif result == "setting disabled" then
				Alerts.BannerNotify({
					Header = "Failed to Share",
					Description = "Turn Sharing on in the settings.",
					Icon = "rbxassetid://14187755345"
				})

			else
				Alerts.BannerNotify({
					Header = "Failed to Share",
					Description = "An error occurred while sharing.",
					Icon = "rbxassetid://14187755345"
				})
			end
		end
	end
end

function callback_ShareArtist(ArtistName)
	if not SettingsPageProperties.Data.Socials.Sharing then
		Alerts.BannerNotify({
			Header = "Sharing Disabled",
			Description = "Turn Sharing on in the setting.",
			Icon = "rbxassetid://11419713314"
		})

		return
	end

	local Receiver = Main.PromptShare({
		Title = ArtistName,
		Subtext = "Artist"
	})

	if Receiver then
		local success, result = events.Main.Sharing.Share:InvokeServer(Receiver, "Artist", ArtistName)

		if success then
			Alerts.BannerNotify({
				Header = "Successfully Shared",
				Description = "You've shared " .. ArtistName .. ".",
				Icon = "rbxassetid://11295275294"
			})
		else
			if result == "disabled" then
				Alerts.BannerNotify({
					Header = "Failed to Share",
					Description = "The person you've tried sharing with is unavailable.",
					Icon = "rbxassetid://14187755345"
				})
			else
				Alerts.BannerNotify({
					Header = "Failed to Share",
					Description = "An error occurred while sharing.",
					Icon = "rbxassetid://14187755345"
				})
			end
		end
	end
end

function callback_SharePlaylist(PlaylistData)
	if not SettingsPageProperties.Data.Socials.Sharing then
		Alerts.BannerNotify({
			Header = "Sharing Disabled",
			Description = "Turn Sharing on in the setting.",
			Icon = "rbxassetid://11419713314"
		})

		return
	end

	local Receiver = Main.PromptShare({
		Title = PlaylistData.Name,
		Subtext = "Playlist",
	})

	if Receiver then
		local success1, result1 = events.Main.Library.SetPlaylistProperty:InvokeServer(PlaylistData.PlaylistId, "Private", false)

		if success1 then
			local success, result = events.Main.Sharing.Share:InvokeServer(Receiver, "Playlist", PlaylistData.PlaylistId)

			if success then
				Alerts.BannerNotify({
					Header = "Successfully Shared",
					Description = "You've shared " .. PlaylistData.Name .. ".",
					Icon = "rbxassetid://11295275294"
				})
			else
				if result == "disabled" then
					Alerts.BannerNotify({
						Header = "Failed to Share",
						Description = "The person you've tried sharing with is unavailable.",
						Icon = "rbxassetid://14187755345"
					})
				else
					Alerts.BannerNotify({
						Header = "Failed to Share",
						Description = "An error occurred while sharing.",
						Icon = "rbxassetid://14187755345"
					})
				end
			end
		else
			Alerts.BannerNotify({
				Header = "Failed to Share",
				Description = "An error occurred while sharing.",
				Icon = "rbxassetid://14187755345"
			})
		end
	end
end

-- Option Functions
print("loaded")
function PromptSongOptions(Source: SongSourceType, Data: SongInfo, Mobile)
	local VisualQueue = Queue.GetVisualQueue()
	local Options = {}

	if Source == "Standard" then
		local SongId = Data.MasterPool[Data.Pointer]
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		local IsAdded = events.Main.Library.IsSongSaved:InvokeServer(SongId)
		local IsFavorited = events.Main.Preferences.IsSongFavorite:InvokeServer(SongId)
		local IsDisliked = events.Main.Preferences.IsSongDislike:InvokeServer(SongId)

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
				Primary = true
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon,
			})
		end

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.AddToPlaylist.Name,
			Icon = OptionInfoPresets.Playlist.AddToPlaylist.Icon,
		})

		table.insert(Options, "SEPARATOR")

		if IsFavorited then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoFavorite.Name,
				Icon = OptionInfoPresets.Preferences.UndoFavorite.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Favorite.Name,
				Icon = OptionInfoPresets.Preferences.Favorite.Icon,
			})
		end

		if IsDisliked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoDislike.Name,
				Icon = OptionInfoPresets.Preferences.UndoDislike.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Dislike.Name,
				Icon = OptionInfoPresets.Preferences.Dislike.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.ShareSong.Name,
			Icon = OptionInfoPresets.Share.ShareSong.Icon,
		})

	elseif Source == "Queue" then
		Options = {
			OptionInfoPresets.PlayModes.ProceedHere,
			OptionInfoPresets.PlayModes.PlayAlone,

			"SEPARATOR",

			OptionInfoPresets.Queue.RemoveFromQueue,
			OptionInfoPresets.Queue.ClearQueue,
		}

	elseif Source == "ContinuePlaying" then
		Options = {
			OptionInfoPresets.PlayModes.ProceedHere,
			OptionInfoPresets.PlayModes.PlayAlone,

			"SEPARATOR",

			OptionInfoPresets.Queue.RemoveFromQueue,
			OptionInfoPresets.Queue.ClearContinuePlaying,
		}

	elseif Source == "Library" then

		local SongId = Data.MasterPool[Data.Pointer]
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		local IsAdded = events.Main.Library.IsSongSaved:InvokeServer(SongId)
		local IsPinned = events.Main.Library.IsPinned:InvokeServer("Song", SongId)
		local IsFavorited = events.Main.Preferences.IsSongFavorite:InvokeServer(SongId)
		local IsDisliked = events.Main.Preferences.IsSongDislike:InvokeServer(SongId)

		if IsPinned then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.UndoPin.Name,
				Icon = OptionInfoPresets.Library.UndoPin.Icon,
				Primary = true
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.Pin.Name,
				Icon = OptionInfoPresets.Library.Pin.Icon,
				Primary = true
			})
		end

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
				Primary = true
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon,
			})
		end

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.CreatePlaylistWith.Name,
			Icon = OptionInfoPresets.Playlist.CreatePlaylistWith.Icon,
		})

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.AddToPlaylist.Name,
			Icon = OptionInfoPresets.Playlist.AddToPlaylist.Icon,
		})

		table.insert(Options, "SEPARATOR")

		if IsFavorited then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoFavorite.Name,
				Icon = OptionInfoPresets.Preferences.UndoFavorite.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Favorite.Name,
				Icon = OptionInfoPresets.Preferences.Favorite.Icon,
			})
		end

		if IsDisliked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoDislike.Name,
				Icon = OptionInfoPresets.Preferences.UndoDislike.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Dislike.Name,
				Icon = OptionInfoPresets.Preferences.Dislike.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.ShareSong.Name,
			Icon = OptionInfoPresets.Share.ShareSong.Icon,
		})

	elseif Source == "NowPlaying" then
		local SongId = Data.SongId

		local IsAdded = events.Main.Library.IsSongSaved:InvokeServer(SongId)
		local IsFavorited = events.Main.Preferences.IsSongFavorite:InvokeServer(SongId)
		local IsDisliked = events.Main.Preferences.IsSongDislike:InvokeServer(SongId)

		table.insert(Options, {
			Name = OptionInfoPresets.Others.ViewDetails.Name,
			Icon = OptionInfoPresets.Others.ViewDetails.Icon
		})

		table.insert(Options, "SEPARATOR")

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon
			})
		end

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.CreatePlaylistWith.Name,
			Icon = OptionInfoPresets.Playlist.CreatePlaylistWith.Icon,
		})

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.AddToPlaylist.Name,
			Icon = OptionInfoPresets.Playlist.AddToPlaylist.Icon
		})

		table.insert(Options, "SEPARATOR")

		if IsFavorited then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoFavorite.Name,
				Icon = OptionInfoPresets.Preferences.UndoFavorite.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Favorite.Name,
				Icon = OptionInfoPresets.Preferences.Favorite.Icon,
			})
		end

		if IsDisliked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoDislike.Name,
				Icon = OptionInfoPresets.Preferences.UndoDislike.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Dislike.Name,
				Icon = OptionInfoPresets.Preferences.Dislike.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.ShareSong.Name,
			Icon = OptionInfoPresets.Share.ShareSong.Icon,
		})

	elseif Source == "Playlist" then
		local SongId = Data.MasterPool[Data.Pointer]
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		local IsFavorited = events.Main.Preferences.IsSongFavorite:InvokeServer(SongId)
		local IsDisliked = events.Main.Preferences.IsSongDislike:InvokeServer(SongId)

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
				Primary = true
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.AddToPlaylist.Name,
			Icon = OptionInfoPresets.Playlist.AddToPlaylist.Icon,
		})

		if client.UserId == PlaylistPageProperties.CurrentCreatorId and table.find(PlaylistPageProperties.Songs, SongId) then
			table.insert(Options, {
				Name = OptionInfoPresets.Playlist.RemoveFromPlaylist.Name,
				Icon = OptionInfoPresets.Playlist.RemoveFromPlaylist.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsFavorited then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoFavorite.Name,
				Icon = OptionInfoPresets.Preferences.UndoFavorite.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Favorite.Name,
				Icon = OptionInfoPresets.Preferences.Favorite.Icon,
			})
		end

		if IsDisliked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoDislike.Name,
				Icon = OptionInfoPresets.Preferences.UndoDislike.Icon,
			})

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Dislike.Name,
				Icon = OptionInfoPresets.Preferences.Dislike.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.ShareSong.Name,
			Icon = OptionInfoPresets.Share.ShareSong.Icon,
		})

	end

	local ContextMenuOption = Main.PromptOptions({
		Header = Data.Title,
		Options = Options,
		Mobile = Mobile
	})

	-- Play Modes

	if ContextMenuOption == "Play" then
		callback_Play(Data)

	elseif ContextMenuOption == "Play Next" then
		callback_PlayNext(Data)

	elseif ContextMenuOption == "Play Last" then
		callback_PlayLast(Data)

	elseif ContextMenuOption == "Play Alone" then
		Data.MasterPool = {Data.SongId}
		Data.Pointer = 1
		Data.ContextName = ""

		callback_Play(Data)

	elseif ContextMenuOption == "Proceed Here" then
		if not Data.TrackingId then return end

		Queue.ProceedByTrackingId(Data.TrackingId)


		-- Library

	elseif ContextMenuOption == "Add To Library" then
		callback_SongLibrary(1, Data)

	elseif ContextMenuOption == "Remove From Library" then
		callback_SongLibrary(2, Data)

	elseif ContextMenuOption == "Pin" then
		callback_PinSong(1, Data)

	elseif ContextMenuOption == "Undo Pin" then
		callback_PinSong(2, Data)

		-- Playlist

	elseif ContextMenuOption == "Create Playlist With" then
		Main.PlaylistCreation(true)

		PlaylistPageProperties.ToAdd = Data.SongId

	elseif ContextMenuOption == "Add To Playlist" then
		callback_AddToPlaylist(Data.SongId)

	elseif ContextMenuOption == "Remove From Playlist" then
		callback_SongPlaylist(2, Data.SongId, PlaylistPageProperties.CurrentPlaylistId)

		-- Preferences

	elseif ContextMenuOption == "Favorite" then
		callback_Favorite(1, Data)

	elseif ContextMenuOption == "Undo Favorite" then
		callback_Favorite(2, Data)

	elseif ContextMenuOption == "Dislike" then
		callback_Dislike(1, Data)

	elseif ContextMenuOption == "Undo Dislike" then
		callback_Dislike(2, Data)


		-- Queue

	elseif ContextMenuOption == "Clear Queue" then
		Queue.ClearQueue()

	elseif ContextMenuOption == "Clear Continue Playing" then
		Queue.ClearContinuePlaying()

	elseif ContextMenuOption == "Remove From Queue" then
		if not Data.TrackingId then return end

		Queue.RemoveByTrackingId(Data.TrackingId)

		-- Others

	elseif ContextMenuOption == "View Artist" then
		callback_ViewArtist(NowPlaying.Content.Media.Details.SongInfo.Source.Text)

	elseif ContextMenuOption == "View Details" then
		callback_ViewDetails()

		-- Share

	elseif ContextMenuOption == "Share Song" then
		callback_ShareSong(Data.SongId, Data.Title, Data.Artist)
	end

end
print("loaded")
function PromptArtistOption(Source: ArtistSourceType, ArtistName, Mobile)
	local Options = {}

	if Source == "Standard" then
		local IsAdded = events.Main.Library.IsArtistSaved:InvokeServer(ArtistName)
		local IsBlocked = events.Main.Preferences.IsArtistBlock:InvokeServer(ArtistName)

		table.insert(Options, {
			Name = OptionInfoPresets.Others.ViewArtist.Name,
			Icon = OptionInfoPresets.Others.ViewArtist.Icon,
			Primary = true
		})

		table.insert(Options, "SEPARATOR")

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsBlocked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoBlock.Name,
				Icon = OptionInfoPresets.Preferences.UndoBlock.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Block.Name,
				Icon = OptionInfoPresets.Preferences.Block.Icon,
			})
		end

	elseif Source == "Library" then
		local IsAdded = events.Main.Library.IsArtistSaved:InvokeServer(ArtistName)
		local IsPinned = events.Main.Library.IsPinned:InvokeServer("Artist", ArtistName)
		local IsBlocked = events.Main.Preferences.IsArtistBlock:InvokeServer(ArtistName)

		table.insert(Options, {
			Name = OptionInfoPresets.Others.ViewArtist.Name,
			Icon = OptionInfoPresets.Others.ViewArtist.Icon,
			Primary = true
		})

		if IsPinned then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.UndoPin.Name,
				Icon = OptionInfoPresets.Library.UndoPin.Icon,
				Primary = true
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.Pin.Name,
				Icon = OptionInfoPresets.Library.Pin.Icon,
				Primary = true
			})

		end

		table.insert(Options, "SEPARATOR")

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsBlocked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoBlock.Name,
				Icon = OptionInfoPresets.Preferences.UndoBlock.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Block.Name,
				Icon = OptionInfoPresets.Preferences.Block.Icon,
			})
		end
	elseif Source == "ArtistPage" then
		local IsAdded = events.Main.Library.IsArtistSaved:InvokeServer(ArtistName)
		local IsBlocked = events.Main.Preferences.IsArtistBlock:InvokeServer(ArtistName)

		if IsAdded then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.RemoveFromLibrary.Name,
				Icon = OptionInfoPresets.Library.RemoveFromLibrary.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.AddToLibrary.Name,
				Icon = OptionInfoPresets.Library.AddToLibrary.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		if IsBlocked then
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.UndoBlock.Name,
				Icon = OptionInfoPresets.Preferences.UndoBlock.Icon,
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Preferences.Block.Name,
				Icon = OptionInfoPresets.Preferences.Block.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.ShareArtist.Name,
			Icon = OptionInfoPresets.Share.ShareArtist.Icon,
		})

	end

	local ContextMenuOption = Main.PromptOptions({
		Header = ArtistName,
		Options = Options,
		Mobile = Mobile
	})

	if ContextMenuOption == "View Artist" then
		callback_ViewArtist(ArtistName)

		-- Library

	elseif ContextMenuOption == "Add To Library" then
		callback_ArtistLibrary(1, ArtistName)

	elseif ContextMenuOption == "Remove From Library" then
		callback_ArtistLibrary(2, ArtistName)

	elseif ContextMenuOption == "Pin" then
		callback_PinArtist(1, ArtistName)

	elseif ContextMenuOption == "Undo Pin" then
		callback_PinArtist(2, ArtistName)

		-- Preferences

	elseif ContextMenuOption == "Block" then
		callback_Block(1, ArtistName)

	elseif ContextMenuOption == "Undo Block" then
		callback_Block(2, ArtistName)

		-- Share

	elseif ContextMenuOption == "Share Artist" then
		callback_ShareArtist(ArtistName)
	end
end
print("loaded")
function PromptPlaylistOption(Source: PlaylistSourceType, PlaylistData, Mobile)
	local VisualQueue = Queue.GetVisualQueue()
	local Options = {}

	if Source == "Standard" then
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		table.insert(Options, {
			Name = OptionInfoPresets.Others.ViewPlaylist.Name,
			Icon = OptionInfoPresets.Others.ViewPlaylist.Icon,
			Primary = true,
		})

		table.insert(Options, "SEPARATOR")

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
				Primary = true
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.SharePlaylist.Name,
			Icon = OptionInfoPresets.Share.SharePlaylist.Icon,
		})

	elseif Source == "Library" then
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)
		local IsPinned = events.Main.Library.IsPinned:InvokeServer("Playlist", PlaylistData.PlaylistId)

		if IsPinned then
			table.insert(Options, {
				Name = OptionInfoPresets.Library.UndoPin.Name,
				Icon = OptionInfoPresets.Library.UndoPin.Icon,
				Primary = true
			})
		else
			table.insert(Options, {
				Name = OptionInfoPresets.Library.Pin.Name,
				Icon = OptionInfoPresets.Library.Pin.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.DeletePlaylist.Name,
			Icon = OptionInfoPresets.Playlist.DeletePlaylist.Icon,
		})

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.SharePlaylist.Name,
			Icon = OptionInfoPresets.Share.SharePlaylist.Icon,
		})

	elseif Source == "PlaylistPage" then
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
				Primary = true
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
				Primary = true
			})
		end

		table.insert(Options, "SEPARATOR")

		if client.UserId == PlaylistPageProperties.CurrentCreatorId then
			if PlaylistData.Private then
				table.insert(Options, {
					Name = OptionInfoPresets.Playlist.SetPublic.Name,
					Icon = OptionInfoPresets.Playlist.SetPublic.Icon,
				})
			else
				table.insert(Options, {
					Name = OptionInfoPresets.Playlist.SetPrivate.Name,
					Icon = OptionInfoPresets.Playlist.SetPrivate.Icon,
				})
			end

		else
			table.insert(Options, {
				Name = OptionInfoPresets.Playlist.AddToLibrary.Name,
				Icon = OptionInfoPresets.Playlist.AddToLibrary.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.Playlist.CopyPlaylist.Name,
				Icon = OptionInfoPresets.Playlist.CopyPlaylist.Icon,
			})
		end

		table.insert(Options, {
			Name = OptionInfoPresets.Playlist.DeletePlaylist.Name,
			Icon = OptionInfoPresets.Playlist.DeletePlaylist.Icon,
		})

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Share.SharePlaylist.Name,
			Icon = OptionInfoPresets.Share.SharePlaylist.Icon,
		})

	end

	local ContextMenuOption = Main.PromptOptions({
		Options = Options,
		Mobile = Mobile
	})

	if ContextMenuOption == "View Playlist" then
		callback_ViewPlaylist(PlaylistData.CreatorId, PlaylistData.PlaylistId)

		-- Library

	elseif ContextMenuOption == "Pin" then
		callback_PinPlaylist(1, PlaylistData.PlaylistId)

	elseif ContextMenuOption == "Undo Pin" then
		callback_PinPlaylist(2, PlaylistData.PlaylistId)

		-- Play Modes

	elseif ContextMenuOption == "Play" then
		Queue.LoadSource(PlaylistData.Songs, 1, PlaylistData.Name, true)

	elseif ContextMenuOption == "Play Next" then
		Queue.PlayNext(PlaylistData.Songs)

	elseif ContextMenuOption == "Play Last" then
		Queue.AddToQueue(PlaylistData.Songs)

		-- Other

	elseif ContextMenuOption == "Set to Private" then
		local success = events.Main.Library.SetPlaylistProperty:InvokeServer(PlaylistData.PlaylistId, "Private", true)

		if success then
			PlaylistPageProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Set this Playlist Private",
				Description = "You set this playlist private. You're the only one able to see this playlist.",
				Icon = "rbxassetid://14187755345"
			})
		else
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "An error occurred while setting this playlist private.",
				Icon = "rbxassetid://14187755345"
			})
		end

	elseif ContextMenuOption == "Set to Public" then
		local success = events.Main.Library.SetPlaylistProperty:InvokeServer(PlaylistData.PlaylistId, "Private", false)

		if success then
			PlaylistPageProperties.RequestReload:Fire()

			Alerts.BannerNotify({
				Header = "Set this Playlist Public",
				Description = "You set this playlist public. Share this playlist and let anyone view this playlist.",
				Icon = "rbxassetid://11293979388"
			})
		else
			Alerts.BannerNotify({
				Header = "An Error Occurred.",
				Description = "An error occurred while setting this playlist public.",
				Icon = "rbxassetid://14187755345"
			})
		end

	elseif ContextMenuOption == "Add To Library" then
		events.Main.Library.AddPublicPlaylist:InvokeServer(
			PlaylistPageProperties.CurrentCreatorId, PlaylistPageProperties.CurrentPlaylistId, false)

		LibraryProperties.RequestReload:Fire()

	elseif ContextMenuOption == "Copy Playlist" then
		events.Main.Library.AddPublicPlaylist:InvokeServer(
			PlaylistPageProperties.CurrentCreatorId, PlaylistPageProperties.CurrentPlaylistId, true)

		LibraryProperties.RequestReload:Fire()

	elseif ContextMenuOption == "Delete Playlist" then
		events.Main.Library.DeletePlaylist:FireServer(PlaylistData.PlaylistId)

		if Main.GetCurrentPage() == "Playlist" then
			Main.SetPage(Main.GetLastMainPage())
		else
			LibraryProperties.RequestReload:Fire()
		end

	elseif ContextMenuOption == "Share Playlist" then
		callback_SharePlaylist(PlaylistData)
	end
end

function PromptStationOption(Source: StationItemProperties, StationData, Online, Mobile)
	local VisualQueue = Queue.GetVisualQueue()
	local Options = {}

	if Source == "Standard" then
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		table.insert(Options, {
			Name = OptionInfoPresets.Others.ViewStation.Name,
			Icon = OptionInfoPresets.Others.ViewStation.Icon,
			Primary = true,
		})

		table.insert(Options, "SEPARATOR")

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
			})
		end

	elseif Source == "StationPage" then
		local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

		if SongsInQueue == 0 and not Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
				Primary = true
			})

		elseif SongsInQueue == 0 and Queue.GetActiveSound() then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

		elseif SongsInQueue > 1 then
			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.Play.Name,
				Icon = OptionInfoPresets.PlayModes.Play.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayNext.Name,
				Icon = OptionInfoPresets.PlayModes.PlayNext.Icon,
			})

			table.insert(Options, {
				Name = OptionInfoPresets.PlayModes.PlayLast.Name,
				Icon = OptionInfoPresets.PlayModes.PlayLast.Icon,
			})
		end

		table.insert(Options, "SEPARATOR")

		table.insert(Options, {
			Name = OptionInfoPresets.Stations.CopyStation.Name,
			Icon = OptionInfoPresets.Stations.CopyStation.Icon,
		})
	end

	local ContextMenuOption = Main.PromptOptions({
		Options = Options,
		Mobile = Mobile
	})

	if ContextMenuOption == "View Station" then
		callback_ViewStation(Online, StationData.StationId)

		-- Play Modes

	elseif ContextMenuOption == "Play" then
		Queue.LoadSource(StationData.Songs, 1, StationData.Name, true)

	elseif ContextMenuOption == "Play Next" then
		Queue.PlayNext(StationData.Songs)

	elseif ContextMenuOption == "Play Last" then
		Queue.AddToQueue(StationData.Songs)

		-- Other

	elseif ContextMenuOption == "Copy Station" then
		if Online then
			callback_CopyOnlineStation(StationData.StationId)
		else
			callback_CopyLocalStation(StationData.StationId)
		end
	end
end

-- Functions / Main

function LoadSettings()
	if SettingsPageProperties.LoadingSettings then return end

	SettingsPageProperties.LoadingSettings = true
	SettingsPageProperties.HasChanged = false

	-- Set Page

	SettingsPage.Util.Loading.Visible = true
	SettingsPage.Header.Visible = false
	SettingsPage.Scroll.Visible = false

	Main.Settings(true)

	-- Data

	local SettingsLoaded = Settings.FetchSettings()
	if not SettingsLoaded then
		SettingsPage.Util.Loading.Visible = false
		SettingsPage.Header.Visible = true
		SettingsPage.Scroll.Visible = true
		SettingsPageProperties.LoadingSettings = false
		return
	end

	SettingsPageProperties.Data = SettingsLoaded

	-- Data / Playback

	if SettingsLoaded.Playback.Crossfade.Enabled then
		local ScaleX = Utilities.Map(SettingsLoaded.Playback.Crossfade.Duration, 1, 10, 0, 1)

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Crossfade.Enabled.Switch, true)

		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Visible = true
		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Timeline.Scrubber.Fill.Size = UDim2.fromScale(ScaleX, 1)
	else
		local ScaleX = Utilities.Map(SettingsLoaded.Playback.Crossfade.Duration, 1, 10, 0, 1)

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Crossfade.Enabled.Switch, false)

		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Visible = false
		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Timeline.Scrubber.Fill.Size = UDim2.fromScale(ScaleX, 1)
	end

	if SettingsLoaded.Playback.Equalizer.Enabled then
		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Equalizer.Enabled.Switch, true)

		SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Visible = true
		SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Visible = true
		SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Visible = true
	else
		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Equalizer.Enabled.Switch, false)

		SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Visible = false
		SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Visible = false
		SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Visible = false
	end

	SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Value.Text = SettingsLoaded.Playback.Equalizer.HighGain
	SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Value.Text = SettingsLoaded.Playback.Equalizer.MidGain
	SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Value.Text = SettingsLoaded.Playback.Equalizer.LowGain

	-- Data / Extras

	Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.Glow.Switch, SettingsLoaded.Extras.Glow)
	Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.PlaybackHaptics.Switch, SettingsLoaded.Extras.PlaybackHaptics)

	-- Data / Socials

	Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.Sharing.Switch, SettingsLoaded.Socials.Sharing)
	Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.ListeningVisibility.Switch, SettingsLoaded.Socials.ListeningVisibility)

	--

	SettingsPage.Util.Loading.Visible = false
	SettingsPage.Header.Visible = true
	SettingsPage.Scroll.Visible = true

	SettingsPageProperties.LoadingSettings = false
end

function LoadPlaylist(CreatorId, PlaylistId)
	if not PlaylistId then return end
	if PlaylistPageProperties.LoadingPlaylist then return end

	PlaylistPageProperties.LoadingPlaylist = true

	local Songs = {}
	local Duration = 0

	-- Set Page

	Full.Container.Playlist.Util.Loading.Visible = true
	Full.Container.Playlist.Canvas.Visible = false
	Full.Container.Playlist.Header.Visible = false
	Full.Container.Playlist.QueueList.Visible = false
	Full.Container.Playlist.FeaturedArtists.Visible = false

	Main.SetPage("Playlist")

	PlaylistPageProperties.CurrentPlaylistId = PlaylistId

	-- Residual

	for i, residual in Full.Container.Playlist.QueueList:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, residual in Full.Container.Playlist.FeaturedArtists.Content:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Data

	local Data = events.Main.Library.GetPlaylistByPlaylistId:InvokeServer(CreatorId, PlaylistId)
	if not Data then PlaylistPageProperties.LoadingPlaylist = false return end

	local Metadata = Audios.GetAudioMetadataAsync(Data.Songs)
	if not Metadata then PlaylistPageProperties.LoadingPlaylist = false return end

	local Success, Username = pcall(function()
		return Players:GetNameFromUserIdAsync(Data.CreatorId)
	end)

	if not Success then PlaylistPageProperties.LoadingPlaylist = false return end

	PlaylistPageProperties.Songs = Data.Songs
	PlaylistPageProperties.CurrentCreatorId = Data.CreatorId
	PlaylistPageProperties.CurrentPlaylistName = Data.Name
	PlaylistPageProperties.CurrentPlaylistData = Data

	if #Data.Songs == 30 then
		Full.Container.Playlist.Canvas.Details.Action.Add.Visible = false
	else
		Full.Container.Playlist.Canvas.Details.Action.Add.Visible = true
	end

	Full.Container.Playlist.Canvas.Details.Action.Add.Visible = Data.CreatorId == client.UserId

	if Data.CreatorId ~= client.UserId and Data.Private then
		Full.Container.Playlist.Util.Loading.Visible = true
		Full.Container.Playlist.Canvas.Visible = false
		Full.Container.Playlist.Header.Visible = false
		Full.Container.Playlist.QueueList.Visible = false

		PlaylistPageProperties.LoadingPlaylist = false

		Main.SetPage(Main.GetLastMainPage())

		Alerts.BannerNotify({
			Header = "Failed to Load Playlist",
			Description = `Failed to load this playlist because {Data.Name} is now private.`,
			Icon = "rbxassetid://14187755345"
		})

		return
	end

	if Data.Cover == "" then
		if #Data.Songs > 0 then
			Full.Util.PlaylistBackground.Background.Image = Utilities.GetCoverForSong(Data.Songs[1])

			if #Data.Songs == 1 then
				Full.Container.Playlist.Canvas.Art.Photo.Image = ""

				Full.Container.Playlist.Canvas.Art.Photo.Default.Visible = true
				Full.Container.Playlist.Canvas.Art.Photo.Default.grid.CellSize = UDim2.fromScale(1, 1)

				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.Songs[1])

			elseif #Data.Songs == 2 then
				Full.Container.Playlist.Canvas.Art.Photo.Image = ""

				Full.Container.Playlist.Canvas.Art.Photo.Default.Visible = true
				Full.Container.Playlist.Canvas.Art.Photo.Default.grid.CellSize = UDim2.fromScale(.5, 1)

				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.Songs[1])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.Songs[2])

			elseif #Data.Songs == 3 then
				Full.Container.Playlist.Canvas.Art.Photo.Image = ""

				Full.Container.Playlist.Canvas.Art.Photo.Default.Visible = true
				Full.Container.Playlist.Canvas.Art.Photo.Default.grid.CellSize = UDim2.fromScale(1, .34)

				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.Songs[1])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.Songs[2])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverC.Image = Utilities.GetCoverForSong(Data.Songs[3])

			elseif #Data.Songs > 3 then
				Full.Container.Playlist.Canvas.Art.Photo.Image = ""

				Full.Container.Playlist.Canvas.Art.Photo.Default.Visible = true
				Full.Container.Playlist.Canvas.Art.Photo.Default.grid.CellSize = UDim2.fromScale(.5, .5)

				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.Songs[1])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.Songs[2])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverC.Image = Utilities.GetCoverForSong(Data.Songs[3])
				Full.Container.Playlist.Canvas.Art.Photo.Default.CoverD.Image = Utilities.GetCoverForSong(Data.Songs[4])
			end
		else
			Full.Util.PlaylistBackground.Background.Image =  "rbxassetid://74118540785733"
			Full.Container.Playlist.Canvas.Art.Photo.Image =  "rbxassetid://74118540785733"
			Full.Container.Playlist.Canvas.Art.Photo.Default.Visible = false
		end
	else
		Full.Util.PlaylistBackground.Background.Image = Data.Cover
		Full.Container.Playlist.Canvas.Art.Photo.Image = Data.Cover
	end

	for i, Song in Metadata do
		Duration += Song.Duration

		AddSongItem({
			Container = Full.Container.Playlist.QueueList,
			ContextName = Data.Name,
			Item = ui.Storage.Items["Item(Vertical)"],
			MasterPool = Data.Songs,
			Pointer = i,
			SongInfo = Song,
			Source = "Playlist"
		})

		--

		local AlreadyAdded = Full.Container.Playlist.FeaturedArtists.Content:FindFirstChild(Song.Artist)

		if not AlreadyAdded then
			AddArtistItem({
				Container = Full.Container.Playlist.FeaturedArtists.Content,
				Item = ui.Storage.Items["Artist(Standard)"],
				ArtistName = Song.Artist,
				Source = "Standard"
			})
		end
	end

	Full.Container.Playlist.Canvas.Details.Info.Source.Text = Username
	Full.Container.Playlist.Canvas.Details.Info.Title.Text = Data.Name

	local UpData = Utilities.FormatEpochData(Data.Updated)

	if #Data.Songs > 1 then
		Full.Container.Playlist.FeaturedArtists.Visible = true
		Full.Container.Playlist.Canvas.Details.Info.Subtext.Text = 
			`{#Data.Songs} Songs · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
	else
		if #Data.Songs == 0 then
			Full.Container.Playlist.FeaturedArtists.Visible = false
			Full.Container.Playlist.Canvas.Details.Info.Subtext.Text = `No Songs · Updated {UpData.Relative}`
		else
			Full.Container.Playlist.FeaturedArtists.Visible = true
			Full.Container.Playlist.Canvas.Details.Info.Subtext.Text = 
				`{#Data.Songs} Song · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
		end
	end

	Full.Container.Playlist.Util.Loading.Visible = false
	Full.Container.Playlist.Canvas.Visible = true
	Full.Container.Playlist.Header.Visible = true
	Full.Container.Playlist.QueueList.Visible = true

	PlaylistPageProperties.LoadingPlaylist = false
end

function LoadOnlineStation(StationId)
	if not StationId then return end
	if StationPageProperties.LoadingStation then return end

	StationPageProperties.LoadingStation = true
	StationPageProperties.IsCurrentlyOnline = true

	local Songs = {}
	local Duration = 0

	-- Set Page

	Full.Container.Stations.Util.Loading.Visible = true
	Full.Container.Stations.Canvas.Visible = false
	Full.Container.Stations.Header.Visible = false
	Full.Container.Stations.QueueList.Visible = false
	Full.Container.Stations.FeaturedArtists.Visible = false

	Main.SetPage("Stations")

	StationPageProperties.CurrentStationId = StationId

	-- Residual

	for i, residual in Full.Container.Stations.QueueList:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, residual in Full.Container.Stations.FeaturedArtists.Content:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Data

	local Data = OnlineStations.GetOnlineStationByStationId(StationId)
	if not Data then StationPageProperties.LoadingStation = false return end

	local Metadata = Audios.GetAudioMetadataAsync(Data.Songs)
	if not Metadata then StationPageProperties.LoadingStation = false return end

	StationPageProperties.Songs = Data.Songs
	StationPageProperties.CurrentStationData = Data

	if Data.Cover == "" then
		Full.Util.PlaylistBackground.Background.Image =  "rbxassetid://74118540785733"
		Full.Container.Stations.Canvas.Art.Photo.Image =  "rbxassetid://74118540785733"
	else
		Full.Util.PlaylistBackground.Background.Image = Data.Cover
		Full.Container.Stations.Canvas.Art.Photo.Image = Data.Cover
	end

	for i, Song in Metadata do
		Duration += Song.Duration or 0

		AddSongItem({
			Container = Full.Container.Stations.QueueList,
			ContextName = Data.Name,
			Item = ui.Storage.Items["Item(Vertical)"],
			MasterPool = Data.Songs,
			Pointer = i,
			SongInfo = Song,
			Source = "Standard"
		})

		--

		local AlreadyAdded = Full.Container.Stations.FeaturedArtists.Content:FindFirstChild(Song.Artist)

		if not AlreadyAdded then
			AddArtistItem({
				Container = Full.Container.Stations.FeaturedArtists.Content,
				Item = ui.Storage.Items["Artist(Standard)"],
				ArtistName = Song.Artist,
				Source = "Standard"
			})
		end
	end

	Full.Container.Stations.Canvas.Details.Info.Source.Text = "Masters"
	Full.Container.Stations.Canvas.Details.Info.Title.Text = Data.Name

	local UpData = Utilities.FormatEpochData(Data.Updated)

	if #Data.Songs > 1 then
		Full.Container.Stations.FeaturedArtists.Visible = true
		Full.Container.Stations.Canvas.Details.Info.Subtext.Text = 
			`{#Data.Songs} Songs · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
	else
		if #Data.Songs == 0 then
			Full.Container.Stations.FeaturedArtists.Visible = false
			Full.Container.Stations.Canvas.Details.Info.Subtext.Text = `No Songs · Updated {UpData.Relative}`
		else
			Full.Container.Stations.FeaturedArtists.Visible = true
			Full.Container.Stations.Canvas.Details.Info.Subtext.Text = 
				`{#Data.Songs} Song · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
		end
	end

	Full.Container.Stations.Util.Loading.Visible = false
	Full.Container.Stations.Canvas.Visible = true
	Full.Container.Stations.Header.Visible = true
	Full.Container.Stations.QueueList.Visible = true

	StationPageProperties.LoadingStation = false
end

function LoadLocalStation(StationId)
	if not StationId then return end
	if StationPageProperties.LoadingStation then return end

	StationPageProperties.LoadingStation = true
	StationPageProperties.IsCurrentlyOnline = false

	local Songs = {}
	local Duration = 0

	-- Set Page

	Full.Container.Stations.Util.Loading.Visible = true
	Full.Container.Stations.Canvas.Visible = false
	Full.Container.Stations.Header.Visible = false
	Full.Container.Stations.QueueList.Visible = false
	Full.Container.Stations.FeaturedArtists.Visible = false

	Main.SetPage("Stations")

	StationPageProperties.CurrentStationId = StationId

	-- Residual

	for i, residual in Full.Container.Stations.QueueList:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, residual in Full.Container.Stations.FeaturedArtists.Content:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Data

	local Data = Configuration.GetLocalStationByStationId(StationId)
	if not Data then StationPageProperties.LoadingStation = false return end

	local Metadata = Audios.GetAudioMetadataAsync(Data.Songs)
	if not Metadata then StationPageProperties.LoadingStation = false return end

	StationPageProperties.Songs = Data.Songs
	StationPageProperties.CurrentStationData = Data

	if Data.Cover == "" then
		Full.Util.PlaylistBackground.Background.Image =  "rbxassetid://74118540785733"
		Full.Container.Stations.Canvas.Art.Photo.Image =  "rbxassetid://74118540785733"
	else
		Full.Util.PlaylistBackground.Background.Image = Data.Cover
		Full.Container.Stations.Canvas.Art.Photo.Image = Data.Cover
	end

	for i, Song in Metadata do
		Duration += Song.Duration

		AddSongItem({
			Container = Full.Container.Stations.QueueList,
			ContextName = Data.Name,
			Item = ui.Storage.Items["Item(Vertical)"],
			MasterPool = Data.Songs,
			Pointer = i,
			SongInfo = Song,
			Source = "Standard"
		})

		--

		local AlreadyAdded = Full.Container.Stations.FeaturedArtists.Content:FindFirstChild(Song.Artist)

		if not AlreadyAdded then
			AddArtistItem({
				Container = Full.Container.Stations.FeaturedArtists.Content,
				Item = ui.Storage.Items["Artist(Standard)"],
				ArtistName = Song.Artist,
				Source = "Standard"
			})
		end
	end

	Full.Container.Stations.Canvas.Details.Info.Source.Text = "Local"
	Full.Container.Stations.Canvas.Details.Info.Title.Text = Data.Name

	local UpData = Utilities.FormatEpochData(Data.Updated)

	if #Data.Songs > 1 then
		Full.Container.Stations.FeaturedArtists.Visible = true
		Full.Container.Stations.Canvas.Details.Info.Subtext.Text = 
			`{#Data.Songs} Songs · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
	else
		if #Data.Songs == 0 then
			Full.Container.Stations.FeaturedArtists.Visible = false
			Full.Container.Stations.Canvas.Details.Info.Subtext.Text = `No Songs · Updated {UpData.Relative}`
		else
			Full.Container.Stations.FeaturedArtists.Visible = true
			Full.Container.Stations.Canvas.Details.Info.Subtext.Text = 
				`{#Data.Songs} Song · {Utilities.FormatSecondsToHM(Duration, true)} · Updated {UpData.Relative}`
		end
	end

	Full.Container.Stations.Util.Loading.Visible = false
	Full.Container.Stations.Canvas.Visible = true
	Full.Container.Stations.Header.Visible = true
	Full.Container.Stations.QueueList.Visible = true

	StationPageProperties.LoadingStation = false
end

function LoadArtist(ArtistName)
	if ArtistPageProperties.LoadingArtist then return end
	ArtistPageProperties.LoadingArtist = true

	local FinishedLoading = false

	local Genres = {}
	local SongIds = {
		Discography = {},
		Familiar = {},
		FamiliarList = {},
	}
	local Duration = 0

	-- Set Page

	local C1, C2 = Utilities.GenerateArtistGradient(ArtistName)

	Full.Util.ArtistBackground.Background.gradient.Color = ColorSequence.new(C1, C2)
	Full.Container.Artist.Action.Play.gradient.Color = ColorSequence.new(C1, C2)

	Full.Container.Artist.Util.Loading.Visible = true
	Full.Container.Artist.Action.Visible = false
	Full.Container.Artist.Canvas.Visible = false
	Full.Container.Artist.Header.Visible = false
	Full.Container.Artist.Sections.Visible = false

	Full.Container.Artist.Sections.Discography.Header.Search.Field.Text = ""
	DiscographySearchKeyword("", false)

	Main.SetPage("Artist")

	ArtistPageProperties.CurrentArtistLoaded = ArtistName

	local Discography = Audios.LoadArtist(ArtistName)
	if #Discography < 1 then return "NotArtist" end

	-- Residual

	for i, residual in Full.Container.Artist.Sections.Discography.Content:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, residual in Full.Container.Artist.Sections.YWF.Content:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Actions

	-- Actions (SAFE NATIVE FETCHING)
	local Algorithm, Library, Preferences

	-- 1. Safely attempt to fetch the data without breaking the thread
	pcall(function() Algorithm = events.Main.Algorithm.FetchAlgorithm:InvokeServer() end)
	pcall(function() Library = events.Main.Library.FetchLibrary:InvokeServer() end)
	pcall(function() Preferences = events.Main.Preferences.FetchPreference:InvokeServer() end)

	-- 2. Fallbacks: If the server failed or returned nil, mock the expected tables
	Algorithm = (type(Algorithm) == "table" and Algorithm) or { Songs = {} }
	Library = (type(Library) == "table" and Library) or { Songs = {} }
	Preferences = (type(Preferences) == "table" and Preferences) or {
		Artists = { Block = {} },
		Songs = { Favorite = {}, Dislike = {} }
	}

	-- 3. Safety Check: Ensure sub-tables exist even if the main table loaded partially
	Preferences.Artists = Preferences.Artists or { Block = {} }
	Preferences.Songs = Preferences.Songs or { Favorite = {}, Dislike = {} }
	Preferences.Artists.Block = Preferences.Artists.Block or {}
	Preferences.Songs.Favorite = Preferences.Songs.Favorite or {}
	Preferences.Songs.Dislike = Preferences.Songs.Dislike or {}

	if table.find(Preferences.Artists.Block, ArtistName) then
		Full.Container.Artist.Action.Blocked.Visible = true
		Full.Container.Artist.Action.Play.Visible = false
		Full.Container.Artist.Action.Shuffle.Visible = false
	else
		Full.Container.Artist.Action.Blocked.Visible = false
		Full.Container.Artist.Action.Play.Visible = true
		Full.Container.Artist.Action.Shuffle.Visible = true
	end

	-- Discography

	for i, Song in Discography do
		local IsPlayed = false
		local IsSaved = false
		local IsFavorited = false
		local IsDisliked = false

		local Score = 0

		Duration += Song.Duration

		-- Tags

		for i, Tags in Song.Tags do
			table.insert(Genres, Tags)
		end

		-- Algorithm

		for i, PlayedSong in Algorithm.Songs do
			if PlayedSong.SongId == Song.Id then
				IsPlayed = true

				-- Played within 7 days

				if (os.time() - PlayedSong.LastUpdate) <= 604800 then
					Score += 20
				else
					Score += 5
				end

				-- Addition of relevance

				Score += PlayedSong.Relevance
			end
		end

		-- Library

		for i, SavedSong in Library.Songs do
			if SavedSong.SongId == Song.Id then
				IsSaved = true

				if SavedSong.Pinned then
					Score += 5
				else
					Score += 1
				end
			end
		end

		-- Preferences

		IsFavorited = table.find(Preferences.Songs.Favorite, Song.Id)
		if IsFavorited then Score += 10 end

		IsDisliked = table.find(Preferences.Songs.Dislike, Song.Id)
		if IsFavorited then Score -= 10 end

		--

		if IsPlayed or IsSaved or IsFavorited or IsDisliked then
			Song.Score = Score
			table.insert(SongIds.Familiar, Song)
		end

		table.insert(SongIds.Discography, Song.Id)

		AddSongItem({
			Container = Full.Container.Artist.Sections.Discography.Content,
			ContextName = ArtistName .. "'s Discography",
			Item = ui.Storage.Items["Item(Vertical)"],
			MasterPool = SongIds.Discography,
			Pointer = i,
			SongInfo = Song,
			Source = "Standard"
		})
	end

	for i, Song in SongIds.Familiar do
		table.insert(SongIds.FamiliarList, Song.Id)

		AddSongItem({
			Container = Full.Container.Artist.Sections.YWF.Content,
			ContextName = "You're Familiar With - " .. ArtistName,
			Item = ui.Storage.Items["Item(Big)"],
			ItemProperties = {LayoutOrder = -Song.Score},
			MasterPool = SongIds.FamiliarList,
			Pointer = i,
			SongInfo = Song,
			Source = "Standard"
		})
	end

	if #SongIds.FamiliarList < 1 then
		Full.Container.Artist.Sections.YWF.Visible = false
	else
		Full.Container.Artist.Sections.YWF.Visible = true
	end

	ArtistPageProperties.Discography = SongIds.Discography

	-- Canvas

	local ArrangedGenres = Utilities.ArrangeByFrequency(Genres)

	if #ArrangedGenres >= 2 then
		local FirstGenre = string.gsub(Utilities.CapitalizeWords(ArrangedGenres[1]), "-", " ")
		local SecondGenre = string.gsub(Utilities.CapitalizeWords(ArrangedGenres[2]), "-", " ")

		Full.Container.Artist.Canvas.Genres.Text = `{FirstGenre} · {SecondGenre}`

	elseif #ArrangedGenres == 1 then
		local FirstGenre = string.gsub(Utilities.CapitalizeWords(ArrangedGenres[1]), "-", " ")

		Full.Container.Artist.Canvas.Genres.Text = FirstGenre
	end

	if #Discography > 1 then
		Full.Container.Artist.Canvas.Genres.Text = `{Full.Container.Artist.Canvas.Genres.Text} · {#Discography} Songs`
	else
		Full.Container.Artist.Canvas.Genres.Text = `{Full.Container.Artist.Canvas.Genres.Text} · {#Discography} Song` 
	end

	Full.Container.Artist.Canvas.Genres.Text = `{Full.Container.Artist.Canvas.Genres.Text} · {Utilities.FormatSecondsToHM(Duration)}` 
	Full.Container.Artist.Canvas.Artist.Text = ArtistName

	Full.Container.Artist.Util.Loading.Visible = false
	Full.Container.Artist.Action.Visible = true
	Full.Container.Artist.Canvas.Visible = true
	Full.Container.Artist.Header.Visible = true
	Full.Container.Artist.Sections.Visible = true

	ArtistPageProperties.LoadingArtist = false
end

function LoadCurrentSongDetails()
	if DetailsPageProperties.LoadingDetails then return end

	local CurrentSongId = Queue.GetCurrentSongId()
	local Metadata = Queue.GetCurrentMetadata()

	if not CurrentSongId then return end
	if not Metadata then return end
	if Metadata.Id ~= CurrentSongId then return end

	local IsShared = events.Main.Sharing.IsShared:InvokeServer("Song", CurrentSongId)

	DetailsPageProperties.LoadingDetails = true
	DetailsPageProperties.CurrentSongLoaded = CurrentSongId

	Full.Util.DetailsBackground.Background.Image = Utilities.GetCoverForSong(CurrentSongId)

	Full.Container.Details.Util.Loading.Visible = true

	Full.Container.Details.Action.Visible = false
	Full.Container.Details.Canvas.Visible = false
	Full.Container.Details.Header.Visible = false
	Full.Container.Details.Sections.Visible = false

	Main.SetPage("Details")

	-- Details
	-- Details / Canvas

	Full.Container.Details.Canvas.Art.Photo.Image = Utilities.GetCoverForSong(CurrentSongId)
	Full.Container.Details.Canvas.Title.Text = Metadata.Title
	Full.Container.Details.Canvas.Source.Text = Metadata.Artist

	-- Details / Artist

	local C1, C2 = Utilities.GenerateArtistGradient(Metadata.Artist)

	Full.Container.Details.Sections.Artist.Container.Artist.Value.Text = Metadata.Artist
	Full.Container.Details.Sections.Artist.Container.Artist.Art.gradient.Color = ColorSequence.new(C1, C2)
	Full.Container.Details.Sections.Artist.Container.Artist.Art.Initials.Text = Utilities.GetInitials(Metadata.Artist)

	-- Details / Lyrics
	print(CurrentSongId)
	task.spawn(function()
		local Lyrics = events.Modules.LyricsEngine.GetLyrics:InvokeServer(CurrentSongId)
		print(Lyrics)
	end)
	if not NowPlayingProperties.CurrentLyricsLoaded then
		NowPlayingProperties["CurrentLyricsLoaded"] = _G.ALL_LYRICS[CurrentSongId]
		print(NowPlayingProperties.CurrentLyricsLoaded)
	end
	if NowPlayingProperties.CurrentLyricsLoaded and NowPlayingProperties.CurrentLyricsLoaded.SoundId == CurrentSongId then
		local CompiledLyrics = {}

		for i, Line in NowPlayingProperties.CurrentLyricsLoaded.Lyrics do
			if Line.Id == "CERTIFICATION" then
				table.insert(CompiledLyrics, "\n" .. Line.Line)
			else
				table.insert(CompiledLyrics, Line.Line)
			end
		end

		Full.Container.Details.Sections.Lyrics.Visible = true
		Full.Container.Details.Sections.Lyrics.DisplayLyrics.Text = table.concat(CompiledLyrics, "\n")
	else
		Full.Container.Details.Sections.Lyrics.Visible = false
	end

	-- Details / More Details

	if Metadata.Tags then
		local Genre = string.gsub(Utilities.CapitalizeWords(Metadata.Tags[1]), "-", " ")

		Full.Container.Details.Sections.Details.Container.Genre.Visible = true
		Full.Container.Details.Sections.Details.Container.Genre.Value.Text = Genre
	else
		Full.Container.Details.Sections.Details.Container.Genre.Visible = false
	end

	Full.Container.Details.Sections.Details.Container.Duration.Value.Text = Utilities.FormatSecondsToHM(Metadata.Duration, true)
	Full.Container.Details.Sections.Details.Container.AssetId.Value.Text = CurrentSongId

	if Metadata.UpdateTime then
		local EpochTime = Utilities.ISOToEpoch(Metadata.UpdateTime)

		if EpochTime then
			local EpochData = Utilities.FormatEpochData(EpochTime)

			Full.Container.Details.Sections.Dates.Container.Updated.Visible = true
			Full.Container.Details.Sections.Dates.Container.Updated.Value.Text =
				`{EpochData.Calender.Month.Long} {EpochData.Calender.Day}, {EpochData.Calender.Year.Long}`
		else
			Full.Container.Details.Sections.Dates.Container.Updated.Visible = false
		end
	else
		Full.Container.Details.Sections.Dates.Container.Updated.Visible = false
	end

	if Metadata.CreateTime then
		local EpochTime = Utilities.ISOToEpoch(Metadata.CreateTime)

		if EpochTime then
			local EpochData = Utilities.FormatEpochData(EpochTime)

			Full.Container.Details.Sections.Dates.Container.Released.Visible = true
			Full.Container.Details.Sections.Dates.Container.Released.Value.Text = 
				`{EpochData.Calender.Month.Long} {EpochData.Calender.Day}, {EpochData.Calender.Year.Long}`
		else
			Full.Container.Details.Sections.Dates.Container.Released.Visible = false
		end
	else
		Full.Container.Details.Sections.Dates.Container.Released.Visible = false
	end

	if IsShared then
		local EpochData = Utilities.FormatEpochData(IsShared.LatestDate)
		local Success, Username = pcall(function()
			return Players:GetNameFromUserIdAsync(IsShared.LatestSender)
		end)

		if Success then
			Full.Container.Details.Sections.Sharing.Visible = true

			Full.Container.Details.Sections.Sharing.Container.TotalShares.Value.Text = IsShared.TotalCount
			Full.Container.Details.Sections.Sharing.Container.Sender.Value.Text = "@" .. Username
			Full.Container.Details.Sections.Sharing.Container.Date.Value.Text = 
				`{EpochData.Calender.Month.Long} {EpochData.Calender.Day}, {EpochData.Calender.Year.Long} {EpochData.Time.Hour}:{EpochData.Time.Minutes} {EpochData.Time.Period}`

		else
			Full.Container.Details.Sections.Sharing.Visible = false
		end
	else
		Full.Container.Details.Sections.Sharing.Visible = false
	end

	DetailsPageProperties.LoadingDetails = false

	Full.Container.Details.Util.Loading.Visible = false

	Full.Container.Details.Action.Visible = true
	Full.Container.Details.Canvas.Visible = true
	Full.Container.Details.Header.Visible = true
	Full.Container.Details.Sections.Visible = true
end

-- Bar
-- Bar / Dragging

local function GetCorrectedPos(input)
	return Vector2.new(input.Position.X, input.Position.Y - GuiService.TopbarInset.Height)
end

local function Update(input)
	local CurrentPos = GetCorrectedPos(input)
	local Delta = CurrentPos - InterfaceDragProperties.MainDragStart
	local NewPos = UDim2.new(
		InterfaceDragProperties.MainStartPos.X.Scale, 
		InterfaceDragProperties.MainStartPos.X.Offset + Delta.X,
		InterfaceDragProperties.MainStartPos.Y.Scale, 
		InterfaceDragProperties.MainStartPos.Y.Offset + Delta.Y
	)

	TweenService:Create(ui.Interface, smooth, {Position = NewPos}):Play()
end

local function DisplayTuckScreen(State)
	if State then
		Bar.page:JumpTo(Bar.Tucked)

		if InterfaceDragProperties.SnappedTo == "Left" then
			Bar.Tucked.list.HorizontalAlignment = Enum.HorizontalAlignment.Right

			TweenService:Create(Bar.Tucked.LeftArrow, normal, {ImageTransparency = 1}):Play()
			TweenService:Create(Bar.Tucked.LeftArrow.scale, normal, {Scale = 0}):Play()

			TweenService:Create(Bar.Tucked.RightArrow, normal, {ImageTransparency = 0}):Play()
			TweenService:Create(Bar.Tucked.RightArrow.scale, normal, {Scale = 1}):Play()

		else
			Bar.Tucked.list.HorizontalAlignment = Enum.HorizontalAlignment.Left

			TweenService:Create(Bar.Tucked.LeftArrow, normal, {ImageTransparency = 0}):Play()
			TweenService:Create(Bar.Tucked.LeftArrow.scale, normal, {Scale = 1}):Play()

			TweenService:Create(Bar.Tucked.RightArrow, normal, {ImageTransparency = 1}):Play()
			TweenService:Create(Bar.Tucked.RightArrow.scale, normal, {Scale = 0}):Play()
		end
	else
		Bar.page:JumpTo(Bar.NowPlaying)

		TweenService:Create(Bar.Tucked.LeftArrow, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(Bar.Tucked.LeftArrow.scale, normal, {Scale = 0}):Play()

		TweenService:Create(Bar.Tucked.RightArrow, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(Bar.Tucked.RightArrow.scale, normal, {Scale = 0}):Play()
	end
end

local function UntuckInterface()
	local ScreenSize = camera.ViewportSize
	local FrameSize = ui.Interface.AbsoluteSize
	local currentCenterX = ui.Interface.AbsolutePosition.X + (FrameSize.X / 2)
	local currentCenterY = (ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height) + (FrameSize.Y / 2)
	local targetX = currentCenterX

	if currentCenterX < ScreenSize.X / 2 then
		targetX = (FrameSize.X / 2) + InterfaceDragProperties.Padding.Left
		InterfaceDragProperties.SnappedTo = "Left"

	else
		targetX = ScreenSize.X - (FrameSize.X / 2) - InterfaceDragProperties.Padding.Right
		InterfaceDragProperties.SnappedTo = "Right"
	end

	InterfaceDragProperties.Tucked = false

	DisplayTuckScreen(false)

	TweenService:Create(ui.Interface, smooth, {
		Position = UDim2.new(0, targetX, 0, currentCenterY)}):Play()
end

local function SnapToNearestSide(Tuck)
	if MastersBackend.Store and MastersBackend.Store.IslandLyrics and MastersBackend.Store.IslandLyrics.Expanded then
		-- island lyrics mode: stay where it was released, just keep it on screen
		local ScreenSize = camera.ViewportSize
		local FrameSize = ui.Interface.AbsoluteSize
		local rawCenterX = ui.Interface.AbsolutePosition.X + (FrameSize.X / 2)
		local rawCenterY = (ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height) + (FrameSize.Y / 2)
		local targetX = math.clamp(rawCenterX, FrameSize.X / 2 + 8, math.max(FrameSize.X / 2 + 8, ScreenSize.X - FrameSize.X / 2 - 8))
		local targetY = math.clamp(rawCenterY, FrameSize.Y / 2 + 8, math.max(FrameSize.Y / 2 + 8, ScreenSize.Y - FrameSize.Y / 2 - 8))
		InterfaceDragProperties.Tucked = false
		DisplayTuckScreen(false)
		TweenService:Create(ui.Interface, smooth, {Position = UDim2.new(0, targetX, 0, targetY)}):Play()
		return
	end
	local ScreenSize = camera.ViewportSize
	local FrameSize = ui.Interface.AbsoluteSize

	local rawCenterX = ui.Interface.AbsolutePosition.X + (FrameSize.X / 2)
	local rawCenterY = (ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height) + (FrameSize.Y / 2)
	local currentCenterX = math.clamp(rawCenterX, 0, ScreenSize.X)
	local currentCenterY = math.clamp(rawCenterY, 0, ScreenSize.Y)
	local targetX = currentCenterX

	if currentCenterX < ScreenSize.X / 2 then
		InterfaceDragProperties.SnappedTo = "Left"
		if Tuck then
			-- Use TuckDepth relative to 0
			targetX = 0 - InterfaceDragProperties.TuckDepth
			InterfaceDragProperties.Tucked = true
			DisplayTuckScreen(true)
		else
			targetX = (FrameSize.X / 2) + InterfaceDragProperties.Padding.Left
			InterfaceDragProperties.Tucked = false
			DisplayTuckScreen(false)
		end
	else
		InterfaceDragProperties.SnappedTo = "Right"
		if Tuck then
			-- Use TuckDepth relative to Max Width
			targetX = ScreenSize.X + InterfaceDragProperties.TuckDepth
			InterfaceDragProperties.Tucked = true
			DisplayTuckScreen(true)
		else
			targetX = ScreenSize.X - (FrameSize.X / 2) - InterfaceDragProperties.Padding.Right
			InterfaceDragProperties.Tucked = false
			DisplayTuckScreen(false)
		end
	end

	local minY = (FrameSize.Y / 2) + InterfaceDragProperties.Padding.Top
	local maxY = ScreenSize.Y - (FrameSize.Y / 2) - InterfaceDragProperties.Padding.Bottom
	local success, targetY = pcall(function()
		return math.clamp(currentCenterY, minY, maxY)
	end)

	if not success then
		targetY = ScreenSize.Y / 2
	end

	TweenService:Create(ui.Interface, smooth, {
		Position = UDim2.new(0, targetX, 0, targetY)}):Play()
end
print("loaded")
Bar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		InterfaceDragProperties.MainDrag = true
		InterfaceDragProperties.MainDragStart = GetCorrectedPos(input)
		InterfaceDragProperties.MainStartPos = ui.Interface.Position

		InterfaceDragProperties.DragStarted:Fire()

		local connection
		connection = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()

				InterfaceDragProperties.MainDrag = false
				InterfaceDragProperties.DragReleased:Fire()

				task.delay(.05, function()
					InterfaceDragProperties.MainCurrentlyDragged = false
				end)

				if MastersBackend.Store and MastersBackend.Store.IslandLyrics and MastersBackend.Store.IslandLyrics.Expanded then
					-- island lyrics mode: stay where dropped, just keep it on screen
					local ScreenSize = camera.ViewportSize
					local FrameSize = ui.Interface.AbsoluteSize
					local cX = math.clamp(ui.Interface.AbsolutePosition.X + FrameSize.X / 2, FrameSize.X / 2 + 8, math.max(FrameSize.X / 2 + 8, ScreenSize.X - FrameSize.X / 2 - 8))
					local cY = math.clamp((ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height) + FrameSize.Y / 2, FrameSize.Y / 2 + 8, math.max(FrameSize.Y / 2 + 8, ScreenSize.Y - FrameSize.Y / 2 - 8))
					TweenService:Create(ui.Interface, smooth, {Position = UDim2.new(0, cX, 0, cY)}):Play()
					return
				end
				local ScreenSize = camera.ViewportSize
				local FrameSize = ui.Interface.AbsoluteSize
				local currentCenterX = ui.Interface.AbsolutePosition.X + (FrameSize.X / 2)
				local currentCenterY = (ui.Interface.AbsolutePosition.Y + GuiService.TopbarInset.Height) + (FrameSize.Y / 2)
				local targetX = currentCenterX
				local targetY = currentCenterY

				InterfaceDragProperties.Tucked = false
				InterfaceDragProperties.SnappedTo = "None"

				DisplayTuckScreen(false)

				if currentCenterX < (InterfaceDragProperties.Padding.Left * -1) then
					targetX = -InterfaceDragProperties.TuckDepth
					InterfaceDragProperties.Tucked = true
					InterfaceDragProperties.SnappedTo = "Left"

					DisplayTuckScreen(true)

				elseif currentCenterX > (ScreenSize.X - (InterfaceDragProperties.Padding.Right * -1)) then
					targetX = ScreenSize.X + InterfaceDragProperties.TuckDepth
					InterfaceDragProperties.Tucked = true
					InterfaceDragProperties.SnappedTo = "Right"

					DisplayTuckScreen(true)

				else
					local distToLeft = currentCenterX 
					local distToRight = ScreenSize.X - currentCenterX
					local distToTop = currentCenterY
					local minDistance = math.min(distToLeft, distToRight, distToTop)

					if minDistance == distToLeft then
						targetX = (FrameSize.X / 2) + InterfaceDragProperties.Padding.Left
						InterfaceDragProperties.SnappedTo = "Left"

					elseif minDistance == distToRight then
						targetX = ScreenSize.X - (FrameSize.X / 2) - InterfaceDragProperties.Padding.Right
						InterfaceDragProperties.SnappedTo = "Right"

					else
						targetY = (FrameSize.Y / 2) + InterfaceDragProperties.Padding.Top
						InterfaceDragProperties.SnappedTo = "Top"
					end

					local maxBottom = ScreenSize.Y - (FrameSize.Y / 2) - InterfaceDragProperties.Padding.Bottom

					if targetY > maxBottom then
						targetY = maxBottom
					end

					if InterfaceDragProperties.SnappedTo == "Top" then
						targetX = math.clamp(targetX, (FrameSize.X / 2) + InterfaceDragProperties.Padding.Left, ScreenSize.X - (FrameSize.X / 2) - InterfaceDragProperties.Padding.Right)
					end
				end

				TweenService:Create(ui.Interface, smooth, {
					Position = UDim2.new(0, targetX, 0, targetY)}):Play()
			end
		end)
	end
end)

Bar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		InterfaceDragProperties.MainDragInput = input
	end
end)

InputService.InputChanged:Connect(function(input)
	if input == InterfaceDragProperties.MainDragInput and InterfaceDragProperties.MainDrag then
		if (GetCorrectedPos(input) - InterfaceDragProperties.MainDragStart).Magnitude > 2 then
			InterfaceDragProperties.MainCurrentlyDragged = true
		end

		Update(input)
	end
end)

InterfaceDragProperties.DragStarted:Connect(function()
	Utilities.Haptic(1, .01)
end)

InterfaceDragProperties.DragReleased:Connect(function()
	Utilities.Haptic(1, .01)
end)

--

Bar.MouseButton1Click:Connect(function()
	if InterfaceDragProperties.MainCurrentlyDragged then return end

	if Bar.page.CurrentPage == Bar.Tucked then
		UntuckInterface()
	else
		Main.SetLastPosition(ui.Interface.Position)
		Main.SetState("Full")
	end
end)

Bar.NowPlaying.Content.Controls.PlayPause.MouseButton1Click:Connect(function()
	events.Playback.PlayPause:Fire()
end)

-- Bar / Animations

Bar.NowPlaying.Content.Controls.PlayPause.MouseEnter:Connect(function()
	TweenService:Create(Bar.NowPlaying.Content.Controls.PlayPause.Icon.scale, normal, {Scale = 1.2}):Play()
end)

Bar.NowPlaying.Content.Controls.PlayPause.MouseButton1Down:Connect(function()
	TweenService:Create(Bar.NowPlaying.Content.Controls.PlayPause.Icon.scale, normal, {Scale = .6}):Play()
end)

Bar.NowPlaying.Content.Controls.PlayPause.InputEnded:Connect(function()
	TweenService:Create(Bar.NowPlaying.Content.Controls.PlayPause.Icon.scale, bounce, {Scale = 1}):Play()
end)
-- Try to force-start the internal state machine
if _G.Masters then
	_G.Masters.Loaded = true
	_G.Masters.Initialized = true
end
print("loaded")
-- Initiations

Main.SetPage("Discovery")
Main.SetState("Bar")
print("loaded")
SnapToNearestSide(true)
print("loaded")
InitiateSettings()
print("loaded")
Audios.LoadAudios(AudiosLoaded)
print("loaded")
-- Full

local ArtistIndex = {}
local ArtistCommitted = 1
local PlaylistIndex = {}
local PlaylistComitted = 1
local SongIndex = {}
local SongCommitted = 1
local StationIndex = {}
local StationComitted = 1
print("loaded")
function AddSongItem(DataInfo: SongItemProperties)
	SongCommitted += 1
	SongIndex[SongCommitted] = DataInfo

	local Data = SongIndex[SongCommitted]
	local SongId = tonumber(Data.MasterPool[Data.Pointer])

	if not SongId then return end
	if not Data then return end

	local Item = Data.Item:Clone()
	if not Item:IsA("ImageButton") then return end

	Item.Name = SongId
	Item:AddTag("MastersSong_" .. Data.Source)

	Item.Information.Source.Text = Data.SongInfo.Artist
	Item.Information.Title.Text = Data.SongInfo.Title

	Item.Art.Photo.Image = Utilities.GetCoverForSong(SongId)

	Item.Parent = Data.Container

	-- 

	local Connection = Queue.TrackChanged:Connect(function(CurrentSongId)
		if CurrentSongId == SongId then
			TweenService:Create(Item.Art.Photo.CurrentlyPlaying, normal, {GroupTransparency = 0}):Play()
		else
			TweenService:Create(Item.Art.Photo.CurrentlyPlaying, normal, {GroupTransparency = 1}):Play()
		end
	end)

	if Data.ItemProperties then
		for Property, Value in Data.ItemProperties do
			if Property == "Pinned" then
				if Value then
					Item.LayoutOrder = -99999
				else
					Item.LayoutOrder = 1
				end

				Item.Art.Photo.Pinned.Visible = Value

				continue

			elseif Property == "Shared" then

				local Success, Username = pcall(function()
					return Players:GetNameFromUserIdAsync(Value.Sender)
				end)

				if not Success then continue end

				Item.Sender.Profile.Image = Utilities.GetPlayerThumbnail(Value.Sender)
				Item.Sender.Username.Text = "From @" .. Username

				continue
			end

			Item[Property] = Value
		end
	end

	--

	local SongInfo: SongInfo = {
		Artist = Data.SongInfo.Artist,
		ContextName = Data.ContextName,
		MasterPool = Data.MasterPool,
		Pointer = Data.Pointer,
		Title = Data.SongInfo.Title,
		SongId = SongId,
	}

	Item.Destroying:Connect(function()
		Connection:Disconnect()
	end)

	Item.MouseButton1Click:Connect(function()
		callback_Play(SongInfo)
	end)

	Item.MouseButton2Click:Connect(function()
		PromptSongOptions(Data.Source, SongInfo)
	end)

	Item.TouchLongPress:Connect(function()
		PromptSongOptions(Data.Source, SongInfo, true)
	end)

	if Data.Item == ui.Storage.Items["Item(Big)"] or Data.Item == ui.Storage.Items["Item(Shared)"] then

		local Hovering = false

		local function Deactivate()
			HoverBackground(false)

			Hovering = false

			Item.ZIndex = 1
			Item.Art.Photo.Hover.Glow:SetAttribute("Enabled", false)

			TweenService:Create(Item.Art.Photo.scale, smooth, {Scale = 1}):Play()

			if InputService.MouseEnabled then
				TweenService:Create(Item.Art.Photo.Hover, smooth, {GroupTransparency = 1}):Play()
			end

			TweenService:Create(Item.Art.Shadow, smooth, {ImageTransparency = .5, SliceScale = .15}):Play()
			TweenService:Create(Item.Art.Shadow.scale, smooth, {Scale = 1}):Play()

			TweenService:Create(Item.list, smooth, {Padding = UDim.new(0, 10)}):Play()
		end

		Item.MouseButton2Click:Connect(Deactivate)
		Item.TouchLongPress:Connect(Deactivate)
		Item.MouseButton1Down:Connect(Deactivate)
		Item.InputEnded:Connect(Deactivate)

		Item.MouseEnter:Connect(function()
			Hovering = true

			Item.ZIndex = 2
			Item.Art.Photo.Hover.Glow:SetAttribute("Enabled", true)

			HoverBackground(true, Utilities.GetCoverForSong(SongId))

			TweenService:Create(Item.Art.Photo.scale, normal, {Scale = 1.2}):Play()

			TweenService:Create(Item.Art.Shadow, normal, {ImageTransparency = 0, SliceScale = .2}):Play()
			TweenService:Create(Item.Art.Shadow.scale, normal, {Scale = 1.4}):Play()

			TweenService:Create(Item.list, normal, {Padding = UDim.new(0, 20)}):Play()

			if InputService.MouseEnabled then
				TweenService:Create(Item.Art.Photo.Hover, normal, {GroupTransparency = 0}):Play()
			end
		end)

		Item.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Hovering then

				local MouseLocation = InputService:GetMouseLocation()
				local RelativePosition = MouseLocation - Item.Art.Photo.Hover.AbsolutePosition

				TweenService:Create(Item.Art.Photo.Hover.Glow, normal, {
					Position = UDim2.fromOffset(RelativePosition.X, RelativePosition.Y)}):Play()
			end
		end)

	elseif Data.Item == ui.Storage.Items["Item(Small)"] or Data.Item == ui.Storage.Items["Item(Vertical)"] or
		Data.Item == ui.Storage.Items["Item(SearchResults)"] or Data.Item == ui.Storage.Items["Item(Playlist)"] then

		if Data.Item == ui.Storage.Items["Item(Vertical)"] then
			local Duration = Utilities.FormatTime(Data.SongInfo.Duration or 0)

			Item.Duration.Text = Duration.Minutes .. ":" .. Duration.Seconds
		end

		local function Deactivate()
			Item.ZIndex = 1

			HoverBackground(false)

			TweenService:Create(Item, smooth, {BackgroundTransparency = 1}):Play()
			TweenService:Create(Item.stroke, smooth, {Transparency = 1}):Play()

			TweenService:Create(Item.Art.Shadow, smooth, {ImageTransparency = .5}):Play()
		end

		Item.MouseButton2Click:Connect(Deactivate)
		Item.TouchLongPress:Connect(Deactivate)
		Item.MouseButton1Down:Connect(Deactivate)
		Item.InputEnded:Connect(Deactivate)

		Item.MouseEnter:Connect(function()
			Item.ZIndex = 2

			HoverBackground(true, Utilities.GetCoverForSong(SongId))

			TweenService:Create(Item, normal, {BackgroundTransparency = .9}):Play()
			TweenService:Create(Item.stroke, normal, {Transparency = .9}):Play()

			TweenService:Create(Item.Art.Shadow, normal, {ImageTransparency = 1}):Play()
		end)
	end
end
print("loaded")
function AddArtistItem(DataInfo: ArtistItemProperties)
	ArtistCommitted += 1
	ArtistIndex[ArtistCommitted] = DataInfo

	local Data = ArtistIndex[ArtistCommitted]

	local Item = Data.Item:Clone()
	if not Item:IsA("ImageButton") then return end

	local Initial = Utilities.GetInitials(Data.ArtistName)
	local C1, C2 = Utilities.GenerateArtistGradient(Data.ArtistName)

	Item.Name = Data.ArtistName
	Item:AddTag("MastersArtist_" .. Data.Source)

	Item.Information.ArtistName.Text = Data.ArtistName

	Item.Art.Photo.Initials.Text = Initial
	Item.Art.Photo.gradient.Color = ColorSequence.new(C1, C2)

	Item.Parent = Data.Container

	--

	if Data.ItemProperties then
		for Property, Value in Data.ItemProperties do
			if Property == "Pinned" then
				if Value then
					Item.LayoutOrder = -99999
				else
					Item.LayoutOrder = 1
				end

				Item.Art.Photo.Pinned.Visible = Value

				continue

			elseif Property == "Shared" then

				local Success, Username = pcall(function()
					return Players:GetNameFromUserIdAsync(Value.Sender)
				end)

				if not Success then continue end

				Item.Sender.Profile.Image = Utilities.GetPlayerThumbnail(Value.Sender)
				Item.Sender.Username.Text = "From @" .. Username

				continue
			end

			Item[Property] = Value
		end
	end

	--

	Item.MouseButton1Click:Connect(function()
		callback_ViewArtist(Data.ArtistName)
	end)

	Item.MouseButton2Click:Connect(function()
		PromptArtistOption(Data.Source, Data.ArtistName)
	end)

	Item.TouchLongPress:Connect(function()
		PromptArtistOption(Data.Source, Data.ArtistName, true)
	end)
end

function AddPlaylistItem(DataInfo: PlaylistItemProperties)
	PlaylistComitted += 1
	PlaylistIndex[PlaylistComitted] = DataInfo

	local Data = PlaylistIndex[PlaylistComitted]

	local Item = Data.Item:Clone()
	if not Item:IsA("ImageButton") then return end

	local Success, Username = pcall(function()
		return Players:GetNameFromUserIdAsync(Data.PlaylistData.CreatorId)
	end)
	if not Success then return end

	Item.Name = Data.PlaylistData.Name
	Item:AddTag("MastersPlaylist_" .. Data.PlaylistData.PlaylistId)

	Item.Information.Title.Text = Data.PlaylistData.Name
	Item.Information.Source.Text = Username

	if Data.PlaylistData.Cover == "" then
		if #Data.PlaylistData.Songs == 0 then
			Item.Art.Photo.Image = "rbxassetid://74118540785733"
			Item.Art.Photo.Default.Visible = false

		elseif #Data.PlaylistData.Songs == 1 then
			Item.Art.Photo.Image = ""

			Item.Art.Photo.Default.Visible = true
			Item.Art.Photo.Default.grid.CellSize = UDim2.fromScale(1, 1)

			Item.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[1])

		elseif #Data.PlaylistData.Songs == 2 then
			Item.Art.Photo.Image = ""

			Item.Art.Photo.Default.Visible = true
			Item.Art.Photo.Default.grid.CellSize = UDim2.fromScale(.5, 1)

			Item.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[1])
			Item.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[2])

		elseif #Data.PlaylistData.Songs == 3 then
			Item.Art.Photo.Image = ""

			Item.Art.Photo.Default.Visible = true
			Item.Art.Photo.Default.grid.CellSize = UDim2.fromScale(1, .34)

			Item.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[1])
			Item.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[2])
			Item.Art.Photo.Default.CoverC.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[3])

		elseif #Data.PlaylistData.Songs > 3 then
			Item.Art.Photo.Image = ""

			Item.Art.Photo.Default.Visible = true
			Item.Art.Photo.Default.grid.CellSize = UDim2.fromScale(.5, .5)

			Item.Art.Photo.Default.CoverA.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[1])
			Item.Art.Photo.Default.CoverB.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[2])
			Item.Art.Photo.Default.CoverC.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[3])
			Item.Art.Photo.Default.CoverD.Image = Utilities.GetCoverForSong(Data.PlaylistData.Songs[4])
		end
	else
		Item.Art.Photo.Image = Data.PlaylistData.Cover
	end

	Item.Parent = Data.Container

	--

	if Data.ItemProperties then
		for Property, Value in Data.ItemProperties do
			if Property == "Pinned" then
				if Value then
					Item.LayoutOrder = -99999
				else
					Item.LayoutOrder = 1
				end

				Item.Art.Photo.Pinned.Visible = Value

				continue

			elseif Property == "Shared" then

				local Success, Username = pcall(function()
					return Players:GetNameFromUserIdAsync(Value.Sender)
				end)

				if not Success then continue end

				Item.Sender.Profile.Image = Utilities.GetPlayerThumbnail(Value.Sender)
				Item.Sender.Username.Text = "From @" .. Username

				continue
			end

			Item[Property] = Value
		end
	end

	--

	Item.MouseButton1Click:Connect(function()
		callback_ViewPlaylist(Data.PlaylistData.CreatorId, Data.PlaylistData.PlaylistId)
	end)

	Item.MouseButton2Click:Connect(function()
		PromptPlaylistOption(Data.Source, DataInfo.PlaylistData)
	end)

	Item.TouchLongPress:Connect(function()
		PromptPlaylistOption(Data.Source, DataInfo.PlaylistData, true)
	end)

	--

	if Data.Item == ui.Storage.Items["Playlist(Big)"] or Data.Item == ui.Storage.Items["Playlist(Shared)"] then
		local Hovering = false

		local function Deactivate()
			Hovering = false

			Item.ZIndex = 1
			Item.Art.Photo.Hover.Glow:SetAttribute("Enabled", false)

			TweenService:Create(Item.Art.Photo.scale, smooth, {Scale = 1}):Play()

			if InputService.MouseEnabled then
				TweenService:Create(Item.Art.Photo.Hover, smooth, {GroupTransparency = 1}):Play()
			end

			TweenService:Create(Item.Art.Shadow, smooth, {ImageTransparency = .5, SliceScale = .15}):Play()
			TweenService:Create(Item.Art.Shadow.scale, smooth, {Scale = 1}):Play()

			TweenService:Create(Item.list, smooth, {Padding = UDim.new(0, 10)}):Play()
		end

		Item.MouseButton2Click:Connect(Deactivate)
		Item.TouchLongPress:Connect(Deactivate)
		Item.MouseButton1Down:Connect(Deactivate)
		Item.InputEnded:Connect(Deactivate)

		Item.MouseEnter:Connect(function()
			Hovering = true

			Item.ZIndex = 2
			Item.Art.Photo.Hover.Glow:SetAttribute("Enabled", true)

			TweenService:Create(Item.Art.Photo.scale, normal, {Scale = 1.2}):Play()

			TweenService:Create(Item.Art.Shadow, normal, {ImageTransparency = 0, SliceScale = .2}):Play()
			TweenService:Create(Item.Art.Shadow.scale, normal, {Scale = 1.4}):Play()

			TweenService:Create(Item.list, normal, {Padding = UDim.new(0, 20)}):Play()

			if InputService.MouseEnabled then
				TweenService:Create(Item.Art.Photo.Hover, normal, {GroupTransparency = 0}):Play()
			end
		end)

		Item.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 and Hovering then

				local MouseLocation = InputService:GetMouseLocation()
				local RelativePosition = MouseLocation - Item.Art.Photo.Hover.AbsolutePosition

				TweenService:Create(Item.Art.Photo.Hover.Glow, normal, {
					Position = UDim2.fromOffset(RelativePosition.X, RelativePosition.Y)}):Play()
			end
		end)
	end
end

function AddStationItem(DataInfo: StationItemProperties)
	StationComitted += 1
	StationIndex[StationComitted] = DataInfo

	local Data = StationIndex[StationComitted]

	local Item = Data.Item:Clone()
	if not Item:IsA("ImageButton") then return end

	Item.Name = Data.StationData.Name
	Item:AddTag("MastersStations_" .. Data.StationData.StationId)

	Item.Content.Title.Text = Data.StationData.Name
	Item.Content.Description.Text = Data.StationData.Description

	if Data.StationData.Cover == "" then
		Item.Util.Visuals.Art.Image = "rbxassetid://74118540785733"
		Item.Util.Visuals.Fade.Image = "rbxassetid://74118540785733"
	else
		Item.Util.Visuals.Art.Image = Data.StationData.Cover
		Item.Util.Visuals.Fade.Image = Data.StationData.Cover
	end

	Item.Parent = Data.Container

	--

	if Data.ItemProperties then
		for Property, Value in Data.ItemProperties do
			Item[Property] = Value
		end
	end

	--

	Item.MouseButton1Click:Connect(function()
		callback_ViewStation(Data.Online, Data.StationData.StationId)
	end)

	Item.MouseButton2Click:Connect(function()
		PromptStationOption(Data.Source, Data.StationData, Data.Online)
	end)

	Item.TouchLongPress:Connect(function()
		PromptStationOption(Data.Source, Data.StationData, Data.Online, true)
	end)
end

-- Full / Discovery

function LoadAllAudios()

	ui.Interface.Interactable = false
	Full.Content.Loading.Visible = true

	-- Clearance

	for i, residual in Full.Container.Discovery:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	--[[ PreparenessChanged only fires on a TRANSITION, and every section below is
	     built asynchronously (the metadata fetches take seconds). So on a rebuild -
	     or on any load that finishes after Masters is already open - the signal has
	     been and gone by the time these connect, and the tiles sit on "Loading..."
	     for good. Run each body exactly once: straight away if the UI is already up,
	     otherwise on the next transition. Every body waits for readiness itself, so
	     one run is all it ever needed. ]]
	--[[ Every call destroys the previous build's containers, but its connected
	     closures live on and error out on the corpses. Stamp each build and let
	     only the current one draw. ]]
	MastersDiscoveryGen = (MastersDiscoveryGen or 0) + 1
	local myGen = MastersDiscoveryGen

	local function WhenReady(fn)
		local ran, conn = false, nil
		local function once()
			if ran or myGen ~= MastersDiscoveryGen then return end
			ran = true
			fn()
		end
		conn = Main.PreparenessChanged:Connect(function()
			if conn then conn:Disconnect() end
			once()
		end)
		if Main.GetState() == "Full" then task.spawn(once) end
	end

	-- Curation
	-- Curation / Datas

	local Algorithm = events.Main.Algorithm.FetchAlgorithm:InvokeServer()
	local Preferences = events.Main.Preferences.FetchPreference:InvokeServer()
	local Library = events.Main.Library.FetchLibrary:InvokeServer()

	if not Algorithm or not Preferences or not Library then return end

	local Curations = {
		KeepPlaying = {},
		ForYou = {},
		Explore = {},
		Genres = {},
		CustomSections = {},
		LocalStations = {},
		OnlineStations = {}
	}

	-- Curation / Functions

	-- [[ MASTERS: THE IMMORTAL HIJACK ]]

	-- 1. THE HIJACKED FUNCTION
	-- We define this FIRST so the rest of the script uses OUR version
	local function RemoveNegatives(SongIds)
		local Cleaned = {}
		if not SongIds or type(SongIds) ~= "table" then return Cleaned end

		local Prefs = (MASTERS_DEFAULT_SETTINGS and MASTERS_DEFAULT_SETTINGS.Data) or {}
		local BlockedArtists = (Prefs.Artists and Prefs.Artists.Block) or {}
		local DislikedSongs = (Prefs.Songs and Prefs.Songs.Dislike) or {}

		for _, Song in pairs(SongIds) do
			local id = (type(Song) == "table" and (Song.Id or Song.SongId or Song.AssetId)) or Song
			if id and not DislikedSongs[id] then
				if type(Song) ~= "table" or not Song.Artist or not BlockedArtists[Song.Artist] then
					table.insert(Cleaned, Song)
				end
			end
		end
		return Cleaned
	end

	-- 2. LOCK THE FUNCTION NAME
	-- This prevents the original script from overwriting our safe version
	_G.RemoveNegatives = RemoveNegatives

	local function CurateKeepPlaying(SongIds)
		SongIds = RemoveNegatives(SongIds)

		local TopSongs = {}
		local TempTable = {}

		for _, Song in SongIds do
			table.insert(TempTable, {
				SongId = Song.SongId,
				Relevance = Song.Relevance or 0,
				LastUpdate = Song.LastUpdate or 0
			})
		end

		table.sort(TempTable, function(a, b)
			if a.Relevance == b.Relevance then
				return a.LastUpdate > b.LastUpdate
			else
				return a.Relevance > b.Relevance
			end
		end)

		for i = 1, math.min(30, #TempTable) do
			table.insert(TopSongs, TempTable[i])
		end

		Curations.KeepPlaying = TopSongs
	end

	--[[ Roblox audio tags arrive lowercase and hyphenated — "pop", "corporate-pop",
	     "traditional-ethnic-folk" — while Algorithm.Tags stores them Title-Cased
	     ("Pop"). Comparing them as whole strings can never match, which is why the
	     display paths run everything through CapitalizeWords first. Match on TOKENS
	     instead, so "Pop" also catches "corporate-pop" and "orchestral-pop". ]]
	local function TagTokens(tag)
		if type(tag) ~= "string" then return nil end

		local tokens = {}

		for word in string.gmatch(string.lower(tag), "%a+") do
			if #word > 2 then table.insert(tokens, word) end
		end

		return tokens
	end

	local function CurateForYou(SongChunk)
		local NOW = os.time()
		local SEVEN_DAYS = 604800

		--[[ Tag weights, decayed by age and keyed per token. This replaces a
		     `TopTags` set whose only fill line was commented out — every song
		     failed the tag test, so this whole section rendered empty. ]]
		local TagWeights = {}

		for _, TagEntry in Algorithm.Tags or {} do
			local timePassed = NOW - (TagEntry.LastUpdate or NOW)
			local decay = math.clamp(math.pow(.5, timePassed / SEVEN_DAYS), 0, 1)
			local tagScore = (TagEntry.Relevance or 0) * decay

			for _, token in ipairs(TagTokens(TagEntry.Tag) or {}) do
				TagWeights[token] = math.max(TagWeights[token] or 0, tagScore)
			end
		end

		--[[ Artists come from three places, strongest last: the algorithm's own
		     list, whoever is behind what has actually been played (Algorithm.Songs
		     carries the play history), and the library, where a pin outranks a
		     plain save. ]]
		local ArtistWeights = {}

		local function weighArtist(name, score)
			if type(name) ~= "string" or name == "" then return end

			local key = string.lower(name)
			ArtistWeights[key] = math.max(ArtistWeights[key] or 0, score)
		end

		for _, ArtistEntry in Algorithm.Artists or {} do
			weighArtist(ArtistEntry.Name, ArtistEntry.Relevance or 0)
		end

		for _, Played in Algorithm.Songs or {} do
			weighArtist(Played.Artist, (Played.Relevance or 0) * .5)
		end

		if Library.Artists then
			for _, SavedArtist in Library.Artists do
				weighArtist(SavedArtist.Name, SavedArtist.Pin and 100 or 50)
			end
		end

		if next(TagWeights) == nil and next(ArtistWeights) == nil then return end

		for _, Song in SongChunk do
			if type(Song) ~= "table" or not Song.Id then continue end

			-- AddSongItem writes SongInfo.Title straight onto a label
			if type(Song.Title) ~= "string" then continue end

			local IsOwned = false

			if table.find(Preferences.Songs.Favorite or {}, Song.Id) then IsOwned = true end

			if not IsOwned and Library.Songs then
				for _, LibSong in Library.Songs do
					if LibSong.SongId == Song.Id then IsOwned = true; break end
				end
			end

			if IsOwned then continue end

			-- Keep Playing is already showing these; don't serve them twice
			local playedRecently = false

			for _, Played in Algorithm.Songs or {} do
				if Played.SongId == Song.Id or Played.Id == Song.Id then
					playedRecently = true
					break
				end
			end

			if playedRecently then continue end

			local TagScore, Matches = 0, 0

			for _, Tag in Song.Tags or {} do
				local best = 0

				for _, token in ipairs(TagTokens(Tag) or {}) do
					best = math.max(best, TagWeights[token] or 0)
				end

				if best > 0 then
					TagScore = TagScore + best
					Matches = Matches + 1
				end
			end

			if Matches > 1 then TagScore = TagScore * 1.25 end   -- agreeing tags count for more

			local ArtistScore = 0

			if type(Song.Artist) == "string" then
				ArtistScore = ArtistWeights[string.lower(Song.Artist)] or 0
			end

			local Score = TagScore + ArtistScore

			--[[ No zero-floor here on purpose. CurateExplore has one
			     (`if TotalScore == 0 then TotalScore = 5 end`) and that single line
			     is what makes Explore "everything"; For You has to keep turning
			     songs away or it is just a second Explore. ]]
			if Score <= 0 then continue end

			--[[ The score lives on its own field, NOT on Relevance. Both curators
			     are handed the SAME song tables out of a chunk, and CurateExplore
			     overwrites Song.Relevance with a randomised value — which would
			     scramble the ordering and the eviction comparisons below. ]]
			Song.ForYouScore = Score

			local existingIndex = nil

			for i, Existing in Curations.ForYou do
				if Existing.Id == Song.Id then
					existingIndex = i
					break
				end
			end

			if existingIndex then
				if Score > (Curations.ForYou[existingIndex].ForYouScore or 0) then
					Curations.ForYou[existingIndex] = Song
				end

			elseif #Curations.ForYou < 30 then
				table.insert(Curations.ForYou, Song)
			else
				local MinIndex, MinScore = 1, Curations.ForYou[1].ForYouScore or 0

				for i, Elem in ipairs(Curations.ForYou) do
					if (Elem.ForYouScore or 0) < MinScore then
						MinScore = Elem.ForYouScore or 0
						MinIndex = i
					end
				end

				if Score > MinScore then
					Curations.ForYou[MinIndex] = Song
				end
			end
		end

		table.sort(Curations.ForYou, function(a, b)
			return (a.ForYouScore or 0) > (b.ForYouScore or 0)
		end)
	end

	-- [[ MASTERS: THE IMMORTAL HIJACK V2 ]]

	-- 1. HIJACKED: IsSongKnown (Fixes Line 4607)
	local function IsSongKnown(SongId)
		-- Safety check for Preferences structure
		local Prefs = (MASTERS_DEFAULT_SETTINGS and MASTERS_DEFAULT_SETTINGS.Data) or {}
		local FavSongs = (Prefs.Songs and Prefs.Songs.Favorite) or {}
		local LibSongs = (Library and Library.Songs) or {}

		-- table.find requires a REAL table. We give it FavSongs (guaranteed to be a table now).
		if table.find(FavSongs, SongId) then 
			return true 
		end

		-- Safe iteration over Library
		if type(LibSongs) == "table" then
			for _, LibSong in pairs(LibSongs) do
				if type(LibSong) == "table" and LibSong.SongId == SongId then 
					return true 
				end
			end
		end

		return false
	end

	-- 2. HIJACKED: RemoveNegatives (Updated for consistency

	-- LOCK THE FUNCTIONS
	_G.IsSongKnown = IsSongKnown

	local function CurateExplore(SongChunk)
		for _, Song in SongChunk do
			if IsSongKnown(Song.Id) then continue end

			local playedRecently = false

			for _, Played in Algorithm.Songs do
				if Played.SongId == Song.Id then playedRecently = true; break end
			end

			if playedRecently then continue end

			local ArtistScore = 0

			for _, ArtistEntry in Algorithm.Artists do
				if ArtistEntry.Name == Song.Artist then
					ArtistScore = ArtistEntry.Relevance or 0
					break
				end
			end

			local TagScore = 0

			for _, Tag in Song.Tags or {} do
				for _, TagEntry in Algorithm.Tags do
					if TagEntry.Tag == Tag then
						TagScore = math.max(TagScore, TagEntry.Relevance or 0)
					end
				end
			end

			local TotalScore = ArtistScore + TagScore

			if TotalScore == 0 then TotalScore = 5 end 

			Song.Relevance = TotalScore + math.random(1, 15)

			if #Curations.Explore < 30 then
				table.insert(Curations.Explore, Song)
			else
				local MinIndex, MinScore = 1, Curations.Explore[1].Relevance or 0

				for i, Elem in ipairs(Curations.Explore) do
					if (Elem.Relevance or 0) < MinScore then
						MinScore = Elem.Relevance or 0
						MinIndex = i
					end
				end

				if Song.Relevance > MinScore then
					Curations.Explore[MinIndex] = Song
				end
			end
		end

		table.sort(Curations.Explore, function(a, b)
			return (a.Relevance or 0) > (b.Relevance or 0)
		end)
	end

	local function GetCustomSections()
		local AllCustomSections = Configuration.GetConfiguration()

		for SectionId, SectionData in AllCustomSections.CustomSections do
			Curations.CustomSections[SectionId] = SectionData
		end
	end

	local function GetLocalStations()
		local AllLocalStations = Configuration.GetLocalStations()

		for i, StationData in AllLocalStations do
			Curations.LocalStations[StationData.StationId] = StationData
		end
	end

	local function GetOnlineStations()
		local AllOnlineStations = OnlineStations.GetOnlineStations()

		for StationId, StationData in AllOnlineStations do
			Curations.OnlineStations[StationId] = StationData
		end
	end

	-- Curation / Process
	-- Curation / Process / Keep Playing

	if #Algorithm.Songs > 0 then
		local Container = ui.Storage.Items["Container(Standard)"]:Clone()		

		local List = {}
		local Metadatas

		CurateKeepPlaying(Algorithm.Songs)

		for i, Song in Curations.KeepPlaying do
			table.insert(List, Song.SongId)
		end

		if #List > 0 then
			Metadatas = AssetService:GetAudioMetadataAsync(List)
		end

		Metadatas = RemoveNegatives(Metadatas)

		if not Metadatas then return end
		Curations.KeepPlaying = Metadatas

		Container.Name = "KeepPlaying"
		Container.LayoutOrder = 1
		Container.Header.Label.Text = "Keep Playing"
		Container.Parent =  Full.Container.Discovery

		WhenReady(function()
			repeat task.wait(1) until Main.GetState() == "Full"

			for i, Data in Metadatas do
				AddSongItem({
					Container = Container.Content,
					ContextName = "Keep Playing",
					Item = ui.Storage.Items["Item(Big)"],
					MasterPool = List,
					Pointer = i,
					SongInfo = Data,
					Source = "Standard"
				})
			end
		end)
	end

	-- Curation / Process / For You

	if #Algorithm.Tags > 0 or #Algorithm.Artists > 0 then
		task.spawn(function()
			local Container = ui.Storage.Items["Container(Standard)"]:Clone()

			Container.Name = "ForYou"
			Container.LayoutOrder = 2
			Container.Header.Label.Text = "For You"
			Container.Parent = Full.Container.Discovery

			Audios.ChunkLoaded:Connect(function(AudioPage, AudioChunk)
				AudioChunk = RemoveNegatives(AudioChunk)
				CurateForYou(AudioChunk)
			end)


			WhenReady(function()
				repeat task.wait(1) until Audios.IsLoaded() and Main.GetState() == "Full"

				local CurationCollection = {}

				for i, Data in Curations.ForYou do
					local ItemLoaded = Container.Content:FindFirstChild(Data.Id)

					table.insert(CurationCollection, Data.Id)

					if ItemLoaded then
						ItemLoaded:Destroy()
					end

					AddSongItem({
						Container = Container.Content,
						ContextName = "For You",
						Item = ui.Storage.Items["Item(Big)"],
						MasterPool = CurationCollection,
						Pointer = i,
						SongInfo = Data,
						Source = "Standard"
					})
				end
			end)
		end)
	end

	-- Curation / Process / Explore

	task.spawn(function()
		local Container = ui.Storage.Items["Container(Standard)"]:Clone()

		Container.Name = "Explore"
		Container.LayoutOrder = 3
		Container.Header.Label.Text = "Explore"
		Container.Parent = Full.Container.Discovery

		Audios.ChunkLoaded:Connect(function(AudioPage, AudioChunk)
			AudioChunk = RemoveNegatives(AudioChunk)
			CurateExplore(AudioChunk)
		end)

		WhenReady(function()
			repeat task.wait(1) until Audios.IsLoaded() and Main.GetState() == "Full"

			local CurationCollection = {}

			for i, Data in Curations.Explore do
				local ItemLoaded = Container.Content:FindFirstChild(Data.Id)

				table.insert(CurationCollection, Data.Id)

				if ItemLoaded then
					ItemLoaded:Destroy()
				end

				AddSongItem({
					Container = Container.Content,
					ContextName = "Explore",
					Item = ui.Storage.Items["Item(Big)"],
					MasterPool = CurationCollection,
					Pointer = i,
					SongInfo = Data,
					Source = "Standard"
				})
			end
		end)
	end)

	-- Curation / Process / Custom Sections

	task.spawn(function()
		if not Configuration.GetConfiguration().CustomSections then return end

		GetCustomSections()

		for SectionId, SectionData in Curations.CustomSections do
			local Metadata = Audios.GetAudioMetadataAsync(SectionData.Songs)
			if not Metadata then continue end

			local Container = ui.Storage.Items["Container(Standard)"]:Clone()

			Container.Name = SectionId
			Container.LayoutOrder = 6
			Container.Header.Label.Text = SectionData.Name
			Container.Parent =  Full.Container.Discovery

			for i, SongId in SectionData.Songs do
				AddSongItem({
					Container = Container.Content,
					ContextName = SectionData.Name,
					Item = ui.Storage.Items["Item(Big)"],
					MasterPool = SectionData.Songs,
					Pointer = i,
					SongInfo = Metadata[i],
					Source = "Standard"
				})
			end
		end
	end)

	-- Curation / Process / Stations

	task.spawn(function()
		GetLocalStations()

		if #Configuration.GetLocalStations() > 0 then
			local Container = ui.Storage.Items["Container(Stations)"]:Clone()

			Container.Name = "LocalStations"
			Container.LayoutOrder = 999
			Container.Header.Label.Text = "Local Stations"
			Container.Parent =  Full.Container.Discovery

			for StationId, StationData in Curations.LocalStations do
				AddStationItem({
					Container = Container.Content,
					Item = ui.Storage.Items["Station(Big)"],
					StationData = StationData,
					Source = "Standard",
					Online = false
				})
			end
		end
	end)

	task.spawn(function()
		if not Configuration.GetConfiguration().Stations.OnlineStations then return end

		local Container = ui.Storage.Items["Container(Stations)"]:Clone()

		Container.Name = "OnlineStations"
		Container.LayoutOrder = 1000
		Container.Header.Label.Text = "Online Stations"
		Container.Parent =  Full.Container.Discovery

		GetOnlineStations()

		for StationId, StationData in Curations.OnlineStations do
			AddStationItem({
				Container = Container.Content,
				Item = ui.Storage.Items["Station(Big)"],
				StationData = StationData,
				Source = "Standard",
				Online = true
			})
		end
	end)

	-- Curation / Process / Tags

	task.spawn(function()
		local List = {}

		Audios.ChunkLoaded:Connect(function(AudioPage, AudioChunk)
			for i, Song in AudioChunk do
				if not Song then continue end
				if not Song.Tags then continue end
				if not Song.Tags[1] then continue end

				local Tag = string.gsub(Utilities.CapitalizeWords(Song.Tags[1]), "-", " ")

				if not List[Tag] then
					List[Tag] = {}
					Curations.Genres[Tag] = {}
				end

				table.insert(List[Tag], Song.Id)
				table.insert(Curations.Genres[Tag], Song)
			end
		end)

		WhenReady(function()
			repeat task.wait(1) until Audios.IsLoaded() and Main.GetState() == "Full"

			for Tag, SongCollection in List do
				for i, SongId in SongCollection do
					local Song = Curations.Genres[Tag][i]
					if not Song then continue end

					local Container = Full.Container.Search.Suggestions:FindFirstChild(Tag)

					if not Container then
						Container = ui.Storage.Items["Container(Charts)"]:Clone()

						Container.Name = Tag
						Container.LayoutOrder = -#SongCollection
						Container.Header.Label.Text = Tag
						Container.Parent = Full.Container.Search.Suggestions
					end

					AddSongItem({
						Container = Container.Content,
						ContextName = Tag,
						Item = ui.Storage.Items["Item(Small)"],
						MasterPool = List[Tag],
						Pointer = i,
						SongInfo = Song,
						Source = "Standard"
					})

				end
			end
		end)	
	end)

	ui.Interface.Interactable = true
	Full.Content.Loading.Visible = false
end

LoadAllAudios()

-- Full / Content

Full.Content.Actions.Close.MouseButton1Click:Connect(function()
	if ui.Interface:GetAttribute("State") == "Full" then
		Main.SetState("Bar")
	end
end)

Full.Content.Actions.Sidebar.MouseButton1Click:Connect(function()
	local SidebarOpened = Main.GetSidebarStatus()

	if SidebarOpened then
		Main.Sidebar(false)
	else
		if Utilities.GetViewportRatio() > 1300 then
			Main.Sidebar(true, false)
		else
			if Main.GetOrientation() == "Landscape" then
				Main.Sidebar(true, false)
			else
				Main.Sidebar(true, true)
			end
		end
	end
end)

ui.Layer.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if ui.Interface:GetAttribute("State") == "Full" then
			Main.SetState("Bar")
		end
	end
end)

-- Lyrics Scroll Sync

local ActiveLyrics = {}
local LyricsHeartbeatConnection
local LyricsScrollProperties = {
	Scrolling = false,
	Threshold = 0
}

NowPlaying.Content.Panel.Lyrics.Shield.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.MouseWheel then

		LyricsScrollProperties.Scrolling = true
	end
end)

NowPlaying.Content.Panel.Lyrics.Shield.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		LyricsScrollProperties.Scrolling = false
	end
end)

--

local function LoadListeners()

	-- Residual

	for i, residual in NowPlaying.Content.Panel.Listeners.Scroll:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Load

	local ListenerData = events.Modules.Listeners.GetListeners:InvokeServer()
	local CurrentSongId = Queue.GetCurrentSongId()

	for UserId, Data in ListenerData do
		UserId = tonumber(UserId)
		if not UserId then continue end

		if Data.CurrentSoundId ~= CurrentSongId then continue end
		if UserId == client.UserId then continue end

		local Player = Players:GetPlayerByUserId(UserId)
		local ListenerName = (Player and Player.DisplayName) or Data.Name or ("Player " .. UserId)

		local Item = ui.Storage.Items.ListenerItem:Clone()

		Item.Name = (Player and Player.Name) or tostring(UserId)
		Item.Profile.Image = Utilities.GetPlayerThumbnail(UserId)
		Item.DisplayName.Text = ListenerName
		Item.Parent = NowPlaying.Content.Panel.Listeners.Scroll

		--

		Item.MouseButton1Click:Connect(function()
			local OptionChosen = Main.PromptOptions({
				Header = ListenerName,
				Options = {
					{Name = "Copy Queue", Icon = "rbxassetid://12974407511"},
					{Name = "Skip to Timestamp", Icon = "rbxassetid://11422923443"},
					{Name = (_G.MastersFollowTarget and (_G.MastersFollowTarget()) == UserId) and "Unfollow Player" or "Follow Player", Icon = "rbxassetid://12974407511"},
				}
			})

			if OptionChosen == "Copy Queue" then
				local QueueList = {}

				if #Data.Queue > 0 then
					for i, SongId in Data.Queue do
						table.insert(QueueList, SongId.Id)
					end
				end

				if #Data.ContinuePlaying > 0 then
					for i, SongId in Data.ContinuePlaying do
						table.insert(QueueList, SongId.Id)
					end
				end

				if #QueueList > 0 then
					Queue.ClearContinuePlaying()
					Queue.AddToQueue(QueueList)

					Alerts.BannerNotify({
						Header = "Successfully Copied queue",
						Description = ListenerName .. "'s Queue was copied to your queue.",
						Icon = "rbxassetid://12974407511"
					})
				else
					Alerts.BannerNotify({
						Header = "Unable to Copy Queue",
						Description = ListenerName .. "'s Queue is empty.",
						Icon = "rbxassetid://11419713314"
					})
				end

			elseif OptionChosen == "Skip to Timestamp" then
				local CurrentTimestamp = events.Modules.Listeners.GetCurrentTimestamp:InvokeServer(UserId, CurrentSongId, tick())
				local ActiveSoundObject = Queue.GetActiveSound()

				if not CurrentTimestamp then return end
				if not ActiveSoundObject then return end

				ActiveSoundObject.TimePosition = CurrentTimestamp
			elseif OptionChosen == "Follow Player" or OptionChosen == "Unfollow Player" then
				if _G.MastersFollow then
					_G.MastersFollow(UserId, ListenerName)
				end
			end
		end)

		Item.MouseEnter:Connect(function()
			TweenService:Create(Item, normal, {BackgroundTransparency = .95}):Play()
		end)

		Item.InputEnded:Connect(function()
			TweenService:Create(Item, normal, {BackgroundTransparency = 1}):Play()
		end)
	end
end

NowPlaying.Content.Panel.Listeners.Header.Refresh.MouseButton1Click:Connect(function()
	LoadListeners()
end)

Queue.TrackChanged:Connect(function(SongId)
	table.clear(ActiveLyrics)

	NowPlayingProperties.CurrentLyricsLoaded = nil

	if LyricsHeartbeatConnection then
		LyricsHeartbeatConnection:Disconnect()
	end

	if SongId then
		local Data = AssetService:GetAudioMetadataAsync({SongId})
		if not Data or not Data[1] then return end

		local TimeData = Utilities.FormatTime(Data[1].Duration)

		-- Full / Miniplayer

		Full.Content.Miniplayer.Container.Media.Art.Photo.Image = Utilities.GetCoverForSong(SongId)
		Full.Content.Miniplayer.Container.Media.Art.Photo.scale.Scale = .8

		Full.Content.Miniplayer.Container.Media.Details.Source.Text = Data[1].Artist or "Unknown"
		Full.Content.Miniplayer.Container.Media.Details.Title.Text = Data[1].Title or "Untitled"

		Full.Content.Miniplayer.Container.Media.Details.Source.TextTransparency = 1
		Full.Content.Miniplayer.Container.Media.Details.Title.TextTransparency = 1

		TweenService:Create(Full.Content.Miniplayer.Container.Media.Art.Photo.scale, normal, {Scale = 1}):Play()

		TweenService:Create(Full.Content.Miniplayer.Container.Media.Details.Source, normal, {TextTransparency = .5}):Play()
		TweenService:Create(Full.Content.Miniplayer.Container.Media.Details.Title, normal, {TextTransparency = 0}):Play()

		-- Bar / Player

		Bar.NowPlaying.Art.Photo.Image = Utilities.GetCoverForSong(SongId)

		Bar.NowPlaying.Content.Details.Title.Text = Data[1].Title or "Untitled"
		Bar.NowPlaying.Content.Details.Title.TextTransparency = 1

		Bar.Tucked.Art.Photo.Image = Utilities.GetCoverForSong(SongId)

		TweenService:Create(Bar.NowPlaying.Content.Details.Title, normal, {TextTransparency = 0}):Play()

		-- NowPlaying / Player

		NowPlayingAlbumArt(Utilities.GetCoverForSong(SongId), Queue.GetCrossfadingStatus())

		NowPlaying.Content.Media.Details.SongInfo.Title.Label.Text = Data[1].Title or "Untitled"
		NowPlaying.Content.Media.Details.SongInfo.Source.Text = Data[1].Artist or "Unknown"

		NowPlaying.Content.Media.Timeline.Data.TimeLength.Text = TimeData.Minutes .. ":" .. TimeData.Seconds

		TweenService:Create(NowPlaying.Content.Panel.Lyrics.Container.Scroll, elastic, {CanvasPosition = Vector2.new(0, 0)}):Play()
		TweenService:Create(NowPlaying.Content.Media.Details.SongInfo.Title.padding, slow, {PaddingLeft = UDim.new(0, 15)}):Play()

		TweenService:Create(NowPlaying.Content.Panel.Actions.Lyrics.Preview, nan, {Size = UDim2.fromScale(.2, 1)}):Play()

		-- Bar / Visuals

		BarBackground(Utilities.GetCoverForSong(SongId))

		-- NowPlaying / Visuals

		NowPlayingBackground(Utilities.GetCoverForSong(SongId))

		-- NowPlaying / Lyrics

		local SoundObject = Queue.GetActiveSound()
		local HasLyrics = LyricsEngine.HasLyrics(SongId)

		for i, residual in NowPlaying.Content.Panel.Lyrics.Container.Scroll:GetChildren() do
			if residual:HasTag("MastersTemplate") then
				residual:Destroy()
			end
		end

		if HasLyrics then
			NowPlaying.Content.Panel.Lyrics.NoLyrics.Visible = false
			NowPlaying.Content.Panel.Actions.Lyrics.Icon.ImageTransparency = 0
		else
			NowPlaying.Content.Panel.Lyrics.NoLyrics.Visible = true
			NowPlaying.Content.Panel.Actions.Lyrics.Icon.ImageTransparency = .8
		end

		if SoundObject and HasLyrics then
			NowPlaying.Content.Panel.Lyrics.Loading.Visible = true

			local LyricData = LyricsEngine.GetLyrics(SongId)

			NowPlayingProperties.CurrentLyricsLoaded = LyricData
			-- GetLyrics can yield; if the panel was rebuilt/torn down meanwhile, or the
			-- song simply has no lyrics, bail cleanly instead of crashing.
			local LyricsPanel = NowPlaying.Parent and NowPlaying.Content:FindFirstChild("Panel")
			LyricsPanel = LyricsPanel and LyricsPanel:FindFirstChild("Lyrics")
			if not LyricsPanel then return end
			if not LyricData or type(LyricData.Lyrics) ~= "table" then
				LyricsPanel.Loading.Visible = false
				LyricsPanel.NoLyrics.Visible = true
				return
			end
			for i, LineData in LyricData.Lyrics do
				local Item

				if LineData.Line == "" then
					if (LineData.TimeEnd - LineData.TimeStart) > 5 then
						Item = ui.Storage.Items.GapItem:Clone()
					else
						continue
					end

				elseif LineData.Line == "..." then
					Item = ui.Storage.Items.GapItem:Clone()

				else
					if LyricData.Unsynced then
						Item = ui.Storage.Items.LyricsAdlibItem:Clone()

						Item.Text = LineData.Line
						Item.TextSize = 14
						Item.TextTransparency = 0

						if LineData.Id == "CERTIFICATION" then
							Item.TextTransparency = .8
							Item.TextSize = 14
							Item.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
						end
					else
						Item = ui.Storage.Items.LyricsItem:Clone()

						Item.MainLyrics.Text = LineData.Line

						if LineData.RightAligned then
							Item.MainLyrics.TextXAlignment = Enum.TextXAlignment.Right
						end

						if LineData.Id == "CERTIFICATION" then
							Item.MainLyrics.TextSize = 14
							Item.MainLyrics.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
						end
					end
				end

				Item.Name = LineData.Id
				Item.LayoutOrder = i

				if LineData.Adlibs then
					for i, Adlib in LineData.Adlibs do
						local AdlibItem = ui.Storage.Items.LyricsAdlibItem:Clone()

						AdlibItem.Name = "Adlib"
						AdlibItem.Text = Adlib
						AdlibItem.LayoutOrder = i
						AdlibItem.Parent = Item

						if LineData.RightAligned then
							AdlibItem.TextXAlignment = Enum.TextXAlignment.Right
						end
					end
				end

				Item.Parent = NowPlaying.Content.Panel.Lyrics.Container.Scroll

				ActiveLyrics[LineData.Id] = {
					Item = Item,
					TimeStart = LineData.TimeStart,
					TimeEnd = LineData.TimeEnd
				}

				--

				if not LyricData.Unsynced then
					Item.MouseButton1Click:Connect(function()
						if TimeScrubberData.Dragging then return end
						if Queue.GetCrossfadingStatus() then return end
						if Queue.GetLoadingStatus() then return end

						SoundObject.TimePosition = LineData.TimeStart
						LyricsScrollProperties.Threshold = 0
					end)

					Item.MouseEnter:Connect(function()
						TweenService:Create(Item, normal, {BackgroundTransparency = .95}):Play()
					end)

					Item.InputEnded:Connect(function()
						TweenService:Create(Item, normal, {BackgroundTransparency = 1}):Play()
					end)
				end

			end

			NowPlaying.Content.Panel.Lyrics.Loading.Visible = false

			if not LyricData.Unsynced then
				LyricsHeartbeatConnection = RunService.Heartbeat:Connect(function(Delta)

					if not SoundObject or not SoundObject.Parent then 
						LyricsHeartbeatConnection:Disconnect()
						return 
					end

					local ActiveLine
					local Scroll = NowPlaying.Content.Panel.Lyrics.Container.Scroll
					local CurrentTime = SoundObject.TimePosition

					for Id, Data in ActiveLyrics do
						if not Data.Item or not Data.Item.Parent then continue end
						if Data.TimeStart and Data.TimeEnd and CurrentTime >= Data.TimeStart and CurrentTime <= Data.TimeEnd then
							if Data.Item:HasTag("MastersGapItem") then
								local ProgressX = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, 0, 1)
								local ScaleSize = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, .6, 1.2)
								local GlowIntensity = Utilities.Map(CurrentTime, Data.TimeStart, Data.TimeEnd, 1, .9)

								Smoothness.ApproachInHeartbeat(Data.Item, "Size", UDim2.new(1, 0, 0, 72), Delta, slow)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.scale, "Scale", ScaleSize, Delta, normal)

								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Fill, "Size", UDim2.fromScale(ProgressX, 1), Delta, normal)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Background, "ImageTransparency", .9, Delta, normal)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Glow, "ImageTransparency", GlowIntensity, Delta, normal)

							else
								do local __ml = Data.Item:FindFirstChild("MainLyrics") if __ml then Smoothness.ApproachInHeartbeat(__ml, "TextTransparency", 0, Delta, smooth) end end
								Smoothness.ApproachInHeartbeat(Data.Item.list, "Padding", UDim.new(0, 10), Delta, normal)
							end

							for i, Adlib in Data.Item:GetChildren() do
								if Adlib.Name == "Adlib" then
									Smoothness.ApproachInHeartbeat(Adlib, "TextTransparency", .5, Delta, slow)
								end
							end

							--

							ActiveLine = Data
						else
							if Data.Item:HasTag("MastersGapItem") then
								Smoothness.ApproachInHeartbeat(Data.Item, "Size", UDim2.new(1, 0, 0, 0), Delta, slow)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.scale, "Scale", .6, Delta, normal)

								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Fill, "Size", UDim2.fromScale(0, 1), Delta, normal)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Background, "ImageTransparency", 1, Delta, normal)
								Smoothness.ApproachInHeartbeat(Data.Item.Canvas.Glow, "ImageTransparency", 1, Delta, normal)

							else
								do local __ml = Data.Item:FindFirstChild("MainLyrics") if __ml then Smoothness.ApproachInHeartbeat(__ml, "TextTransparency", .9, Delta, smooth) end end
								Smoothness.ApproachInHeartbeat(Data.Item.list, "Padding", UDim.new(0, -10), Delta, normal)
							end

							for i, Adlib in Data.Item:GetChildren() do
								if Adlib.Name == "Adlib" then
									Smoothness.ApproachInHeartbeat(Adlib, "TextTransparency", 1, Delta, slow)
								end
							end
						end

						if Main.GetOrientation() == "Portrait" then
							if Data.Item:HasTag("MastersGapItem") then
								Data.Item.scale.Scale = 1.6
							else
								if Data.Item.Name ~= "CERTIFICATION" then
									Data.Item.MainLyrics.TextSize = 36

									for i, Adlib in Data.Item:GetChildren() do
										if Adlib.Name == "Adlib" then
											Adlib.TextSize = 30
										end
									end
								end
							end
						else
							if Data.Item:HasTag("MastersGapItem") then
								Data.Item.scale.Scale = 1
							else
								if Data.Item.Name ~= "CERTIFICATION" then
									Data.Item.MainLyrics.TextSize = 26

									for i, Adlib in Data.Item:GetChildren() do
										if Adlib.Name == "Adlib" then
											Adlib.TextSize = 20
										end
									end									
								end

							end
						end
					end

					if ActiveLine then
						if LyricsScrollProperties.Scrolling then
							LyricsScrollProperties.Threshold = 240
						else
							LyricsScrollProperties.Threshold -= 1

							if LyricsScrollProperties.Threshold < 1 then
								local TargetY = ActiveLine.Item.AbsolutePosition.Y - Scroll.AbsolutePosition.Y + Scroll.CanvasPosition.Y - NowPlayingProperties.LyricsTopOffset

								TargetY = math.clamp(
									TargetY,
									0,
									Scroll.AbsoluteCanvasSize.Y - Scroll.AbsoluteWindowSize.Y
								)

								Smoothness.ApproachInHeartbeat(Scroll, "CanvasPosition", Vector2.new(0, TargetY), Delta, 
									TweenInfo.new(2, Enum.EasingStyle.Exponential))
							end
						end

						local OffsetXGlow = Utilities.Map(CurrentTime, ActiveLine.TimeStart, ActiveLine.TimeEnd, .2, 1.2)

						Smoothness.ApproachInHeartbeat(NowPlaying.Content.Panel.Actions.Lyrics.Preview, 
							"Size",UDim2.fromScale(OffsetXGlow, 1), Delta, normal)

					else
						Smoothness.ApproachInHeartbeat(NowPlaying.Content.Panel.Actions.Lyrics.Preview, 
							"Size",UDim2.fromScale(.2, 1), Delta, normal)
					end
				end)
			end
		end

		-- Listeners

		--events.Modules.Listeners.UpdateListener:FireServer({
		--	CurrentSoundId = SongId,
		--	Queue = Queue.GetVisualQueue().Queue,
		--	ContinuePlaying = Queue.GetVisualQueue().ContinuePlaying
		--})

	else

		-- Bar / Visuals

		BarBackground("")

		-- NowPlaying / Visuals

		NowPlayingBackground("")

		-- Listeners

		--events.Modules.Listeners.UpdateListener:FireServer({
		--	CurrentSoundId = 0,
		--	Queue = Queue.GetVisualQueue().Queue,
		--	ContinuePlaying = Queue.GetVisualQueue().ContinuePlaying
		--})
	end

	-- Listeners
	--if SettingsPageProperties.Data.Socials.ListeningVisibility == nil then SettingsPageProperties.Data.Socials.ListeningVisibility = false end
	task.spawn(function()
		if SettingsPageProperties.Data.Socials.ListeningVisibility then
			NowPlaying.Content.Panel.Listeners.Scroll.Visible = true
			NowPlaying.Content.Panel.Listeners.Disabled.Visible = false
			NowPlaying.Content.Panel.Listeners.Header.Refresh.Visible = true

			LoadListeners()

		else
			for i, residual in NowPlaying.Content.Panel.Listeners.Scroll:GetChildren() do
				if residual:HasTag("MastersTemplate") then
					residual:Destroy()
				end
			end

			NowPlaying.Content.Panel.Listeners.Scroll.Visible = false
			NowPlaying.Content.Panel.Listeners.Disabled.Visible = true
			NowPlaying.Content.Panel.Listeners.Header.Refresh.Visible = false
		end
	end)
end)

RunService.Heartbeat:Connect(function(Delta)
	local CurrentSound = Queue.GetActiveSound()
	local VisualQueue = Queue.GetVisualQueue()
	local SongsInQueue = (#VisualQueue.Queue + #VisualQueue.ContinuePlaying)

	if CurrentSound and CurrentSound.IsPlaying then
		local Loudness = CurrentSound.PlaybackLoudness
		local Scale = Utilities.Map(Loudness, 0, 1000, 1, 5)
		local Transparency = Utilities.Map(Loudness, 0, 500, 1, .7)
		local Saturation = Utilities.Map(Loudness, 0, 1000, .3, 1)

		-- NowPlaying / Media

		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Art.Photo.scale, "Scale", 1, Delta, smooth)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Art.Shadow.scale, "Scale", 1, Delta, smooth)

		if SettingsPageProperties.Data.Extras.Glow then

			-- Bar / Visuals / Glow

			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Saturation, "GroupColor3", Color3.fromHSV(0, 0, Saturation), Delta, five)
			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise, "ImageTransparency", Transparency, Delta, slow)
			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise.scale, "Scale", Scale, Delta, slow)

			-- NowPlaying / Visuals / Glow

			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Saturation, "GroupColor3", Color3.fromHSV(0, 0, Saturation), Delta, five)
			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise, "ImageTransparency", Transparency, Delta, slow)
			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise.scale, "Scale", Scale, Delta, slow)
		else

			-- Bar / Visuals / Glow

			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Saturation, "GroupColor3", Color3.fromHSV(0, 0, .5), Delta, five)
			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise, "ImageTransparency", 1, Delta, slow)
			Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise.scale, "Scale", 1, Delta, slow)

			-- NowPlaying / Visuals / Glow

			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Saturation, "GroupColor3", Color3.fromHSV(0, 0, .5), Delta, five)
			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise, "ImageTransparency", 1, Delta, slow)
			Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise.scale, "Scale", 1, Delta, slow)
		end

		if SettingsPageProperties.Data.Extras.PlaybackHaptics then
			Utilities.Haptic(Utilities.Map(Loudness, 100, 1000, 0, 5) * Playback.Volume, .005)
		end

		local BaseSpeed = .05 
		local MusicInfluence = Utilities.Map(Loudness, 0, 1000, 0, .001)
		local FinalSpeed = BaseSpeed + MusicInfluence
		local MovementInfo = TweenInfo.new(5, Enum.EasingStyle.Linear)

		local VisualA = NowPlaying.Util.Visual.Saturation.Visual_A
		local VisualB = NowPlaying.Util.Visual.Saturation.Visual_B

		Smoothness.ApproachInHeartbeat(VisualA, "Position", NowPlayingProperties.TargetPosition, Delta * FinalSpeed, MovementInfo)
		Smoothness.ApproachInHeartbeat(VisualA, "AnchorPoint", NowPlayingProperties.TargetAnchor, Delta * FinalSpeed, MovementInfo)

		VisualB.Position = VisualA.Position
		VisualB.AnchorPoint = VisualA.AnchorPoint

		Bar.Util.Visual.Saturation.Visual_A.Position = VisualA.Position		
		Bar.Util.Visual.Saturation.Visual_A.AnchorPoint = VisualA.AnchorPoint

		Bar.Util.Visual.Saturation.Visual_B.Position = VisualA.Position		
		Bar.Util.Visual.Saturation.Visual_B.AnchorPoint = VisualA.AnchorPoint

		local DistX = math.abs(VisualA.Position.X.Scale - NowPlayingProperties.TargetPosition.X.Scale)
		local DistY = math.abs(VisualA.Position.Y.Scale - NowPlayingProperties.TargetPosition.Y.Scale)

		if DistX < .05 and DistY < .05 then
			NowPlayingProperties.CurrentIndex += 1

			if NowPlayingProperties.CurrentIndex > #NowPlayingProperties.Sequence then
				NowPlayingProperties.CurrentIndex = 1
			end

			local NextState = NowPlayingProperties.Sequence[NowPlayingProperties.CurrentIndex]
			local NewSpot = GetSpotByName(NextState)

			NowPlayingProperties.TargetPosition = NewSpot.Position
			NowPlayingProperties.TargetAnchor = NewSpot.AnchorPoint
		end

		-- NowPlaying / Timeline

		if not TimeScrubberData.Dragging then
			local TimePosition = Utilities.Map(CurrentSound.TimePosition, 0, CurrentSound.TimeLength, 0, 1)
			local TimeData = Utilities.FormatTime(CurrentSound.TimePosition)

			NowPlaying.Content.Media.Timeline.Data.TimePosition.Text = TimeData.Minutes .. ":" .. TimeData.Seconds

			Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Timeline.Scrubber.Fill, "Size", 
				UDim2.fromScale(TimePosition, 1), Delta, quick)
		else
			local TimePosition = Utilities.Map(NowPlaying.Content.Media.Timeline.Scrubber.Fill.Size.X.Scale, 0, 1, 
				0, CurrentSound.TimeLength)
			local TimeData = Utilities.FormatTime(TimePosition)

			NowPlaying.Content.Media.Timeline.Data.TimePosition.Text = TimeData.Minutes .. ":" .. TimeData.Seconds
		end
	else

		-- Bar / Visuals / Glow

		Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise, "ImageTransparency", 1, Delta, five)
		Smoothness.ApproachInHeartbeat(Bar.Util.Visual.Noise.scale, "Scale", 1, Delta, five)

		-- NowPlaying / Visuals / Glow

		Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Saturation, "GroupColor3", Color3.fromRGB(30, 30, 30), Delta, five)
		Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise, "ImageTransparency", 1, Delta, five)
		Smoothness.ApproachInHeartbeat(NowPlaying.Util.Visual.Noise.scale, "Scale", 1, Delta, slow)

		-- NowPlaying / Media

		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Art.Photo.scale, "Scale", .8, Delta, smooth)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Art.Shadow.scale, "Scale", .8, Delta, smooth)
	end

	if Queue.GetActiveSound() then
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer, "AnchorPoint", Vector2.new(1, 1), Delta, slow)
	else
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer, "AnchorPoint", Vector2.new(1, 0), Delta, slow)
	end

	if Queue.GetLoadingStatus() then		
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 0, Delta, normal)
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)

		Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 0, Delta, normal)
		Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)
		Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)

		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 0, Delta, normal)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
	else
		Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 1, Delta, normal)
		Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 1, Delta, normal)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.ThrobberIcon, "ImageTransparency", 1, Delta, normal)

		if CurrentSound then
			if CurrentSound.IsPlaying then
				Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 0, Delta, normal)
				Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)

				Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PauseIcon, "ImageTransparency", 0, Delta, normal)
				Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)

				Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 0, Delta, normal)
				Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 1, Delta, normal)

			else

				Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
				Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)

				Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
				Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)

				Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
				Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)
			end
		else
			Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
			Smoothness.ApproachInHeartbeat(Full.Content.Miniplayer.Container.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)

			Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
			Smoothness.ApproachInHeartbeat(Bar.NowPlaying.Content.Controls.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)

			Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PauseIcon, "ImageTransparency", 1, Delta, normal)
			Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Playback.PlayPause.Icon.PlayIcon, "ImageTransparency", 0, Delta, normal)
		end
	end

	if Queue.GetCrossfadingStatus() then
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Timeline.Data.MusicStatus.Masters, "ImageTransparency", 1, Delta, slow)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Timeline.Data.MusicStatus.Crossfading, "ImageTransparency", .5, Delta, slow)
	else
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Timeline.Data.MusicStatus.Masters, "ImageTransparency", .5, Delta, slow)
		Smoothness.ApproachInHeartbeat(NowPlaying.Content.Media.Timeline.Data.MusicStatus.Crossfading, "ImageTransparency", 1, Delta, slow)
	end

	NowPlaying.Content.Media.Timeline.Scrubber.Interactable = not (Queue.GetLoadingStatus() or Queue.GetCrossfadingStatus())

	-- Glow Effect

	if InputService.MouseEnabled then
		local MouseLocation = InputService:GetMouseLocation()

		for i, Glow in CollectionService:GetTagged("MastersGlowHoverEffect") do
			if Glow:GetAttribute("Enabled") then
				local RelativePosition = MouseLocation - Glow.Parent.AbsolutePosition
				local Offset = GuiService.TopbarInset

				Smoothness.ApproachInHeartbeat(Glow, "Position", UDim2.fromOffset(RelativePosition.X, RelativePosition.Y - Offset.Height), Delta, normal)
			end
		end
	end
end)

Full.Content.Sidebar.Tabs.Pages.Discovery.MouseButton1Click:Connect(function()
	Main.SetPage("Discovery")

	local SidebarOpened, Fullscreen = Main.GetSidebarStatus()

	if Fullscreen then
		Main.Sidebar(false)
	end
end)

Full.Content.Sidebar.Tabs.Pages.Search.MouseButton1Click:Connect(function()
	Main.SetPage("Search")

	local SidebarOpened, Fullscreen = Main.GetSidebarStatus()

	if Fullscreen then
		Main.Sidebar(false)
	end
end)

Full.Content.Sidebar.Tabs.Pages.Library.MouseButton1Click:Connect(function()
	Main.SetPage("Library")

	local SidebarOpened, Fullscreen = Main.GetSidebarStatus()

	if Fullscreen then
		Main.Sidebar(false)
	end
end)

-- Full / Visuals

TweenService:Create(Full.Util.ArtistBackground.Background.gradient, long_loop_reverses, {Offset = Vector2.new(0, 1)}):Play()
TweenService:Create(Full.Util.ArtistBackground.Visual, long_loop, {Rotation = 360}):Play()

-- Bar / Visuals

TweenService:Create(Bar.Util.Visual.Noise, long_loop, {Rotation = 360}):Play()

-- NowPlaying / Visuals

TweenService:Create(NowPlaying.Content.Media.Timeline.Data.MusicStatus.Crossfading.gradient, crossfading_loop, {Offset = Vector2.new(1, 0)}):Play()

TweenService:Create(NowPlaying.Util.Visual.Noise, long_loop, {Rotation = 360}):Play()

-- Full / Miniplayer

Full.Content.Miniplayer.Container.Playback.PlayPause.MouseButton1Click:Connect(function()
	events.Playback.PlayPause:Fire()
end)

Full.Content.Miniplayer.Container.Playback.Forward.MouseButton1Click:Connect(function()
	events.Playback.Forward:Fire()
end)

Full.Content.Miniplayer.Container.Playback.Rewind.MouseButton1Click:Connect(function()
	events.Playback.Rewind:Fire()
end)

Full.Content.Miniplayer.MouseButton1Click:Connect(function()
	Main.NowPlaying(true)
end)

Full.Content.Miniplayer.TouchSwipe:Connect(function(Direction)
	if Direction == Enum.SwipeDirection.Up then
		Main.NowPlaying(true)
	end
end)

Main.StateChanged:Connect(function(MastersState)	
	if MastersState ~= "Artist" then

		-- Residual

		for i, residual in Full.Container.Artist.Sections.Discography.Content:GetChildren() do
			if residual:HasTag("MastersTemplate") then
				residual:Destroy()
			end
		end

		for i, residual in Full.Container.Artist.Sections.YWF.Content:GetChildren() do
			if residual:HasTag("MastersTemplate") then
				residual:Destroy()
			end
		end

		ArtistPageProperties.Discography = {}

		Main.SetPage(Main.GetLastMainPage())
	end
end)

-- Full / Miniplayer / More
-- NowPlaying / More

Full.Content.Miniplayer.Container.Actions.Queue.MouseButton1Click:Connect(function()
	Main.NowPlaying(true)
	Main.NowPlayingPanelScreen("QueueList")
end)

Full.Content.Miniplayer.Container.Actions.More.MouseButton1Click:Connect(function()
	local SongId = Queue.GetCurrentSongId()
	local Metadata = Queue.GetCurrentMetadata()
	if not SongId or not Metadata then return end

	PromptSongOptions("NowPlaying", {
		MasterPool = {SongId},
		SongId = SongId,
		Title = Metadata.Title,
		Artist = Metadata.Artist,
		Pointer = 1
	})
end)

Full.Content.Miniplayer.Container.Actions.More.TouchLongPress:Connect(function()
	local SongId = Queue.GetCurrentSongId()
	local Metadata = Queue.GetCurrentMetadata()
	if not SongId or not Metadata then return end

	PromptSongOptions("NowPlaying", {
		MasterPool = {SongId},
		SongId = SongId,
		Title = Metadata.Title,
		Artist = Metadata.Artist,
		Pointer = 1
	}, true)
end)

NowPlaying.Content.Panel.Actions.More.MouseButton1Click:Connect(function()
	local SongId = Queue.GetCurrentSongId()
	local Metadata = Queue.GetCurrentMetadata()
	if not SongId or not Metadata then return end

	PromptSongOptions("NowPlaying", {
		MasterPool = {SongId},
		SongId = SongId,
		Title = Metadata.Title,
		Artist = Metadata.Artist,
		Pointer = 1
	})
end)

NowPlaying.Content.Panel.Actions.More.TouchLongPress:Connect(function()
	local SongId = Queue.GetCurrentSongId()
	local Metadata = Queue.GetCurrentMetadata()
	if not SongId or not Metadata then return end

	PromptSongOptions("NowPlaying", {
		MasterPool = {SongId},
		SongId = SongId,
		Title = Metadata.Title,
		Artist = Metadata.Artist,
		Pointer = 1
	}, true)
end)

Full.Content.Miniplayer.Container.Actions.Shuffle.MouseButton1Click:Connect(function()
	Queue.ToggleShuffle()
end)

-- Full / Search

Full.Container.Search.Results.Visible = false
Full.Container.Search.Suggestions.Visible = true

Full.Container.Search:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
	local CanvasPos = Full.Container.Search.AbsoluteCanvasSize.Y - Full.Container.Search.AbsoluteWindowSize.Y
	local Threshold = CanvasPos * .8

	if Full.Container.Search.CanvasPosition.Y >= Threshold then
		local PaginationLoading = Full.Container.Search.Results:FindFirstChild("PaginationLoading")

		if not PaginationLoading then
			PaginationLoading = ui.Storage.Items.PaginationLoading:Clone()
			PaginationLoading.Icon:AddTag("MastersThrobberIcon")
			PaginationLoading.Parent = Full.Container.Search.Results
		end

		if SearchingProperties.SearchData and not SearchingProperties.Advancing then
			task.spawn(function()
				SearchingProperties.Advancing = true
				SearchingProperties.SearchData.Advance()

				--
				task.wait(SearchingProperties.Cooldown)
				--

				if Full.Container.Search.CanvasPosition.Y >= Threshold and SearchingProperties.SearchData then
					SearchingProperties.SearchData.Advance()
				end

				SearchingProperties.Advancing = false
			end)
		end
	end
end)

Full.Container.Search.Frame.Textbox.FocusLost:Connect(function()
	if Full.Container.Search.Frame.Textbox.Text == "" then
		Full.Container.Search.Results.Visible = false
		Full.Container.Search.Suggestions.Visible = true

		SearchingProperties.RecentKeyword = ""
		SearchingProperties.SearchData = nil

		-- Clearance

		for i, residual in Full.Container.Search.Results:GetChildren() do
			if residual:HasTag("MastersTemplate") then
				residual:Destroy()
			end
		end

	else

		local Keyword = Full.Container.Search.Frame.Textbox.Text
		if Keyword == SearchingProperties.RecentKeyword then return end

		local PossibleAssetId = tonumber(Keyword)

		SearchingProperties.RecentKeyword = Keyword

		if PossibleAssetId and PossibleAssetId > 999999 then

			Full.Container.Search.Results.Visible = true
			Full.Container.Search.Suggestions.Visible = false

			-- Clearance

			for i, residual in Full.Container.Search.Results:GetChildren() do
				if residual:HasTag("MastersTemplate") then
					residual:Destroy()
				end
			end

			-- Search Queries

			local SongData = Audios.GetAudioMetadataAsync({PossibleAssetId})
			if not SongData or not SongData[1] then return end
			if not SongData[1].Title or not SongData[1].Artist then return end

			AddSongItem({
				Container = Full.Container.Search.Results,
				ContextName = SearchingProperties.RecentKeyword,
				Item = ui.Storage.Items["Item(SearchResults)"],
				MasterPool = {SongData[1].AssetId},
				ItemProperties = {LayoutOrder = 2},
				Pointer = 1,
				SongInfo = SongData[1],
				Source = "Standard"
			})

			local AlreadyAdded = Full.Container.Search.Results:FindFirstChild(SongData[1].Artist)
			if AlreadyAdded and AlreadyAdded:HasTag("MastersArtistItem") then return end

			AddArtistItem({
				Container = Full.Container.Search.Results,
				Item = ui.Storage.Items["Artist(SearchResults)"],
				ItemProperties = {LayoutOrder = 1},
				ArtistName = SongData[1].Artist,
				Source = "Standard"
			})

		else

			local SearchData = Audios.SearchAudiosByKeyword(Keyword)

			SearchingProperties.SearchData = SearchData

			Full.Container.Search.Results.Visible = true
			Full.Container.Search.Suggestions.Visible = false

			-- Clearance

			for i, residual in Full.Container.Search.Results:GetChildren() do
				if residual:HasTag("MastersTemplate") then
					residual:Destroy()
				end
			end

			-- Search Queuries

			local ChunkLoadedTriggered = false

			local function ArrangeSearchQueries(IsFinished, Array)
				if IsFinished then return end
				if #Array == 0 then return end

				-- Clearance

				for i, residual in Full.Container.Search.Results:GetChildren() do
					if residual:HasTag("MastersResidual") then
						residual:Destroy()
					end
				end

				-- Placing

				for i, Song in Array do
					AddSongItem({
						Container = Full.Container.Search.Results,
						ContextName = SearchingProperties.RecentKeyword,
						Item = ui.Storage.Items["Item(SearchResults)"],
						MasterPool = {Song.Id},
						ItemProperties = {LayoutOrder = 2},
						Pointer = 1,
						SongInfo = Song,
						Source = "Standard"
					})

					if Utilities.HowSimilar(Keyword, Song.Artist) >= 75 then
						local AlreadyAdded = Full.Container.Search.Results:FindFirstChild(Song.Artist)
						if AlreadyAdded and AlreadyAdded:HasTag("MastersArtistItem") then continue end

						AddArtistItem({
							Container = Full.Container.Search.Results,
							Item = ui.Storage.Items["Artist(SearchResults)"],
							ItemProperties = {LayoutOrder = 1},
							ArtistName = Song.Artist,
							Source = "Standard"
						})
					end
				end 
			end

			SearchData.ChunkLoaded:Connect(function(IsFinished, Array)
				ChunkLoadedTriggered = false
				ArrangeSearchQueries(IsFinished, Array)
			end)

			if not ChunkLoadedTriggered then
				ArrangeSearchQueries(false, SearchData.Results)
			end
		end
	end
end)
print("loaded")
local SearchedKeywords = {}

Audios.SearchedAudio:Connect(function(Keyword)
	Full.Container.Search.Suggestions.Keywords.Visible = true

	if #SearchedKeywords >= 2 then
		table.remove(SearchedKeywords, 1)
	end

	if not table.find(SearchedKeywords, Keyword) then
		table.insert(SearchedKeywords, Keyword)
	end

	for i, residual in Full.Container.Search.Suggestions.Keywords:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, Word in SearchedKeywords do
		local item = ui.Storage.Items.PreviousKeyword:Clone()

		item.Name = Word
		item.LayoutOrder = -i
		item.Parent = Full.Container.Search.Suggestions.Keywords

		item.Label.Text = Word

		--

		item.MouseButton1Click:Connect(function()
			Full.Container.Search.Frame.Textbox.Text = Word
			Full.Container.Search.Frame.Textbox:CaptureFocus()
		end)

		item.Clear.MouseButton1Click:Connect(function()
			item:Destroy()

			table.remove(SearchedKeywords, table.find(SearchedKeywords, Word) or 0)

			if #SearchedKeywords == 0 then
				Full.Container.Search.Suggestions.Keywords.Visible = false
			end
		end)

		--

		item.MouseButton1Down:Connect(function()
			TweenService:Create(item.Label, normal, {TextTransparency = .5}):Play()
			TweenService:Create(item.Icon, normal, {ImageTransparency = .5}):Play()
		end)

		item.InputEnded:Connect(function()
			TweenService:Create(item.Label, normal, {TextTransparency = 0}):Play()
			TweenService:Create(item.Icon, normal, {ImageTransparency = 0}):Play()
		end)

		item.Clear.MouseButton1Down:Connect(function()
			TweenService:Create(item.Clear.Icon, normal, {ImageTransparency = .5}):Play()
		end)

		item.Clear.InputEnded:Connect(function()
			TweenService:Create(item.Clear.Icon, normal, {ImageTransparency = 0}):Play()
		end)
	end
end)

-- Full / Library

function LoadLibrary()
	task.spawn(function()
		if LibraryProperties.Loading then LibraryProperties.ForReload = true return end
		LibraryProperties.Loading = true

		-- Clearance

		for i, residual in Full.Container.Library.Frame:GetChildren() do
			if residual:HasTag("MastersTemplate") then
				residual:Destroy()
			end
		end

		-- Loading

		local Library = events.Main.Library.FetchLibrary:InvokeServer()
		local Preferences = events.Main.Preferences.FetchPreference:InvokeServer()
		local SharedWithYou = events.Main.Sharing.FetchSharedWithYou:InvokeServer()

		if not Library or not Preferences or not SharedWithYou then return end

		-- Artists (4)

		if #Library.Artists > 0 then
			local Container = ui.Storage.Items["Container(ArtistStandard)"]:Clone()

			Container.Name = "Artists"
			Container.LayoutOrder = 4
			Container.Header.Label.Text = "Artists"
			Container.Parent = Full.Container.Library.Frame

			for i, Artist in Library.Artists do
				AddArtistItem({
					Container = Container.Content,
					Item = ui.Storage.Items["Artist(Standard)"],
					ItemProperties = {Pinned = Artist.Pin},
					ArtistName = Artist.Name,
					Source = "Library"
				})
			end
		end

		-- Playlists (2)

		if #Library.Playlist > 0 then
			local Container = ui.Storage.Items["Container(Standard)"]:Clone()

			Container.Name = "Playlists"
			Container.LayoutOrder = 2
			Container.Header.Label.Text = "Playlists"
			Container.Parent = Full.Container.Library.Frame

			for i, Playlist in Library.Playlist do
				AddPlaylistItem({
					Container = Container.Content,
					Item = ui.Storage.Items["Playlist(Big)"],
					ItemProperties = {Pinned = Playlist.Pin, LayoutOrder = -i},
					PlaylistData = Playlist,
					Source = "Library"
				})
			end
		end

		-- Songs (3)

		if #Library.Songs > 0 then
			local List = {}

			for i, Song in Library.Songs do
				table.insert(List, i, Song.SongId)
			end

			local Metadatas = Audios.GetAudioMetadataAsync(List)
			if not Metadatas then return end

			local Container = ui.Storage.Items["Container(Standard)"]:Clone()

			Container.Name = "Songs"
			Container.LayoutOrder = 3
			Container.Header.Label.Text = "Songs"
			Container.Parent = Full.Container.Library.Frame

			for i, Song in Library.Songs do				
				AddSongItem({
					Container = Container.Content,
					ContextName = "Library",
					Item = ui.Storage.Items["Item(Big)"],
					ItemProperties = {Pinned = Song.Pin},
					MasterPool = List,
					Pointer = i,
					SongInfo = Metadatas[i],
					Source = "Library"
				})
			end
		end

		-- Favorite Songs (1)

		if #Preferences.Songs.Favorite > 0 then
			local List = Preferences.Songs.Favorite
			local Metadatas = Audios.GetAudioMetadataAsync(List)
			if not Metadatas then return end

			local Container = ui.Storage.Items["Container(Charts)"]:Clone()

			Container.Name = "Favorites"
			Container.LayoutOrder = 1
			Container.Header.Label.Text = "Favorites"
			Container.Parent = Full.Container.Library.Frame

			for i, Song in List do				
				AddSongItem({
					Container = Container.Content,
					ContextName = "Favorites",
					Item = ui.Storage.Items["Item(Small)"],
					MasterPool = List,
					Pointer = i,
					SongInfo = Metadatas[i],
					Source = "Standard"
				})
			end
		end

		-- Shared With You (5)

		if #SharedWithYou > 0 then
			local Container = ui.Storage.Items["Container(Shared)"]:Clone()

			Container.Name = "SharedWithYou"
			Container.LayoutOrder = 5
			Container.Header.Label.Text = "Shared With You"
			Container.Parent = Full.Container.Library.Frame

			local Songs = {}
			local SongData = {}

			for i, Item in SharedWithYou do
				if Item.Type == "Song" then
					table.insert(Songs, Item.Identifier)
					table.insert(SongData, Item)
				end
			end

			local Metadata = Audios.GetAudioMetadataAsync(Songs)
			if not Metadata then return end

			for i, Item in Songs do
				AddSongItem({
					Container = Container.Content,
					ContextName = "Library",
					Item = ui.Storage.Items["Item(Shared)"],
					ItemProperties = {Shared = SongData[i], LayoutOrder = -SongData[i].TimeSent},
					MasterPool = Songs,
					Pointer = i,
					SongInfo = Metadata[i],
					Source = "Standard"
				})
			end

			for i, Item in SharedWithYou do
				if Item.Type == "Artist" then
					AddArtistItem({
						Container = Container.Content,
						Item = ui.Storage.Items["Artist(Shared)"],
						ItemProperties = {Shared = Item, LayoutOrder = -Item.TimeSent},
						ArtistName = Item.Identifier,
						Source = "Standard"
					})

				elseif Item.Type == "Playlist" then
					local PlaylistData = events.Main.Library.GetPlaylistByPlaylistId:InvokeServer(Item.Sender, Item.Identifier)
					if not PlaylistData then continue end

					AddPlaylistItem({
						Container = Container.Content,
						Item = ui.Storage.Items["Playlist(Shared)"],
						ItemProperties = {Shared = Item, LayoutOrder = -Item.TimeSent},
						PlaylistData = PlaylistData,
						Source = "Standard"
					})
				end
			end
		end

		LibraryProperties.Loading = false
	end)
end

Main.PageChanged:Connect(function(Page, Parameter)
	if Page == "Library" then
		LoadLibrary()
	end
end)

LibraryProperties.RequestReload:Connect(function()
	task.wait(.1)
	LoadLibrary()
end)

-- NowPlaying
-- NowPlaying / ViewStates

NowPlaying.Content.Media.Details.More.MouseButton1Click:Connect(function()
	local Orientation = Main.GetOrientation()

	if Orientation == "Portrait" then
		Main.NowPlayingView(false, true)
	elseif Orientation == "Landscape" then
		Main.NowPlayingView(true, true)
	end
end)

NowPlaying.Content.Panel.QueueOptions.Back.MouseButton1Click:Connect(function()
	local Orientation = Main.GetOrientation()

	if Orientation == "Portrait" then
		Main.NowPlayingView(true, false)
	elseif Orientation == "Landscape" then
		Main.NowPlayingView(true, false)
	end
end)

Main.OrientationChanged:Connect(function(Orientation)
	local MediaState, PanelState = Main.GetNowplayingViewStates()

	if Orientation == "Landscape" then

		-- NowPlaying

		if PanelState then
			Main.NowPlayingView(true, true)
		end

		NowPlayingProperties.LyricsTopOffset = 20

		NowPlaying.Content.Media.scale.Scale = 1
		NowPlaying.Content.Media.list.Padding = UDim.new(0, 10)

		-- Sidebar

		local SidebarOpened, SidebarFullscreen = Main.GetSidebarStatus()

		if SidebarOpened and SidebarFullscreen then
			Main.Sidebar(true, false)
		end

		-- PlaylistPage

		Full.Container.Playlist.Canvas.list.HorizontalAlignment = Enum.HorizontalAlignment.Left
		Full.Container.Playlist.Canvas.Details.Info.Source.TextXAlignment = Enum.TextXAlignment.Left
		Full.Container.Playlist.Canvas.Details.Info.Subtext.TextXAlignment = Enum.TextXAlignment.Left
		Full.Container.Playlist.Canvas.Details.Info.Title.TextXAlignment = Enum.TextXAlignment.Left

		Full.Container.Stations.Canvas.list.HorizontalAlignment = Enum.HorizontalAlignment.Left
		Full.Container.Stations.Canvas.Details.Info.Source.TextXAlignment = Enum.TextXAlignment.Left
		Full.Container.Stations.Canvas.Details.Info.Subtext.TextXAlignment = Enum.TextXAlignment.Left
		Full.Container.Stations.Canvas.Details.Info.Title.TextXAlignment = Enum.TextXAlignment.Left

		-- Miniplayer

		Full.Content.Miniplayer.Position = UDim2.new(1, 0, 1, 0)

		Full.Content.Miniplayer.Container.Actions.Visible = true

		Full.Content.Miniplayer.Container.Playback.Size = UDim2.new(0, 200, 1, 0)
		Full.Content.Miniplayer.Container.Playback.Rewind.Visible = true

		Full.Content.Miniplayer.Container.divider1.Visible = true
		Full.Content.Miniplayer.Container.divider2.Visible = true

		Full.Content.Miniplayer.Container.corner.CornerRadius = UDim.new(0, 0)

		Full.Content.Miniplayer.padding.PaddingLeft = UDim.new(0, 0)
		Full.Content.Miniplayer.padding.PaddingRight = UDim.new(0, 0)

	elseif Orientation == "Portrait" then

		-- NowPlaying

		if MediaState and PanelState then
			Main.NowPlayingView(true, false)
		end

		NowPlayingProperties.LyricsTopOffset = 60

		NowPlaying.Content.Media.scale.Scale = 1.8
		NowPlaying.Content.Media.list.Padding = UDim.new(0, 20)

		-- Sidebar

		local SidebarOpened = Main.GetSidebarStatus()

		if SidebarOpened then
			Main.Sidebar(true, true)
		end

		-- PlaylistPage

		Full.Container.Playlist.Canvas.list.HorizontalAlignment = Enum.HorizontalAlignment.Center
		Full.Container.Playlist.Canvas.Details.Info.Source.TextXAlignment = Enum.TextXAlignment.Center
		Full.Container.Playlist.Canvas.Details.Info.Subtext.TextXAlignment = Enum.TextXAlignment.Center
		Full.Container.Playlist.Canvas.Details.Info.Title.TextXAlignment = Enum.TextXAlignment.Center

		Full.Container.Stations.Canvas.list.HorizontalAlignment = Enum.HorizontalAlignment.Center
		Full.Container.Stations.Canvas.Details.Info.Source.TextXAlignment = Enum.TextXAlignment.Center
		Full.Container.Stations.Canvas.Details.Info.Subtext.TextXAlignment = Enum.TextXAlignment.Center
		Full.Container.Stations.Canvas.Details.Info.Title.TextXAlignment = Enum.TextXAlignment.Center

		-- Miniplayer

		Full.Content.Miniplayer.Position = UDim2.new(1, 0, 1, -15)

		Full.Content.Miniplayer.Container.Actions.Visible = false

		Full.Content.Miniplayer.Container.Playback.Size = UDim2.new(0, 140, 1, 0)
		Full.Content.Miniplayer.Container.Playback.Rewind.Visible = false

		Full.Content.Miniplayer.Container.divider1.Visible = false
		Full.Content.Miniplayer.Container.divider2.Visible = false

		Full.Content.Miniplayer.Container.corner.CornerRadius = UDim.new(0, 12)

		Full.Content.Miniplayer.padding.PaddingLeft = UDim.new(0, 15)
		Full.Content.Miniplayer.padding.PaddingRight = UDim.new(0, 15)
	end

	task.delay(.01, function()
		if Main.GetState() ~= "Bar" then return end
		SnapToNearestSide(true)
	end)
end)

-- NowPlaying / PanelScreen

NowPlaying.Content.Panel.Actions.Listeners.MouseButton1Click:Connect(function()
	Main.NowPlayingPanelScreen("Listeners")
end)

NowPlaying.Content.Panel.Actions.Lyrics.MouseButton1Click:Connect(function()
	Main.NowPlayingPanelScreen("Lyrics")
end)

NowPlaying.Content.Panel.Actions.QueueList.MouseButton1Click:Connect(function()
	Main.NowPlayingPanelScreen("QueueList")
end)

NowPlaying.Content.Media.MouseEnter:Connect(function()
	local TitleX = NowPlaying.Content.Media.Details.SongInfo.Title.Label.AbsoluteSize.X

	if TitleX > 180 then
		local Offset = 180 - TitleX

		TweenService:Create(NowPlaying.Content.Media.Details.SongInfo.Title.padding, TweenInfo.new(TitleX / 50), 
			{PaddingLeft = UDim.new(0, Offset)}):Play()
	end
end)

NowPlaying.Content.Media.InputEnded:Connect(function()
	TweenService:Create(NowPlaying.Content.Media.Details.SongInfo.Title.padding, slow, {PaddingLeft = UDim.new(0, 15)}):Play()
end)

NowPlaying.Content.Media.Details.SongInfo.Title.TouchSwipe:Connect(function(Direction)
	if Direction == Enum.SwipeDirection.Right then
		events.Playback.Rewind:Fire()

	elseif Direction == Enum.SwipeDirection.Left then
		events.Playback.Forward:Fire()
	end
end)

NowPlaying.Content.Media.Details.SongInfo.Source.TouchSwipe:Connect(function(Direction)
	if Direction == Enum.SwipeDirection.Right then
		events.Playback.Rewind:Fire()

	elseif Direction == Enum.SwipeDirection.Left then
		events.Playback.Forward:Fire()
	end
end)

NowPlaying.Content.Media.Art.Photo.Shield.TouchSwipe:Connect(function(Direction)
	if Direction == Enum.SwipeDirection.Right then
		events.Playback.Rewind:Fire()

	elseif Direction == Enum.SwipeDirection.Left then
		events.Playback.Forward:Fire()
	end
end)

NowPlaying.Content.Media.Details.SongInfo.Source.MouseButton1Click:Connect(function()
	local Option = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.Others.ViewArtist.Name, Icon = OptionInfoPresets.Others.ViewArtist.Icon},
			{Name = OptionInfoPresets.Others.ViewDetails.Name, Icon = OptionInfoPresets.Others.ViewDetails.Icon}
		},
	})

	if Option == "View Artist" then
		callback_ViewArtist(NowPlaying.Content.Media.Details.SongInfo.Source.Text)

	elseif Option == "View Details" then
		callback_ViewDetails()

	end
end)

NowPlaying.Content.Media.Details.SongInfo.Source.TouchLongPress:Connect(function()
	local Option = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.Others.ViewArtist.Name, Icon = OptionInfoPresets.Others.ViewArtist.Icon},
			{Name = OptionInfoPresets.Others.ViewDetails.Name, Icon = OptionInfoPresets.Others.ViewDetails.Icon}
		},
		Mobile = true
	})

	if Option == "View Artist" then
		callback_ViewArtist(NowPlaying.Content.Media.Details.SongInfo.Source.Text)

	elseif Option == "View Details" then
		callback_ViewDetails()

	end
end)

-- NowPlaying / Scrubber

local function UpdateTimeScrubber(input)
	local Frame = NowPlaying.Content.Media.Timeline.Scrubber
	local DeltaX = input.Position.X - TimeScrubberData.StartPos
	local DeltaScale = DeltaX / Frame.AbsoluteSize.X
	local NewScale = math.clamp(TimeScrubberData.StartScale + DeltaScale, 0, 1)

	Frame.Fill.Size = UDim2.fromScale(NewScale, 1)

	return NewScale
end

local function ApplyTimeScrubbedPosition()
	if Queue.GetLoadingStatus() then return end
	if Queue.GetCrossfadingStatus() then return end

	local CurrentSong = Queue.GetActiveSound()
	if not CurrentSong then return end

	local ScaleX = NowPlaying.Content.Media.Timeline.Scrubber.Fill.Size.X.Scale
	local TimePosition = Utilities.Map(ScaleX, 0, 1, 0, CurrentSong.TimeLength)

	CurrentSong.TimePosition = TimePosition
end

NowPlaying.Content.Media.Timeline.Scrubber.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		TimeScrubberData.Dragging = true
		TimeScrubberData.StartPos = input.Position.X
		TimeScrubberData.StartScale = NowPlaying.Content.Media.Timeline.Scrubber.Fill.Size.X.Scale

		TweenService:Create(NowPlaying.Content.Media.Timeline.Scrubber, normal, {
			GroupTransparency = 0,
			Size = UDim2.new(1, 20, 0, 12)}):Play()

		TweenService:Create(NowPlaying.Content.Media.Timeline.Data.TimeLength, normal, {TextTransparency = 0}):Play()
		TweenService:Create(NowPlaying.Content.Media.Timeline.Data.TimePosition, normal, {TextTransparency = 0}):Play()
	end
end)

InputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if TimeScrubberData.Dragging then
			ApplyTimeScrubbedPosition()

			TimeScrubberData.Dragging = false

			--

			TweenService:Create(NowPlaying.Content.Media.Timeline.Scrubber, normal, {GroupTransparency = .5,
				Size = UDim2.new(1, 0, 0, 6)}):Play()

			TweenService:Create(NowPlaying.Content.Media.Timeline.Data.TimeLength, normal, {TextTransparency = .8}):Play()
			TweenService:Create(NowPlaying.Content.Media.Timeline.Data.TimePosition, normal, {TextTransparency = .8}):Play()
		end
	end
end)

InputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or
		input.UserInputType == Enum.UserInputType.Touch then

		if TimeScrubberData.Dragging then
			UpdateTimeScrubber(input)
		end
	end
end)

--

Queue.QueueUpdated:Connect(function()
	print("updated")

	-- Clearance

	for i, residual in NowPlaying.Content.Panel.Queue.QueueSection.Container:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	for i, residual in NowPlaying.Content.Panel.Queue.ContinuePlayingSection.Container:GetChildren() do
		if residual:HasTag("MastersTemplate") then
			residual:Destroy()
		end
	end

	-- Listing

	local VisualQueue = Queue.GetVisualQueue()

	NowPlaying.Content.Panel.Queue.QueueSection.Visible = #VisualQueue.Queue > 0
	NowPlaying.Content.Panel.Queue.ContinuePlayingSection.Visible = #VisualQueue.ContinuePlaying > 0

	NowPlaying.Content.Panel.Queue.ContinuePlayingSection.Header.Context.Text = "From " .. Queue.GetContextName()

	local Lists = {
		Queue = {},
		ContinuePlaying = {},
	}

	for i, Song in VisualQueue.Queue do
		Lists.Queue[i] = Song.Id
	end

	for i, Song in VisualQueue.ContinuePlaying do
		Lists.ContinuePlaying[i] = Song.Id
	end

	local QueueMetadata = Audios.GetAudioMetadataAsync(Lists.Queue)
	local ContinuePlayingMetadata = Audios.GetAudioMetadataAsync(Lists.ContinuePlaying)

	if not QueueMetadata or not ContinuePlayingMetadata then return end

	for i, Song in VisualQueue.Queue do
		local Data = QueueMetadata[i]
		if not Data then return end

		local item = ui.Storage.Items["Item(NowPlayingQueue)"]:Clone()

		item.Name = Song.Id
		item.LayoutOrder = i

		item:SetAttribute("TrackingId", Song.TrackingId)

		item.Art.Photo.Image = Utilities.GetCoverForSong(Song.Id)

		item.Information.Source.Text = Data.Artist		
		item.Information.Title.Text = Data.Title

		item.Parent = NowPlaying.Content.Panel.Queue.QueueSection.Container

		item.MouseButton1Click:Connect(function()
			Queue.ProceedByTrackingId(Song.TrackingId)
		end)

		item.MouseButton2Click:Connect(function()
			PromptSongOptions("Queue", {
				SongId = Song.Id,
				TrackingId = Song.TrackingId
			})
		end)

		item.TouchLongPress:Connect(function()
			PromptSongOptions("Queue", {
				SongId = Song.Id,
				TrackingId = Song.TrackingId
			}, true)
		end)
	end

	for i, Song in VisualQueue.ContinuePlaying do
		local Data = ContinuePlayingMetadata[i]
		if not Data then return end

		local item = ui.Storage.Items["Item(NowPlayingQueue)"]:Clone()

		item.Name = Song.Id
		item.LayoutOrder = i

		item:SetAttribute("TrackingId", Song.TrackingId)

		item.Art.Photo.Image = Utilities.GetCoverForSong(Song.Id)

		item.Information.Source.Text = Data.Artist		
		item.Information.Title.Text = Data.Title

		item.Parent = NowPlaying.Content.Panel.Queue.ContinuePlayingSection.Container

		item.MouseButton1Click:Connect(function()
			Queue.ProceedByTrackingId(Song.TrackingId)
		end)

		item.MouseButton2Click:Connect(function()
			PromptSongOptions("ContinuePlaying", {
				SongId = Song.Id,
				TrackingId = Song.TrackingId
			})
		end)

		item.TouchLongPress:Connect(function()
			PromptSongOptions("ContinuePlaying", {
				SongId = Song.Id,
				TrackingId = Song.TrackingId,
			}, true)
		end)
	end
end)

NowPlaying.Content.Panel.Queue.QueueSection.Header.Clear.MouseButton1Click:Connect(function()
	Queue.ClearQueue()
end)

--

NowPlaying.Content.Media.Playback.PlayPause.MouseButton1Click:Connect(function()
	events.Playback.PlayPause:Fire()
end)

NowPlaying.Content.Media.Playback.Forward.MouseButton1Click:Connect(function()
	events.Playback.Forward:Fire()
end)

NowPlaying.Content.Media.Playback.Rewind.MouseButton1Click:Connect(function()
	events.Playback.Rewind:Fire()
end)

-- NowPlaying / Dragging Behavior

local NowPlayingDragProperties = {
	MaxSize = 1,
	MinSize = 0,
	Threshold = .5,
	Elasticity = .3,
	SnapTween = TweenInfo.new(.5, Enum.EasingStyle.Exponential)
}

local NowPlayingDragStatus = {
	Dragging = false,
	DragStartY = 0,
	StartSize = NowPlaying.Size.Y.Scale,
	StartPos = NowPlaying.Position.Y.Scale
}

local function SetSize(ScaleY)
	ScaleY = math.clamp(ScaleY, -5, 5)
	NowPlaying.Size = UDim2.new(NowPlaying.Size.X.Scale, NowPlaying.Size.X.Offset, ScaleY, NowPlaying.Size.Y.Offset or 0)
end

local function SnapTo(State)
	if State then
		TweenService:Create(NowPlaying, NowPlayingDragProperties.SnapTween, {
			Size = UDim2.new(NowPlaying.Size.X.Scale, NowPlaying.Size.X.Offset,
				NowPlayingDragProperties.MaxSize, NowPlaying.Size.Y.Offset or 0), Position = UDim2.new(.5, 0, 1, 0)}):Play()		
	else
		Main.NowPlaying(false)
	end
end

NowPlaying.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	NowPlaying.Content.Media.Interactable = false
	NowPlaying.Content.Panel.Interactable = false

	NowPlayingDragStatus.Dragging = true
	NowPlayingDragStatus.DragStartY = input.Position.Y
	NowPlayingDragStatus.StartSize = NowPlaying.Size.Y.Scale
	NowPlayingDragStatus.StartPos = NowPlaying.Position.Y.Scale

	input.Changed:Connect(function()
		if input.UserInputState == Enum.UserInputState.End and NowPlayingDragStatus.Dragging then
			NowPlayingDragStatus.Dragging = false

			NowPlaying.Content.Media.Interactable = true
			NowPlaying.Content.Panel.Interactable = true

			local currentScale = NowPlaying.Size.Y.Scale

			if currentScale <= NowPlayingDragProperties.Threshold then
				SnapTo(false)
			else
				SnapTo(true)
			end
		end
	end)
end)

InputService.InputChanged:Connect(function(input)
	if not NowPlayingDragStatus.Dragging then return end

	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if TimeScrubberData.Dragging then return end

		local DeltaY = input.Position.Y - NowPlayingDragStatus.DragStartY
		local ParentHeight = math.max(1, NowPlaying.Parent.AbsoluteSize.Y)
		local Data = -DeltaY / ParentHeight
		local Target = NowPlayingDragStatus.StartSize + Data

		if Target > NowPlayingDragProperties.MaxSize then
			Target = NowPlayingDragProperties.MaxSize + (Target - NowPlayingDragProperties.MaxSize) * NowPlayingDragProperties.Elasticity
		elseif Target < NowPlayingDragProperties.MinSize then
			Target = NowPlayingDragProperties.MinSize - (NowPlayingDragProperties.MinSize - Target) * NowPlayingDragProperties.Elasticity
		end

		SetSize(Target)
	end
end)

-- NowPlaying / Volume

local function UpdateVolumeScrubber(input)
	local Frame = NowPlaying.Content.Media.Volume.Scrubber
	local DeltaX = input.Position.X - VolumeScrubberData.StartPos
	local DeltaScale = DeltaX / Frame.AbsoluteSize.X
	local NewScale = math.clamp(VolumeScrubberData.StartScale + DeltaScale, 0, 1)

	Frame.Fill.Size = UDim2.fromScale(NewScale, 1)

	local NewVolume = Utilities.Map(NewScale, 0, 1, 0, 2)

	TweenService:Create(Playback, normal, {Volume = NewVolume}):Play()
end

local function ApplyNewVolume(Volume)
	local Frame = NowPlaying.Content.Media.Volume.Scrubber
	local NewScale = Utilities.Map(Volume, 0, 2, 0, 1)

	TweenService:Create(Frame.Fill, normal, {Size = UDim2.fromScale(NewScale, 1)}):Play()
end

NowPlaying.Content.Media.Volume.Scrubber.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		VolumeScrubberData.Dragging = true
		VolumeScrubberData.StartPos = input.Position.X
		VolumeScrubberData.StartScale = NowPlaying.Content.Media.Volume.Scrubber.Fill.Size.X.Scale

		TweenService:Create(NowPlaying.Content.Media.Volume, normal, {Size = UDim2.new(0, 190, 0, 14)}):Play()
		TweenService:Create(NowPlaying.Content.Media.Volume.Scrubber, normal, {
			GroupTransparency = 0,
			Size = UDim2.new(1, 0, 0, 12)}):Play()

		TweenService:Create(NowPlaying.Content.Media.Volume.Max, normal, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlaying.Content.Media.Volume.Min, normal, {ImageTransparency = 0}):Play()
	end
end)

InputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if VolumeScrubberData.Dragging then
			VolumeScrubberData.Dragging = false

			--

			TweenService:Create(NowPlaying.Content.Media.Volume, normal, {Size = UDim2.new(0, 180, 0, 14)}):Play()
			TweenService:Create(NowPlaying.Content.Media.Volume.Scrubber, normal, {
				GroupTransparency = .5,
				Size = UDim2.new(1, 0, 0, 6)}):Play()

			TweenService:Create(NowPlaying.Content.Media.Volume.Max, normal, {ImageTransparency = .5}):Play()
			TweenService:Create(NowPlaying.Content.Media.Volume.Min, normal, {ImageTransparency = .5}):Play()
		end
	end
end)

InputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or
		input.UserInputType == Enum.UserInputType.Touch then

		if VolumeScrubberData.Dragging then
			UpdateVolumeScrubber(input)
		end
	end
end)

-- NowPlaying / QueueControls

NowPlaying.Content.Panel.QueueOptions.Shuffle.MouseButton1Click:Connect(function()
	Queue.ToggleShuffle()
end)

NowPlaying.Content.Panel.QueueOptions.Queue.MouseButton1Click:Connect(function()
	Queue.ToggleRepeat()
end)

Queue.StatusChanged:Connect(function(Status)
	if Status.Settings.Shuffle then
		TweenService:Create(NowPlaying.Content.Panel.QueueOptions.Shuffle, normal, {BackgroundTransparency = .7}):Play()

		TweenService:Create(Full.Content.Miniplayer.Container.Actions.Shuffle.Fill, normal, {BackgroundTransparency = .95}):Play()
		TweenService:Create(Full.Content.Miniplayer.Container.Actions.Shuffle.Fill.scale, normal, {Scale = 1}):Play()
	else
		TweenService:Create(NowPlaying.Content.Panel.QueueOptions.Shuffle, normal, {BackgroundTransparency = .95}):Play()

		TweenService:Create(Full.Content.Miniplayer.Container.Actions.Shuffle.Fill, normal, {BackgroundTransparency = 1}):Play()
		TweenService:Create(Full.Content.Miniplayer.Container.Actions.Shuffle.Fill.scale, normal, {Scale = .6}):Play()
	end

	if Status.Settings.RepeatMode == "Song" then
		NowPlaying.Content.Panel.Queue.Repeating.Visible = true

		TweenService:Create(NowPlaying.Content.Panel.QueueOptions.Queue, normal, {BackgroundTransparency = .7}):Play()
	else
		NowPlaying.Content.Panel.Queue.Repeating.Visible = false

		TweenService:Create(NowPlaying.Content.Panel.QueueOptions.Queue, normal, {BackgroundTransparency = .95}):Play()
	end
end)

-- Full / Artists

-- ArtistPage / Discography Search

function DiscographySearchKeyword(Keyword, SetVisibility)
	local Container = Full.Container.Artist.Sections.Discography.Content 
	local isCleaningUp = (Keyword == "" or Keyword:match("^%s*$"))
	local CleanKeyword = Keyword:lower()

	for _, Item in Container:GetChildren() do
		if not Item:IsA("GuiObject") then continue end
		if not Item:GetAttribute("OriginalLayoutOrder") then
			Item:SetAttribute("OriginalLayoutOrder", Item.LayoutOrder)
		end

		local Variable = {Item.Name, Item.Information.Source.Text, Item.Information.Title.Text} 
		local CombinedKeywords = table.concat(Variable, " "):lower()

		if isCleaningUp then
			Item.Visible = true
			Item.LayoutOrder = Item:GetAttribute("OriginalLayoutOrder") or 1
		else
			local matchFound = string.find(CombinedKeywords, CleanKeyword, 1, true) ~= nil

			if SetVisibility then
				Item.Visible = matchFound 
			else
				if matchFound then
					local startPos = string.find(CombinedKeywords, CleanKeyword, 1, true)
					Item.LayoutOrder = startPos
				else
					Item.LayoutOrder = 9999 
				end
			end
		end
	end
end

Full.Container.Artist.Sections.Discography.Header.Search.Field.FocusLost:Connect(function()
	DiscographySearchKeyword(Full.Container.Artist.Sections.Discography.Header.Search.Field.Text, false)

	TweenService:Create(Full.Container.Artist.Sections.Discography.Header.Search.Util.Line, normal, {BackgroundTransparency = .9}):Play()
end)

Full.Container.Artist.Sections.Discography.Header.Search.Field.Focused:Connect(function()
	TweenService:Create(Full.Container.Artist.Sections.Discography.Header.Search.Util.Line, normal, {BackgroundTransparency = .5}):Play()
end)

-- ArtistPage / Actions

Full.Container.Artist.Action.Play.MouseButton1Click:Connect(function()
	if #ArtistPageProperties.Discography < 1 then return end

	Queue.LoadSource(ArtistPageProperties.Discography, 1, ArtistPageProperties.CurrentArtistLoaded .. "'s Discography", true)
end)

Full.Container.Artist.Action.Play.MouseButton2Click:Connect(function()
	if #ArtistPageProperties.Discography < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayLast.PlayNext.Icon}
		}
	})

	if Options == "Play" then
		Queue.LoadSource(ArtistPageProperties.Discography, 1, ArtistPageProperties.CurrentArtistLoaded .. "'s Discography", true)

	elseif Options == "Play Next" then
		Queue.PlayNext(ArtistPageProperties.Discography)

	elseif Options == "Play Last" then
		Queue.AddToQueue(ArtistPageProperties.Discography)
	end
end)

Full.Container.Artist.Action.Play.TouchLongPress:Connect(function()
	if #ArtistPageProperties.Discography < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayModes.PlayLast.Icon},
		}, 
		Mobile = true
	})

	if Options == "Play" then
		Queue.LoadSource(ArtistPageProperties.Discography, 1, ArtistPageProperties.CurrentArtistLoaded .. "'s Discography", true)

	elseif Options == "Play Next" then
		Queue.PlayNext(ArtistPageProperties.Discography)

	elseif Options == "Play Last" then
		Queue.AddToQueue(ArtistPageProperties.Discography)
	end
end)

Full.Container.Artist.Action.Shuffle.MouseButton1Click:Connect(function()
	if #ArtistPageProperties.Discography < 1 then return end

	if Queue.GetSettings().Shuffle then
		Queue.LoadSource(ArtistPageProperties.Discography, math.random(1, #ArtistPageProperties.Discography), 
			ArtistPageProperties.CurrentArtistLoaded .. "'s Discography", true)

		Queue.ToggleShuffle()
		Queue.ToggleShuffle()
	else
		Queue.LoadSource(ArtistPageProperties.Discography, math.random(1, #ArtistPageProperties.Discography), 
			ArtistPageProperties.CurrentArtistLoaded .. "'s Discography", true)
		Queue.ToggleShuffle()
	end
end)
print("loaded")
Full.Container.Artist.Action.More.MouseButton1Click:Connect(function()
	PromptArtistOption("ArtistPage", ArtistPageProperties.CurrentArtistLoaded)
end)

Full.Container.Artist.Action.More.TouchLongPress:Connect(function()
	PromptArtistOption("ArtistPage", ArtistPageProperties.CurrentArtistLoaded, true)
end)

Full.Container.Artist.Header.Back.MouseButton1Click:Connect(function()
	Main.SetPage(Main.GetLastMainPage())
end)

Full.Container.Artist:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
	local YAxis = Full.Container.Artist.CanvasPosition.Y
	local Transparency = Utilities.Map(YAxis, 100, 200, 0, .8)

	TweenService:Create(Full.Util.ArtistBackground.Background, smooth, {BackgroundTransparency = Transparency}):Play()
end)

-- DetailsPage

Full.Container.Details.Header.Back.MouseButton1Click:Connect(function()
	Main.SetPage(Main.GetLastMainPage())
end)

Full.Container.Details.Action.Play.MouseButton1Click:Connect(function()
	Queue.LoadSource({DetailsPageProperties.CurrentSongLoaded}, 1, "Masters", true)
end)

-- PlaylistPage

PlaylistPageProperties.RequestReload:Connect(function()
	if Main.GetCurrentPage() == "Playlist" then
		LoadPlaylist(PlaylistPageProperties.CurrentCreatorId, PlaylistPageProperties.CurrentPlaylistId)
	end
end)

Full.Container.Playlist.Canvas.Details.Action.Play.MouseButton1Click:Connect(function()
	if #PlaylistPageProperties.Songs < 1 then return end

	Queue.LoadSource(PlaylistPageProperties.Songs, 1, PlaylistPageProperties.CurrentPlaylistName, true)
end)

Full.Container.Playlist.Canvas.Details.Action.Play.MouseButton2Click:Connect(function()
	if #PlaylistPageProperties.Songs < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayLast.PlayNext.Icon}
		}
	})

	if Options == "Play" then
		Queue.LoadSource(PlaylistPageProperties.Songs, 1, PlaylistPageProperties.CurrentPlaylistName, true)

	elseif Options == "Play Next" then
		Queue.PlayNext(PlaylistPageProperties.Songs)

	elseif Options == "Play Last" then
		Queue.AddToQueue(PlaylistPageProperties.Songs)
	end
end)

Full.Container.Playlist.Canvas.Details.Action.Play.TouchLongPress:Connect(function()
	if #PlaylistPageProperties.Songs < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayModes.PlayLast.Icon},
		}, 
		Mobile = true
	})

	if Options == "Play" then
		Queue.LoadSource(PlaylistPageProperties.Songs, 1, PlaylistPageProperties.CurrentPlaylistName, true)

	elseif Options == "Play Next" then
		Queue.PlayNext(PlaylistPageProperties.Songs)

	elseif Options == "Play Last" then
		Queue.AddToQueue(PlaylistPageProperties.Songs)
	end
end)

Full.Container.Playlist.Canvas.Details.Action.Shuffle.MouseButton1Click:Connect(function()
	if #PlaylistPageProperties.Songs < 1 then return end

	if Queue.GetSettings().Shuffle then
		Queue.LoadSource(PlaylistPageProperties.Songs, math.random(1, #PlaylistPageProperties.Songs), 
			PlaylistPageProperties.CurrentPlaylistName, true)

		Queue.ToggleShuffle()
		Queue.ToggleShuffle()
	else
		Queue.LoadSource(PlaylistPageProperties.Songs, math.random(1, #PlaylistPageProperties.Songs), 
			PlaylistPageProperties.CurrentPlaylistName, true)
		Queue.ToggleShuffle()
	end
end)

Full.Container.Playlist.Canvas.Details.Action.More.MouseButton1Click:Connect(function()
	PromptPlaylistOption("PlaylistPage", PlaylistPageProperties.CurrentPlaylistData)
end)

Full.Container.Playlist.Canvas.Details.Action.More.TouchLongPress:Connect(function()
	PromptPlaylistOption("PlaylistPage", PlaylistPageProperties.CurrentPlaylistData, true)
end)

Full.Container.Playlist.Canvas.Details.Action.Add.MouseButton1Click:Connect(function()
	Main.SetPage("Search")
end)

Full.Container.Playlist.Header.Back.MouseButton1Click:Connect(function()
	Main.SetPage(Main.GetLastMainPage())
end)

-- StationPage

Full.Container.Stations.Canvas.Details.Action.Play.MouseButton1Click:Connect(function()
	if #StationPageProperties.Songs < 1 then return end

	Queue.LoadSource(StationPageProperties.Songs, 1, StationPageProperties.CurrentStationData.Name, true)
end)

Full.Container.Stations.Canvas.Details.Action.Play.MouseButton2Click:Connect(function()
	if #StationPageProperties.Songs < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayLast.PlayNext.Icon}
		}
	})

	if Options == "Play" then
		Queue.LoadSource(StationPageProperties.Songs, 1, StationPageProperties.CurrentStationData.Name, true)

	elseif Options == "Play Next" then
		Queue.PlayNext(StationPageProperties.Songs)

	elseif Options == "Play Last" then
		Queue.AddToQueue(StationPageProperties.Songs)
	end
end)

Full.Container.Stations.Canvas.Details.Action.Play.TouchLongPress:Connect(function()
	if #StationPageProperties.Songs < 1 then return end

	local Options = Main.PromptOptions({
		Options = {
			{Name = OptionInfoPresets.PlayModes.Play.Name, Icon = OptionInfoPresets.PlayModes.Play.Icon, Primary = true},

			"SEPARATOR",

			{Name = OptionInfoPresets.PlayModes.PlayNext.Name, Icon = OptionInfoPresets.PlayModes.PlayNext.Icon},
			{Name = OptionInfoPresets.PlayModes.PlayLast.Name, Icon = OptionInfoPresets.PlayModes.PlayLast.Icon},
		}, 
		Mobile = true
	})

	if Options == "Play" then
		Queue.LoadSource(StationPageProperties.Songs, 1, StationPageProperties.CurrentStationData.Name, true)

	elseif Options == "Play Next" then
		Queue.PlayNext(StationPageProperties.Songs)

	elseif Options == "Play Last" then
		Queue.AddToQueue(StationPageProperties.Songs)
	end
end)

Full.Container.Stations.Canvas.Details.Action.Shuffle.MouseButton1Click:Connect(function()
	if #StationPageProperties.Songs < 1 then return end

	if Queue.GetSettings().Shuffle then
		Queue.LoadSource(StationPageProperties.Songs, math.random(1, #StationPageProperties.Songs), 
			StationPageProperties.CurrentStationData.Name, true)

		Queue.ToggleShuffle()
		Queue.ToggleShuffle()
	else
		Queue.LoadSource(StationPageProperties.Songs, math.random(1, #StationPageProperties.Songs), 
			StationPageProperties.CurrentStationData.Name, true)
		Queue.ToggleShuffle()
	end
end)

Full.Container.Stations.Canvas.Details.Action.More.MouseButton1Click:Connect(function()
	PromptStationOption("StationPage",  StationPageProperties.CurrentStationData, StationPageProperties.IsCurrentlyOnline)
end)

Full.Container.Stations.Canvas.Details.Action.More.TouchLongPress:Connect(function()
	PromptStationOption("StationPage", StationPageProperties.CurrentStationData, StationPageProperties.IsCurrentlyOnline, true)
end)

Full.Container.Stations.Header.Back.MouseButton1Click:Connect(function()
	Main.SetPage(Main.GetLastMainPage())
end)

-- Full / Sidebar

function AssignClientInformation()
	Full.Content.Sidebar.User.Profile.Image = Utilities.GetPlayerThumbnail(client.UserId)
	Full.Content.Sidebar.User.Display.Text = client.DisplayName
end

AssignClientInformation()

Full.Content.Sidebar.User.More.MouseButton1Click:Connect(function()
	local OptionChosen = Main.PromptOptions({
		Options = {
			{Name = "Settings", Icon = "rbxassetid://11293977610"}
		}
	})

	if OptionChosen == "Settings" then
		LoadSettings()
	end
end)

-- Full & NowPlaying / Animations

for i, Actions in CollectionService:GetTagged("MastersMiniplayerAction") do
	if Actions:IsA("ImageButton") then

		Actions.MouseEnter:Connect(function()
			TweenService:Create(Actions.Icon.scale, normal, {Scale = 1.2}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(Actions.Selection.scale, normal, {Scale = 1.1}):Play()
		end)

		Actions.MouseButton1Down:Connect(function()
			TweenService:Create(Actions.Icon.scale, normal, {Scale = .6}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(Actions.Selection.scale, normal, {Scale = .9}):Play()
		end)

		Actions.InputEnded:Connect(function()
			TweenService:Create(Actions.Icon.scale, bounce, {Scale = 1}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = 1}):Play()
			TweenService:Create(Actions.Selection.scale, bounce, {Scale = 1}):Play()
		end)

	end
end

ui.DescendantAdded:Connect(function(Actions)
	if Actions:HasTag("MastersMiniplayerAction") then
		Actions.MouseEnter:Connect(function()
			TweenService:Create(Actions.Icon.scale, normal, {Scale = 1.2}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(Actions.Selection.scale, normal, {Scale = 1.1}):Play()
		end)

		Actions.MouseButton1Down:Connect(function()
			TweenService:Create(Actions.Icon.scale, normal, {Scale = .6}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(Actions.Selection.scale, normal, {Scale = .9}):Play()
		end)

		Actions.InputEnded:Connect(function()
			TweenService:Create(Actions.Icon.scale, bounce, {Scale = 1}):Play()
			TweenService:Create(Actions.Selection, normal, {BackgroundTransparency = 1}):Play()
			TweenService:Create(Actions.Selection.scale, bounce, {Scale = 1}):Play()
		end)
	end
end)

for i, PlaybackControl in CollectionService:GetTagged("MastersMiniplayerPlaybackControls") do
	if PlaybackControl:IsA("ImageButton") then

		PlaybackControl.MouseEnter:Connect(function()
			TweenService:Create(PlaybackControl.Icon.scale, normal, {Scale = 1.2}):Play()
			TweenService:Create(PlaybackControl.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(PlaybackControl.Selection.scale, normal, {Scale = 1.1}):Play()
		end)

		PlaybackControl.MouseButton1Down:Connect(function()
			TweenService:Create(PlaybackControl.Icon.scale, normal, {Scale = .6}):Play()
			TweenService:Create(PlaybackControl.Selection, normal, {BackgroundTransparency = .95}):Play()
			TweenService:Create(PlaybackControl.Selection.scale, normal, {Scale = .9}):Play()
		end)

		PlaybackControl.InputEnded:Connect(function()
			TweenService:Create(PlaybackControl.Icon.scale, bounce, {Scale = 1}):Play()
			TweenService:Create(PlaybackControl.Selection, normal, {BackgroundTransparency = 1}):Play()
			TweenService:Create(PlaybackControl.Selection.scale, bounce, {Scale = 1}):Play()
		end)

	end
end

local MiniplayerPlaybackAnimations = {
	Forward = {
		Animating = false,
		State = 1,
		Triangles = {
			A = Full.Content.Miniplayer.Container.Playback.Forward.Icon.TriangleA,
			B = Full.Content.Miniplayer.Container.Playback.Forward.Icon.TriangleB,
			C = Full.Content.Miniplayer.Container.Playback.Forward.Icon.TriangleC,
		}
	},

	Rewind = {
		Animating = false,
		State = 1,
		Triangles = {
			A = Full.Content.Miniplayer.Container.Playback.Rewind.Icon.TriangleA,
			B = Full.Content.Miniplayer.Container.Playback.Rewind.Icon.TriangleB,
			C = Full.Content.Miniplayer.Container.Playback.Rewind.Icon.TriangleC,
		}
	},
}

Full.Content.Miniplayer.Container.Playback.Forward.MouseButton1Click:Connect(function()
	if MiniplayerPlaybackAnimations.Forward.Animating then return end
	MiniplayerPlaybackAnimations.Forward.Animating = true

	if MiniplayerPlaybackAnimations.Forward.State == 1 then
		MiniplayerPlaybackAnimations.Forward.State += 1

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.A, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.A.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.C, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.C.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 2
		MiniplayerPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 3
		MiniplayerPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 1

	elseif MiniplayerPlaybackAnimations.Forward.State == 2 then
		MiniplayerPlaybackAnimations.Forward.State += 1

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.C, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.C.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.B, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.B.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 3
		MiniplayerPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 1
		MiniplayerPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 2

	elseif MiniplayerPlaybackAnimations.Forward.State == 3 then
		MiniplayerPlaybackAnimations.Forward.State = 1

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.B, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.B.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.A, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Forward.Triangles.A.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 1
		MiniplayerPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 2
		MiniplayerPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 3
	end

	MiniplayerPlaybackAnimations.Forward.Animating = false
end)

Full.Content.Miniplayer.Container.Playback.Rewind.MouseButton1Click:Connect(function()
	if MiniplayerPlaybackAnimations.Rewind.Animating then return end
	MiniplayerPlaybackAnimations.Rewind.Animating = true

	if MiniplayerPlaybackAnimations.Rewind.State == 1 then
		MiniplayerPlaybackAnimations.Rewind.State += 1

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.A, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.A.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.C, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.C.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 2
		MiniplayerPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 1
		MiniplayerPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 3

	elseif MiniplayerPlaybackAnimations.Rewind.State == 2 then
		MiniplayerPlaybackAnimations.Rewind.State += 1

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.C, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.C.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.B, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.B.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 1
		MiniplayerPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 3
		MiniplayerPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 2

	elseif MiniplayerPlaybackAnimations.Rewind.State == 3 then
		MiniplayerPlaybackAnimations.Rewind.State = 1

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.B, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.B.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.A, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(MiniplayerPlaybackAnimations.Rewind.Triangles.A.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		MiniplayerPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 3
		MiniplayerPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 2
		MiniplayerPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 1
	end

	MiniplayerPlaybackAnimations.Rewind.Animating = false
end)

local NowPlayingPlaybackAnimations = {
	Forward = {
		Animating = false,
		State = 1,
		Triangles = {
			A = NowPlaying.Content.Media.Playback.Forward.Icon.TriangleA,
			B = NowPlaying.Content.Media.Playback.Forward.Icon.TriangleB,
			C = NowPlaying.Content.Media.Playback.Forward.Icon.TriangleC,
		}
	},

	Rewind = {
		Animating = false,
		State = 1,
		Triangles = {
			A = NowPlaying.Content.Media.Playback.Rewind.Icon.TriangleA,
			B = NowPlaying.Content.Media.Playback.Rewind.Icon.TriangleB,
			C = NowPlaying.Content.Media.Playback.Rewind.Icon.TriangleC,
		}
	},
}

NowPlaying.Content.Media.Playback.Forward.MouseButton1Click:Connect(function()
	if NowPlayingPlaybackAnimations.Forward.Animating then return end
	NowPlayingPlaybackAnimations.Forward.Animating = true

	if NowPlayingPlaybackAnimations.Forward.State == 1 then
		NowPlayingPlaybackAnimations.Forward.State += 1

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.A, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.A.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.C, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.C.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 2
		NowPlayingPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 3
		NowPlayingPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 1

	elseif NowPlayingPlaybackAnimations.Forward.State == 2 then
		NowPlayingPlaybackAnimations.Forward.State += 1

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.C, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.C.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.B, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.B.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 3
		NowPlayingPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 1
		NowPlayingPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 2

	elseif NowPlayingPlaybackAnimations.Forward.State == 3 then
		NowPlayingPlaybackAnimations.Forward.State = 1

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.B, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.B.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.A, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Forward.Triangles.A.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Forward.Triangles.A.LayoutOrder = 1
		NowPlayingPlaybackAnimations.Forward.Triangles.B.LayoutOrder = 2
		NowPlayingPlaybackAnimations.Forward.Triangles.C.LayoutOrder = 3
	end

	NowPlayingPlaybackAnimations.Forward.Animating = false
end)

NowPlaying.Content.Media.Playback.Rewind.MouseButton1Click:Connect(function()
	if NowPlayingPlaybackAnimations.Rewind.Animating then return end
	NowPlayingPlaybackAnimations.Rewind.Animating = true

	if NowPlayingPlaybackAnimations.Rewind.State == 1 then
		NowPlayingPlaybackAnimations.Rewind.State += 1

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.A, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.A.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.C, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.C.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 2
		NowPlayingPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 1
		NowPlayingPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 3

	elseif NowPlayingPlaybackAnimations.Rewind.State == 2 then
		NowPlayingPlaybackAnimations.Rewind.State += 1

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.C, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.C.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.B, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.B.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 1
		NowPlayingPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 3
		NowPlayingPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 2

	elseif NowPlayingPlaybackAnimations.Rewind.State == 3 then
		NowPlayingPlaybackAnimations.Rewind.State = 1

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.B, bounce, {ImageTransparency = 0}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.B.scale, bounce, {Scale = 1}):Play()

		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.A, normal, {ImageTransparency = 1}):Play()
		TweenService:Create(NowPlayingPlaybackAnimations.Rewind.Triangles.A.scale, normal, {Scale = 0}):Play()

		--
		task.wait(.5)
		--

		NowPlayingPlaybackAnimations.Rewind.Triangles.A.LayoutOrder = 3
		NowPlayingPlaybackAnimations.Rewind.Triangles.B.LayoutOrder = 2
		NowPlayingPlaybackAnimations.Rewind.Triangles.C.LayoutOrder = 1
	end

	NowPlayingPlaybackAnimations.Rewind.Animating = false
end)

-- PlaylistCreation

PlaylistCreation.Header.Create.MouseButton1Click:Connect(function()
	--print(PlaylistCreation:GetAttribute("Title"))
	if PlaylistCreation:GetAttribute("Title") == "" then
		Alerts.BannerNotify({
			Header = "Missing Fields",
			Description = "There are some fields left that you need to fill out.",
			Icon = "rbxassetid://11432842812"
		})

		return
	end

	if not PlaylistCreation.Cover.Custom.IsLoaded then
		Alerts.BannerNotify({
			Header = "Not Loading",
			Description = "The provided playlist cover is not loading.",
			Icon = "rbxassetid://11419713569"
		})

		return
	end

	if PlaylistPageProperties.FilteringTitle then
		Alerts.BannerNotify({
			Header = "Filtering Text",
			Description = "Your playlist title is still being filtered.",
			Icon = "rbxassetid://11419713569"
		})

		return
	end

	local Success, Result = events.Main.Library.CreatePlaylist:InvokeServer({
		Name = PlaylistCreation:GetAttribute("Title"),
		Cover = PlaylistCreation:GetAttribute("Cover"),
	})

	if Success then
		Main.PlaylistCreation(false)
		Main.PlaylistCreationClosed:Fire(Result)

		if PlaylistPageProperties.ToAdd ~= 0 then
			callback_SongPlaylist(1, PlaylistPageProperties.ToAdd, Result)
		end

		LoadPlaylist(client.UserId, Result)

	else
		if Result == "limit" then
			Alerts.BannerNotify({
				Header = ".",
				Description = "You have exceeded the maximum of 30 playlists.",
				Icon = "rbxassetid://11419709766"
			})
		end
	end
end)

PlaylistCreation.Header.Cancel.MouseButton1Click:Connect(function()
	PlaylistPageProperties.ToAdd = 0

	Main.PlaylistCreation(false)
	Main.PlaylistCreationClosed:Fire()
end)

-- PlaylistCreation / Cover

PlaylistCreation:GetAttributeChangedSignal("Cover"):Connect(function()
	PlaylistCreation.Info.Cover.AssetId.Field.Text = PlaylistCreation:GetAttribute("Cover")
end)

PlaylistCreation.Info.Title.Field:GetPropertyChangedSignal("Text"):Connect(function()
	PlaylistCreation.Info.Title.Count.Text = string.len(PlaylistCreation.Info.Title.Field.Text) .. "/30"
end)

task.spawn(function()
	while task.wait(1) do
		PlaylistPageProperties.FilteringTitle = true

		local Trimmed = Utilities.TrimString(PlaylistCreation.Info.Title.Field.Text, 30)
		--local Final = TextFiltering.FilterBroadcast(Trimmed, client.UserId)

		PlaylistPageProperties.FilteringTitle = false

		PlaylistCreation.Info.Title.Field.Text = Trimmed
		PlaylistCreation:SetAttribute("Title", Trimmed)
		--print(PlaylistCreation.Info.Title.Field.Text)
	end
end)
PlaylistCreation.Info.Title.Field.FocusLost:Connect(function()
	PlaylistPageProperties.FilteringTitle = true

	local Trimmed = Utilities.TrimString(PlaylistCreation.Info.Title.Field.Text, 30)
	--local Final = TextFiltering.FilterBroadcast(Trimmed, client.UserId)

	PlaylistPageProperties.FilteringTitle = false

	PlaylistCreation.Info.Title.Field.Text = Trimmed
	PlaylistCreation:SetAttribute("Title", Trimmed)
end)

PlaylistCreation.Info.Cover.AssetId.Field.FocusLost:Connect(function()
	local AssetId = PlaylistCreation.Info.Cover.AssetId.Field.Text

	if tonumber(AssetId) then
		AssetId = "rbxassetid://" .. AssetId
	end

	PlaylistCreation.Cover.Custom.Image = AssetId
	PlaylistCreation:SetAttribute("Cover", AssetId)
end)

PlaylistCreation.Cover.Custom:GetPropertyChangedSignal("IsLoaded"):Connect(function()
	if PlaylistCreation.Cover.Custom.IsLoaded then
		TweenService:Create(PlaylistCreation.Cover.Custom.Loading, normal, {ImageTransparency = 1}):Play()
	else
		TweenService:Create(PlaylistCreation.Cover.Custom.Loading, normal, {ImageTransparency = .5}):Play()
	end
end)

-- SettingsPage
-- SettingsPage / Playback
-- SettingsPage / Playback / Crossfade

local CrossfadeDurationTimeline = SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Timeline
local CrossfadeDurationScrubber = SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Timeline.Scrubber

local function UpdateCrossfadeDurationScrubber(input)
	local DeltaX = input.Position.X - CrossfadeDurationScrubberData.StartPos
	local DeltaScale = DeltaX / CrossfadeDurationScrubber.AbsoluteSize.X
	local NewScale = math.clamp(CrossfadeDurationScrubberData.StartScale + DeltaScale, 0, 1)

	CrossfadeDurationScrubber.Fill.Size = UDim2.fromScale(NewScale, 1)

	local NewDuration = Utilities.Map(NewScale, 0, 1, 1, 10)

	SettingsPageProperties.Data.Playback.Crossfade.Duration = NewDuration
end

SettingsPage.Scroll.Playback.Container.Crossfade.Enabled.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	if SettingsPageProperties.Data.Playback.Crossfade.Enabled then
		SettingsPageProperties.Data.Playback.Crossfade.Enabled = false

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Crossfade.Enabled.Switch, false)

		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Visible = false
	else
		SettingsPageProperties.Data.Playback.Crossfade.Enabled = true

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Crossfade.Enabled.Switch, true)

		SettingsPage.Scroll.Playback.Container.Crossfade.Duration.Visible = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

CrossfadeDurationScrubber.InputBegan:Connect(function(input)
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		CrossfadeDurationScrubberData.Dragging = true
		CrossfadeDurationScrubberData.StartPos = input.Position.X
		CrossfadeDurationScrubberData.StartScale = CrossfadeDurationScrubber.Fill.Size.X.Scale

		TweenService:Create(CrossfadeDurationTimeline, normal, {Size = UDim2.new(1, 0, 0, 40)}):Play()
		TweenService:Create(CrossfadeDurationScrubber, normal, {
			GroupTransparency = 0,
			Size = UDim2.new(1, 0, 0, 12)}):Play()

		TweenService:Create(CrossfadeDurationTimeline.Data.Max, normal, {TextTransparency = 0}):Play()
		TweenService:Create(CrossfadeDurationTimeline.Data.Min, normal, {TextTransparency = 0}):Play()
	end
end)

InputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if CrossfadeDurationScrubberData.Dragging then
			CrossfadeDurationScrubberData.Dragging = false

			SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)

			--

			TweenService:Create(CrossfadeDurationTimeline, normal, {Size = UDim2.new(1, 0, 0, 30)}):Play()
			TweenService:Create(CrossfadeDurationScrubber, normal, {
				GroupTransparency = .5,
				Size = UDim2.new(1, 0, 0, 6)}):Play()

			TweenService:Create(CrossfadeDurationTimeline.Data.Max, normal, {TextTransparency = .5}):Play()
			TweenService:Create(CrossfadeDurationTimeline.Data.Min, normal, {TextTransparency = .5}):Play()
		end
	end
end)

InputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or
		input.UserInputType == Enum.UserInputType.Touch then

		if CrossfadeDurationScrubberData.Dragging then
			UpdateCrossfadeDurationScrubber(input)
		end
	end
end)

-- SettingsPage / Playback / Equalizer

SettingsPage.Scroll.Playback.Container.Equalizer.Enabled.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	if SettingsPageProperties.Data.Playback.Equalizer.Enabled then
		SettingsPageProperties.Data.Playback.Equalizer.Enabled = false

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Equalizer.Enabled.Switch, false)

		SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Visible = false
		SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Visible = false
		SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Visible = false
	else
		SettingsPageProperties.Data.Playback.Equalizer.Enabled = true

		Utilities.SwitchToggle(SettingsPage.Scroll.Playback.Container.Equalizer.Enabled.Switch, true)

		SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Visible = true
		SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Visible = true
		SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Visible = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Value.FocusLost:Connect(function(entered)
	if not entered then return end
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	local Value = tonumber(SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Value.Text)

	if Value then
		if Value > 10 then
			Value = 10
		elseif Value < -80 then
			Value = -80
		end
	else
		Value = SettingsPageProperties.Data.Playback.Equalizer.LowGain
	end

	SettingsPage.Scroll.Playback.Container.Equalizer.LowGain.Value.Text = Value

	SettingsPageProperties.Data.Playback.Equalizer.LowGain = Value
	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Value.FocusLost:Connect(function(entered)
	if not entered then return end
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	local Value = tonumber(SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Value.Text)

	if Value then
		if Value > 10 then
			Value = 10
		elseif Value < -80 then
			Value = -80
		end
	else
		Value = SettingsPageProperties.Data.Playback.Equalizer.MidGain
	end

	SettingsPage.Scroll.Playback.Container.Equalizer.MiddleGain.Value.Text = Value

	SettingsPageProperties.Data.Playback.Equalizer.MidGain = Value
	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Value.FocusLost:Connect(function(entered)
	if not entered then return end
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	local Value = tonumber(SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Value.Text)

	if Value then
		if Value > 10 then
			Value = 10
		elseif Value < -80 then
			Value = -80
		end
	else
		Value = SettingsPageProperties.Data.Playback.Equalizer.HighGain
	end

	SettingsPage.Scroll.Playback.Container.Equalizer.HighGain.Value.Text = Value

	SettingsPageProperties.Data.Playback.Equalizer.HighGain = Value
	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

-- SettingsPage / Extras

SettingsPage.Scroll.Extras.Container.Glow.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	local NewValue = not SettingsPageProperties.Data.Extras.Glow
	if SettingsPageProperties.Data.Extras.Glow then
		Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.Glow.Switch, false)

		SettingsPageProperties.Data.Extras.Glow = false
	else
		Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.Glow.Switch, true)

		SettingsPageProperties.Data.Extras.Glow = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

SettingsPage.Scroll.Extras.Container.PlaybackHaptics.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	if SettingsPageProperties.Data.Extras.PlaybackHaptics then
		Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.PlaybackHaptics.Switch, false)

		SettingsPageProperties.Data.Extras.PlaybackHaptics = false
	else
		Utilities.SwitchToggle(SettingsPage.Scroll.Extras.Container.PlaybackHaptics.Switch, true)

		SettingsPageProperties.Data.Extras.PlaybackHaptics = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

-- SettingsPage / Socials

SettingsPage.Scroll.Socials.Container.Sharing.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	local NewValue = not SettingsPageProperties.Data.Socials.Sharing

	if SettingsPageProperties.Data.Socials.Sharing then
		Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.Sharing.Switch, false)

		SettingsPageProperties.Data.Socials.Sharing = false
	else
		Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.Sharing.Switch, true)

		SettingsPageProperties.Data.Socials.Sharing = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

SettingsPage.Scroll.Socials.Container.ListeningVisibility.MouseButton1Click:Connect(function()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	if SettingsPageProperties.Data.Socials.ListeningVisibility then
		Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.ListeningVisibility.Switch, false)

		SettingsPageProperties.Data.Socials.ListeningVisibility = false
	else
		Utilities.SwitchToggle(SettingsPage.Scroll.Socials.Container.ListeningVisibility.Switch, true)

		SettingsPageProperties.Data.Socials.ListeningVisibility = true
	end

	SettingsPageProperties.Changed:Fire(SettingsPageProperties.Data)
end)

-- SettingsPage / Changed

function ApplySettingChanges()
	if SettingsPageProperties.LoadingSettings then return end
	if not SettingsPageProperties.Data then return end

	Playback.Equalizer.Enabled = SettingsPageProperties.Data.Playback.Equalizer.Enabled

	Playback.Equalizer.HighGain = SettingsPageProperties.Data.Playback.Equalizer.HighGain
	Playback.Equalizer.MidGain = SettingsPageProperties.Data.Playback.Equalizer.MidGain
	Playback.Equalizer.LowGain = SettingsPageProperties.Data.Playback.Equalizer.LowGain
end

SettingsPageProperties.Changed:Connect(function(Data)
	print(Data)
	SettingsPageProperties.HasChanged = true

	ApplySettingChanges()

	if Data.Socials.ListeningVisibility then
		LoadListeners()
	end
end)

SettingsPage.Header.Back.MouseButton1Click:Connect(function()
	Main.Settings(false)

	if SettingsPageProperties.HasChanged then
		SettingsPageProperties.HasChanged = false
		events.Main.Settings.SetSettings:FireServer(SettingsPageProperties.Data)
	end
end)

-- ShareSheet

function ShareSheetSeachKeyword(Keyword, SetVisibility)
	local Container = ShareSheet.MainFrame.Frame.Container.Players 
	local isCleaningUp = (Keyword == "" or Keyword:match("^%s*$"))
	local CleanKeyword = Keyword:lower()

	for _, Item in Container:GetChildren() do
		if not Item:IsA("ImageButton") and not Item:HasTag("MastersTemplate") then continue end
		if not Item:GetAttribute("OriginalLayoutOrder") then
			Item:SetAttribute("OriginalLayoutOrder", Item.LayoutOrder)
		end

		local Variable = {Item.Name, Item.Display.Text, Item.Username.Text} 
		local CombinedKeywords = table.concat(Variable, " "):lower()

		if isCleaningUp then
			Item.Visible = true
			Item.LayoutOrder = Item:GetAttribute("OriginalLayoutOrder") or 1
		else
			local matchFound = string.find(CombinedKeywords, CleanKeyword, 1, true) ~= nil

			if SetVisibility then
				Item.Visible = matchFound 
			else
				if matchFound then
					local startPos = string.find(CombinedKeywords, CleanKeyword, 1, true)
					Item.LayoutOrder = startPos
				else
					Item.LayoutOrder = 9999 
				end
			end
		end
	end
end

ShareSheet.MainFrame.Frame.Container.Search.Field.TextBox.FocusLost:Connect(function()
	local Keyword = ShareSheet.MainFrame.Frame.Container.Search.Field.TextBox.Text

	ShareSheetSeachKeyword(Keyword, true)

	local Success, UserId = pcall(function()
		return Players:GetUserIdFromNameAsync(Keyword)
	end)

	if not Success then return end

	for i, Player in Players:GetPlayers() do
		if Player.UserId == UserId then
			return
		end
	end

	local Username = Players:GetNameFromUserIdAsync(UserId)
	local OfflineItem = ShareSheet.MainFrame.Frame.Container.Players.OfflineItem

	OfflineItem:SetAttribute("UserId", UserId)
	OfflineItem.Photo.Image = Utilities.GetPlayerThumbnail(UserId)
	OfflineItem.Display.Text = "@" .. Username
	OfflineItem.Username.Text = ""
	OfflineItem.Visible = true
end)

ShareSheet.MainFrame.Frame.Container.Search.Field.TextBox.Focused:Connect(function()
	ShareSheetSeachKeyword("", true)

	ShareSheet.MainFrame.Frame.Container.Players.OfflineItem.Visible = false
end)

-- Events
-- Events / Playback
print("loaded")
events.Playback.PlayPause.Event:Connect(function()
	local CurrentSound = Queue.GetActiveSound()
	if not CurrentSound then return end

	local QState = Queue.GetState()

	if CurrentSound.IsPlaying then
		QState.IsPaused = false -- heal any desync so Pause() proceeds
		Queue.Pause()
	else
		QState.IsPaused = true -- heal any desync so Resume() proceeds
		Queue.Resume()
		task.wait(0.1)
		if not CurrentSound.IsPlaying then
			-- an ended/stopped sound cannot Resume; restart it
			CurrentSound.TimePosition = 0
			CurrentSound:Play()
			QState.IsPaused = false
		end
	end
end)

events.Playback.Forward.Event:Connect(function()
	Queue.Next()
end)

events.Playback.Rewind.Event:Connect(function()
	Queue.Previous()
end)

-- Events / Modules / Listeners

events.Modules.Listeners.GetCurrentTimestamp.OnClientInvoke = function(SoundId)
	local CurrentSoundId = Queue.GetCurrentSongId()

	if not CurrentSoundId then return end
	if SoundId ~= CurrentSoundId then return end
	if Queue.GetLoadingStatus() or Queue.GetCrossfadingStatus() then return end

	local ActiveSoundObject = Queue.GetActiveSound()
	if not ActiveSoundObject then return end

	return ActiveSoundObject.TimePosition
end

-- Throbber

for i, Icon in CollectionService:GetTagged("MastersThrobberIcon") do
	TweenService:Create(Icon, loop, {Rotation = 360}):Play()
end

ui.DescendantAdded:Connect(function(Object)
	if Object:HasTag("MastersThrobberIcon") then
		TweenService:Create(Object, loop, {Rotation = 360}):Play()
	end
end)

-- Click To Focus

for i, Field in CollectionService:GetTagged("MastersClickToFocus") do
	if Field:IsA("ImageButton") then

		Field.MouseButton1Click:Connect(function()
			Field.Value.Interactable = true
			Field.Value:CaptureFocus()

			Field.Value.SelectionStart = 0
			Field.Value.CursorPosition = string.len(Field.Value.Text) + 1
		end)

		Field.Value.FocusLost:Connect(function()
			Field.Value.Interactable = false
		end)

	end
end

-- Horizontal Containers

local TWEEN_TIME = .1
local MOVE_STEP = 80

local function NavigateHorizontalContainer(Container)
	local Content = Container:WaitForChild("Content")
	local Nav = Container.Util.Navigation
	local LeftBtn = Nav.Left
	local RightBtn = Nav.Right

	local isHoldingLeft = false
	local isHoldingRight = false

	local function UpdateButtons()
		local currentX = Content.CanvasPosition.X
		local maxScroll = Content.AbsoluteCanvasSize.X - Content.AbsoluteWindowSize.X

		LeftBtn.Visible = currentX > 1
		RightBtn.Visible = maxScroll > 0 and currentX < (maxScroll - 1)
	end

	task.defer(UpdateButtons)

	Content:GetPropertyChangedSignal("CanvasPosition"):Connect(UpdateButtons)

	local Layout = Content:FindFirstChildWhichIsA("UILayout")

	if Layout then
		Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateButtons)
	end

	LeftBtn.Button.MouseButton1Down:Connect(function()
		isHoldingLeft = true

		while isHoldingLeft do
			local targetX = math.max(0, Content.CanvasPosition.X - MOVE_STEP)
			TweenService:Create(Content, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Linear), {
				CanvasPosition = Vector2.new(targetX, 0)
			}):Play()
			task.wait(TWEEN_TIME)
			if targetX <= 0 then break end
		end
	end)

	RightBtn.Button.MouseButton1Down:Connect(function()
		isHoldingRight = true

		while isHoldingRight do
			local maxScroll = Content.AbsoluteCanvasSize.X - Content.AbsoluteWindowSize.X
			local targetX = math.min(maxScroll, Content.CanvasPosition.X + MOVE_STEP)

			TweenService:Create(Content, TweenInfo.new(TWEEN_TIME, Enum.EasingStyle.Linear), {
				CanvasPosition = Vector2.new(targetX, 0)
			}):Play()

			task.wait(TWEEN_TIME)
			if targetX >= maxScroll then break end
		end
	end)

	local function stop() isHoldingLeft = false; isHoldingRight = false end

	LeftBtn.Button.InputEnded:Connect(stop)
	RightBtn.Button.InputEnded:Connect(stop)
end

for _, Container in CollectionService:GetTagged("MastersHorizontalContainer") do
	NavigateHorizontalContainer(Container)
end

ui.DescendantAdded:Connect(function(descendant)
	if descendant:HasTag("MastersHorizontalContainer") then
		NavigateHorizontalContainer(descendant)
	end
end)
-- Session Saving

local LastSessionLoaded = false

local function LoadLastSession()
	local LastSavedSession = events.Main.SessionSaving.FetchSavedSession:InvokeServer()
	if not LastSavedSession then return end

	Playback.Volume = 1
	ApplyNewVolume(1)
	if LastSavedSession.Repeat == nil then LastSavedSession.Repeat = false end
	if LastSavedSession.Repeat == "Song" then
		Queue.ToggleRepeat()
	end
	if LastSavedSession.Shuffle == nil then LastSavedSession.Shuffle = false end
	if LastSavedSession.Shuffle then
		Queue.ToggleShuffle()
	end

	LastSessionLoaded = true
end

local function SaveCurrentSession()
	if not LastSessionLoaded then return end

	local Sound = Queue.GetActiveSound()
	local TimePos = 0

	if Sound and not Queue.GetLoadingStatus() and not Queue.GetCrossfadingStatus() then
		TimePos = Sound.TimePosition
	end

	events.Main.SessionSaving.SetPlaybackState:FireServer({
		Volume = Playback.Volume,
		Repeat = Queue.GetSettings().RepeatMode,
		Shuffle = Queue.GetSettings().Shuffle,
	})
end

LoadLastSession()
AutostartStation()

Players.PlayerRemoving:Connect(function(Player)
	if Player == client then
		SaveCurrentSession()
	end
end)
print("loaded")

-- [[ ============================================================================
--   LYRIC STUDIO — sidebar page inside Masters
--   Tools: pick a song, fetch what's already published, import synced lyrics
--   produced by the python `lyricsync` tool, preview them on the now-playing
--   page, then publish them to everyone.
--   Appended by the loader work; safe to remove as one block.
-- ============================================================================ ]]
--[[ Lyric Studio is an ADD-ON, so nothing is built until it has been added from
     the loader's Addons page. State comes from _G.MastersAddons when the loader
     is running in this session, otherwise from the file it wrote, so the choice
     also survives a rejoin. ]]
local function MastersAddonEnabled(name)
	local g = rawget(_G, "MastersAddons")
	if type(g) == "table" and g[name] ~= nil then return g[name] == true end
	local on = false
	pcall(function()
		if isfile and isfile("MastersAddons.json") then
			local d = game:GetService("HttpService"):JSONDecode(readfile("MastersAddons.json"))
			on = type(d) == "table" and d[name] == true
		end
	end)
	return on
end

task.spawn(function()
	while not MastersAddonEnabled("Lyric Studio") do task.wait(2) end
	local ok, err = pcall(function()
		-- the Handler's own `Http` local lives inside the backend do-block, so it is
		-- not in scope out here; take our own handle
		local Http      = game:GetService("HttpService")
		local Pages     = Full.Content.Sidebar.Tabs.Pages
		local Container = Full.Container
		if Container:FindFirstChild("LyricStudio") then return end

		local FF   = Pages.Library.FontFace
		local INK  = Color3.fromRGB(245,246,250)
		local MUT  = Color3.fromRGB(139,144,160)
		local LINE = Color3.fromRGB(35,37,47)
		local CARD = Color3.fromRGB(14,16,24)
		local BLUE = Color3.fromRGB(26,116,230)

		local function new(class, props, kids)
			local o = Instance.new(class)
			local parent = props and props.Parent
			if props then for k,v in pairs(props) do if k ~= "Parent" then o[k] = v end end end
			if kids then for _,c in ipairs(kids) do c.Parent = o end end
			if parent then o.Parent = parent end
			return o
		end
		local function rnd(px) return new("UICorner",{CornerRadius=UDim.new(0,px)}) end
		local function edge(tr) return new("UIStroke",{Color=LINE,Thickness=1,Transparency=tr or 0}) end

		-- ------------------------------------------------------ sidebar entry
		local tab = Pages.Library:Clone()
		tab.Name = "LyricStudio"
		tab.Text = "Lyric Studio"
		tab.LayoutOrder = 4
		tab.BackgroundColor3 = Color3.fromRGB(15,15,15)
		tab.TextTransparency = 0.5
		tab.Parent = Pages

		-- ------------------------------------------------------------- page
		local page = new("ScrollingFrame",{Name="LyricStudio",Size=UDim2.fromScale(1,1),
			Position=UDim2.fromScale(1,0),AnchorPoint=Vector2.new(1,0),BackgroundTransparency=1,
			BorderSizePixel=0,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
			ScrollBarThickness=4,ScrollBarImageColor3=Color3.fromRGB(42,45,56),Visible=false,
			Parent=Container},{
			new("UIListLayout",{Padding=UDim.new(0,14),SortOrder=Enum.SortOrder.LayoutOrder,
				HorizontalAlignment=Enum.HorizontalAlignment.Center}),
			new("UIPadding",{PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,40),
				PaddingLeft=UDim.new(0,20),PaddingRight=UDim.new(0,20)}),
		})

		local function card(order, height)
			return new("Frame",{BackgroundColor3=CARD,BorderSizePixel=0,Size=UDim2.new(1,0,0,height),
				LayoutOrder=order,Parent=page},{rnd(14),edge(0)})
		end
		local function title(parent, text, y)
			return new("TextLabel",{BackgroundTransparency=1,Text=text,FontFace=FF,TextSize=15,
				TextColor3=INK,TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromOffset(18,y),
				Size=UDim2.new(1,-36,0,18),Parent=parent})
		end
		local function note(parent, text, y)
			return new("TextLabel",{BackgroundTransparency=1,Text=text,FontFace=FF,TextSize=12,
				TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,
				Position=UDim2.fromOffset(18,y),Size=UDim2.new(1,-36,0,16),Parent=parent})
		end
		local function button(parent, text, x, y, w, primary)
			local b = new("TextButton",{Text=text,FontFace=FF,TextSize=13,
				TextColor3=primary and INK or Color3.fromRGB(206,210,222),
				BackgroundColor3=primary and BLUE or Color3.fromRGB(30,33,44),AutoButtonColor=false,
				Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,34),Parent=parent},{rnd(9)})
			b.MouseEnter:Connect(function()
				TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3 =
					primary and Color3.fromRGB(42,132,242) or Color3.fromRGB(42,46,60)}):Play()
			end)
			b.MouseLeave:Connect(function()
				TweenService:Create(b,TweenInfo.new(0.15),{BackgroundColor3 =
					primary and BLUE or Color3.fromRGB(30,33,44)}):Play()
			end)
			return b
		end

		-- header
		local head = new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,58),LayoutOrder=0,Parent=page})
		new("TextLabel",{BackgroundTransparency=1,Text="Lyric Studio",FontFace=FF,TextSize=24,TextColor3=INK,
			TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,0,0,28),Parent=head})
		new("TextLabel",{BackgroundTransparency=1,
			Text="Import synced lyrics, preview them on the now-playing page, then publish.",
			FontFace=FF,TextSize=13,TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,
			Position=UDim2.fromOffset(0,30),Size=UDim2.new(1,0,0,18),Parent=head})

		-- ---------------------------------------------------------- 1. song
		local c1 = card(1, 150)
		title(c1, "Song", 16)
		note(c1, "The music id these lyrics belong to.", 36)
		local idBox = new("TextBox",{Text="",PlaceholderText="Music id",FontFace=FF,TextSize=14,
			TextColor3=INK,PlaceholderColor3=Color3.fromRGB(96,100,114),BackgroundColor3=Color3.fromRGB(9,10,16),
			BorderSizePixel=0,ClearTextOnFocus=false,TextXAlignment=Enum.TextXAlignment.Left,
			Position=UDim2.fromOffset(18,62),Size=UDim2.new(1,-322,0,34),Parent=c1},{rnd(9),edge(0),
			new("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12)})})
		local useCur  = button(c1,"Use current song",0,62,150)
		useCur.AnchorPoint = Vector2.new(1,0); useCur.Position = UDim2.new(1,-146,0,62)
		local loadBtn = button(c1,"Load & play",0,62,120)
		loadBtn.AnchorPoint = Vector2.new(1,0); loadBtn.Position = UDim2.new(1,-18,0,62)
		local songLab = new("TextLabel",{BackgroundTransparency=1,Text="No song selected.",FontFace=FF,TextSize=13,
			TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,
			Position=UDim2.fromOffset(18,108),Size=UDim2.new(1,-36,0,18),Parent=c1})

		-- --------------------------------------------------------- 2. lyrics
		local c2 = card(2, 268)
		title(c2, "Lyrics", 16)
		note(c2, "Paste the JSON that `lyricsync` produced, or pull what is already published.", 36)
		local jsonBox = new("TextBox",{Text="",PlaceholderText='{"SoundId":123,"Lyrics":[ ... ]}',
			FontFace=FF,TextSize=12,TextColor3=Color3.fromRGB(205,209,222),
			PlaceholderColor3=Color3.fromRGB(88,92,106),BackgroundColor3=Color3.fromRGB(9,10,16),
			BorderSizePixel=0,ClearTextOnFocus=false,MultiLine=true,TextWrapped=true,
			TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
			Position=UDim2.fromOffset(18,62),Size=UDim2.new(1,-36,0,140),Parent=c2},{rnd(9),edge(0),
			new("UIPadding",{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,12),
				PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10)})})
		local importBtn = button(c2,"Import",18,214,120,true)
		local fetchBtn  = button(c2,"Fetch published",146,214,150)
		local clearBtn  = button(c2,"Clear",304,214,90)
		local lyrLab = new("TextLabel",{BackgroundTransparency=1,Text="Nothing loaded.",FontFace=FF,TextSize=13,
			TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Right,AnchorPoint=Vector2.new(1,0),
			Position=UDim2.new(1,-18,0,214),Size=UDim2.fromOffset(210,34),Parent=c2})

		-- -------------------------------------------------------- 3. publish
		local c3 = card(3, 128)
		title(c3, "Preview & publish", 16)
		note(c3, "Preview applies the lyrics locally only. Publishing sends them to every player.", 36)
		local prevBtn = button(c3,"Preview",18,66,130,true)
		local pubBtn  = button(c3,"Publish",156,66,130)
		local remBtn  = button(c3,"Remove published",294,66,160)
		local status = new("TextLabel",{BackgroundTransparency=1,Text="",FontFace=FF,TextSize=13,
			TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,TextWrapped=true,LayoutOrder=5,
			Size=UDim2.new(1,0,0,34),Parent=page})

		-- ---------------------------------------------------- 4. lyrics editor
		local c4 = card(4, 124)
		title(c4, "Lyrics Editor", 16)
		note(c4, "No timings yet? Paste the plain lyrics and tap them in time with the song.", 36)
		local openEd = button(c4, "Open Lyrics Editor", 18, 68, 190, true)

		-- ------------------------------------------------------------ state
		local doc                       -- the working lyric document
		local previewFor, previewPrev   -- song id being previewed + what it shadowed
		local function say(msg, bad)
			status.Text = msg
			status.TextColor3 = bad and Color3.fromRGB(232,138,150) or Color3.fromRGB(139,200,160)
		end
		local function apiUrl()
			local url = ""
			pcall(function()
				if isfile("MastersShareAPI.txt") then
					url = string.gsub(readfile("MastersShareAPI.txt"), "%s+", "")
				end
			end)
			return url
		end
		local function currentId()
			local n = tonumber(idBox.Text)
			return n
		end
		local function setDoc(d, source)
			doc = d
			local n = (d and d.Lyrics) and #d.Lyrics or 0
			lyrLab.Text = n .. " line(s) " .. (source or "loaded")
			lyrLab.TextColor3 = n > 0 and Color3.fromRGB(139,200,160) or MUT
		end
		local function describe(id)
			task.spawn(function()
				local title2, artist
				pcall(function()
					local meta = game:GetService("AssetService"):GetAudioMetadataAsync({id})
					if meta and meta[1] then title2, artist = meta[1].Title, meta[1].Artist end
				end)
				songLab.Text = (title2 and title2 ~= "" and title2 or ("Song " .. id))
					.. ((artist and artist ~= "") and ("  -  " .. artist) or "")
			end)
		end

		idBox.FocusLost:Connect(function()
			local id = currentId()
			if id then describe(id) else songLab.Text = "No song selected." end
		end)
		useCur.MouseButton1Click:Connect(function()
			local id = Queue.GetCurrentSongId()
			if not id or id == 0 then say("Nothing is playing right now.", true) return end
			idBox.Text = tostring(id)
			describe(id)
			say("Using the song that is playing.")
		end)
		loadBtn.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in first.", true) return end
			Queue.LoadSource({id}, 1, "Lyric Studio", true)
			describe(id)
			say("Loading the song...")
		end)

		importBtn.MouseButton1Click:Connect(function()
			local text = jsonBox.Text
			if text == "" then say("Paste the lyric JSON first.", true) return end
			local ok2, parsed = pcall(function() return Http:JSONDecode(text) end)
			if not ok2 or type(parsed) ~= "table" then say("That is not valid JSON.", true) return end
			if type(parsed.Lyrics) ~= "table" or #parsed.Lyrics == 0 then
				say("No Lyrics array in that document.", true) return
			end
			if parsed.SoundId and not currentId() then idBox.Text = tostring(parsed.SoundId) end
			local id = currentId() or tonumber(parsed.SoundId)
			if id then parsed.SoundId = id; describe(id) end
			setDoc(parsed, "imported")
			say("Imported " .. #parsed.Lyrics .. " line(s). Preview to hear them.")
		end)
		clearBtn.MouseButton1Click:Connect(function()
			jsonBox.Text = ""; setDoc(nil, "loaded"); say("Cleared.")
		end)
		fetchBtn.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in first.", true) return end
			local url = apiUrl()
			if url == "" then say("No API configured (MastersShareAPI.txt).", true) return end
			say("Fetching...")
			task.spawn(function()
				local ok2, res = pcall(request, {Url = url .. "/api/lyrics?songId=" .. id, Method = "GET"})
				if not (ok2 and type(res) == "table" and res.Success and res.Body and res.Body ~= "") then
					say("Nothing published for " .. id .. " yet.", true) return
				end
				local ok3, parsed = pcall(function() return Http:JSONDecode(res.Body) end)
				if not ok3 or type(parsed) ~= "table" or type(parsed.Lyrics) ~= "table" then
					say("The API returned something unreadable.", true) return
				end
				jsonBox.Text = Http:JSONEncode(parsed)
				setDoc(parsed, "fetched")
				say("Fetched " .. #parsed.Lyrics .. " published line(s).")
			end)
		end)

		--[[ A preview only shadows the published lyrics while it is running. The
		     previous value (usually nil, meaning "serve the published one") is put
		     back on stop, so previewing a draft never sticks for the session. ]]
		--[[ LyricsEngine keeps its own CachedLyrics list (30 entries, matched by
		     Data.SoundId) and will not re-ask while a match is there, so swapping
		     _G.ALL_LYRICS alone changes nothing. Reach the upvalue and drop this
		     song's entries so the very next lookup asks the backend again. ]]
		local function evictLyricCache(id)
			local n = tonumber(id)
			pcall(function()
				for i = 1, 8 do
					local a, b = debug.getupvalue(LyricsEngine.GetLyrics, i)
					for _, cand in ipairs({a, b}) do
						if type(cand) == "table" and cand[1] ~= nil and type(cand[1]) == "table"
							and cand[1].SoundId ~= nil then
							for j = #cand, 1, -1 do
								local d = cand[j]
								if type(d) == "table" and (d.SoundId == n or tostring(d.SoundId) == tostring(id)) then
									table.remove(cand, j)
								end
							end
						end
					end
				end
			end)
		end

		local function stopPreview(quiet)
			if not previewFor then return end
			local id = previewFor
			_G.ALL_LYRICS[id] = previewPrev
			evictLyricCache(id)
			previewFor, previewPrev = nil, nil
			prevBtn.Text = "Preview"
			pcall(function() Queue.TrackChanged:Fire(tonumber(id), "MastersLyricsRefresh") end)
			if not quiet then say("Preview stopped - the published lyrics are back.") end
		end

		prevBtn.MouseButton1Click:Connect(function()
			local id = currentId() or (doc and tonumber(doc.SoundId))
			-- pressing it again while previewing puts the published set back
			if previewFor and id and previewFor == tostring(id) then stopPreview() return end
			if not doc then say("Import or fetch some lyrics first.", true) return end
			if not id then say("Put a music id in first.", true) return end
			stopPreview(true)
			doc.SoundId = id
			-- apply locally only; this is exactly where the player looks lyrics up
			previewFor  = tostring(id)
			previewPrev = _G.ALL_LYRICS[previewFor]
			_G.ALL_LYRICS[previewFor] = doc
			evictLyricCache(id)
			prevBtn.Text = "Stop Preview"
			if tostring(Queue.GetCurrentSongId() or 0) ~= tostring(id) then
				Queue.LoadSource({id}, 1, "Lyric Studio", true)
			else
				pcall(function() Queue.TrackChanged:Fire(id, "MastersLyricsRefresh") end)
			end
			-- and jump to the now-playing page with the lyrics panel open
			task.delay(0.35, function()
				pcall(function()
					Main.NowPlaying(true)
					Main.NowPlayingPanelScreen("Lyrics")
				end)
			end)
			say("Previewing " .. #doc.Lyrics .. " line(s) - local only, and it reverts when you stop.")
		end)

		pubBtn.MouseButton1Click:Connect(function()
			if not doc then say("Import or fetch some lyrics first.", true) return end
			local id = currentId() or tonumber(doc.SoundId)
			if not id then say("Put a music id in first.", true) return end
			local url = apiUrl()
			if url == "" then say("No API configured (MastersShareAPI.txt).", true) return end
			doc.SoundId = id
			say("Publishing...")
			task.spawn(function()
				local body = Http:JSONEncode({SoundId = id, Unsynced = doc.Unsynced and true or false,
					Lyrics = doc.Lyrics})
				local ok2, res = pcall(request, {Url = url .. "/api/lyrics", Method = "POST",
					Headers = {["Content-Type"] = "application/json"}, Body = body})
				if ok2 and type(res) == "table" and res.Success then
					stopPreview(true)   -- it is real now; let the published copy serve it
					say("Published " .. #doc.Lyrics .. " line(s). Everyone picks it up within ~20s.")
				else
					say("Publish failed" .. (type(res)=="table" and (" (HTTP " .. tostring(res.StatusCode) .. ")") or "") .. ".", true)
				end
			end)
		end)

		remBtn.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in first.", true) return end
			local url = apiUrl()
			if url == "" then say("No API configured (MastersShareAPI.txt).", true) return end
			say("Removing...")
			task.spawn(function()
				local ok2, res = pcall(request, {Url = url .. "/api/lyrics?songId=" .. id, Method = "DELETE"})
				if ok2 and type(res) == "table" and res.Success then
					say("Removed the published lyrics for " .. id .. ".")
				else
					say("Remove failed.", true)
				end
			end)
		end)


		-- ============================================ manual tap-to-sync editor
		--[[ Paste plain lyrics, hit Process, then play the song and tap Proceed as
		     each line comes in. The timings come out the far end as a normal lyric
		     document, handed straight back to the cards above. ]]
		local rawLines, marks, cursor, syncing = {}, {}, 1, false
		local lineLabels = {}

		local ed = new("Frame",{Name="LyricEditor",BackgroundColor3=Color3.fromRGB(10,11,16),
			BorderSizePixel=0,Size=UDim2.fromScale(1,1),Visible=false,ZIndex=200,Parent=Full})

		local edTitle = new("TextLabel",{BackgroundTransparency=1,Text="-",FontFace=FF,TextSize=16,
			TextColor3=INK,TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromScale(0.09,0.045),
			Size=UDim2.fromScale(0.55,0.05),ZIndex=201,Parent=ed})
		local edArtist = new("TextLabel",{BackgroundTransparency=1,Text="",FontFace=FF,TextSize=12,
			TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromScale(0.09,0.095),
			Size=UDim2.fromScale(0.55,0.04),ZIndex=201,Parent=ed})
		local edClose = new("TextButton",{Text="X",FontFace=FF,TextSize=13,TextColor3=Color3.fromRGB(198,202,212),
			BackgroundColor3=Color3.fromRGB(28,30,40),AutoButtonColor=false,AnchorPoint=Vector2.new(1,0),
			Position=UDim2.new(1,-18,0,14),Size=UDim2.fromOffset(30,30),ZIndex=202,Parent=ed},
			{new("UICorner",{CornerRadius=UDim.new(1,0)})})
		-- the little "Syncing" pill from the reference
		local badge = new("Frame",{BackgroundColor3=Color3.fromRGB(24,160,86),BorderSizePixel=0,
			AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-56,0,14),Size=UDim2.fromOffset(88,26),
			Visible=false,ZIndex=202,Parent=ed},{rnd(13)})
		new("Frame",{BackgroundColor3=Color3.fromRGB(210,255,225),BorderSizePixel=0,Size=UDim2.fromOffset(8,8),
			AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,10,0.5,0),ZIndex=203,Parent=badge},
			{new("UICorner",{CornerRadius=UDim.new(1,0)})})
		new("TextLabel",{BackgroundTransparency=1,Text="Syncing",FontFace=FF,TextSize=12,TextColor3=INK,
			Position=UDim2.fromOffset(24,0),Size=UDim2.new(1,-28,1,0),TextXAlignment=Enum.TextXAlignment.Left,
			ZIndex=203,Parent=badge})

		-- ---- left: the raw lyrics editor
		local edLeft = new("Frame",{BackgroundColor3=Color3.fromRGB(17,19,26),BorderSizePixel=0,
			Position=UDim2.fromScale(0.028,0.165),Size=UDim2.fromScale(0.44,0.62),ZIndex=201,Parent=ed},
			{rnd(14),edge(0)})
		new("TextLabel",{BackgroundTransparency=1,Text="Lyrics Editor",FontFace=FF,TextSize=13,TextColor3=MUT,
			Position=UDim2.fromOffset(0,10),Size=UDim2.new(1,0,0,16),ZIndex=202,Parent=edLeft})
		local rawBox = new("TextBox",{Text="",PlaceholderText="line1\nline2\nline3",FontFace=FF,TextSize=13,
			TextColor3=Color3.fromRGB(214,218,230),PlaceholderColor3=Color3.fromRGB(88,92,106),
			BackgroundTransparency=1,BorderSizePixel=0,ClearTextOnFocus=false,MultiLine=true,
			TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Top,
			Position=UDim2.fromOffset(16,36),Size=UDim2.new(1,-32,1,-96),ZIndex=202,Parent=edLeft})
		local processBtn = button(edLeft,"Process",0,0,110,true)
		processBtn.AnchorPoint = Vector2.new(1,1)
		processBtn.Position = UDim2.new(1,-14,1,-12)
		processBtn.ZIndex = 202
		local clearRaw = button(edLeft,"Clear",14,0,80)
		clearRaw.AnchorPoint = Vector2.new(0,1)
		clearRaw.Position = UDim2.new(0,14,1,-12)
		clearRaw.ZIndex = 202
		-- the notice that replaces the editor once syncing begins
		local lockNote = new("Frame",{BackgroundTransparency=1,Visible=false,
			Position=UDim2.fromOffset(16,0),Size=UDim2.new(1,-32,1,0),ZIndex=203,Parent=edLeft})
		new("TextLabel",{BackgroundTransparency=1,Text="Syncing Has Started",FontFace=FF,TextSize=14,
			TextColor3=INK,TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromScale(0,0.44),
			Size=UDim2.new(1,0,0,18),ZIndex=203,Parent=lockNote})
		new("TextLabel",{BackgroundTransparency=1,
			Text="Once the syncing has started, the final processed lyrics are used. To use Lyrics Editor, restart the lyrics.",
			FontFace=FF,TextSize=12,TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,
			TextYAlignment=Enum.TextYAlignment.Top,TextWrapped=true,Position=UDim2.fromScale(0,0.52),
			Size=UDim2.new(1,0,0,54),ZIndex=203,Parent=lockNote})

		-- ---- right: the lines, big, with the live one lit
		local edRight = new("Frame",{BackgroundColor3=Color3.fromRGB(17,19,26),BorderSizePixel=0,
			Position=UDim2.fromScale(0.492,0.165),Size=UDim2.fromScale(0.48,0.62),ZIndex=201,Parent=ed},
			{rnd(14),edge(0)})
		local lineList = new("ScrollingFrame",{BackgroundTransparency=1,BorderSizePixel=0,
			Position=UDim2.fromOffset(14,14),Size=UDim2.new(1,-28,1,-28),CanvasSize=UDim2.new(),
			AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=3,
			ScrollBarImageColor3=Color3.fromRGB(42,45,56),ZIndex=202,Parent=edRight},{
			new("UIListLayout",{Padding=UDim.new(0,14),SortOrder=Enum.SortOrder.LayoutOrder}),
			new("UIPadding",{PaddingTop=UDim.new(0,6),PaddingBottom=UDim.new(0,20)})})

		-- ---- bottom: clock, the green transport button, and the mark controls
		local clock = new("Frame",{BackgroundColor3=Color3.fromRGB(17,19,26),BorderSizePixel=0,
			AnchorPoint=Vector2.new(1,0),Position=UDim2.fromScale(0.53,0.815),Size=UDim2.fromScale(0.30,0.085),
			ZIndex=201,Parent=ed},{rnd(12),edge(0)})
		local nowLab = new("TextLabel",{BackgroundTransparency=1,Text="00:00.00",FontFace=FF,TextSize=20,
			TextColor3=INK,TextXAlignment=Enum.TextXAlignment.Right,Position=UDim2.fromScale(0,0),
			Size=UDim2.fromScale(0.46,1),ZIndex=202,Parent=clock})
		new("TextLabel",{BackgroundTransparency=1,Text="|",FontFace=FF,TextSize=16,
			TextColor3=Color3.fromRGB(60,64,78),Position=UDim2.fromScale(0.48,0),Size=UDim2.fromScale(0.04,1),
			ZIndex=202,Parent=clock})
		local totalLab = new("TextLabel",{BackgroundTransparency=1,Text="00:00.00",FontFace=FF,TextSize=20,
			TextColor3=Color3.fromRGB(96,100,114),TextXAlignment=Enum.TextXAlignment.Left,
			Position=UDim2.fromScale(0.54,0),Size=UDim2.fromScale(0.44,1),ZIndex=202,Parent=clock})

		local playBtn = new("TextButton",{Text="",BackgroundColor3=Color3.fromRGB(31,177,90),
			AutoButtonColor=false,BorderSizePixel=0,AnchorPoint=Vector2.new(0,0),
			Position=UDim2.fromScale(0.555,0.808),Size=UDim2.fromOffset(52,52),ZIndex=202,Parent=ed},
			{new("UICorner",{CornerRadius=UDim.new(1,0)})})
		-- play triangle / pause bars, drawn so no glyph is needed
		local triA = new("Frame",{BackgroundColor3=INK,BorderSizePixel=0,Size=UDim2.fromOffset(4,18),
			Rotation=25,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.44,0.42),
			ZIndex=203,Parent=playBtn},{rnd(2)})
		local triB = new("Frame",{BackgroundColor3=INK,BorderSizePixel=0,Size=UDim2.fromOffset(4,18),
			Rotation=-25,AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.44,0.6),
			ZIndex=203,Parent=playBtn},{rnd(2)})
		local triC = new("Frame",{BackgroundColor3=INK,BorderSizePixel=0,Size=UDim2.fromOffset(4,20),
			AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.fromScale(0.62,0.5),ZIndex=203,Parent=playBtn},{rnd(2)})
		local function paintTransport(paused)
			triA.Rotation = paused and 25 or 0
			triB.Rotation = paused and -25 or 0
			triA.Position = paused and UDim2.fromScale(0.44,0.42) or UDim2.fromScale(0.40,0.5)
			triB.Position = paused and UDim2.fromScale(0.44,0.6)  or UDim2.fromScale(0.40,0.5)
			triC.Position = paused and UDim2.fromScale(0.62,0.5) or UDim2.fromScale(0.60,0.5)
			playBtn.BackgroundColor3 = paused and Color3.fromRGB(31,177,90) or Color3.fromRGB(217,138,40)
		end

		local function mkCtl(text, x)
			local b = button(ed, text, 0, 0, 150)
			b.AnchorPoint = Vector2.new(0.5,0)
			b.Position = UDim2.fromScale(x,0.915)
			b.ZIndex = 202
			return b
		end
		local proceedBtn = mkCtl("Proceed", 0.255)
		local nextBtn    = mkCtl("Proceed To Next", 0.435)
		local undoBtn    = mkCtl("Remove Last Mark", 0.615)
		local doneBtn    = button(ed, "Use These Lyrics", 0, 0, 170, true)
		doneBtn.AnchorPoint = Vector2.new(1,0)
		doneBtn.Position = UDim2.new(1,-18,0.915,0)
		doneBtn.ZIndex = 202

		-- ------------------------------------------------------- editor logic
		local function fmt(t)
			t = math.max(t or 0, 0)
			return string.format("%02d:%05.2f", math.floor(t/60), t % 60)
		end
		local function sound() return Queue.GetActiveSound() end
		local function paintLines()
			for i,lbl in ipairs(lineLabels) do
				local done = marks[i] ~= nil
				local isNow = (i == cursor)
				lbl.TextColor3 = isNow and INK or (done and Color3.fromRGB(150,200,170) or Color3.fromRGB(150,154,168))
				lbl.TextTransparency = isNow and 0 or 0.45
				lbl.TextSize = isNow and 22 or 20
			end
			local lbl = lineLabels[cursor]
			if lbl then
				local y = lbl.AbsolutePosition.Y - lineList.AbsolutePosition.Y + lineList.CanvasPosition.Y
				lineList.CanvasPosition = Vector2.new(0, math.max(0, y - lineList.AbsoluteSize.Y/2))
			end
		end
		local function buildLines()
			for _,l in ipairs(lineLabels) do l:Destroy() end
			table.clear(lineLabels)
			for i,text in ipairs(rawLines) do
				lineLabels[i] = new("TextLabel",{BackgroundTransparency=1,Text=text,FontFace=FF,TextSize=20,
					TextColor3=Color3.fromRGB(150,154,168),TextTransparency=0.45,TextWrapped=true,
					TextXAlignment=Enum.TextXAlignment.Left,AutomaticSize=Enum.AutomaticSize.Y,
					Size=UDim2.new(1,0,0,0),LayoutOrder=i,ZIndex=202,Parent=lineList})
			end
			paintLines()
		end
		local function setSyncing(on)
			syncing = on
			badge.Visible = on
			lockNote.Visible = on
			rawBox.Visible = not on
			processBtn.Visible = not on
			clearRaw.Visible = not on
		end

		processBtn.MouseButton1Click:Connect(function()
			table.clear(rawLines); table.clear(marks); cursor = 1
			for line in string.gmatch(rawBox.Text, "[^\r\n]+") do
				local trimmed = string.match(line, "^%s*(.-)%s*$")
				if trimmed ~= "" then rawLines[#rawLines+1] = trimmed end
			end
			if #rawLines == 0 then say("Paste some lyrics into the editor first.", true) return end
			buildLines()
			say(#rawLines .. " line(s) ready - press play, then tap Proceed on each line.")
		end)
		clearRaw.MouseButton1Click:Connect(function()
			rawBox.Text = ""; table.clear(rawLines); table.clear(marks); cursor = 1; buildLines()
		end)

		playBtn.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in the Song card first.", true) return end
			if #rawLines == 0 then say("Press Process first.", true) return end
			local s = sound()
			if not s or tostring(Queue.GetCurrentSongId() or 0) ~= tostring(id) then
				Queue.LoadSource({id}, 1, "Lyric Studio", true)
				setSyncing(true)
				return
			end
			if Queue.GetPausedStatus() then Queue.Resume() else Queue.Pause() end
			setSyncing(true)
		end)

		proceedBtn.MouseButton1Click:Connect(function()
			local s = sound()
			if not s then say("Nothing is playing.", true) return end
			if cursor > #rawLines then say("Every line is marked - hit Use These Lyrics.", true) return end
			local now = s.TimePosition
			if cursor > 1 and marks[cursor-1] and not marks[cursor-1].TimeEnd then
				marks[cursor-1].TimeEnd = now
			end
			marks[cursor] = {Line = rawLines[cursor], TimeStart = now}
			cursor += 1
			paintLines()
		end)
		nextBtn.MouseButton1Click:Connect(function()
			-- close the line that is running without opening the next one, which
			-- leaves an instrumental gap
			local s = sound()
			if not s then say("Nothing is playing.", true) return end
			local last = marks[cursor-1]
			if last and not last.TimeEnd then
				last.TimeEnd = s.TimePosition
				say("Closed that line - the next Proceed opens a gap before the following one.")
			else
				say("Nothing open to close.", true)
			end
		end)
		undoBtn.MouseButton1Click:Connect(function()
			if cursor <= 1 then return end
			cursor -= 1
			marks[cursor] = nil
			if marks[cursor-1] then marks[cursor-1].TimeEnd = nil end
			paintLines()
		end)

		local function closeEditor()
			ed.Visible = false
			-- stop the track that was being synced rather than leaving it running
			pcall(function()
				if not Queue.GetPausedStatus() then Queue.Pause() end
			end)
		end

		doneBtn.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in the Song card first.", true) return end
			local n = 0
			for i = 1, #rawLines do if marks[i] then n += 1 end end
			if n == 0 then say("Mark at least one line before using them.", true) return end
			local s = sound()
			local total = (s and s.TimeLength > 0) and s.TimeLength or nil
			local built, num = {}, 0
			for i = 1, #rawLines do
				local m = marks[i]
				if m then
					local nextStart
					for j = i+1, #rawLines do
						if marks[j] then nextStart = marks[j].TimeStart break end
					end
					local endT = m.TimeEnd or nextStart
						or (total and math.min(m.TimeStart + 4, total)) or (m.TimeStart + 4)
					num += 1
					built[#built+1] = {RightAligned=false, Line=m.Line, Id="L"..num,
						TimeStart=m.TimeStart, TimeEnd=endT, Adlibs={}}
					-- a long silence before the next line becomes a gap entry, which
					-- is what Masters renders as the pulsing dots
					if nextStart and m.TimeEnd and nextStart - m.TimeEnd > 5 then
						built[#built+1] = {RightAligned=false, Line="", Id="GAP_"..num,
							TimeStart=m.TimeEnd, TimeEnd=nextStart, Adlibs={}}
					end
				end
			end
			local d = {SoundId = id, Unsynced = false, Lyrics = built}
			jsonBox.Text = Http:JSONEncode(d)
			setDoc(d, "from the editor")
			closeEditor()
			say("Built " .. #built .. " timed line(s). Preview or Publish them above.")
		end)

		edClose.MouseButton1Click:Connect(closeEditor)
		openEd.MouseButton1Click:Connect(function()
			local id = currentId()
			if not id then say("Put a music id in the Song card first.", true) return end
			setSyncing(false)
			table.clear(marks); cursor = 1
			-- seed the editor from whatever is loaded, so imported or fetched lyrics
			-- can be re-timed instead of retyped
			if doc and type(doc.Lyrics) == "table" and #doc.Lyrics > 0 then
				local lines = {}
				for _, L in ipairs(doc.Lyrics) do
					if L.Line and L.Line ~= "" then lines[#lines+1] = L.Line end
				end
				if #lines > 0 then
					rawBox.Text = table.concat(lines, "\n")
					table.clear(rawLines)
					for _, t in ipairs(lines) do rawLines[#rawLines+1] = t end
				end
			end
			if #rawLines > 0 then buildLines() end
			describe(id)
			edTitle.Text = songLab.Text
			task.delay(0.6, function() edTitle.Text = songLab.Text end)
			ed.Visible = true
		end)

		-- the clock + transport paint, only while the editor is on screen
		task.spawn(function()
			while ed.Parent do
				task.wait(0.05)
				if ed.Visible then
					local s = sound()
					nowLab.Text = fmt(s and s.TimePosition or 0)
					totalLab.Text = fmt(s and s.TimeLength or 0)
					paintTransport(not s or Queue.GetPausedStatus() or not s.IsPlaying)
				end
			end
		end)

		-- a preview belongs to the song that is playing: as soon as the track
		-- changes (or playback is closed) the published lyrics come back
		pcall(function()
			Queue.TrackChanged:Connect(function(songId, reason)
				if reason == "MastersLyricsRefresh" then return end
				if previewFor and tostring(songId or 0) ~= previewFor then
					stopPreview(true)
					say("Preview ended - the song changed, published lyrics are back.")
				end
			end)
		end)

		-- -------------------------------------------------------- navigation
		local OTHER = {"Discovery","Search","Library","Expanded","Playlist","Artist","Details","Stations"}
		local function showStudio()
			for _,n in ipairs(OTHER) do
				local f = Container:FindFirstChild(n)
				if f then f.Visible = false end
			end
			page.Visible = true
			TweenService:Create(tab,TweenInfo.new(0.2),
				{BackgroundColor3=Color3.fromRGB(20,20,20),TextTransparency=0}):Play()
			for _,n in ipairs({"Discovery","Search","Library"}) do
				local b = Pages:FindFirstChild(n)
				if b then TweenService:Create(b,TweenInfo.new(0.2),
					{BackgroundColor3=Color3.fromRGB(15,15,15),TextTransparency=0.5}):Play() end
			end
			local _, fullscreen = Main.GetSidebarStatus()
			if fullscreen then Main.Sidebar(false) end
		end
		tab.MouseButton1Click:Connect(showStudio)
		-- any other page taking over hides this one and dims the tab
		Main.PageChanged:Connect(function()
			if page.Visible then
				page.Visible = false
				TweenService:Create(tab,TweenInfo.new(0.2),
					{BackgroundColor3=Color3.fromRGB(15,15,15),TextTransparency=0.5}):Play()
			end
		end)

		-- removing the add-on again takes the tab away without a rejoin
		task.spawn(function()
			while tab.Parent do
				task.wait(2)
				local on = MastersAddonEnabled("Lyric Studio")
				if tab.Visible ~= on then
					tab.Visible = on
					if not on and page.Visible then
						page.Visible = false
						pcall(function() Main.SetPage(Main.GetLastMainPage()) end)
					end
				end
			end
		end)

		print("[MASTERS] Lyric Studio ready (add-on enabled)")
	end)
	if not ok then warn("[MASTERS] Lyric Studio failed: " .. tostring(err)) end
end)


-- [[ ============================================================================
--   LOCAL STATIONS — add-on: a pack of ten genre stations
--   Songs come live from Roblox's own audio catalogue (AudioSearchParams, the
--   same API Masters uses for artist discographies), so every station holds real
--   playable tracks instead of a hardcoded id list that could rot.
--   Reuses MastersAddonEnabled() declared by the Lyric Studio block above.
-- ============================================================================ ]]
task.spawn(function()
	while not MastersAddonEnabled("Local Stations") do task.wait(2) end
	local ok, err = pcall(function()
		local AS = game:GetService("AssetService")   -- the mock passes non-RS services through

		local PACK = {
			{id = 8101, name = "Lo-Fi Beats", desc = "Slow, warm and unbothered.",     key = "lofi"},
			{id = 8102, name = "Rock",        desc = "Guitars, loud and honest.",      tag = "rock"},
			{id = 8103, name = "Pop",         desc = "Choruses you already know.",     tag = "pop"},
			{id = 8104, name = "Electronic",  desc = "Synths all the way down.",       tag = "electronic"},
			{id = 8105, name = "Hip Hop",     desc = "Bars and breaks.",               key = "hip hop"},  -- no such Tag; keyword finds it
			{id = 8106, name = "Jazz",        desc = "Brushed drums and late nights.", tag = "jazz"},
			{id = 8107, name = "Classical",   desc = "Strings, keys and space.",       tag = "classical"},
			{id = 8108, name = "Chill",       desc = "Nothing in a hurry.",            key = "chill"},
			{id = 8109, name = "Country",     desc = "Stories with a twang.",          tag = "country"},
			{id = 8110, name = "Metal",       desc = "Turn it up.",                    tag = "metal"},
		}

		local built = {}   -- finished stations, in pack order

		local function collect(spec, want)
			local songs = {}
			pcall(function()
				local sp = Instance.new("AudioSearchParams")
				if spec.tag then sp.Tag = spec.tag else sp.SearchKeyword = spec.key end
				local pages = AS:SearchAudio(sp)
				for _ = 1, 2 do                       -- two pages is plenty for 20 tracks
					for _, a in ipairs(pages:GetCurrentPage()) do
						if a.Id then songs[#songs + 1] = a.Id end
						if #songs >= want then return end
					end
					if pages.IsFinished then break end
					pages:AdvanceToNextPageAsync()
				end
			end)
			return songs
		end

		task.spawn(function()
			for _, spec in ipairs(PACK) do
				local songs = collect(spec, 20)
				if #songs > 0 then
					built[#built + 1] = {
						StationId   = spec.id,
						Name        = spec.name,
						Description = spec.desc .. "  -  " .. #songs .. " songs",
						Cover       = "",
						Updated     = os.time(),
						Songs       = songs,
					}
				end
				task.wait(0.15)                        -- stay polite to the endpoint
			end
			print("[MASTERS] Local Stations add-on: " .. #built .. " station(s) ready")
			-- Discovery rendered its station shelf at startup; rebuild it or the
			-- pack stays invisible until the next rejoin
			if _G.MastersRefreshDiscovery then _G.MastersRefreshDiscovery(true) end
		end)

		--[[ Every station lookup - from the Handler's mock `events`, from the real
		     Bindables, either way - funnels through MastersBackend.Handle, so that
		     is the one place worth wrapping. (The backend's own H table lives inside
		     its do-block and is not reachable from out here.) ]]
		local origHandle = MastersBackend.Handle
		local function withPack(base)
			local list = {}
			if type(base) == "table" then
				for _, st in ipairs(base) do list[#list + 1] = st end
			end
			if MastersAddonEnabled("Local Stations") then
				for _, st in ipairs(built) do list[#list + 1] = st end
			end
			return list
		end
		MastersBackend.Handle = function(name, ...)
			if name == "GetLocalStations" or name == "GetLocalStationsServer" then
				local handled, base = origHandle(name, ...)
				return true, withPack(handled and base or nil)
			elseif name == "GetLocalStationByStationId" or name == "GetLocalStationByStationIdServer" then
				local wanted = ...
				local handled, base = origHandle("GetLocalStations")
				for _, st in ipairs(withPack(handled and base or nil)) do
					if st.StationId == wanted then return true, st end
				end
				return true, nil
			end
			return origHandle(name, ...)
		end

		print("[MASTERS] Local Stations add-on wired")
	end)
	if not ok then warn("[MASTERS] Local Stations failed: " .. tostring(err)) end
end)


-- [[ ============================================================================
--   MASTERS EXTRAS
--     * Discovery refresh      - LoadAllAudios only ever ran once, so anything
--                                added later (stations, history) never appeared
--     * Keep Playing           - Algorithm.Songs was a hardcoded three-song list
--                                and H.AddSong a no-op, so it could never change
--     * Admin tab (owner only) - who is on Masters, what they are playing, join
-- ============================================================================ ]]

-- ---------------------------------------------------------- Discovery reload
--[[ LoadAllAudios builds the Discovery page (Keep Playing / For You / Local
     Stations) exactly once at startup and clears its own tagged residuals first,
     so calling it again is safe and is the only way new content shows up. ]]
do
	local lastRun = 0
	rawset(_G, "MastersRefreshDiscovery", function(force)
		if not force and os.clock() - lastRun < 20 then return false end
		lastRun = os.clock()
		task.spawn(function()
			local ok, err = pcall(function() LoadAllAudios() end)
			if not ok then warn("[MASTERS] Discovery refresh failed: " .. tostring(err)) end
		end)
		return true
	end)
end

-- ------------------------------------------------------------- Keep Playing
task.spawn(function()
	local ok, err = pcall(function()
		local Http    = game:GetService("HttpService")
		local Players = game:GetService("Players")
		local AS      = game:GetService("AssetService")
		local FILE    = "MastersRecent_" .. tostring(Players.LocalPlayer.UserId) .. ".json"

		local recent = {}          -- [songId] = {SongId, Plays, Last, Name, Artist}
		pcall(function()
			if isfile and isfile(FILE) then
				local d = Http:JSONDecode(readfile(FILE))
				if type(d) == "table" then recent = d end
			end
		end)
		local function save()
			pcall(function() if writefile then writefile(FILE, Http:JSONEncode(recent)) end end)
		end

		local function remember(songId)
			local key = tostring(songId)
			if key == "0" or key == "nil" then return end
			local e = recent[key]
			if e then
				e.Plays = (e.Plays or 1) + 1
				e.Last  = os.time()
			else
				e = {SongId = tonumber(songId), Plays = 1, Last = os.time()}
				recent[key] = e
			end
			-- names make the Discovery tiles readable; fetched once, in the background
			if not e.Name then
				task.spawn(function()
					pcall(function()
						local meta = AS:GetAudioMetadataAsync({tonumber(songId)})
						if meta and meta[1] then
							e.Name   = meta[1].Title
							e.Artist = meta[1].Artist
							save()
						end
					end)
				end)
			end
			save()
			if _G.MastersRefreshDiscovery then _G.MastersRefreshDiscovery() end
		end

		-- what actually gets played is the only honest source of history
		Queue.TrackChanged:Connect(function(songId, reason)
			if reason == "MastersLyricsRefresh" then return end
			remember(songId)
		end)

		--[[ Feed the history back in as Algorithm.Songs. CurateKeepPlaying sorts on
		     Relevance then LastUpdate, so play count drives the order and the most
		     recent wins ties. The stock entries stay on the end as a floor. ]]
		local origHandle = MastersBackend.Handle
		MastersBackend.Handle = function(name, ...)
			if name == "FetchAlgorithm" or name == "GetAlgorithm" or name == "GetMetadata" then
				local handled, base = origHandle(name, ...)
				if not handled or type(base) ~= "table" then return handled, base end
				local list, seen = {}, {}
				local ordered = {}
				for _, e in pairs(recent) do ordered[#ordered + 1] = e end
				table.sort(ordered, function(a, b)
					if (a.Plays or 0) == (b.Plays or 0) then return (a.Last or 0) > (b.Last or 0) end
					return (a.Plays or 0) > (b.Plays or 0)
				end)
				for _, e in ipairs(ordered) do
					--[[ AddSongItem assigns SongInfo.Title straight onto a TextLabel, so a
					     song whose metadata never resolved (private, or simply has none)
					     throws and takes the rest of the shelf down with it. Wait until the
					     name is known before offering it. ]]
					local named = type(e.Name) == "string" and e.Name ~= ""
					if e.SongId and named and not seen[e.SongId] then
						seen[e.SongId] = true
						list[#list + 1] = {
							Id = e.SongId, SongId = e.SongId,
							Relevance = 100 + (e.Plays or 1) * 5,
							LastUpdate = e.Last or os.time(),
							Name = e.Name or ("Song " .. e.SongId),
							Artist = e.Artist or "",
						}
					end
				end
				for _, s in ipairs(base.Songs or {}) do
					if s.SongId and not seen[s.SongId] then
						seen[s.SongId] = true
						list[#list + 1] = s
					end
				end
				local out = {}
				for k, v in pairs(base) do out[k] = v end
				out.Songs = list
				return true, out
			end
			return origHandle(name, ...)
		end

		-- the first Discovery build ran before this wrap existed, so bring it
		-- back round now that there is a history to show
		if next(recent) ~= nil and _G.MastersRefreshDiscovery then
			task.delay(2, function() _G.MastersRefreshDiscovery(true) end)
		end

		print("[MASTERS] Keep Playing now tracks what you actually play")
	end)
	if not ok then warn("[MASTERS] Keep Playing failed: " .. tostring(err)) end
end)

-- ------------------------------------------------------------- Admin tab
task.spawn(function()
	local OWNER = 3681686378        -- DaniBoyNov2014
	local Players = game:GetService("Players")
	if Players.LocalPlayer.UserId ~= OWNER then return end

	local ok, err = pcall(function()
		local AS        = game:GetService("AssetService")
		local Pages     = Full.Content.Sidebar.Tabs.Pages
		local Container = Full.Container
		if Container:FindFirstChild("Admin") then return end

		local FF   = Pages.Library.FontFace
		local INK  = Color3.fromRGB(245,246,250)
		local MUT  = Color3.fromRGB(139,144,160)
		local LINE = Color3.fromRGB(35,37,47)

		local function new(class, props, kids)
			local o = Instance.new(class)
			local parent = props and props.Parent
			if props then for k,v in pairs(props) do if k ~= "Parent" then o[k] = v end end end
			if kids then for _,c in ipairs(kids) do c.Parent = o end end
			if parent then o.Parent = parent end
			return o
		end

		local tab = Pages.Library:Clone()
		tab.Name = "Admin"
		tab.Text = "Admin"
		tab.LayoutOrder = 9
		tab.BackgroundColor3 = Color3.fromRGB(15,15,15)
		tab.TextTransparency = 0.5
		tab.Parent = Pages

		local page = new("ScrollingFrame",{Name="Admin",Size=UDim2.fromScale(1,1),
			Position=UDim2.fromScale(1,0),AnchorPoint=Vector2.new(1,0),BackgroundTransparency=1,
			BorderSizePixel=0,CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,
			ScrollBarThickness=4,ScrollBarImageColor3=Color3.fromRGB(42,45,56),Visible=false,
			Parent=Container},{
			new("UIListLayout",{Padding=UDim.new(0,12),SortOrder=Enum.SortOrder.LayoutOrder,
				HorizontalAlignment=Enum.HorizontalAlignment.Center}),
			new("UIPadding",{PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,40),
				PaddingLeft=UDim.new(0,20),PaddingRight=UDim.new(0,20)}),
		})

		local head = new("Frame",{BackgroundTransparency=1,Size=UDim2.new(1,0,0,58),LayoutOrder=0,Parent=page})
		new("TextLabel",{BackgroundTransparency=1,Text="Admin",FontFace=FF,TextSize=24,TextColor3=INK,
			TextXAlignment=Enum.TextXAlignment.Left,Size=UDim2.new(1,0,0,28),Parent=head})
		local headSub = new("TextLabel",{BackgroundTransparency=1,Text="Everyone on Masters right now.",
			FontFace=FF,TextSize=13,TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,
			Position=UDim2.fromOffset(0,30),Size=UDim2.new(1,0,0,18),Parent=head})

		local rows = {}
		local titleCache = {}
		local function titleFor(songId)
			local key = tostring(songId)
			if titleCache[key] then return titleCache[key] end
			titleCache[key] = "Song " .. key
			task.spawn(function()
				pcall(function()
					local meta = AS:GetAudioMetadataAsync({tonumber(songId)})
					if meta and meta[1] and meta[1].Title ~= "" then
						titleCache[key] = meta[1].Title ..
							((meta[1].Artist ~= "" and meta[1].Artist) and ("  -  " .. meta[1].Artist) or "")
					end
				end)
			end)
			return titleCache[key]
		end

		local function rebuild()
			for _, r in ipairs(rows) do r:Destroy() end
			table.clear(rows)
			local listeners = {}
			pcall(function()
				if _G.MastersOnlineListeners then listeners = _G.MastersOnlineListeners() end
			end)
			headSub.Text = (#listeners == 0)
				and "Nobody else is listening right now."
				or (#listeners .. " listener(s) on Masters right now.")
			for i, p in ipairs(listeners) do
				local row = new("Frame",{BackgroundColor3=Color3.fromRGB(14,16,24),BorderSizePixel=0,
					Size=UDim2.new(1,0,0,84),LayoutOrder=i,Parent=page},{
					new("UICorner",{CornerRadius=UDim.new(0,14)}),
					new("UIStroke",{Color=LINE,Thickness=1}),
				})
				rows[#rows + 1] = row
				new("ImageLabel",{BackgroundColor3=Color3.fromRGB(30,33,44),BorderSizePixel=0,
					Image=Utilities.GetPlayerThumbnail(p.UserId),Size=UDim2.fromOffset(52,52),
					AnchorPoint=Vector2.new(0,0.5),Position=UDim2.new(0,18,0.5,0),Parent=row},
					{new("UICorner",{CornerRadius=UDim.new(1,0)})})
				new("TextLabel",{BackgroundTransparency=1,Text=p.Name,FontFace=FF,TextSize=16,TextColor3=INK,
					TextXAlignment=Enum.TextXAlignment.Left,Position=UDim2.fromOffset(84,20),
					Size=UDim2.new(1,-260,0,20),Parent=row})
				local nowLab = new("TextLabel",{BackgroundTransparency=1,Text="",FontFace=FF,TextSize=13,
					TextColor3=MUT,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,
					Position=UDim2.fromOffset(84,44),Size=UDim2.new(1,-260,0,18),Parent=row})
				nowLab.Text = (p.SongId and p.SongId ~= 0)
					and ("Playing  " .. titleFor(p.SongId)) or "Idle"
				task.delay(1.2, function()
					if nowLab.Parent and p.SongId then nowLab.Text = "Playing  " .. titleFor(p.SongId) end
				end)

				local join = new("TextButton",{Text="Join their music",FontFace=FF,TextSize=13,TextColor3=INK,
					BackgroundColor3=Color3.fromRGB(26,116,230),AutoButtonColor=false,
					AnchorPoint=Vector2.new(1,0.5),Position=UDim2.new(1,-18,0.5,0),
					Size=UDim2.fromOffset(150,36),Parent=row},{new("UICorner",{CornerRadius=UDim.new(0,10)})})
				join.MouseButton1Click:Connect(function()
					if _G.MastersFollow then
						_G.MastersFollow(p.UserId, p.Name)     -- copies their queue and stays in step
						join.Text = "Following"
						join.BackgroundColor3 = Color3.fromRGB(26,32,28)
						join.TextColor3 = Color3.fromRGB(99,217,138)
					end
				end)
			end
		end

		local OTHER = {"Discovery","Search","Library","Expanded","Playlist","Artist","Details","Stations","LyricStudio"}
		tab.MouseButton1Click:Connect(function()
			for _, n in ipairs(OTHER) do
				local f = Container:FindFirstChild(n)
				if f then f.Visible = false end
			end
			page.Visible = true
			rebuild()
			TweenService:Create(tab,TweenInfo.new(0.2),
				{BackgroundColor3=Color3.fromRGB(20,20,20),TextTransparency=0}):Play()
			for _, n in ipairs({"Discovery","Search","Library","LyricStudio"}) do
				local b = Pages:FindFirstChild(n)
				if b then TweenService:Create(b,TweenInfo.new(0.2),
					{BackgroundColor3=Color3.fromRGB(15,15,15),TextTransparency=0.5}):Play() end
			end
			local _, fullscreen = Main.GetSidebarStatus()
			if fullscreen then Main.Sidebar(false) end
		end)
		Main.PageChanged:Connect(function()
			if page.Visible then
				page.Visible = false
				TweenService:Create(tab,TweenInfo.new(0.2),
					{BackgroundColor3=Color3.fromRGB(15,15,15),TextTransparency=0.5}):Play()
			end
		end)
		-- keep the list live while it is on screen
		task.spawn(function()
			while tab.Parent do
				task.wait(5)
				if page.Visible then rebuild() end
			end
		end)

		print("[MASTERS] Admin tab ready (owner)")
	end)
	if not ok then warn("[MASTERS] Admin tab failed: " .. tostring(err)) end
end)


-- [[ ============================================================================
--   MASTERS UPDATER
--     Notices when a newer release is published and offers to install it.
--     Applying one means a rejoin, because the Handler is already loaded and
--     re-running the loader in place would stack a second copy of everything.
-- ============================================================================ ]]

task.spawn(function()
	local ok, err = pcall(function()
		local Http    = game:GetService("HttpService")
		local Players = game:GetService("Players")
		local TS      = game:GetService("TeleportService")
		-- fetched rather than borrowed from the Handler's top-level locals, so this
		-- block can be loaded and tested on its own
		local TweenService = game:GetService("TweenService")

		local REPO        = "DanielNov2014/Masters-client-sided"
		local VERSION_API = "https://bestmusicplayer.vercel.app/api/version"
		local BOOTSTRAP   = "https://raw.githubusercontent.com/" .. REPO .. "/main/bootstrap.lua"
		local STATE       = "MastersSync.json"
		local CHECK_EVERY = 300      -- seconds

		if not (isfile and readfile and request) then return end

		--[[ Which release this install came from. The bootstrap records it; an
		     older install predates that field, in which case there is nothing to
		     compare against and we stay quiet rather than nag. ]]
		local function installedCommit()
			local commit
			pcall(function()
				if isfile(STATE) then
					local s = Http:JSONDecode(readfile(STATE))
					if type(s) == "table" then commit = s.commit end
				end
			end)
			return commit
		end

		local MANIFEST = "https://raw.githubusercontent.com/" .. REPO .. "/main/manifest.json"

		local function fetchJson(url)
			local ok, res = pcall(request, {Url = url, Method = "GET",
				Headers = {["User-Agent"] = "Masters"}})
			if not ok or type(res) ~= "table" or res.StatusCode ~= 200 then return nil end
			local okj, data = pcall(function() return Http:JSONDecode(res.Body) end)
			return okj and type(data) == "table" and data or nil
		end

		--[[ The API answers instantly and is never cached, which is the whole point
		     of it. If it is not deployed (or is down) fall back to the manifest on
		     the branch: raw caches that for ~5 minutes, so an update is noticed a
		     little later, but it is noticed. ]]
		local function latestRelease()
			local data = fetchJson(VERSION_API)
			if data and data.ok and data.commit then return data end

			data = fetchJson(MANIFEST)
			if data and data.commit then
				return {commit = data.commit, notes = data.notes or "",
				        changelog = data.changelog or {}, viaManifest = true}
			end
			return nil
		end

		-- ------------------------------------------------------------------ UI

		local function E(class, props, kids)
			local o = Instance.new(class)
			local parent = props.Parent
			for k, v in pairs(props) do if k ~= "Parent" then o[k] = v end end
			if kids then for _, c in ipairs(kids) do c.Parent = o end end
			o.Parent = parent
			return o
		end
		local function corner(r) return E("UICorner", {CornerRadius = UDim.new(0, r)}) end

		local INK  = Color3.fromRGB(245, 246, 250)
		local MUT  = Color3.fromRGB(139, 144, 160)
		local BLUE = Color3.fromRGB(26, 116, 230)

		local shown = false

		--[[ The card arrives unprompted while the player is listening to something,
		     so the ping ducks the music under itself and fades it back rather than
		     competing with it.

		     `ui.Playback` is a SoundGroup, which makes it the right thing to duck:
		     one volume covers every Masters sound at once, including both halves of
		     a crossfade, and nothing writes to it except the volume slider while it
		     is actually being dragged. The ping itself is parented to SoundService,
		     outside that group, so it does not duck itself. ]]
		local PING_ID     = "rbxassetid://138118203571469"
		local PING_VOLUME = 1
		local DUCK_TO     = 0.15     -- fraction of the current volume to dip to
		local FADE_OUT    = 0.25
		local FADE_IN     = 1.1

		local function musicGroup()
			local g
			pcall(function()
				local pg = Players.LocalPlayer:FindFirstChild("PlayerGui")
				local mui = pg and pg:FindFirstChild("Masters")
				local found = mui and mui:FindFirstChild("Playback")
				if found and found:IsA("SoundGroup") then g = found end
			end)
			return g
		end

		local function ping()
			pcall(function()
				local Debris = game:GetService("Debris")

				local s = Instance.new("Sound")
				s.SoundId = PING_ID
				s.Volume = PING_VOLUME
				s.Parent = game:GetService("SoundService")
				Debris:AddItem(s, 15)

				local group = musicGroup()
				if not group or group.Volume <= 0.001 then
					s:Play()          -- nothing playing to duck
					return
				end

				local restoreTo = group.Volume
				local ducked = restoreTo * DUCK_TO
				local restored = false

				local function fadeBackIn()
					if restored then return end
					restored = true
					--[[ If the volume moved while we had it ducked the player was on
					     the slider; their value wins and we leave it alone. ]]
					if math.abs(group.Volume - ducked) > 0.02 then return end
					TweenService:Create(group, TweenInfo.new(FADE_IN, Enum.EasingStyle.Quad),
						{Volume = restoreTo}):Play()
				end

				TweenService:Create(group, TweenInfo.new(FADE_OUT, Enum.EasingStyle.Quad),
					{Volume = ducked}):Play()

				task.delay(FADE_OUT, function()
					if s.Parent then s:Play() end
				end)

				-- fade back when the ping finishes, with a timeout in case Ended
				-- never fires (asset failed to load, sound destroyed early)
				s.Ended:Connect(fadeBackIn)
				task.delay(FADE_OUT + math.max(s.TimeLength, 2) + 0.2, fadeBackIn)
			end)
		end

		local function showUpdateWindow(rel, from)
			if shown then return end
			shown = true
			ping()

			local host = (gethui and gethui()) or game:GetService("CoreGui")
			local old = host:FindFirstChild("MastersUpdate")
			if old then old:Destroy() end

			local screen = E("ScreenGui", {Name = "MastersUpdate", IgnoreGuiInset = true,
				ResetOnSpawn = false, DisplayOrder = 50, Parent = host})

			-- what landed since the release they are on
			local lines = {}
			for _, entry in ipairs(rel.changelog or {}) do
				if entry.sha == from then break end
				if entry.message and entry.message ~= "" then
					lines[#lines + 1] = "•  " .. entry.message
				end
				if #lines >= 5 then break end
			end
			if #lines == 0 then
				lines[1] = "•  " .. ((rel.notes ~= "" and rel.notes) or "A new release is available.")
			end

			local H = 176 + #lines * 16
			local card = E("Frame", {BackgroundColor3 = Color3.fromRGB(14, 16, 24),
				BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, -24, 1, 24), Size = UDim2.fromOffset(390, H),
				Parent = screen}, {corner(16),
				E("UIStroke", {Color = Color3.fromRGB(38, 41, 54), Thickness = 1})})
			TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quint),
				{Position = UDim2.new(1, -24, 1, -24)}):Play()

			E("Frame", {BackgroundColor3 = Color3.fromRGB(99, 217, 138), BorderSizePixel = 0,
				Position = UDim2.fromOffset(22, 24), Size = UDim2.fromOffset(9, 9), Parent = card},
				{E("UICorner", {CornerRadius = UDim.new(1, 0)})})
			E("TextLabel", {BackgroundTransparency = 1, Text = "Update available",
				Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = INK,
				TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(40, 17),
				Size = UDim2.fromOffset(260, 22), Parent = card})
			local sub = E("TextLabel", {BackgroundTransparency = 1,
				Text = ("Masters %s is ready to install"):format(tostring(rel.commit):sub(1, 8)),
				Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = MUT,
				TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
				Position = UDim2.fromOffset(22, 42), Size = UDim2.new(1, -70, 0, 16), Parent = card})

			local function closeCard()
				TweenService:Create(card, TweenInfo.new(0.25),
					{Position = UDim2.new(1, -24, 1, 24)}):Play()
				task.delay(0.3, function() screen:Destroy() end)
				shown = false
			end

			local x = E("TextButton", {Text = "✕", AutoButtonColor = false,
				Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Color3.fromRGB(120, 126, 145),
				BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, -16, 0, 14), Size = UDim2.fromOffset(24, 24), Parent = card})
			x.MouseButton1Click:Connect(closeCard)

			-- changelog
			local notes = E("Frame", {BackgroundColor3 = Color3.fromRGB(20, 23, 32),
				BorderSizePixel = 0, Position = UDim2.fromOffset(22, 68),
				Size = UDim2.fromOffset(346, 14 + #lines * 16), Parent = card},
				{corner(9), E("UIStroke", {Color = Color3.fromRGB(38, 41, 54), Thickness = 1})})
			for i, line in ipairs(lines) do
				E("TextLabel", {BackgroundTransparency = 1, Text = line, Font = Enum.Font.Gotham,
					TextSize = 11, TextColor3 = Color3.fromRGB(190, 196, 214),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextTruncate = Enum.TextTruncate.AtEnd,
					Position = UDim2.fromOffset(10, -9 + i * 16),
					Size = UDim2.fromOffset(326, 15), Parent = notes})
			end

			--[[ The warning is not a formality: applying an update teleports the
			     player out of whatever server they are in, so it must be said
			     before anything happens, not after. ]]
			local warn1 = E("TextLabel", {BackgroundTransparency = 1, Visible = false,
				Text = "⚠  You will be rejoined into a new server to apply this.",
				Font = Enum.Font.GothamMedium, TextSize = 12,
				TextColor3 = Color3.fromRGB(240, 190, 90),
				TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
				Position = UDim2.fromOffset(22, H - 92), Size = UDim2.fromOffset(346, 32),
				Parent = card})

			local primary = E("TextButton", {Text = "", AutoButtonColor = false,
				BackgroundColor3 = BLUE, BorderSizePixel = 0,
				AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 22, 1, -22),
				Size = UDim2.fromOffset(212, 38), Parent = card}, {corner(9)})
			local primaryLabel = E("TextLabel", {BackgroundTransparency = 1, Text = "Update",
				Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Color3.fromRGB(255,255,255),
				Size = UDim2.fromScale(1, 1), Parent = primary})

			local secondary = E("TextButton", {Text = "Later", AutoButtonColor = false,
				Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = MUT,
				BackgroundColor3 = Color3.fromRGB(28, 31, 42), BorderSizePixel = 0,
				AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -22, 1, -22),
				Size = UDim2.fromOffset(112, 38), Parent = card}, {corner(9)})
			secondary.MouseButton1Click:Connect(closeCard)

			primary.MouseEnter:Connect(function()
				TweenService:Create(primary, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
			end)
			primary.MouseLeave:Connect(function()
				TweenService:Create(primary, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
			end)

			-- first press asks, second press does it
			local armed = false
			primary.MouseButton1Click:Connect(function()
				if not armed then
					armed = true
					warn1.Visible = true
					primaryLabel.Text = "Rejoin and update"
					secondary.Text = "Cancel"
					sub.Text = "Your queue will stop while the game reloads"
					TweenService:Create(primary, TweenInfo.new(0.2),
						{BackgroundColor3 = Color3.fromRGB(230, 138, 30)}):Play()
					return
				end

				primaryLabel.Text = "Rejoining…"
				primary.Active = false
				secondary.Visible = false

				--[[ Hand the installer to the next session before leaving this one.
				     MastersAutoUpdate makes it skip the Run button, start Masters
				     itself, and then show what changed. ]]
				local queued = ([[
_G.MastersAutoUpdate = { from = %q }
local ok, err = pcall(function()
    loadstring(game:HttpGet(%q))()
end)
if not ok then warn("[MASTERS] update failed after rejoin: " .. tostring(err)) end
]]):format(tostring(from or ""), BOOTSTRAP)

				local queuedOk = false
				for _, fn in ipairs({queue_on_teleport, queueonteleport, queue_on_tp, queueontp}) do
					if type(fn) == "function" then
						queuedOk = pcall(fn, queued)
						if queuedOk then break end
					end
				end

				if not queuedOk then
					-- without a teleport queue the update cannot be automatic; say so
					-- rather than rejoining and silently doing nothing
					warn1.Text = "⚠  This executor can't queue scripts across a teleport. "
						.. "Rejoin and run the installer yourself."
					primaryLabel.Text = "Copy installer"
					primary.Active = true
					armed = false
					pcall(function()
						setclipboard('loadstring(game:HttpGet("' .. BOOTSTRAP .. '"))()')
					end)
					return
				end

				task.wait(0.4)
				local tok = pcall(function() TS:Teleport(game.PlaceId, Players.LocalPlayer) end)
				if not tok then
					warn1.Text = "⚠  Couldn't rejoin automatically — rejoin the game yourself "
						.. "and the update will apply."
					primaryLabel.Text = "Waiting for rejoin"
				end
			end)
		end

		-- ------------------------------------------------------------- polling

		task.spawn(function()
			task.wait(20)      -- let Masters finish starting before touching the network
			while true do
				local from = installedCommit()
				local rel = latestRelease()
				if rel and from and rel.commit ~= from then
					showUpdateWindow(rel, from)
				end
				task.wait(CHECK_EVERY)
			end
		end)

		--[[ Also exposed so it can be triggered by hand, and so the check can be
		     forced right after an install without waiting for the next tick. ]]
		rawset(_G, "MastersCheckForUpdate", function()
			local from = installedCommit()
			local rel = latestRelease()
			if not rel then return false, "release API unavailable" end
			if not from then return false, "this install predates update tracking" end
			if rel.commit == from then return false, "already up to date" end
			showUpdateWindow(rel, from)
			return true, rel.commit
		end)

		print("[MASTERS] Updater armed")
	end)
	if not ok then warn("[MASTERS] Updater failed: " .. tostring(err)) end
end)
