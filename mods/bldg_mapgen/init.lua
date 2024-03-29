--
-- Aliases for map generators
--

minetest.register_alias("mapgen_stone", "bldg_nodes:stone")
minetest.register_alias("mapgen_water_source", "bldg_nodes:water_source")
minetest.register_alias("mapgen_river_water_source", "bldg_nodes:river_water_source")

include("biomes")
include("decorations")
include("flowers")

local use_ores = bldg.conf:get('bldg_ores') or true
if use_ores then
	include("ores")
end
