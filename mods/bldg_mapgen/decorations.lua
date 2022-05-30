
--
-- Register decorations
--

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		name = "bldg_nodes:grass_" .. length,
		deco_type = "simple",
		place_on = {"bldg_nodes:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "bldg_nodes:grass_" .. length,
	})
end

local function register_fern_decoration(seed, length)
	minetest.register_decoration({
		name = "bldg_nodes:fern_" .. length,
		deco_type = "simple",
		place_on = {"bldg_nodes:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.2,
			spread = {x = 100, y = 100, z = 100},
			seed = seed,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"coniferous_forest"},
		y_max = 31000,
		y_min = 6,
		decoration = "bldg_nodes:fern_" .. length,
	})
end

-- Apple tree and log

minetest.register_decoration({
	name = "bldg_nodes:apple_tree",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.024,
		scale = 0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/apple_tree.mts",
	flags = "place_center_x, place_center_z",
	rotation = "random",
})

minetest.register_decoration({
	name = "bldg_nodes:apple_log",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_grass"},
	place_offset_y = 1,
	sidelen = 16,
	noise_params = {
		offset = 0.0012,
		scale = 0.0007,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/apple_log.mts",
	flags = "place_center_x",
	rotation = "random",
	spawn_by = "bldg_nodes:dirt_with_grass",
	num_spawn_by = 8,
})

-- Taiga and temperate coniferous forest pine tree, small pine tree and log

minetest.register_decoration({
	name = "bldg_nodes:pine_tree",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_snow", "bldg_nodes:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.010,
		scale = 0.048,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"taiga", "coniferous_forest"},
	y_max = 31000,
	y_min = 4,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/pine_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "bldg_nodes:small_pine_tree",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_snow", "bldg_nodes:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.010,
		scale = -0.048,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"taiga", "coniferous_forest"},
	y_max = 31000,
	y_min = 4,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/small_pine_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "bldg_nodes:pine_log",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_snow", "bldg_nodes:dirt_with_coniferous_litter"},
	place_offset_y = 1,
	sidelen = 80,
	fill_ratio = 0.0018,
	biomes = {"taiga", "coniferous_forest"},
	y_max = 31000,
	y_min = 4,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/pine_log.mts",
	flags = "place_center_x",
	rotation = "random",
	spawn_by = {"bldg_nodes:dirt_with_snow", "bldg_nodes:dirt_with_coniferous_litter"},
	num_spawn_by = 8,
})

-- Aspen tree and log

minetest.register_decoration({
	name = "bldg_nodes:aspen_tree",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		scale = -0.015,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/aspen_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	name = "bldg_nodes:aspen_log",
	deco_type = "schematic",
	place_on = {"bldg_nodes:dirt_with_grass"},
	place_offset_y = 1,
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		scale = -0.0008,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_max = 31000,
	y_min = 1,
	schematic = minetest.get_modpath("bldg_mapgen") .. "/schematics/aspen_log.mts",
	flags = "place_center_x",
	rotation = "random",
	spawn_by = "bldg_nodes:dirt_with_grass",
	num_spawn_by = 8,
})

-- Cactus

minetest.register_decoration({
	name = "bldg_nodes:cactus",
	deco_type = "simple",
	place_on = {"bldg_nodes:desert_sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 230,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"desert"},
	y_max = 31000,
	y_min = 4,
	decoration = "bldg_nodes:cactus",
	height = 2,
	height_max = 5,
})

-- Grasses

register_grass_decoration(-0.03,  0.09,  5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0,      0.06,  3)
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)

-- Ferns

register_fern_decoration(14936, 3)
register_fern_decoration(801,   2)
register_fern_decoration(5,     1)

-- Dry shrub

minetest.register_decoration({
	name = "bldg_nodes:dry_shrub",
	deco_type = "simple",
	place_on = {"bldg_nodes:desert_sand",
		"bldg_nodes:sand", "bldg_nodes:silver_sand"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.02,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"desert", "sandstone_desert", "cold_desert"},
	y_max = 31000,
	y_min = 2,
	decoration = "bldg_nodes:dry_shrub",
	param2 = 4,
})

-- Marram grass

minetest.register_decoration({
	name = "bldg_nodes:marram_grass",
	deco_type = "simple",
	place_on = {"bldg_nodes:sand"},
	sidelen = 4,
	noise_params = {
		offset = -0.7,
		scale = 4.0,
		spread = {x = 16, y = 16, z = 16},
		seed = 513337,
		octaves = 1,
		persist = 0.0,
		flags = "absvalue, eased"
	},
	biomes = {"coniferous_forest_dunes", "grassland_dunes"},
	y_max = 6,
	y_min = 4,
	decoration = {
		"bldg_nodes:marram_grass_1",
		"bldg_nodes:marram_grass_2",
		"bldg_nodes:marram_grass_3",
	},
})

-- Coral reef

minetest.register_decoration({
	name = "bldg_nodes:corals",
	deco_type = "simple",
	place_on = {"bldg_nodes:sand"},
	place_offset_y = -1,
	sidelen = 4,
	noise_params = {
		offset = -4,
		scale = 4,
		spread = {x = 50, y = 50, z = 50},
		seed = 7013,
		octaves = 3,
		persist = 0.7,
	},
	biomes = {
		"desert_ocean",
	},
	y_max = -2,
	y_min = -8,
	flags = "force_placement",
	decoration = {
		"bldg_nodes:coral_green", "bldg_nodes:coral_pink",
		"bldg_nodes:coral_cyan", "bldg_nodes:coral_brown",
		"bldg_nodes:coral_orange", "bldg_nodes:coral_skeleton",
	},
})

-- Kelp

minetest.register_decoration({
	name = "bldg_nodes:kelp",
	deco_type = "simple",
	place_on = {"bldg_nodes:sand"},
	place_offset_y = -1,
	sidelen = 16,
	noise_params = {
		offset = -0.04,
		scale = 0.1,
		spread = {x = 200, y = 200, z = 200},
		seed = 87112,
		octaves = 3,
		persist = 0.7
	},
	biomes = {
		"taiga_ocean",
		"snowy_grassland_ocean",
		"grassland_ocean",
		"coniferous_forest_ocean",
		"deciduous_forest_ocean",
		"sandstone_desert_ocean",
		"cold_desert_ocean"},
	y_max = -5,
	y_min = -10,
	flags = "force_placement",
	decoration = "bldg_nodes:sand_with_kelp",
	param2 = 48,
	param2_max = 96,
})
