local readRuneScape = require("readRuneScape")
local pluginui = require("pluginui")

print("Fish Flingers Solver loading!")

--[[
FISHCOMP_RESULT_FISH
1: Herring
2: Cod
3: Bass
4: Trout
5: Pike
6: Salmon
]]
Fishes = {}
Fishes[1] = 'Herring'
Fishes[2] = 'Cod'
Fishes[3] = 'Bass'
Fishes[4] = 'Trout'
Fishes[5] = 'Pike'
Fishes[6] = 'Salmon'

--[[
FISHCOMP_CLIENT_HOOK / FISHCOMP_RESULT_HOOK
1: Standard
2: Slim
3: Large
4: Bone
5: Wooden
6: Double
]]
Hooks = {}
Hooks[1] = 'Standard'
Hooks[2] = 'Slim'
Hooks[3] = 'Large'
Hooks[4] = 'Bone'
Hooks[5] = 'Wooden'
Hooks[6] = 'Double'

--[[
FISHCOMP_CLIENT_BAIT / FISHCOMP_RESULT_BAIT
1: Worm
2: Maggot
3: Cricket
4: Locust
5: Cray
6: Shrimp
7: Green Moth
8: Grey Moth
]]
Baits = {}
Baits[1] = 'Worm'
Baits[2] = 'Maggot'
Baits[3] = 'Cricket'
Baits[4] = 'Locust'
Baits[5] = 'Cray'
Baits[6] = 'Shrimp'
Baits[7] = 'Green Moth'
Baits[8] = 'Grey Moth'

--[[
FISHCOMP_RESULT_HABITAT = Habitat
1: Lake
2: River
3: Beach
4: Dock
]]
Habitats = {}
Habitats[1] = 'Lake'
Habitats[2] = 'River'
Habitats[3] = 'Beach'
Habitats[4] = 'Dock'

--[[
Weight buttons are tracked by 0 or their value
eg.
FISHCOMP_CLIENT_WEIGHT_1 = 1 means that the weight 1 button is blocked
FISHCOMP_CLIENT_WEIGHT_2 = 2 means that the weight 2 button is blocked
FISHCOMP_CLIENT_WEIGHT_3 = 3 means that the weight 3 button is blocked

But you can also just see the combined value in results:
FISHCOMP_RESULT_DISTANCE = 5 if button 2 and 3 are pressed

There are unused VarClients for weight 4 and weight 5.
]]

local results = {}
local fishHabitats = {}
local fishBaits = {}
local fishHooks = {}
local fishDistances = {}

local function watchForFishFlingers(varTransmitEvent)
    if varTransmitEvent.var.configName == 'FISHCOMP_RESULT_RATING' then
        readRuneScape.handleFishCaught(results, fishHooks, fishBaits, fishDistances)
        pluginui.syncResults(fishHabitats, fishHooks, fishBaits, fishDistances)
    end

    if varTransmitEvent.var.configName == 'TOPLEVEL_V2_ACTIVE_MODAL_ID' and ui.Interfaces:GetInterface(id.Interface.FISHCOMP_STATBLOCK) ~= nil then
        readRuneScape.readStatBlock(fishHabitats)

        pluginui.syncResults(fishHabitats, fishHooks, fishBaits, fishDistances)
    end

    log("Value change for " ..
        (varTransmitEvent.var.configName or "nil") ..
        ": " .. (varTransmitEvent.oldValue or "nil") .. " -> " .. (varTransmitEvent.newValue or "nil"))
end

Event.VarTransmit.Subscribe("watchForFishFlingers", watchForFishFlingers)
