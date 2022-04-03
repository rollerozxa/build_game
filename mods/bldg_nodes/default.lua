local sound_stone = bldg_sounds.sound_stone()
local sound_dirt = bldg_sounds.sound_dirt()
local sound_sand = bldg_sounds.sound_sand()
local sound_gravel = bldg_sounds.sound_gravel()
local sound_wood = bldg_sounds.sound_wood()
local sound_leaves = bldg_sounds.sound_leaves()
local sound_glass = bldg_sounds.sound_glass()
local sound_ice = bldg_sounds.sound_ice()
local sound_metal = bldg_sounds.sound_metal()
local sound_water = bldg_sounds.sound_water()
local sound_snow = bldg_sounds.sound_snow()

-- Required wrapper to allow customization of bldg.after_place_leaves
local function after_place_leaves(...)
	return bldg.after_place_leaves(...)
end

-- Required wrapper to allow customization of bldg.grow_sapling
local function grow_sapling(...)
	return bldg.grow_sapling(...)
end

local function coral_on_place(itemstack, placer, pointed_thing)
	if pointed_thing.type ~= "node" or not placer then
		return itemstack
	end

	local player_name = placer:get_player_name()
	local pos_under = pointed_thing.under
	local pos_above = pointed_thing.above
	local node_under = minetest.get_node(pos_under)
	local def_under = minetest.registered_nodes[node_under.name]

	if def_under and def_under.on_rightclick and not placer:get_player_control().sneak then
		return def_under.on_rightclick(pos_under, node_under,
				placer, itemstack, pointed_thing) or itemstack
	end

	if node_under.name ~= "bldg_nodes:coral_skeleton" or
			minetest.get_node(pos_above).name ~= "bldg_nodes:water_source" then
		return itemstack
	end

	if minetest.is_protected(pos_under, player_name) or
			minetest.is_protected(pos_above, player_name) then
		minetest.log("action", player_name
			.. " tried to place " .. itemstack:get_name()
			.. " at protected position "
			.. minetest.pos_to_string(pos_under))
		minetest.record_protection_violation(pos_under, player_name)
		return itemstack
	end

	node_under.name = itemstack:get_name()
	minetest.set_node(pos_under, node_under)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end

	return itemstack
end

