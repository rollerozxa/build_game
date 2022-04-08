--
-- Aliases for map generators
--

minetest.register_alias("mapgen_stone", "bldg_nodes:stone")
minetest.register_alias("mapgen_water_source", "bldg_nodes:water_source")
minetest.register_alias("mapgen_river_water_source", "bldg_nodes:river_water_source")


--
-- Register ores
--

local function register_ores()
	-- Stratum ores.
	-- These obviously first.

	-- Silver sandstone

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "bldg_nodes:silver_sandstone",
		wherein         = {"bldg_nodes:stone"},
		clust_scarcity  = 1,
		y_max           = 46,
		y_min           = 10,
		noise_params    = {
			offset = 28,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 4,
		biomes = {"cold_desert"},
	})

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "bldg_nodes:silver_sandstone",
		wherein         = {"bldg_nodes:stone"},
		clust_scarcity  = 1,
		y_max           = 42,
		y_min           = 6,
		noise_params    = {
			offset = 24,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"cold_desert"},
	})

	-- Desert sandstone

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "bldg_nodes:desert_sandstone",
		wherein         = {"bldg_nodes:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 46,
		y_min           = 10,
		noise_params    = {
			offset = 28,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 4,
		biomes = {"desert"},
	})

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "bldg_nodes:desert_sandstone",
		wherein         = {"bldg_nodes:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 42,
		y_min           = 6,
		noise_params    = {
			offset = 24,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"desert"},
	})

	-- Sandstone

	minetest.register_ore({
		ore_type        = "stratum",
		ore             = "bldg_nodes:sandstone",
		wherein         = {"bldg_nodes:desert_stone"},
		clust_scarcity  = 1,
		y_max           = 39,
		y_min           = 3,
		noise_params    = {
			offset = 21,
			scale = 16,
			spread = {x = 128, y = 128, z = 128},
			seed = 90122,
			octaves = 1,
		},
		stratum_thickness = 2,
		biomes = {"desert"},
	})

	-- Blob ore.
	-- These before scatter ores to avoid other ores in blobs.

	-- Clay

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "bldg_nodes:clay",
		wherein         = {"bldg_nodes:sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 0,
		y_min           = -15,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

	-- Silver sand

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "bldg_nodes:silver_sand",
		wherein         = {"bldg_nodes:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 2316,
			octaves = 1,
			persist = 0.0
		},
	})

	-- Dirt

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "bldg_nodes:dirt",
		wherein         = {"bldg_nodes:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 17676,
			octaves = 1,
			persist = 0.0
		},
		-- Only where bldg_nodes:dirt is present as surface material
		biomes = {"taiga", "snowy_grassland", "grassland", "coniferous_forest",
				"deciduous_forest", "deciduous_forest_shore"}
	})

	-- Gravel

	minetest.register_ore({
		ore_type        = "blob",
		ore             = "bldg_nodes:gravel",
		wherein         = {"bldg_nodes:stone"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_max           = 31000,
		y_min           = -31000,
		noise_threshold = 0.0,
		noise_params    = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = 766,
			octaves = 1,
			persist = 0.0
		},
	})

	-- Scatter ores

	-- Coal

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:coal_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 9,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:coal_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_max          = 64,
		y_min          = -127,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:coal_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 30,
		clust_size     = 5,
		y_max          = -128,
		y_min          = -31000,
	})

	-- Tin

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:tin_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:tin_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:tin_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})

	-- Copper

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:copper_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:copper_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -64,
		y_min          = -127,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:copper_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -31000,
	})

	-- Iron

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:iron_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 9 * 9 * 9,
		clust_num_ores = 12,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:iron_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 7 * 7 * 7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -128,
		y_min          = -255,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:iron_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 29,
		clust_size     = 5,
		y_max          = -256,
		y_min          = -31000,
	})

	-- Gold

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:gold_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:gold_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -256,
		y_min          = -511,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:gold_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 13 * 13 * 13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -512,
		y_min          = -31000,
	})

	-- Mese crystal

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -512,
		y_min          = -1023,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 14 * 14 * 14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -1024,
		y_min          = -31000,
	})

	-- Diamond

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:diamond_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:diamond_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 17 * 17 * 17,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -1024,
		y_min          = -2047,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:diamond_ore",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_max          = -2048,
		y_min          = -31000,
	})

	-- Mese block

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_block",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = 31000,
		y_min          = 1025,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_block",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_max          = -2048,
		y_min          = -4095,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "bldg_nodes:mese_block",
		wherein        = "bldg_nodes:stone",
		clust_scarcity = 28 * 28 * 28,
		clust_num_ores = 5,
		clust_size     = 3,
		y_max          = -4096,
		y_min          = -31000,
	})
end


--
-- Register biomes
--

