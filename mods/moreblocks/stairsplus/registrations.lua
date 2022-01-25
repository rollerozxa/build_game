--[[
More Blocks: registrations

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- default registrations
local default_nodes = { -- Default stairs/slabs/panels/microblocks:
	"stone",
	"stone_block",
	"cobble",
	"mossycobble",
	"brick",
	"sandstone",
	"steelblock",
	"goldblock",
	"copperblock",
	"bronzeblock",
	"diamondblock",
	"tinblock",
	"desert_stone",
	"desert_stone_block",
	"desert_cobble",
	"meselamp",
	"glass",
	"tree",
	"wood",
	"pine_tree",
	"pine_wood",
	"acacia_tree",
	"acacia_wood",
	"aspen_tree",
	"aspen_wood",
	"obsidian",
	"obsidian_block",
	"obsidianbrick",
	"stonebrick",
	"desert_stonebrick",
	"sandstonebrick",
	"silver_sandstone",
	"silver_sandstone_brick",
	"silver_sandstone_block",
	"desert_sandstone",
	"desert_sandstone_brick",
	"desert_sandstone_block",
	"sandstone_block",
	"coral_skeleton",
	"ice",
}

for _, name in pairs(default_nodes) do
	local mod = "default"
	local nodename = mod .. ":" .. name
	local ndef = table.copy(minetest.registered_nodes[nodename])
	ndef.sunlight_propagates = true

	-- Stone and desert_stone drop cobble and desert_cobble respectively.
	if type(ndef.drop) == "string" then
		ndef.drop = ndef.drop:gsub(".+:", "")
	end

	-- Use the primary tile for all sides of cut glasslike nodes and disregard paramtype2.
	if #ndef.tiles > 1 and ndef.drawtype and ndef.drawtype:find("glass") then
		ndef.tiles = {ndef.tiles[1]}
		ndef.paramtype2 = nil
	end

	mod = "moreblocks"
	stairsplus:register_all(mod, name, nodename, ndef)
end

-- wool registrations
if minetest.get_modpath("wool") then
	local dyes = {"white", "grey", "black", "red", "yellow", "green", "cyan",
	              "blue", "magenta", "orange", "violet", "brown", "pink",
	              "dark_grey", "dark_green"}
	for _, name in pairs(dyes) do
		local mod = "wool"
		local nodename = mod .. ":" .. name
		local ndef = table.copy(minetest.registered_nodes[nodename])
		ndef.sunlight_propagates = true

		stairsplus:register_all(mod, name, nodename, ndef)
	end
end

-- Alias cuts of split_stone_tile_alt which was renamed checker_stone_tile.
stairsplus:register_alias_all("moreblocks", "split_stone_tile_alt", "moreblocks", "checker_stone_tile")

-- The following LBM is necessary because the name stair_split_stone_tile_alt
-- conflicts with another node and so the alias for that specific node gets
-- ignored.
minetest.register_lbm({
	name = "moreblocks:fix_split_stone_tile_alt_name_collision",
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
