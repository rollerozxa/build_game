
--
-- Register ores
--

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
