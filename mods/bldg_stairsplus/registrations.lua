--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- The following LBM is necessary because the name stair_split_stone_tile_alt
-- conflicts with another node and so the alias for that specific node gets
-- ignored.
minetest.register_lbm({
	name = "bldg_stairsplus:fix_split_stone_tile_alt_name_collision",
	nodenames = {"moreblocks:stair_split_stone_tile_alt"},
	action = function(pos, node)
		minetest.set_node(pos, {
			name = "moreblocks:stair_checker_stone_tile",
			param2 = minetest.get_node(pos).param2

		})
		minetest.log('action', "LBM replaced " .. node.name ..
			" at " .. minetest.pos_to_string(pos))
	end,
})
