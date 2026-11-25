local pluginui = {}

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
{ height = 320, activeIndex = 2, scrollable = true, onChange = on_fish_flinger_solver_tabs_change }
)

local function create_fish_overview_header(page)
    page:AddText({ text = "Species", width = 110 })
    page:AddText({ text = "Habitat", width = 110, inline = true })
    page:AddText({ text = "Hook", width = 110, inline = true })
    page:AddText({ text = "Distance", width = 110, inline = true })
    page:AddText({ text = "Bait", width = 110, inline = true })
end

local function create_fish_overview_row(page, fish)
    page:AddText({ text = fish, width = 110 })
    local habitat = page:AddText({ text = "", width = 110, height = 35, inline = true })
    local hook = page:AddText({ text = "", width = 110, height = 35, inline = true })
    local distance = page:AddText({ text = "", width = 110, height = 35, inline = true })
    local bait = page:AddText({ text = "", width = 110, height = 35, inline = true })
    return habitat, hook, distance, bait
end

local overview_page = fish_flinger_solver_tabs:GetPage(1)
create_fish_overview_header(overview_page)
local overview_herring_habitat, overview_herring_hook, overview_herring_distance, overview_herring_bait = create_fish_overview_row(overview_page, "Herring")
local overview_bass_habitat, overview_bass_hook, overview_bass_distance, overview_bass_bait = create_fish_overview_row(overview_page, "Bass")
local overview_cod_habitat, overview_cod_hook, overview_cod_distance, overview_cod_bait = create_fish_overview_row(overview_page, "Cod")
local overview_pike_habitat, overview_pike_hook, overview_pike_distance, overview_pike_bait = create_fish_overview_row(overview_page, "Pike")
local overview_salmon_habitat, overview_salmon_hook, overview_salmon_distance, overview_salmon_bait = create_fish_overview_row(overview_page, "Salmon")
local overview_trout_habitat, overview_trout_hook, overview_trout_distance, overview_trout_bait = create_fish_overview_row(overview_page, "Trout")
overview_page:RefreshRowBackgrounds()


