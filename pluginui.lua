local pluginui = {}

Fishes = {}
Fishes[1] = 'Herring'
Fishes[2] = 'Cod'
Fishes[3] = 'Bass'
Fishes[4] = 'Trout'
Fishes[5] = 'Pike'
Fishes[6] = 'Salmon'

local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__GAME_AREA)
local fish_flinger_solver_window = prettyui.Window.new(parent,
{ title = "Fish Flinger Solver", x = 0, y = 0, width = 620, height = 370, scrollable = false })
local function on_fish_flinger_solver_tabs_change(tabs, index, value, page)
end
local fish_flinger_solver_tabs = fish_flinger_solver_window:AddTabs(
{
    { text = "Overview", tooltip = "Overview", rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true },
    { text = "Possibles", tooltip = "Possible combinations", rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true },
    { text = "Hints", tooltip = "Hints", rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true }
},
{ height = 320, activeIndex = 1, scrollable = true, onChange = on_fish_flinger_solver_tabs_change }
)

local function create_fish_overview_header(page)
    page:AddText({ text = "Species", width = 110 })
    page:AddText({ text = "Habitat", width = 110, inline = true })
    page:AddText({ text = "Hook", width = 110, inline = true })
    page:AddText({ text = "Distance", width = 110, inline = true })
    page:AddText({ text = "Bait", width = 110, inline = true })
end

local function create_fish_overview_row(page, fish, rows)
    page:AddText({ text = fish, width = 110 })
    rows[fish] = {}
    rows[fish].habitat = page:AddText({ text = "", width = 110, height = 35, inline = true })
    rows[fish].hook = page:AddText({ text = "", width = 110, height = 35, inline = true })
    rows[fish].distance = page:AddText({ text = "", width = 110, height = 35, inline = true })
    rows[fish].bait = page:AddText({ text = "", width = 110, height = 35, inline = true })
end

local overview_page = fish_flinger_solver_tabs:GetPage(1)
create_fish_overview_header(overview_page)
local overview_rows = {}
create_fish_overview_row(overview_page, "Herring", overview_rows)
create_fish_overview_row(overview_page, "Bass", overview_rows)
create_fish_overview_row(overview_page, "Cod", overview_rows)
create_fish_overview_row(overview_page, "Pike", overview_rows)
create_fish_overview_row(overview_page, "Salmon", overview_rows)
create_fish_overview_row(overview_page, "Trout", overview_rows)
overview_page:RefreshRowBackgrounds()


