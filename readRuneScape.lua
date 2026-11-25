local readRuneScape = {}

function readRuneScape.readStatBlock(fishHabitats)
    local fish1 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_1_TXT).content, ' ')[2]
    fish1 = string.upper(string.sub(fish1, 1, 1)) .. string.sub(fish1, 2)
    local habitat1 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_1_HABITAT_TXT).content
    fishHabitats[fish1] = habitat1

    local fish2 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_2_TXT).content, ' ')[2]
    fish2 = string.upper(string.sub(fish2, 1, 1)) .. string.sub(fish2, 2)
    local habitat2 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_2_HABITAT_TXT).content
    fishHabitats[fish2] = habitat2

    local fish3 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_3_TXT).content, ' ')[2]
    fish3 = string.upper(string.sub(fish3, 1, 1)) .. string.sub(fish3, 2)
    local habitat3 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_3_HABITAT_TXT).content
    fishHabitats[fish3] = habitat3

    local fish4 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_4_TXT).content, ' ')[2]
    fish4 = string.upper(string.sub(fish4, 1, 1)) .. string.sub(fish4, 2)
    local habitat4 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_4_HABITAT_TXT).content
    fishHabitats[fish4] = habitat4

    local fish5 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_5_TXT).content, ' ')[2]
    fish5 = string.upper(string.sub(fish5, 1, 1)) .. string.sub(fish5, 2)
    local habitat5 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_5_HABITAT_TXT).content
    fishHabitats[fish5] = habitat5

    local fish6 = mysplit(ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_NAME_6_TXT).content, ' ')[2]
    fish6 = string.upper(string.sub(fish6, 1, 1)) .. string.sub(fish6, 2)
    local habitat6 = ui.Interfaces:GetComponent(id.Component.FISHCOMP_STATBLOCK__FISH_6_HABITAT_TXT).content
    fishHabitats[fish6] = habitat6
end

function readRuneScape.handleFishCaught(results, fishBaits, fishHooks, fishDistances)
    log("Just caught a fish!")

    local fish = Fishes[var.VarClient.FISHCOMP_RESULT_FISH.value]
    if results[fish] == nil then results[fish] = {} end
    local result = {
        weight = var.VarClient.FISHCOMP_RESULT_WEIGHT.value,
        habitat = Habitats[var.VarClient.FISHCOMP_RESULT_HABITAT.value],
        bait = Baits[var.VarClient.FISHCOMP_RESULT_BAIT.value],
        hook = Hooks[var.VarClient.FISHCOMP_RESULT_HOOK.value],
        distance = var.VarClient.FISHCOMP_RESULT_DISTANCE.value,
        rating = var.VarClient.FISHCOMP_RESULT_RATING.value
    }
    table.insert(results[fish], result)
    if result.rating == 100 then
        fishBaits[fish] = result.bait
        fishHooks[fish] = result.hook
        fishDistances[fish] = result.distance
    end
end

return readRuneScape