local function create_possibles_row(page, fish)
    local row_background_group = "component_possibles_" .. fish

    page:AddTitle({ text = fish, rowBackgroundGroup = row_background_group })

    page:AddText({ text = "Bone", width = 100, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Wood", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "1", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "2", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Worm", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Maggot", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Cricket", width = 100, inline = true, rowBackgroundGroup = row_background_group })

    page:AddText({ text = "Double", width = 100, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Large", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "3", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "4", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Shrimp", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Locust", width = 100, inline = true, rowBackgroundGroup = row_background_group })

    page:AddText({ text = "Standard", width = 100, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Slim", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "5", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "6", width = 25, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Crayfish", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Grey M", width = 100, inline = true, rowBackgroundGroup = row_background_group })
    page:AddText({ text = "Green M", width = 100, inline = true, rowBackgroundGroup = row_background_group })
end

local possibles_page = fish_flinger_solver_tabs:GetPage(2)
create_possibles_row(possibles_page, "Herring")
create_possibles_row(possibles_page, "Bass")
create_possibles_row(possibles_page, "Cod")
create_possibles_row(possibles_page, "Pike")
create_possibles_row(possibles_page, "Salmon")
create_possibles_row(possibles_page, "Trout")
possibles_page:RefreshRowBackgrounds()

local function create_fish_hints_header(page)
    page:AddText({ text = "Species", width = 110 })
    page:AddText({ text = "Habitat", width = 110, inline = true })
    page:AddText({ text = "Hook", width = 110, inline = true })
    page:AddText({ text = "Distance", width = 110, inline = true })
    page:AddText({ text = "Bait", width = 110, inline = true })
end

local function create_fish_hints_row(page, fish, on_hook_change, on_distance_change, on_bait_change)
    page:AddText({ text = fish, width = 110 })
    local habitat = page:AddText({ text = "", width = 110, inline = true })
    local hook = page:AddComboBox({
        entries = {
            { label = "", id = 1 },
            { label = "Standard", id = 2 },
            { label = "Slim", id = 3 },
            { label = "Large", id = 4 },
            { label = "Double", id = 5 },
            { label = "Bone", id = 6 },
            { label = "Wood", id = 7 }
        },
        width = 110,
        inline = true,
        tooltip = "Herring hook",
        selectedID = 1,
        onChange = on_hook_change
    })
    local distance = page:AddComboBox({
        entries = {
            { label = "", id = 1 },
            { label = "Close", id = 2 },
            { label = "Medium", id = 3 },
            { label = "Far", id = 4 }
        },
        width = 110,
        inline = true,
        tooltip =
        "Herring distance",
        selectedID = 1,
        onChange = on_distance_change
    })
    local bait = page:AddComboBox({
        entries = {
            { label = "", id = 1 },
            { label = "Worm", id = 2 },
            { label = "Maggot", id = 3 },
            { label = "Cricket", id = 4 },
            { label = "Locust", id = 5 },
            { label = "Green M", id = 6 },
            { label = "Grey M", id = 7 },
            { label = "Crayfish", id = 8 },
            { label = "Shrimp", id = 9 }
        },
        width = 110,
        inline = true,
        tooltip =
        "Herring bait",
        selectedID = 1,
        onChange = on_bait_change
    })
    return habitat, hook, distance, bait
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

local hint_herring_habitat, hint_herring_hook, hint_herring_distance, hint_herring_bait = create_fish_hints_row(hints_page, "Herring", on_hint_herring_hook_change,
on_hint_herring_distance_change, on_hint_herring_bait_change)
local hint_bass_habitat, hint_bass_hook, hint_bass_distance, hint_bass_bait = create_fish_hints_row(hints_page, "Bass", on_hint_bass_hook_change,
on_hint_bass_distance_change, on_hint_bass_bait_change)
local hint_cod_habitat, hint_cod_hook, hint_cod_distance, hint_cod_bait = create_fish_hints_row(hints_page, "Cod", on_hint_cod_hook_change, on_hint_cod_distance_change,
on_hint_cod_bait_change)
local hint_pike_habitat, hint_pike_hook, hint_pike_distance, hint_pike_bait = create_fish_hints_row(hints_page, "Pike", on_hint_pike_hook_change,
on_hint_pike_distance_change, on_hint_pike_bait_change)
local hint_salmon_habitat, hint_salmon_hook, hint_salmon_distance, hint_salmon_bait = create_fish_hints_row(hints_page, "Salmon", on_hint_salmon_hook_change,
on_hint_salmon_distance_change, on_hint_salmon_bait_change)
local hint_trout_habitat, hint_trout_hook, hint_trout_distance, hint_trout_bait = create_fish_hints_row(hints_page, "Trout", on_hint_trout_hook_change,
on_hint_trout_distance_change, on_hint_trout_bait_change)
fish_flinger_solver_tabs:GetPage(3):RefreshRowBackgrounds()

function pluginui.syncResults(fishHabitats, fishHooks, fishBaits, fishDistances)
    overview_herring_habitat.content = fishHabitats['Herring']
    hint_herring_habitat.content = fishHabitats['Herring']
    overview_herring_hook.content = fishHooks['Herring']
    hint_herring_hook.content = fishHooks['Herring']
    overview_herring_bait.content = fishBaits['Herring']
    hint_herring_bait.content = fishBaits['Herring']
    overview_herring_distance.content = fishDistances['Herring']
    hint_herring_distance.content = fishDistances['Herring']

    overview_bass_habitat.content = fishHabitats['Bass']
    hint_bass_habitat.content = fishHabitats['Bass']
    overview_bass_hook.content = fishHooks['Bass']
    hint_bass_hook.content = fishHooks['Bass']
    overview_bass_bait.content = fishBaits['Bass']
    hint_bass_bait.content = fishBaits['Bass']
    overview_bass_distance.content = fishDistances['Bass']
    hint_bass_distance.content = fishDistances['Bass']

    overview_cod_habitat.content = fishHabitats['Cod']
    hint_cod_habitat.content = fishHabitats['Cod']
    overview_cod_hook.content = fishHooks['Cod']
    hint_cod_hook.content = fishHooks['Cod']
    overview_cod_bait.content = fishBaits['Cod']
    hint_cod_bait.content = fishBaits['Cod']
    overview_cod_distance.content = fishDistances['Cod']
    hint_cod_distance.content = fishDistances['Cod']

    overview_pike_habitat.content = fishHabitats['Pike']
    hint_pike_habitat.content = fishHabitats['Pike']
    overview_pike_hook.content = fishHooks['Pike']
    hint_pike_hook.content = fishHooks['Pike']
    overview_pike_bait.content = fishBaits['Pike']
    hint_pike_bait.content = fishBaits['Pike']
    overview_pike_distance.content = fishDistances['Pike']
    hint_pike_distance.content = fishDistances['Pike']

    overview_salmon_habitat.content = fishHabitats['Salmon']
    hint_salmon_habitat.content = fishHabitats['Salmon']
    overview_salmon_hook.content = fishHooks['Salmon']
    hint_salmon_hook.content = fishHooks['Salmon']
    overview_salmon_bait.content = fishBaits['Salmon']
    hint_salmon_bait.content = fishBaits['Salmon']
    overview_salmon_distance.content = fishDistances['Salmon']
    hint_salmon_distance.content = fishDistances['Salmon']

    overview_trout_habitat.content = fishHabitats['Trout']
    hint_trout_habitat.content = fishHabitats['Trout']
    overview_trout_hook.content = fishHooks['Trout']
    hint_trout_hook.content = fishHooks['Trout']
    overview_trout_bait.content = fishBaits['Trout']
    hint_trout_bait.content = fishBaits['Trout']
    overview_trout_distance.content = fishDistances['Trout']
    hint_trout_distance.content = fishDistances['Trout']
end

return pluginui
