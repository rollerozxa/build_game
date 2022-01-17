
local function register_flower(seed, flower_name)
	minetest.register_decoration({
		name = "flowers:"..flower_name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.04,
			spread = {x = 200, y = 200, z = 200},
			seed = seed,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"grassland", "deciduous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "flowers:"..flower_name,
	})
end

local function register_mushroom(mushroom_name)
	minetest.register_decoration({
		name = "flowers:"..mushroom_name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest", "coniferous_forest"},
		y_max = 31000,
		y_min = 1,
		decoration = "flowers:"..mushroom_name,
	})
end

local function register_waterlily()
	minetest.register_decoration({
		name = "default:waterlily",
		deco_type = "simple",
		place_on = {"default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"savanna_shore", "deciduous_forest_shore"},
		y_max = 0,
		y_min = 0,
		decoration = "flowers:waterlily_waving",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})
end

function flowers.register_decorations()
	register_flower(436,     "rose")
	register_flower(19822,   "tulip")
	register_flower(1220999, "dandelion_yellow")
	register_flower(800081,  "chrysanthemum_green")
	register_flower(36662,   "geranium")
	register_flower(1133,    "viola")
	register_flower(73133,   "dandelion_white")
	register_flower(42,      "tulip_black")

	register_mushroom("mushroom_brown")
	register_mushroom("mushroom_red")

	register_waterlily()
end

flowers.register_decorations()
