
local function register_wall(node_name, wall_name)
	local def = minetest.registered_nodes[node_name]

	minetest.register_node(":"..wall_name, {
		description = def.description.." Wall",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			connect_front = {-3/16, -1/2, -1/2,  3/16, 3/8, -1/4},
			connect_left = {-1/2, -1/2, -3/16, -1/4, 3/8,  3/16},
			connect_back = {-3/16, -1/2,  1/4,  3/16, 3/8,  1/2},
			connect_right = { 1/4, -1/2, -3/16,  1/2, 3/8,  3/16},
		},
		collision_box = {
			type = "connected",
			fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
			connect_front = {-1/4,-1/2,-1/2,1/4,1/2,-1/4},
			connect_left = {-1/2,-1/2,-1/4,-1/4,1/2,1/4},
			connect_back = {-1/4,-1/2,1/4,1/4,1/2,1/2},
			connect_right = {1/4,-1/2,-1/4,1/2,1/2,1/4},
		},
		connects_to = { "group:wall", "group:stone", "group:fence" },
		paramtype = "light",
		is_ground_content = false,
		tiles = def.tiles,
		walkable = true,
		groups = {snappy=3, wall=1, stone=2},
		sounds = def.sounds,
	})
end

register_wall("bldg_nodes:brick", "walls:brick")

register_wall("bldg_nodes:cobble", "walls:cobble")
register_wall("bldg_nodes:mossycobble", "walls:mossycobble")
register_wall("bldg_nodes:desert_cobble", "walls:desertcobble")

register_wall("bldg_nodes:sandstone", "walls:sandstone")
register_wall("bldg_nodes:sandstone_brick", "walls:sandstone_brick")
register_wall("bldg_nodes:sandstone_block", "walls:sandstone_block")

register_wall("bldg_nodes:stone", "walls:stone")
register_wall("bldg_nodes:stone_brick", "walls:stone_brick")
register_wall("bldg_nodes:stone_block", "walls:stone_block")

register_wall("bldg_nodes:desert_stone", "walls:desert_stone")
register_wall("bldg_nodes:desert_stone_brick", "walls:desert_stone_brick")
register_wall("bldg_nodes:desert_stone_block", "walls:desert_stone_block")

register_wall("bldg_nodes:desert_sandstone", "walls:desert_sandstone")
register_wall("bldg_nodes:desert_sandstone_brick", "walls:desert_sandstone_brick")
register_wall("bldg_nodes:desert_sandstone_block", "walls:desert_sandstone_block")

register_wall("bldg_nodes:silver_sandstone", "walls:silver_sandstone")
register_wall("bldg_nodes:silver_sandstone_brick", "walls:silver_sandstone_brick")
register_wall("bldg_nodes:silver_sandstone_block", "walls:silver_sandstone_block")

register_wall("bldg_nodes:obsidian", "walls:obsidian")
register_wall("bldg_nodes:obsidian_brick", "walls:obsidian_brick")
register_wall("bldg_nodes:obsidian_block", "walls:obsidian_block")
