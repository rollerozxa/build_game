print[[

	Powered by

	██╗██████╗
	██║╚════██╗
	██║ █████╔╝
	██║ ╚═══██╗
	██║██████╔╝
	╚═╝╚═════╝
]]

local modpath = core.get_modpath"i3"
local storage = core.get_mod_storage()
local _loadfile = dofile(modpath .. "/src/operators.lua")

local function lf(path)
	return assert(_loadfile(modpath .. path))
end

i3 = {
	data = core.deserialize(storage:get_string"data") or {},

	settings = {
		debug_mode = false,
		max_waypoints = 15,
		min_fs_version = 4,
		item_btn_size = 1.1,
		save_interval = 600, -- Player data save interval (in seconds)

		hud_speed = 1,
		hud_timer_max = 1.5,
	},

	categories = {
		"waypoints",
		"skins",

	},

	saves = { -- Metadata to save
		home = true,
		waypoints = true,
		inv_items = true,
		drop_items = true,
		known_recipes = true,
	},

	files = {
		api = lf"/src/api.lua",
		caches = lf"/src/caches.lua",
		callbacks = lf"/src/callbacks.lua",
		common = lf"/src/common.lua",
		compress = lf"/src/compress.lua",
		detached = lf"/src/detached_inv.lua",
		fields = lf"/src/fields.lua",
		gui = lf"/src/gui.lua",
		hud = lf"/src/hud.lua",
		styles = lf"/src/styles.lua",
	},

	-- Caches
	init_items = {},
	fuel_cache = {},
	usages_cache = {},
	recipes_cache = {},

	tabs = {},
	cubes = {},
	plants = {},
	modules = {},

	recipe_filters = {},
	search_filters = {},
	sorting_methods = {},
}

i3.settings.hotbar_len = 9
i3.settings.inv_size   = 4 * i3.settings.hotbar_len

i3.files.common()
i3.files.api()
i3.files.compress()
i3.files.callbacks(storage)
