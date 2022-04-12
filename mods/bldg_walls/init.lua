
function register_wall(node_name, wall_name)
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

register_wall("bldg_nodes:cobble", "walls:cobble")

register_wall("bldg_nodes:mossycobble", "walls:mossycobble")

register_wall("bldg_nodes:desert_cobble", "walls:desertcobble")
