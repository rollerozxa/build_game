
--
-- Register biomes
--

-- Turn the comma-separated settings value into an easier to work with
-- table.
local biomes_str = minetest.settings:get('bldg_biomes') or 'icesheet,taiga,snowy_grassland,grassland,coniferous_forest,deciduous_forest,desert,sandstone_desert'
local biomes = {}
for biome in biomes_str:gmatch('[^,%s]+') do
	biomes[biome] = true
end


if biomes.icesheet then
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

end

if biomes.taiga then
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

end

if biomes.snowy_grassland then
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

end

if biomes.grassland then
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

end

if biomes.coniferous_forest then
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

end

if biomes.deciduous_forest then
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

end

if biomes.desert then
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

end

if biomes.sandstone_desert then
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