local nodes = {
	--
	-- Stone-like
	--
	stone = {
		description = "Stone",
		groups = {stone=1},
		sounds = sound_stone,
	},
	cobble = {
		description = "Cobblestone",
		is_ground_content = false,
		groups = {stone=2},
		sounds = sound_stone,
	},
	stone_brick = {
		description = "Stone Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {stone=1},
		sounds = sound_stone,
		original_itemstring = "default:stonebrick",
	},
	stone_block = {
		description = "Stone Block",
		is_ground_content = false,
		groups = {stone=1},
		sounds = sound_stone,
	},
	mossycobble = {
		description = "Mossy Cobblestone",
		is_ground_content = false,
		groups = {stone=1},
		sounds = sound_stone,
	},
	desert_stone = {
		description = "Desert Stone",
		groups = {stone=1},
		sounds = sound_stone,
	},
	desert_stone_brick = {
		description = "Desert Stone Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {stone=1},
		sounds = sound_stone,
		original_itemstring = "default:desert_stonebrick"
	},
	desert_stone_block = {
		description = "Desert Stone Block",
		is_ground_content = false,
		groups = {stone=1},
		sounds = sound_stone,
	},
	sandstone = {
		description = "Sandstone",
		sounds = sound_stone,
	},
	sandstone_brick = {
		description = "Sandstone Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
		original_itemstring = "default:sandstonebrick"
	},
	sandstone_block = {
		description = "Sandstone Block",
		is_ground_content = false,
		sounds = sound_stone,
	},
	desert_sandstone = {
		description = "Desert Sandstone",
		sounds = sound_stone,
	},
	desert_sandstone_brick = {
		description = "Desert Sandstone Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
	},
	desert_sandstone_block = {
		description = "Desert Sandstone Block",
		is_ground_content = false,
		sounds = sound_stone,
	},
	silver_sandstone = {
		description = "Silver Sandstone",
		sounds = sound_stone,
	},
	silver_sandstone_brick = {
		description = "Silver Sandstone Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
	},
	silver_sandstone_block = {
		description = "Silver Sandstone Block",
		is_ground_content = false,
		sounds = sound_stone,
	},
	obsidian = {
		description = "Obsidian",
		sounds = sound_stone,
	},
	obsidian_brick = {
		description = "Obsidian Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
	},
	obsidian_block = {
		description = "Obsidian Block",
		is_ground_content = false,
		sounds = sound_stone,
	},

	--
	-- Soft / Non-Stone
	--
	dirt = {
		description = "Dirt",
		groups = {soil=1},
		sounds = sound_dirt,
	},
	dirt_with_grass = {
		description = "Dirt with Grass",
		tiles = {
			"default_grass.png",
			"default_dirt.png",
			"default_dirt.png^default_grass_side.png"},
		groups = {soil=1, spreading_dirt_type=1},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_grass_footstep", gain = 0.25},
		}),
	},
	dirt_with_dry_grass = {
		description = "Dirt with Savanna Grass",
		tiles = {
			"default_dry_grass.png",
			"default_dirt.png",
			"default_dirt.png^default_dry_grass_side.png"},
		groups = {soil=1, spreading_dirt_type=1},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_grass_footstep", gain = 0.4},
		}),
	},
	dirt_with_snow = {
		description = "Dirt with Snow",
		tiles = {
			"default_snow.png",
			"default_dirt.png",
			"default_dirt.png^default_snow_side.png"},
		groups = {soil=1, spreading_dirt_type=1, snowy=1},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_snow_footstep", gain = 0.2},
		}),
	},
	dirt_with_coniferous_litter = {
		description = "Dirt with Coniferous Litter",
		tiles = {
			"default_coniferous_litter.png",
			"default_dirt.png",
			"default_dirt.png^default_coniferous_litter_side.png"},
		groups = {soil=1, spreading_dirt_type=1},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_grass_footstep", gain = 0.4},
		}),
	},
	dry_dirt = {
		description = "Savanna Dirt",
		groups = {soil=1},
		sounds = sound_dirt,
	},
	dry_dirt_with_dry_grass = {
		description = "Savanna Dirt with Savanna Grass",
		tiles = {
			"default_dry_grass.png",
			"default_dry_dirt.png",
			"default_dry_dirt.png^default_dry_grass_side.png"},
		groups = {soil = 1},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_grass_footstep", gain = 0.4},
		}),
	},
	permafrost = {
		description = "Permafrost",
		sounds = sound_dirt,
	},
	permafrost_with_stones = {
		description = "Permafrost with Stones",
		tiles = {
			"default_permafrost.png^default_stones.png",
			"default_permafrost.png",
			"default_permafrost.png^default_stones_side.png"},
		sounds = sound_gravel,
	},
	permafrost_with_moss = {
		description = "Permafrost with Moss",
		tiles = {
			"default_moss.png",
			"default_permafrost.png",
			"default_permafrost.png^default_moss_side.png"},
		sounds = bldg_sounds.sound_dirt({
			footstep = {name = "default_grass_footstep", gain = 0.25},
		}),
	},
	sand = {
		description = "Sand",
		groups = {sand=1},
		sounds = sound_sand,
	},
	desert_sand = {
		description = "Desert Sand",
		groups = {sand=1},
		sounds = sound_sand,
	},
	silver_sand = {
		description = "Silver Sand",
		groups = {sand=1},
		sounds = sound_sand,
	},
	gravel = {
		description = "Gravel",
		sounds = sound_gravel,
	},
	clay = {
		description = "Clay",
		sounds = sound_dirt,
	},
	snow = {
		description = "Snow",
		paramtype = "light",
		buildable_to = true,
		floodable = true,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -6 / 16, 0.5},
			},
		},
		groups = {snowy=1},
		sounds = sound_snow,

		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "bldg_nodes:dirt_with_grass" then
				minetest.set_node(pos, {name = "bldg_nodes:dirt_with_snow"})
			end
		end,
	},
	snowblock = {
		description = "Snow Block",
		tiles = {"default_snow.png"},
		groups = {cools_lava=1, snowy=1},
		sounds = sound_snow,

		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "bldg_nodes:dirt_with_grass" then
				minetest.set_node(pos, {name = "bldg_nodes:dirt_with_snow"})
			end
		end,
	},
	ice = {
		description = "Ice",
		is_ground_content = false,
		paramtype = "light",
		groups = {cools_lava=1, slippery=3},
		sounds = sound_ice,
	},

	--
	-- Trees
	--
	tree = {
		description = "Apple Tree",
		tiles = {
			"default_tree_top.png",
			"default_tree_top.png",
			"default_tree.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {tree=1},
		sounds = sound_wood,

		on_place = minetest.rotate_node
	},
	wood = {
		description = "Apple Wood Planks",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {wood=1},
		sounds = sound_wood,
	},
	leaves = {
		description = "Apple Tree Leaves",
		drawtype = "allfaces_optional",
		waving = 1,
		special_tiles = {"default_leaves_simple.png"},
		paramtype = "light",
		is_ground_content = false,
		groups = {leafdecay=3, leaves=1},
		sounds = sound_leaves,

		after_place_node = after_place_leaves,
	},
	sapling = {
		description = "Apple Tree Sapling",
		drawtype = "plantlike",
		inventory_image = "default_sapling.png",
		wield_image = "default_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = grow_sapling,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
		},
		groups = {attached_node=1, sapling=1},
		sounds = sound_leaves,

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = bldg.sapling_on_place(itemstack, placer, pointed_thing,
				"bldg_nodes:sapling",
				-- minp, maxp to be checked, relative to sapling pos
				-- minp_relative.y = 1 because sapling pos has been checked
				{x = -3, y = 1, z = -3},
				{x = 3, y = 6, z = 3},
				-- maximum interval of interior volume check
				4)

			return itemstack
		end,
	},
	apple = {
		description = "Apple",
		drawtype = "plantlike",
		inventory_image = "default_apple.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		is_ground_content = false,
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
		},
		groups = {leafdecay=3, leafdecay_drop=1},
		sounds = sound_leaves,
	},

	pine_tree = {
		description = "Pine Tree",
		tiles = {
			"default_pine_tree_top.png",
			"default_pine_tree_top.png",
			"default_pine_tree.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {tree = 1},
		sounds = sound_wood,

		on_place = minetest.rotate_node
	},
	pine_wood = {
		description = "Pine Wood Planks",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {wood=1},
		sounds = sound_wood,
	},
	pine_needles = {
		description = "Pine Needles",
		drawtype = "allfaces_optional",
		waving = 1,
		paramtype = "light",
		is_ground_content = false,
		groups = {leafdecay=3, leaves=1},
		sounds = sound_leaves,

		after_place_node = after_place_leaves,
	},
	pine_sapling = {
		description = "Pine Tree Sapling",
		drawtype = "plantlike",
		inventory_image = "default_pine_sapling.png",
		wield_image = "default_pine_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = grow_sapling,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
		},
		groups = {attached_node=1, sapling=1},
		sounds = sound_leaves,

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = bldg.sapling_on_place(itemstack, placer, pointed_thing,
				"bldg_nodes:pine_sapling",
				-- minp, maxp to be checked, relative to sapling pos
				-- minp_relative.y = 1 because sapling pos has been checked
				{x = -2, y = 1, z = -2},
				{x = 2, y = 14, z = 2},
				-- maximum interval of interior volume check
				4)

			return itemstack
		end,
	},

	acacia_tree = {
		description = "Acacia Tree",
		tiles = {"default_acacia_tree_top.png", "default_acacia_tree_top.png",
			"default_acacia_tree.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {tree=1, snappy=3},
		sounds = sound_wood,

		on_place = minetest.rotate_node
	},
	acacia_wood = {
		description = "Acacia Wood Planks",
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"default_acacia_wood.png"},
		is_ground_content = false,
		groups = {snappy=3, wood = 1},
		sounds = sound_wood,
	},
	acacia_leaves = {
		description = "Acacia Tree Leaves",
		drawtype = "allfaces_optional",
		tiles = {"default_acacia_leaves.png"},
		special_tiles = {"default_acacia_leaves_simple.png"},
		waving = 1,
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3, leafdecay = 3, leaves = 1},
		sounds = sound_leaves,

		after_place_node = after_place_leaves,
	},
	acacia_sapling = {
		description = "Acacia Tree Sapling",
		drawtype = "plantlike",
		tiles = {"default_acacia_sapling.png"},
		inventory_image = "default_acacia_sapling.png",
		wield_image = "default_acacia_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = grow_sapling,
		selection_box = {
			type = "fixed",
			fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
		},
		groups = {snappy=3, attached_node=1, sapling=1},
		sounds = sound_leaves,

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = bldg.sapling_on_place(itemstack, placer, pointed_thing,
				"bldg_nodes:acacia_sapling",
				-- minp, maxp to be checked, relative to sapling pos
				-- minp_relative.y = 1 because sapling pos has been checked
				{x = -4, y = 1, z = -4},
				{x = 4, y = 7, z = 4},
				-- maximum interval of interior volume check
				4)

			return itemstack
		end,
	},

	aspen_tree = {
		description = "Aspen Tree",
		tiles = {
			"default_aspen_tree_top.png",
			"default_aspen_tree_top.png",
			"default_aspen_tree.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {tree=1},
		sounds = sound_wood,

		on_place = minetest.rotate_node
	},
	aspen_wood = {
		description = "Aspen Wood Planks",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		groups = {wood=1},
		sounds = sound_wood,
	},
	aspen_leaves = {
		description = "Aspen Tree Leaves",
		drawtype = "allfaces_optional",
		waving = 1,
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3, leafdecay = 3, leaves = 1},
		sounds = bldg_sounds.sound_leaves(),

		after_place_node = after_place_leaves,
	},
	aspen_sapling = {
		description = "Aspen Tree Sapling",
		drawtype = "plantlike",
		inventory_image = "default_aspen_sapling.png",
		wield_image = "default_aspen_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		on_timer = grow_sapling,
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}
		},
		groups = {attached_node=1, sapling=1},
		sounds = bldg_sounds.sound_leaves(),

		on_construct = function(pos)
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,

		on_place = function(itemstack, placer, pointed_thing)
			itemstack = bldg.sapling_on_place(itemstack, placer, pointed_thing,
				"bldg_nodes:aspen_sapling",
				-- minp, maxp to be checked, relative to sapling pos
				-- minp_relative.y = 1 because sapling pos has been checked
				{x = -2, y = 1, z = -2},
				{x = 2, y = 12, z = 2},
				-- maximum interval of interior volume check
				4)

			return itemstack
		end,
	},

	vessels_shelf = {
		description = "Vessels Shelf",
		tiles = {"default_wood.png", "default_wood.png", "default_wood.png",
			"default_wood.png", "vessels_shelf.png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		sounds = sound_wood,
	},

	--
	-- Ores
	--
	coal_ore = {
		description = "Coal Ore",
		tiles = {"default_stone.png^default_mineral_coal.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_coal",
	},
	coal_block = {
		description = "Coal Block",
		sounds = sound_stone,
		original_itemstring = "default:coalblock",
	},
	iron_ore = {
		description = "Iron Ore",
		tiles = {"default_stone.png^default_mineral_iron.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_iron",
	},
	steel_block = {
		description = "Steel Block",
		sounds = sound_metal,
		original_itemstring = "default:steelblock",
	},
	copper_ore = {
		description = "Copper Ore",
		tiles = {"default_stone.png^default_mineral_copper.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_copper",
	},
	copper_block = {
		description = "Copper Block",
		sounds = sound_metal,
		original_itemstring = "default:copperblock",
	},
	tin_ore = {
		description = "Tin Ore",
		tiles = {"default_stone.png^default_mineral_tin.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_tin",
	},
	tin_block = {
		description = "Tin Block",
		sounds = sound_metal,
		original_itemstring = "default:tinblock",
	},
	bronze_block = {
		description = "Bronze Block",
		sounds = sound_metal,
		original_itemstring = "default:bronzeblock",
	},
	mese_ore = {
		description = "Mese Ore",
		tiles = {"default_stone.png^default_mineral_mese.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_mese",
	},
	mese_block = {
		description = "Mese Block",
		sounds = sound_stone,
		original_itemstring = "default:mese",
	},
	gold_ore = {
		description = "Gold Ore",
		tiles = {"default_stone.png^default_mineral_gold.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_gold",
	},
	gold_block = {
		description = "Gold Block",
		sounds = sound_metal,
		original_itemstring = "default:goldblock",
	},
	diamond_ore = {
		description = "Diamond Ore",
		tiles = {"default_stone.png^default_mineral_diamond.png"},
		sounds = sound_stone,
		original_itemstring = "default:stone_with_diamond",
	},
	diamond_block = {
		description = "Diamond Block",
		sounds = sound_metal,
		original_itemstring = "default:diamondblock",
	},

	--
	-- Plantlife (non-cubic)
	--
	cactus = {
		description = "Cactus",
		tiles = {
			"default_cactus_top.png",
			"default_cactus_top.png",
			"default_cactus_side.png"},
		paramtype2 = "facedir",
		sounds = sound_wood,
		on_place = minetest.rotate_node,
	},
	papyrus = {
		description = "Papyrus",
		drawtype = "plantlike",
		inventory_image = "default_papyrus.png",
		wield_image = "default_papyrus.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		sounds = sound_leaves,

		after_dig_node = function(pos, node, metadata, digger)
			bldg.dig_up(pos, node, digger)
		end,
	},
	-- TODO: grasses in default_todo.lua
	bush_leaves = {
		description = "Bush Leaves",
		drawtype = "allfaces_optional",
		tiles = {"default_leaves_simple.png"},
		paramtype = "light",
		groups = {leaves=1},
		sounds = sound_leaves,
		after_place_node = after_place_leaves,
	},
	blueberry_bush_leaves_with_berries = {
		description = "Blueberry Bush Leaves with Berries",
		drawtype = "allfaces_optional",
		tiles = {"default_blueberry_bush_leaves.png^default_blueberry_overlay.png"},
		paramtype = "light",
		groups = {leaves=1},
		sounds = sound_leaves,
		node_dig_prediction = "bldg_nodes:blueberry_bush_leaves",

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			minetest.set_node(pos, {name = "bldg_nodes:blueberry_bush_leaves"})
			minetest.get_node_timer(pos):start(math.random(300, 1500))
		end,
	},
	blueberry_bush_leaves = {
		description = "Blueberry Bush Leaves",
		drawtype = "allfaces_optional",
		tiles = {"default_blueberry_bush_leaves.png"},
		paramtype = "light",
		groups = {leaves=1},
		sounds = sound_leaves,

		on_timer = function(pos, elapsed)
			if minetest.get_node_light(pos) < 11 then
				minetest.get_node_timer(pos):start(200)
			else
				minetest.set_node(pos, {name = "bldg_nodes:blueberry_bush_leaves_with_berries"})
			end
		end,

		after_place_node = after_place_leaves,
	},
	acacia_bush_leaves = {
		description = "Acacia Bush Leaves",
		drawtype = "allfaces_optional",
		tiles = {"default_acacia_leaves_simple.png"},
		paramtype = "light",
		groups = {leaves=1},
		sounds = sound_leaves,
		after_place_node = after_place_leaves,
	},
	pine_bush_needles = {
		description = "Pine Bush Needles",
		drawtype = "allfaces_optional",
		tiles = {"default_pine_needles.png"},
		paramtype = "light",
		groups = {leaves=1},
		sounds = sound_leaves,
		after_place_node = after_place_leaves,
	},
	-- TODO: kelp

	--
	-- Corals
	--
	coral_green = {
		description = "Green Coral",
		drawtype = "plantlike_rooted",
		waving = 1,
		paramtype = "light",
		tiles = {"default_coral_skeleton.png"},
		special_tiles = {"default_coral_green.png"},
		inventory_image = "default_coral_green.png",
		wield_image = "default_coral_green.png",
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
			},
		},
		node_dig_prediction = "bldg_nodes:coral_skeleton",
		node_placement_prediction = "",
		sounds = bldg_sounds.sound_stone({
			dig = {name = "default_dig_snappy", gain = 0.2},
			dug = {name = "default_grass_footstep", gain = 0.25},
		}),

		on_place = coral_on_place,

		after_destruct  = function(pos, oldnode)
			minetest.set_node(pos, {name = "bldg_nodes:coral_skeleton"})
		end,
	},

	coral_pink = {
		description = "Pink Coral",
		drawtype = "plantlike_rooted",
		waving = 1,
		paramtype = "light",
		tiles = {"default_coral_skeleton.png"},
		special_tiles = {name = "default_coral_pink.png"},
		inventory_image = "default_coral_pink.png",
		wield_image = "default_coral_pink.png",
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
			},
		},
		node_dig_prediction = "bldg_nodes:coral_skeleton",
		node_placement_prediction = "",
		sounds = bldg_sounds.sound_stone({
			dig = {name = "default_dig_snappy", gain = 0.2},
			dug = {name = "default_grass_footstep", gain = 0.25},
		}),

		on_place = coral_on_place,

		after_destruct  = function(pos, oldnode)
			minetest.set_node(pos, {name = "bldg_nodes:coral_skeleton"})
		end,
	},

	coral_cyan = {
		description = "Cyan Coral",
		drawtype = "plantlike_rooted",
		waving = 1,
		paramtype = "light",
		tiles = {"default_coral_skeleton.png"},
		special_tiles = {"default_coral_cyan.png"},
		inventory_image = "default_coral_cyan.png",
		wield_image = "default_coral_cyan.png",
		groups = {snappy=3},
		selection_box = {
			type = "fixed",
			fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{-4/16, 0.5, -4/16, 4/16, 1.5, 4/16},
			},
		},
		node_dig_prediction = "bldg_nodes:coral_skeleton",
		node_placement_prediction = "",
		sounds = bldg_sounds.sound_stone({
			dig = {name = "default_dig_snappy", gain = 0.2},
			dug = {name = "default_grass_footstep", gain = 0.25},
		}),

		on_place = coral_on_place,

		after_destruct  = function(pos, oldnode)
			minetest.set_node(pos, {name = "bldg_nodes:coral_skeleton"})
		end,
	},

	coral_brown = {
		description = "Brown Coral",
		sounds = sound_stone,
	},
	coral_orange = {
		description = "Orange Coral",
		sounds = sound_stone,
	},
	coral_skeleton = {
		description = "Coral Skeleton",
		sounds = sound_stone,
	},

	--
	-- Misc nodes
	--
	bookshelf = {
		description = "Bookshelf",
		tiles = {
			"default_wood.png", "default_wood.png", "default_wood.png",
			"default_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
		paramtype2 = "facedir",
		sounds = sound_wood,
	},

	ladder_wood = {
		description = "Wooden Ladder",
		drawtype = "signlike",
		inventory_image = "default_ladder_wood.png",
		wield_image = "default_ladder_wood.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		climbable = true,
		is_ground_content = false,
		selection_box = {
			type = "wallmounted"
		},
		sounds = sound_wood,
	},
	ladder_steel = {
		description = "Steel Ladder",
		drawtype = "signlike",
		inventory_image = "default_ladder_steel.png",
		wield_image = "default_ladder_steel.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = false,
		climbable = true,
		is_ground_content = false,
		selection_box = {
			type = "wallmounted"
		},
		sounds = sound_metal,
	},

	glass = {
		description = "Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png", "default_glass_detail.png"},
		use_texture_alpha = "clip", -- only needed for stairs API
		paramtype = "light",
		paramtype2 = "glasslikeliquidlevel",
		sunlight_propagates = true,
		is_ground_content = false,
		sounds = sound_glass,
	},
	brick = {
		description = "Brick Block",
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {
			"default_brick.png^[transformFX",
			"default_brick.png"},
		is_ground_content = false,
		sounds = sound_stone,
	},
	meselamp = {
		description = "Mese Lamp",
		drawtype = "glasslike",
		tiles = {"default_meselamp.png"},
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		sounds = sound_glass,
		light_source = minetest.LIGHT_MAX,
	}
}

for name, def in pairs(nodes) do
	def.tiles = def.tiles or {"default_"..name..".png"}

	if not def.groups then def.groups = {} end
	def.groups.snappy = 3

	minetest.register_node("bldg_nodes:"..name, def)

	local original_itemstring = "default:"..name
	if def.original_itemstring then
		original_itemstring = def.original_itemstring
	end

	minetest.register_alias(original_itemstring, "bldg_nodes:"..name)
end