local function register_biomes()
	-- Icesheet

	minetest.register_biome({
		name = "icesheet",
		node_dust = "bldg_nodes:snowblock",
		node_top = "bldg_nodes:snowblock",
		depth_top = 1,
		node_filler = "bldg_nodes:snowblock",
		depth_filler = 3,
		node_stone = "bldg_nodes:cave_ice",
		node_water_top = "bldg_nodes:ice",
		depth_water_top = 10,
		node_river_water = "bldg_nodes:ice",
		node_riverbed = "bldg_nodes:gravel",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:ice",
		node_dungeon_stair = "stairs:stair_ice",
		y_max = 31000,
		y_min = -8,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_ocean",
		node_dust = "bldg_nodes:snowblock",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_water_top = "bldg_nodes:ice",
		depth_water_top = 10,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -9,
		y_min = -255,
		heat_point = 0,
		humidity_point = 73,
	})

	minetest.register_biome({
		name = "icesheet_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 0,
		humidity_point = 73,
	})


	-- Taiga

	minetest.register_biome({
		name = "taiga",
		node_dust = "bldg_nodes:snow",
		node_top = "bldg_nodes:dirt_with_snow",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 4,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_ocean",
		node_dust = "bldg_nodes:snow",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 25,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "taiga_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 25,
		humidity_point = 70,
	})

	-- Snowy grassland

	minetest.register_biome({
		name = "snowy_grassland",
		node_dust = "bldg_nodes:snow",
		node_top = "bldg_nodes:dirt_with_snow",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 1,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 4,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_ocean",
		node_dust = "bldg_nodes:snow",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 20,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "snowy_grassland_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 20,
		humidity_point = 35,
	})

	-- Grassland

	minetest.register_biome({
		name = "grassland",
		node_top = "bldg_nodes:dirt_with_grass",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 1,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 6,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_dunes",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 2,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_ocean",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 3,
		y_min = -255,
		heat_point = 50,
		humidity_point = 35,
	})

	minetest.register_biome({
		name = "grassland_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 50,
		humidity_point = 35,
	})

	-- Coniferous forest

	minetest.register_biome({
		name = "coniferous_forest",
		node_top = "bldg_nodes:dirt_with_coniferous_litter",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 6,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_dunes",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = 5,
		y_min = 4,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_ocean",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 3,
		y_min = -255,
		heat_point = 45,
		humidity_point = 70,
	})

	minetest.register_biome({
		name = "coniferous_forest_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 45,
		humidity_point = 70,
	})

	-- Deciduous forest

	minetest.register_biome({
		name = "deciduous_forest",
		node_top = "bldg_nodes:dirt_with_grass",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 31000,
		y_min = 1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_shore",
		node_top = "bldg_nodes:dirt",
		depth_top = 1,
		node_filler = "bldg_nodes:dirt",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = 0,
		y_min = -1,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_ocean",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		vertical_blend = 1,
		y_max = -2,
		y_min = -255,
		heat_point = 60,
		humidity_point = 68,
	})

	minetest.register_biome({
		name = "deciduous_forest_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 68,
	})

	-- Desert

	minetest.register_biome({
		name = "desert",
		node_top = "bldg_nodes:desert_sand",
		depth_top = 1,
		node_filler = "bldg_nodes:desert_sand",
		depth_filler = 1,
		node_stone = "bldg_nodes:desert_stone",
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:desert_stone",
		node_dungeon_stair = "stairs:stair_desert_stone",
		y_max = 31000,
		y_min = 4,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_ocean",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_stone = "bldg_nodes:desert_stone",
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:desert_stone",
		node_dungeon_stair = "stairs:stair_desert_stone",
		vertical_blend = 1,
		y_max = 3,
		y_min = -255,
		heat_point = 92,
		humidity_point = 16,
	})

	minetest.register_biome({
		name = "desert_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 92,
		humidity_point = 16,
	})

	-- Sandstone desert

	minetest.register_biome({
		name = "sandstone_desert",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 1,
		node_stone = "bldg_nodes:sandstone",
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_dungeon = "bldg_nodes:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_max = 31000,
		y_min = 4,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_ocean",
		node_top = "bldg_nodes:sand",
		depth_top = 1,
		node_filler = "bldg_nodes:sand",
		depth_filler = 3,
		node_stone = "bldg_nodes:sandstone",
		node_riverbed = "bldg_nodes:sand",
		depth_riverbed = 2,
		node_cave_liquid = "bldg_nodes:water_source",
		node_dungeon = "bldg_nodes:sandstonebrick",
		node_dungeon_stair = "stairs:stair_sandstone_block",
		y_max = 3,
		y_min = -255,
		heat_point = 60,
		humidity_point = 0,
	})

	minetest.register_biome({
		name = "sandstone_desert_under",
		node_cave_liquid = {"bldg_nodes:water_source", "bldg_nodes:lava_source"},
		node_dungeon = "bldg_nodes:cobble",
		node_dungeon_alt = "bldg_nodes:mossycobble",
		node_dungeon_stair = "stairs:stair_cobble",
		y_max = -256,
		y_min = -31000,
		heat_point = 60,
		humidity_point = 0,
	})
end


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


local function register_decorations()

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
end


--
-- Detect mapgen to select functions
--

minetest.clear_registered_biomes()
minetest.clear_registered_ores()
minetest.clear_registered_decorations()

register_biomes()
register_ores()
register_decorations()

include("flowers")
