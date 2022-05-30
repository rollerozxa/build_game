print[[

	Powered by

	██╗██████╗
	██║╚════██╗
	██║ █████╔╝
	██║ ╚═══██╗
	██║██████╔╝
	╚═╝╚═════╝
]]

local storage = minetest.get_mod_storage()

local function lf(path)
	return assert(loadfile(minetest.get_modpath("bldg_i3") .. path))
end

i3 = {
	data = minetest.deserialize(storage:get_string"data") or {},

	settings = {
		debug_mode = false,
		max_waypoints = 15,
		save_interval = 600, -- Player data save interval (in seconds)

		hud_speed = 1,
		hud_timer_max = 1.5,
	},

	categories = {
		"waypoints",
		--"skins",
	},

	saves = { -- Metadata to save
		home = true,
		waypoints = true,
		inv_items = true,
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
