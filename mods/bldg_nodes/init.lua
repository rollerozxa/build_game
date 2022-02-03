
minetest.register_node("bldg_nodes:wired_fence", {
	description = "Wired fence",
	tiles = {"bldg_nodes_wired_fence.png"},
	use_texture_alpha = "clip",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.437500, 0.5, 0.5, 0.5}, -- NodeBox1
		}
	},
	groups = {snappy=3},
	sounds = default.sound_stone(),
})
