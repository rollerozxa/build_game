
--
-- Lavacooling
--

bldg.cool_lava = function(pos, node)
	if node.name == "bldg_nodes:lava_source" then
		minetest.set_node(pos, {name = "bldg_nodes:obsidian"})
	else -- Lava flowing
		minetest.set_node(pos, {name = "bldg_nodes:stone"})
	end
	minetest.sound_play("default_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.25}, true)
end

minetest.register_abm({
	label = "Lava cooling",
	nodenames = {"bldg_nodes:lava_source", "bldg_nodes:lava_flowing"},
	neighbors = {"group:cools_lava", "group:water"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(...)
		bldg.cool_lava(...)
	end,
})

--
-- Convert bldg_nodes:dirt to something that fits the environment
--

minetest.register_abm({
	label = "Grass spread",
	nodenames = {"bldg_nodes:dirt"},
	neighbors = {
		"air",
		"group:grass",
		"group:dry_grass",
		"bldg_nodes:snow",
	},
	interval = 6,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end

		-- Look for spreading dirt-type neighbours
		local p2 = minetest.find_node_near(pos, 1, "group:spreading_dirt_type")
		if p2 then
			local n3 = minetest.get_node(p2)
			minetest.set_node(pos, {name = n3.name})
			return
		end

		-- Else, any seeding nodes on top?
		local name = minetest.get_node(above).name
		-- Snow check is cheapest, so comes first
		if name == "bldg_nodes:snow" then
			minetest.set_node(pos, {name = "bldg_nodes:dirt_with_snow"})
		elseif minetest.get_item_group(name, "grass") ~= 0 then
			minetest.set_node(pos, {name = "bldg_nodes:dirt_with_grass"})
		elseif minetest.get_item_group(name, "dry_grass") ~= 0 then
			minetest.set_node(pos, {name = "bldg_nodes:dirt_with_dry_grass"})
		end
	end
})


--
-- Grass and dry grass removed in darkness
--

minetest.register_abm({
	label = "Grass covered",
	nodenames = {"group:spreading_dirt_type", "bldg_nodes:dry_dirt_with_dry_grass"},
	interval = 8,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			if node.name == "bldg_nodes:dry_dirt_with_dry_grass" then
				minetest.set_node(pos, {name = "bldg_nodes:dry_dirt"})
			else
				minetest.set_node(pos, {name = "bldg_nodes:dirt"})
			end
		end
	end
})


--
-- Moss growth on cobble near water
--

local moss_correspondences = {
	["bldg_nodes:cobble"] = "bldg_nodes:mossycobble",
	["stairs:slab_cobble"] = "stairs:slab_mossycobble",
	["stairs:stair_cobble"] = "stairs:stair_mossycobble",
	["stairs:stair_inner_cobble"] = "stairs:stair_inner_mossycobble",
	["stairs:stair_outer_cobble"] = "stairs:stair_outer_mossycobble",
	["walls:cobble"] = "walls:mossycobble",
}
minetest.register_abm({
	label = "Moss growth",
	nodenames = {"bldg_nodes:cobble", "stairs:slab_cobble", "stairs:stair_cobble",
		"stairs:stair_inner_cobble", "stairs:stair_outer_cobble",
		"walls:cobble"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		node.name = moss_correspondences[node.name]
		if node.name then
			minetest.set_node(pos, node)
		end
	end
})

--
-- register trees for leafdecay
--

bldg.register_leafdecay({
	trunks = {"bldg_nodes:tree"},
	leaves = {"bldg_nodes:apple", "bldg_nodes:leaves"},
	radius = 3,
})

bldg.register_leafdecay({
	trunks = {"bldg_nodes:pine_tree"},
	leaves = {"bldg_nodes:pine_needles"},
	radius = 3,
})

bldg.register_leafdecay({
	trunks = {"bldg_nodes:acacia_tree"},
	leaves = {"bldg_nodes:acacia_leaves"},
	radius = 2,
})

bldg.register_leafdecay({
	trunks = {"bldg_nodes:aspen_tree"},
	leaves = {"bldg_nodes:aspen_leaves"},
	radius = 3,
})

include("trees")
