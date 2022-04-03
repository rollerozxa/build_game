function register_default_alias(itemstring)
	minetest.register_alias("default:"..itemstring, "bldg_nodes:"..itemstring)
end

-- grasses
minetest.register_node("bldg_nodes:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 4,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, attached_node = 1},
	sounds = bldg_sounds.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 4 / 16, 6 / 16},
	},
})
minetest.register_alias("default:dry_shrub", "bldg_nodes:dry_shrub")


minetest.register_node("bldg_nodes:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_grass_1.png"},
	-- Use texture of a taller grass stage in inventory
	inventory_image = "default_grass_3.png",
	wield_image = "default_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flora = 1, attached_node = 1, grass = 1,
		normal_grass = 1},
	sounds = bldg_sounds.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("bldg_nodes:grass_" .. math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("bldg_nodes:grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_alias("default:grass_1", "bldg_nodes:grass_1")

for i = 2, 5 do
	minetest.register_node("bldg_nodes:grass_" .. i, {
		description = "Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_grass_" .. i .. ".png"},
		inventory_image = "default_grass_" .. i .. ".png",
		wield_image = "default_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		drop = "bldg_nodes:grass_1",
		groups = {snappy=3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1,
			normal_grass = 1},
		sounds = bldg_sounds.sound_leaves(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
		},
	})
	minetest.register_alias("default:grass_"..i, "bldg_nodes:grass_"..i)
end


minetest.register_node("bldg_nodes:dry_grass_1", {
	description = "Savanna Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_dry_grass_1.png"},
	inventory_image = "default_dry_grass_3.png",
	wield_image = "default_dry_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flora = 1,
		attached_node = 1, grass = 1, dry_grass = 1},
	sounds = bldg_sounds.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("bldg_nodes:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("bldg_nodes:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_alias("default:dry_grass_1", "bldg_nodes:dry_grass_1")

for i = 2, 5 do
	minetest.register_node("bldg_nodes:dry_grass_" .. i, {
		description = "Savanna Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_dry_grass_" .. i .. ".png"},
		inventory_image = "default_dry_grass_" .. i .. ".png",
		wield_image = "default_dry_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy=3, flora = 1, attached_node = 1,
			not_in_creative_inventory = 1, grass = 1, dry_grass = 1},
		drop = "bldg_nodes:dry_grass_1",
		sounds = bldg_sounds.sound_leaves(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
	minetest.register_alias("default:dry_grass_"..i, "bldg_nodes:dry_grass_"..i)
end


minetest.register_node("bldg_nodes:fern_1", {
	description = "Fern",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_fern_1.png"},
	inventory_image = "default_fern_1.png",
	wield_image = "default_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flora = 1, grass = 1,
		fern = 1, attached_node = 1},
	sounds = bldg_sounds.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("bldg_nodes:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("bldg_nodes:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_alias("default:fern_1", "bldg_nodes:fern_1")

for i = 2, 3 do
	minetest.register_node("bldg_nodes:fern_" .. i, {
		description = "Fern",
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"default_fern_" .. i .. ".png"},
		inventory_image = "default_fern_" .. i .. ".png",
		wield_image = "default_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy=3, flora = 1, attached_node = 1,
			grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "bldg_nodes:fern_1",
		sounds = bldg_sounds.sound_leaves(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
	minetest.register_alias("default:fern_"..i, "bldg_nodes:fern_"..i)
end


minetest.register_node("bldg_nodes:marram_grass_1", {
	description = "Marram Grass",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_marram_grass_1.png"},
	inventory_image = "default_marram_grass_1.png",
	wield_image = "default_marram_grass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3, flora = 1, grass = 1, marram_grass = 1,
		attached_node = 1},
	sounds = bldg_sounds.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("bldg_nodes:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("bldg_nodes:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_alias("default:marram_grass_1", "bldg_nodes:marram_grass_1")

for i = 2, 3 do
	minetest.register_node("bldg_nodes:marram_grass_" .. i, {
		description = "Marram Grass",
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_marram_grass_" .. i .. ".png"},
		inventory_image = "default_marram_grass_" .. i .. ".png",
		wield_image = "default_marram_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy=3, flora = 1, attached_node = 1,
			grass = 1, marram_grass = 1, not_in_creative_inventory = 1},
		drop = "bldg_nodes:marram_grass_1",
		sounds = bldg_sounds.sound_leaves(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
	minetest.register_alias("default:marram_grass_"..i, "bldg_nodes:marram_grass_"..i)
end

-- kelp
minetest.register_node("bldg_nodes:sand_with_kelp", {
	description = "Kelp",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {"default_kelp.png"},
	inventory_image = "default_kelp.png",
	wield_image = "default_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy=3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "bldg_nodes:sand",
	node_placement_prediction = "",
	sounds = bldg_sounds.sound_sand({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "bldg_nodes:sand" then
			return itemstack
		end

		local height = math.random(4, 6)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "bldg_nodes:sand_with_kelp",
					param2 = height * 16})
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "bldg_nodes:sand"})
	end
})
minetest.register_alias("default:sand_with_kelp", "bldg_nodes:sand_with_kelp")

-- corals



-- liquidz
minetest.register_node("bldg_nodes:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "default_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "default_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "bldg_nodes:water_flowing",
	liquid_alternative_source = "bldg_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = bldg_sounds.sound_water(),
})

register_default_alias("water_source")


minetest.register_node("bldg_nodes:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"default_water.png"},
	special_tiles = {
		{
			name = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "bldg_nodes:water_flowing",
	liquid_alternative_source = "bldg_nodes:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = bldg_sounds.sound_water(),
})

register_default_alias("water_flowing")


minetest.register_node("bldg_nodes:river_water_source", {
	description = "River Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "default_river_water_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "default_river_water_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "bldg_nodes:river_water_flowing",
	liquid_alternative_source = "bldg_nodes:river_water_source",
	liquid_viscosity = 1,
	-- Not renewable to avoid horizontal spread of water sources in sloping
	-- rivers that can cause water to overflow riverbanks and cause floods.
	-- River water source is instead made renewable by the 'force renew'
	-- option used in the 'bucket' mod by the river water bucket.
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	sounds = bldg_sounds.sound_water(),
})

register_default_alias("river_water_source")

minetest.register_node("bldg_nodes:river_water_flowing", {
	description = "Flowing River Water",
	drawtype = "flowingliquid",
	tiles = {"default_river_water.png"},
	special_tiles = {
		{
			name = "default_river_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "default_river_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "bldg_nodes:river_water_flowing",
	liquid_alternative_source = "bldg_nodes:river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,
		cools_lava = 1},
	sounds = bldg_sounds.sound_water(),
})

register_default_alias("river_water_flowing")


minetest.register_node("bldg_nodes:lava_source", {
	description = "Lava Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "default_lava_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "default_lava_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = minetest.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "bldg_nodes:lava_flowing",
	liquid_alternative_source = "bldg_nodes:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1},
})

register_default_alias("lava_source")

minetest.register_node("bldg_nodes:lava_flowing", {
	description = "Flowing Lava",
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	special_tiles = {
		{
			name = "default_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "default_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = minetest.LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "bldg_nodes:lava_flowing",
	liquid_alternative_source = "bldg_nodes:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

register_default_alias("lava_flowing")

