--[[
More Blocks: alias definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Old block/item replacement:
minetest.register_alias("moreblocks:oerkkiblock", "default:mossycobble")
minetest.register_alias("moreblocks:screwdriver", "screwdriver:screwdriver")

-- Node and item renaming:
minetest.register_alias("moreblocks:stone_bricks", "default:stonebrick")
minetest.register_alias("moreblocks:stonebrick", "default:stonebrick")

minetest.register_alias("moreblocks:horizontaltree", "moreblocks:horizontal_tree")
minetest.register_alias("moreblocks:stonesquare", "moreblocks:stone_tile")
minetest.register_alias("moreblocks:circlestonebrick", "moreblocks:circle_stone_bricks")
minetest.register_alias("moreblocks:ironstonebrick", "moreblocks:iron_stone_bricks")
minetest.register_alias("moreblocks:coalstone", "moreblocks:coal_stone")
minetest.register_alias("moreblocks:ironstone", "moreblocks:iron_stone")
minetest.register_alias("moreblocks:woodtile", "moreblocks:wood_tile")
minetest.register_alias("moreblocks:woodtile_full", "moreblocks:wood_tile_full")
minetest.register_alias("moreblocks:woodtile_centered", "moreblocks:wood_tile_centered")
minetest.register_alias("moreblocks:woodtile_up", "moreblocks:wood_tile_offset")
minetest.register_alias("moreblocks:wood_tile_up", "moreblocks:wood_tile_offset")
minetest.register_alias("moreblocks:woodtile_down", "moreblocks:wood_tile_down")
minetest.register_alias("moreblocks:woodtile_left", "moreblocks:wood_tile_left")
minetest.register_alias("moreblocks:woodtile_right", "moreblocks:wood_tile_right")
minetest.register_alias("moreblocks:coalglass", "moreblocks:coal_glass")
minetest.register_alias("moreblocks:ironglass", "moreblocks:iron_glass")
minetest.register_alias("moreblocks:glowglass", "moreblocks:glow_glass")
minetest.register_alias("moreblocks:superglowglass", "moreblocks:super_glow_glass")
minetest.register_alias("moreblocks:trapglass", "moreblocks:trap_glass")
minetest.register_alias("moreblocks:trapstone", "moreblocks:trap_stone")
minetest.register_alias("moreblocks:cactuschecker", "moreblocks:cactus_checker")
minetest.register_alias("moreblocks:coalchecker", "moreblocks:coal_checker")
minetest.register_alias("moreblocks:ironchecker", "moreblocks:iron_checker")
minetest.register_alias("moreblocks:cactusbrick", "moreblocks:cactus_brick")
minetest.register_alias("moreblocks:cleanglass", "moreblocks:clean_glass")
minetest.register_alias("moreblocks:emptybookshelf", "moreblocks:empty_bookshelf")
minetest.register_alias("moreblocks:splitstonesquare","moreblocks:split_stone_tile")
minetest.register_alias("moreblocks:allfacestree","moreblocks:all_faces_tree")
minetest.register_alias("moreblocks:empty_bookshelf","moreblocks:empty_shelf")
minetest.register_alias("moreblocks:split_stone_tile_alt","moreblocks:checker_stone_tile")

-- ABM for horizontal trees (fix facedir):
local horizontal_tree_convert_facedir = {7, 12, 9, 18}

minetest.register_abm({
	nodenames = {"moreblocks:horizontal_tree","moreblocks:horizontal_jungle_tree"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		if node.name == "moreblocks:horizontal_tree" then
			node.name = "default:tree"
		else
			node.name = "default:jungletree"
		end
		node.param2 = node.param2 < 3 and node.param2 or 0
		minetest.set_node(pos, {
			name = node.name,
			param2 = horizontal_tree_convert_facedir[node.param2 + 1]
		})
	end,
})
