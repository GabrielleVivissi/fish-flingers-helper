print("Fish Flingers Solver loading!")

-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
	if type(o) == 'table' then
		local s = '{ '
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
		end
		return s .. '} '
	else
		return tostring(o)
	end
end

-- from https://stackoverflow.com/questions/1426954/split-string-in-lua
function mysplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

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


local parent = ui.Interfaces:GetComponent(id.Component.TOPLEVEL_V2__GAME_AREA)
local fish_flinger_solver_window = prettyui.Window.new(parent,
	{ title = "Fish Flinger Solver", x = 0, y = 0, width = 620, height = 370, scrollable = false })
local function on_fish_flinger_solver_tabs_change(tabs, index, value, page)
end
local fish_flinger_solver_tabs = fish_flinger_solver_window:AddTabs(
	{
		{ text = "Overview",  tooltip = "Overview",              rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true },
		{ text = "Possibles", tooltip = "Possible combinations", rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true },
		{ text = "Hints",     tooltip = "Hints",                 rowBackgroundColours = { 0x24211EFF, 0x2E2825FF }, rowBackgroundEdgeToEdge = true }
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
local overview_herring_habitat = create_fish_overview_row(overview_page, "Herring")
local overview_bass_habitat    = create_fish_overview_row(overview_page, "Bass")
local overview_cod_habitat     = create_fish_overview_row(overview_page, "Cod")
local overview_pike_habitat    = create_fish_overview_row(overview_page, "Pike")
local overview_salmon_habitat  = create_fish_overview_row(overview_page, "Salmon")
local overview_trout_habitat   = create_fish_overview_row(overview_page, "Trout")
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
			{ label = "",         id = 1 },
			{ label = "Standard", id = 2 },
			{ label = "Slim",     id = 3 },
			{ label = "Large",    id = 4 },
			{ label = "Double",   id = 5 },
			{ label = "Bone",     id = 6 },
			{ label = "Wood",     id = 7 }
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

local hint_herring_habitat = create_fish_hints_row(hints_page, "Herring", on_hint_herring_hook_change,
	on_hint_herring_distance_change, on_hint_herring_bait_change)
local hint_bass_habitat = create_fish_hints_row(hints_page, "Bass", on_hint_bass_hook_change,
	on_hint_bass_distance_change, on_hint_bass_bait_change)
local hint_cod_habitat = create_fish_hints_row(hints_page, "Cod", on_hint_cod_hook_change, on_hint_cod_distance_change,
	on_hint_cod_bait_change)
local hint_pike_habitat = create_fish_hints_row(hints_page, "Pike", on_hint_pike_hook_change,
	on_hint_pike_distance_change, on_hint_pike_bait_change)
local hint_salmon_habitat = create_fish_hints_row(hints_page, "Salmon", on_hint_salmon_hook_change,
	on_hint_salmon_distance_change, on_hint_salmon_bait_change)
local hint_trout_habitat = create_fish_hints_row(hints_page, "Trout", on_hint_trout_hook_change,
	on_hint_trout_distance_change, on_hint_trout_bait_change)
fish_flinger_solver_tabs:GetPage(3):RefreshRowBackgrounds()


local results = {}
local fishHabitats = {}

local function varTest(varTransmitEvent)
	if varTransmitEvent.var.configName == 'FISHCOMP_RESULT_RATING' then
		-- just caught a fish!
		log("Just caught a fish!")

		local fish = Fishes[var.VarClient.FISHCOMP_RESULT_FISH.value]
		if results[fish] == nil then results[fish] = {} end
		table.insert(results[fish], {
			weight = var.VarClient.FISHCOMP_RESULT_WEIGHT.value,
			habitat = Habitats[var.VarClient.FISHCOMP_RESULT_HABITAT.value],
			bait = Baits[var.VarClient.FISHCOMP_RESULT_BAIT.value],
			hook = Hooks[var.VarClient.FISHCOMP_RESULT_HOOK.value],
			distance = var.VarClient.FISHCOMP_RESULT_DISTANCE.value,
			rating = var.VarClient.FISHCOMP_RESULT_RATING.value
		})

		log(dump(results))
	end

	if varTransmitEvent.var.configName == 'TOPLEVEL_V2_ACTIVE_MODAL_ID' and ui.Interfaces:GetInterface(id.Interface.FISHCOMP_STATBLOCK) ~= nil then
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

		overview_herring_habitat.content = fishHabitats['Herring']
		hint_herring_habitat.content = fishHabitats['Herring']
		overview_bass_habitat.content = fishHabitats['Bass']
		hint_bass_habitat.content = fishHabitats['Bass']
		overview_cod_habitat.content = fishHabitats['Cod']
		hint_cod_habitat.content = fishHabitats['Cod']
		overview_pike_habitat.content = fishHabitats['Pike']
		hint_pike_habitat.content = fishHabitats['Pike']
		overview_salmon_habitat.content = fishHabitats['Salmon']
		hint_salmon_habitat.content = fishHabitats['Salmon']
		overview_trout_habitat.content = fishHabitats['Trout']
		hint_trout_habitat.content = fishHabitats['Trout']

		log(dump(fishHabitats))
	end

	log("Value change for " ..
		(varTransmitEvent.var.configName or "nil") ..
		": " .. (varTransmitEvent.oldValue or "nil") .. " -> " .. (varTransmitEvent.newValue or "nil"))
end

Event.VarTransmit.Subscribe("watchForFishFlingers", varTest)
