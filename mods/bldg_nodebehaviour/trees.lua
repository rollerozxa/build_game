
local random = math.random

--
-- Grow trees from saplings
--

-- 'can grow' function

function bldg.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end
	return true
end


-- Grow sapling

function bldg.grow_sapling(pos)
	if not bldg.can_grow(pos) then
		-- try again 5 min later
		minetest.get_node_timer(pos):start(300)
		return
	end

	local mg_name = minetest.get_mapgen_setting("mg_name")
	local node = minetest.get_node(pos)
	if node.name == "bldg_nodes:sapling" then
		minetest.log("action", "A sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		bldg.grow_new_apple_tree(pos)
	elseif node.name == "bldg_nodes:pine_sapling" then
		minetest.log("action", "A pine sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		local snow = minetest.find_node_near(pos, 1, {"group:snowy"})
		if snow then
			bldg.grow_new_snowy_pine_tree(pos)
		else
			bldg.grow_new_pine_tree(pos)
		end
	elseif node.name == "bldg_nodes:acacia_sapling" then
		minetest.log("action", "An acacia sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		bldg.grow_new_acacia_tree(pos)
	elseif node.name == "bldg_nodes:aspen_sapling" then
		minetest.log("action", "An aspen sapling grows into a tree at "..
			minetest.pos_to_string(pos))
		bldg.grow_new_aspen_tree(pos)
	end
end

--
-- Tree generation
--

-- New apple tree

function bldg.grow_new_apple_tree(pos)
	local path = minetest.get_modpath("bldg_mapgen") ..
		"/schematics/apple_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
		path, "random", nil, false)
end

-- New pine tree

function bldg.grow_new_pine_tree(pos)
	local path
	if math.random() > 0.5 then
		path = minetest.get_modpath("bldg_mapgen") ..
			"/schematics/pine_tree_from_sapling.mts"
	else
		path = minetest.get_modpath("bldg_mapgen") ..
			"/schematics/small_pine_tree_from_sapling.mts"
	end
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end

-- New snowy pine tree

function bldg.grow_new_snowy_pine_tree(pos)
	local path
	if math.random() > 0.5 then
		path = minetest.get_modpath("bldg_mapgen") ..
			"/schematics/snowy_pine_tree_from_sapling.mts"
	else
		path = minetest.get_modpath("bldg_mapgen") ..
			"/schematics/snowy_small_pine_tree_from_sapling.mts"
	end
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "random", nil, false)
end

-- New acacia tree

function bldg.grow_new_acacia_tree(pos)
	local path = minetest.get_modpath("bldg_mapgen") ..
		"/schematics/acacia_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 4, y = pos.y - 1, z = pos.z - 4},
		path, "random", nil, false)
end

-- New aspen tree

function bldg.grow_new_aspen_tree(pos)
	local path = minetest.get_modpath("bldg_mapgen") ..
		"/schematics/aspen_tree_from_sapling.mts"
	minetest.place_schematic({x = pos.x - 2, y = pos.y - 1, z = pos.z - 2},
		path, "0", nil, false)
end

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function bldg.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
--		minetest.chat_send_player(player_name,
--			itemstack:get_definition().description .. " will intersect protection " ..
--			"on growth")
		minetest.chat_send_player(player_name,
			itemstack:get_definition().description.." will intersect protection on growth.")
		return itemstack
	end

	minetest.log("action", player_name .. " places node "
			.. sapling_name .. " at " .. minetest.pos_to_string(pos))

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end
