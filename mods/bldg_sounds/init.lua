
--
-- Sounds
--

bldg_sounds = {}

function bldg_sounds.sound(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "default_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "default_place_node_hard", gain = 1.0}
	return table
end

function bldg_sounds.sound_stone(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_dirt(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_dirt_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "default_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_sand(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_sand_footstep", gain = 0.05}
	table.dug = table.dug or
			{name = "default_sand_footstep", gain = 0.15}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_gravel(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_gravel_footstep", gain = 0.1}
	table.dig = table.dig or
			{name = "default_gravel_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "default_gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_wood(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_wood_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_wood_footstep", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_leaves(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_grass_footstep", gain = 0.45}
	table.dug = table.dug or
			{name = "default_grass_footstep", gain = 0.7}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_glass(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "default_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "default_break_glass", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_ice(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_ice_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "default_ice_dig", gain = 0.5}
	table.dug = table.dug or
			{name = "default_ice_dug", gain = 0.5}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_metal(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_metal_footstep", gain = 0.4}
	table.dig = table.dig or
			{name = "default_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "default_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "default_place_node_metal", gain = 0.5}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_water(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_water_footstep", gain = 0.2}
	bldg_sounds.sound(table)
	return table
end

function bldg_sounds.sound_snow(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_snow_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "default_snow_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_snow_footstep", gain = 0.3}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	bldg_sounds.sound(table)
	return table
end