local function create_possibles_row(page, fish)
    local row_background_group = "component_possibles_" .. fish

    page:AddTitle({ text = fish, rowBackgroundGroup = row_background_group })

    local row = {}
    row.hooks = {}
    row.distances = {}
    row.baits = {}

    row.hooks['Bone'] = page:AddText({ text = "Bone", width = 100, rowBackgroundGroup = row_background_group })
    row.hooks['Wood'] = page:AddText({ text = "Wood", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[1] = page:AddText({ text = "1", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[2] = page:AddText({ text = "2", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Worm'] = page:AddText({ text = "Worm", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Maggot'] = page:AddText({ text = "Maggot", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Cricket'] = page:AddText({ text = "Cricket", width = 100, inline = true, rowBackgroundGroup = row_background_group })

    row.hooks['Double'] = page:AddText({ text = "Double", width = 100, rowBackgroundGroup = row_background_group })
    row.hooks['Large'] = page:AddText({ text = "Large", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[3] = page:AddText({ text = "3", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[4] = page:AddText({ text = "4", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Shrimp'] = page:AddText({ text = "Shrimp", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Locust'] = page:AddText({ text = "Locust", width = 100, inline = true, rowBackgroundGroup = row_background_group })

    row.hooks['Standard'] = page:AddText({ text = "Standard", width = 100, rowBackgroundGroup = row_background_group })
    row.hooks['Slim'] = page:AddText({ text = "Slim", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[5] = page:AddText({ text = "5", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.distances[6] = page:AddText({ text = "6", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Crayfish'] = page:AddText({ text = "Crayfish", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Grey Moth'] = page:AddText({ text = "Grey M", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    row.baits['Green Moth'] = page:AddText({ text = "Green M", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    return row
end

local possibles_page = fish_flinger_solver_tabs:GetPage(2)
possibles_rows = {}
possibles_rows["Herring"] = create_possibles_row(possibles_page, "Herring")
possibles_rows["Bass"] = create_possibles_row(possibles_page, "Bass")
possibles_rows["Cod"] = create_possibles_row(possibles_page, "Cod")
possibles_rows["Pike"] = create_possibles_row(possibles_page, "Pike")
possibles_rows["Salmon"] = create_possibles_row(possibles_page, "Salmon")
possibles_rows["Trout"] = create_possibles_row(possibles_page, "Trout")
possibles_page:RefreshRowBackgrounds()

local function create_fish_hints_header(page)
    page:AddText({ text = "Species", width = 110 })
    page:AddText({ text = "Habitat", width = 110, inline = true })
    page:AddText({ text = "Hook", width = 110, inline = true })
    page:AddText({ text = "Distance", width = 110, inline = true })
    page:AddText({ text = "Bait", width = 110, inline = true })
end

local hookSelectorIds = {}
hookSelectorIds[""] = 1
hookSelectorIds["Standard"] = 2
hookSelectorIds["Slim"] = 3
hookSelectorIds["Large"] = 4
hookSelectorIds["Double"] = 5
hookSelectorIds["Bone"] = 6
hookSelectorIds["Wood"] = 7

local distanceSelectorIds = {}
distanceSelectorIds[0] = 1
distanceSelectorIds[1] = 2 -- Close
distanceSelectorIds[2] = 2 -- Close
distanceSelectorIds[3] = 3 -- Medium
distanceSelectorIds[4] = 3 -- Medium
distanceSelectorIds[5] = 4 -- Far
distanceSelectorIds[6] = 4 -- Far

local baitSelectorIds = {}
baitSelectorIds[""] = 1
baitSelectorIds["Worm"] = 2
baitSelectorIds["Maggot"] = 3
baitSelectorIds["Cricket"] = 4
baitSelectorIds["Locust"] = 5
baitSelectorIds["Green Moth"] = 6
baitSelectorIds["Grey Moth"] = 7
baitSelectorIds["Crayfish"] = 8
baitSelectorIds["Shrimp"] = 9

local function create_fish_hints_row(page, fish, on_hook_change, on_distance_change, on_bait_change, hint_rows)
    hint_rows[fish] = {}
    page:AddText({ text = fish, width = 110 })
    hint_rows[fish].habitat = page:AddText({ text = "", width = 110, inline = true })
    hint_rows[fish].hook = page:AddComboBox({
        entries = {
            { label = "", id = 1, order = 1 },
            { label = "Standard", id = 2, order = 2 },
            { label = "Slim", id = 3, order = 3 },
            { label = "Large", id = 4, order = 4 },
            { label = "Double", id = 5, order = 5 },
            { label = "Bone", id = 6, order = 6 },
            { label = "Wood", id = 7, order = 7 }
        },
        width = 110,
        inline = true,
        tooltip = fish .. " hook",
        selectedID = 1,
        onChange = on_hook_change
    })
    hint_rows[fish].distance = page:AddComboBox({
        entries = {
            { label = "", id = 1, order = 1 },
            { label = "Close", id = 2, order = 2 },
            { label = "Medium", id = 3, order = 3 },
            { label = "Far", id = 4, order = 4 }
        },
        width = 110,
        inline = true,
        tooltip = fish .. " distance",
        selectedID = 1,
        onChange = on_distance_change
    })
    hint_rows[fish].bait = page:AddComboBox({
        entries = {
            { label = "", id = 1, order = 1 },
            { label = "Worm", id = 2, order = 2 },
            { label = "Maggot", id = 3, order = 3 },
            { label = "Cricket", id = 4, order = 4 },
            { label = "Locust", id = 5, order = 5 },
            { label = "Green M", id = 6, order = 6 },
            { label = "Grey M", id = 7, order = 7 },
            { label = "Crayfish", id = 8, order = 8 },
            { label = "Shrimp", id = 9, order = 9 }
        },
        width = 110,
        inline = true,
        tooltip = fish .. " bait",
        selectedID = 1,
        onChange = on_bait_change
    })
end

local hints_page = fish_flinger_solver_tabs:GetPage(3)
create_fish_hints_header(hints_page)

local function on_hint_herring_hook_change(combo, id, label, eventType)
end
local function on_hint_herring_distance_change(combo, id, label, eventType)
end
local function on_hint_herring_bait_change(combo, id, label, eventType)
end

local function on_hint_bass_hook_change(combo, id, label, eventType)
end
local function on_hint_bass_distance_change(combo, id, label, eventType)
end
local function on_hint_bass_bait_change(combo, id, label, eventType)
end

local function on_hint_cod_hook_change(combo, id, label, eventType)
end
local function on_hint_cod_distance_change(combo, id, label, eventType)
end
local function on_hint_cod_bait_change(combo, id, label, eventType)
end

local function on_hint_pike_hook_change(combo, id, label, eventType)
end
local function on_hint_pike_distance_change(combo, id, label, eventType)
end
local function on_hint_pike_bait_change(combo, id, label, eventType)
end

local function on_hint_salmon_hook_change(combo, id, label, eventType)
end
local function on_hint_salmon_distance_change(combo, id, label, eventType)
end
local function on_hint_salmon_bait_change(combo, id, label, eventType)
end

local function on_hint_trout_hook_change(combo, id, label, eventType)
end
local function on_hint_trout_distance_change(combo, id, label, eventType)
end
local function on_hint_trout_bait_change(combo, id, label, eventType)
end

local hint_rows = {}
create_fish_hints_row(hints_page, "Herring", on_hint_herring_hook_change,  on_hint_herring_distance_change, on_hint_herring_bait_change, hint_rows)
create_fish_hints_row(hints_page, "Bass", on_hint_bass_hook_change, on_hint_bass_distance_change, on_hint_bass_bait_change, hint_rows)
create_fish_hints_row(hints_page, "Cod", on_hint_cod_hook_change, on_hint_cod_distance_change, on_hint_cod_bait_change, hint_rows)
create_fish_hints_row(hints_page, "Pike", on_hint_pike_hook_change, on_hint_pike_distance_change, on_hint_pike_bait_change, hint_rows)
create_fish_hints_row(hints_page, "Salmon", on_hint_salmon_hook_change, on_hint_salmon_distance_change, on_hint_salmon_bait_change, hint_rows)
create_fish_hints_row(hints_page, "Trout", on_hint_trout_hook_change, on_hint_trout_distance_change, on_hint_trout_bait_change, hint_rows)
fish_flinger_solver_tabs:GetPage(3):RefreshRowBackgrounds()

function pluginui.syncResults(fishHabitats, fishHooks, fishBaits, fishDistances)
    for index, fish in ipairs(Fishes) do
        overview_rows[fish].habitat.content = fishHabitats[fish] or ""
        overview_rows[fish].hook.content = fishHooks[fish] or ""
        overview_rows[fish].bait.content = fishBaits[fish] or ""
        overview_rows[fish].distance.content = tostring(fishDistances[fish] or "")

        hint_rows[fish].habitat.content = fishHabitats[fish] or ""
        log("hook " .. fish .. " " .. tostring(hookSelectorIds[fishHooks[fish] or ""]))
        log("hook " .. fish .. " " .. tostring(fishHooks[fish] or ""))
        hint_rows[fish].hook:Select(hookSelectorIds[fishHooks[fish] or ""])
        log("bait " .. fish .. " " .. tostring(baitSelectorIds[fishBaits[fish] or ""]))
        log("bait " .. fish .. " " .. tostring(fishBaits[fish] or ""))
        hint_rows[fish].bait:Select(baitSelectorIds[fishBaits[fish] or ""])
        log("distance " .. fish .. " " .. tostring(distanceSelectorIds[fishDistances[fish] or 0]))
        log("distance " .. fish .. " " .. tostring(fishDistances[fish] or 0))
        hint_rows[fish].distance:Select(distanceSelectorIds[fishDistances[fish] or 0])

        if fishDistances[fish] then
            possibles_rows[fish].distances[fishDistances[fish]].content = ''
        end
        if fishBaits[fish] then
            possibles_rows[fish].baits[fishBaits[fish]].content = ''
        end
        if fishHooks[fish] then
            possibles_rows[fish].hooks[fishHooks[fish]].content = ''
        end
    end
end

return pluginui
