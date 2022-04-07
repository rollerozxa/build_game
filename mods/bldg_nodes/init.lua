
minetest.register_node("bldg_nodes:wired_fence", {
	description = "Wired fence",
	tiles = {
		"bldg_nodes_wired_fence.png",
		"bldg_nodes_wired_fence.png",
		"blank.png", "blank.png",
		"bldg_nodes_wired_fence.png^[transformFX",
		"bldg_nodes_wired_fence.png"},
	use_texture_alpha = "clip",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.437500, 0.5, 0.5, 0.5},
		}
	},
	groups = {snappy=3},
	sounds = bldg_sounds.sound_stone(),
})

include("default")
include("default_fences")
include("default_mesepost")
include("default_signs")
include("default_todo")
include("default_moreblocks")
include("wool")
