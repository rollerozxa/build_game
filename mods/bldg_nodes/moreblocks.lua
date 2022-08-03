
local sound_wood = bldg_sounds.sound_wood()
local sound_stone = bldg_sounds.sound_stone()
local sound_glass = bldg_sounds.sound_glass()
local sound_leaves = bldg_sounds.sound_leaves()
local sound_metal = bldg_sounds.sound_metal()

local function tile_tiles(name)
	local tex = "moreblocks_" ..name.. ".png"
	return {tex, tex, tex, tex, tex.. "^[transformR90", tex.. "^[transformR90"}
end

local nodes = {
	wood_tile = {
		description = "Wooden Tile",
		groups = {wood = 1},
		is_ground_content = false,
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90",
		"default_wood.png^moreblocks_wood_tile.png^[transformR90"},
		sounds = sound_wood,
	},
	wood_tile_center = {
		description = "Centered Wooden Tile",
		groups = {wood = 1},
		is_ground_content = false,
		tiles = {"default_wood.png^moreblocks_wood_tile_center.png"},
		sounds = sound_wood,
	},
	wood_tile_full = {
		description = "Full Wooden Tile",
		groups = {wood = 1},
		is_ground_content = false,
		tiles = tile_tiles("wood_tile_full"),
		sounds = sound_wood,
	},
	wood_tile_offset = {
		description = "Offset Wooden Tile",
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {wood = 1},
		is_ground_content = false,
		tiles = {"default_wood.png^moreblocks_wood_tile_offset.png"},
		sounds = sound_wood,
		no_stairs = true,
	},
	circle_stone_bricks = {
		description = "Circle Stone Bricks",
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	grey_bricks = {
		description = "Stone Bricks",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
	},
	coal_stone_bricks = {
		description = "Coal Stone Bricks",
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	iron_stone_bricks = {
		description = "Iron Stone Bricks",
		paramtype2 = "facedir",
		place_param2 = 0,
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	stone_tile = {
		description = "Stone Tile",
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	split_stone_tile = {
		description = "Split Stone Tile",
		paramtype2 = "facedir",
		place_param2 = 0,
		tiles = {"moreblocks_split_stone_tile_top.png",
			"moreblocks_split_stone_tile.png"},
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	checker_stone_tile = {
		description = "Checker Stone Tile",
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	tar = {
		description = "Tar",
		is_ground_content = false,
		sounds = sound_stone,
	},
	plankstone = {
		description = "Plankstone",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		tiles = tile_tiles("plankstone"),
		sounds = sound_stone,
	},
	iron_glass = {
		description = "Iron Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#DEDEDE", "default_glass_detail.png^[colorize:#DEDEDE"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		sounds = sound_glass,
	},
	coal_glass = {
		description = "Coal Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#828282", "default_glass_detail.png^[colorize:#828282"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		sounds = sound_glass,
	},
	clean_glass = {
		description = "Clean Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"moreblocks_clean_glass.png", "moreblocks_clean_glass_detail.png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		sounds = sound_glass,
	},
	cactus_brick = {
		description = "Cactus Brick",
		paramtype2 = "facedir",
		place_param2 = 0,
		is_ground_content = false,
		sounds = sound_stone,
	},
	cactus_checker = {
		description = "Cactus Checker",
		groups = {stone = 1},
		is_ground_content = false,
		tiles = {"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png",
		"default_stone.png^moreblocks_cactus_checker.png^[transformR90",
		"default_stone.png^moreblocks_cactus_checker.png^[transformR90"},
		sounds = sound_stone,
	},
	empty_shelf = {
		description = "Empty Shelf",
		paramtype2 = "facedir",
		tiles = {"default_wood.png", "default_wood.png", "default_wood.png",
		"default_wood.png", "moreblocks_empty_shelf.png", "moreblocks_empty_shelf.png"},
		is_ground_content = false,
		sounds = sound_wood,
		furnace_burntime = 15,
		no_stairs = true,
	},
	coal_stone = {
		description = "Coal Stone",
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	iron_stone = {
		description = "Iron Stone",
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	coal_checker = {
		description = "Coal Checker",
		tiles = {"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png",
		"default_stone.png^moreblocks_coal_checker.png^[transformR90",
		"default_stone.png^moreblocks_coal_checker.png^[transformR90"},
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	iron_checker = {
		description = "Iron Checker",
		tiles = {"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png",
		"default_stone.png^moreblocks_iron_checker.png^[transformR90",
		"default_stone.png^moreblocks_iron_checker.png^[transformR90"},
		groups = {stone = 1},
		is_ground_content = false,
		sounds = sound_stone,
	},
	all_faces_tree = {
		description = "All-faces Tree",
		tiles = {"default_tree_top.png"},
		groups = {tree = 1},
		sounds = sound_wood,
	},
	all_faces_pine_tree = {
		description = "All-faces Pine Tree",
		tiles = {"default_pine_tree_top.png"},
		groups = {tree = 1},
		sounds = sound_wood,
	},
	all_faces_acacia_tree = {
		description = "All-faces Acacia Tree",
		tiles = {"default_acacia_tree_top.png"},
		groups = {tree = 1},
		sounds = sound_wood,
	},
	all_faces_aspen_tree = {
		description = "All-faces Aspen Tree",
		tiles = {"default_aspen_tree_top.png"},
		groups = {tree = 1},
		sounds = sound_wood,
	},
	glow_glass = {
		description = "Glow Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#E9CD61", "default_glass_detail.png^[colorize:#E9CD61"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = 11,
		sounds = sound_glass,
	},
	clean_glow_glass = {
		description = "Clean Glow Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"moreblocks_clean_glass.png^[colorize:#E9CD61", "moreblocks_clean_glass_detail.png^[colorize:#E9CD61"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = 11,
		sounds = sound_glass,
	},
	super_glow_glass = {
		description = "Super Glow Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"default_glass.png^[colorize:#FFFF78", "default_glass_detail.png^[colorize:#FFFF78"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = minetest.LIGHT_MAX,
		sounds = sound_glass,
	},
	clean_super_glow_glass = {
		description = "Clean Super Glow Glass",
		drawtype = "glasslike_framed_optional",
		tiles = {"moreblocks_clean_glass.png^[colorize:#FFFF78", "moreblocks_clean_glass_detail.png^[colorize:#FFFF78"},
		use_texture_alpha = "clip",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		light_source = minetest.LIGHT_MAX,
		sounds = sound_glass,
	},
	rope = {
		description = "Rope",
		drawtype = "signlike",
		inventory_image = "moreblocks_rope.png",
		wield_image = "moreblocks_rope.png",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = false,
		paramtype2 = "wallmounted",
		walkable = false,
		climbable = true,
		selection_box = {type = "wallmounted"},
		sounds = sound_leaves,
		no_stairs = true,
	},
	copperpatina = {
		description = "Copper Patina Block",
		is_ground_content = false,
		sounds = sound_metal,
	},
}

for name, def in pairs(nodes) do
	def.tiles = def.tiles or {"moreblocks_" ..name.. ".png"}

	if not def.groups then def.groups = {} end
	def.groups.snappy = 3

	minetest.register_node("bldg_nodes:" ..name, def)

	def_copy = table.copy(def)

	-- Use the primary tile for all sides of cut glasslike nodes.
	-- This makes them easier to see
	if
		#def_copy.tiles > 1 and
		def_copy.drawtype and
		def_copy.drawtype == "glasslike_framed" or
		def_copy.drawtype == "glasslike_framed_optional"
	then
		def.tiles = {def_copy.tiles[1]}
		def.use_texture_alpha = "clip"
	else
		def.use_texture_alpha = "opaque"
	end

	if not def.no_stairs then
		local groups = {}
		for k, v in pairs(def.groups) do groups[k] = v end
		stairsplus:register_all("bldg_stairsplus", name, "moreblocks:" ..name, {
			description = def.description,
			groups = groups,
			tiles = def.tiles,
			sunlight_propagates = def.sunlight_propagates,
			light_source = def.light_source,
			use_texture_alpha = def.use_texture_alpha,
			sounds = def.sounds,
		})
		stairsplus:register_alias_all("moreblocks", name, "bldg_stairsplus", name)
	end
end
