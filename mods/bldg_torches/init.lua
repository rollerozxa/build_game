
local function on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("bldg_torches:torch 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"default_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1},
			true
		)
	end
	-- Remove the torch node
	return false
end

minetest.register_node("bldg_torches:torch", {
	description = "Torch",
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
	tiles = {{
		    name = "default_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = 12,
	groups = {snappy=3, attached_node=1, torch=1},
	drop = "bldg_torches:torch",
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = bldg_sounds.sound_wood(),
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("bldg_torches:torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("bldg_torches:torch")
		else
			fakestack:set_name("bldg_torches:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("bldg_torches:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_node("bldg_torches:torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		name = "default_torch_on_floor_animated.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {snappy=3, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "bldg_torches:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = bldg_sounds.sound_wood(),
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

minetest.register_node("bldg_torches:torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		name = "default_torch_on_floor_animated.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 12,
	groups = {snappy=3, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "bldg_torches:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = bldg_sounds.sound_wood(),
	floodable = true,
	on_flood = on_flood,
	on_rotate = false
})

if do_compat then
	-- Compatibility for MTG
	minetest.register_alias("default:torch", "bldg_torches:torch")
	minetest.register_alias("default:torch_wall", "bldg_torches:torch_wall")
	minetest.register_alias("default:torch_ceiling", "bldg_torches:torch_ceiling")
end
