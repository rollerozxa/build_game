--[[
More Blocks: stair definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Node will be called <modname>:stair_<subname>

function stairsplus:register_stair_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":stair_" .. subname_old .. alternate, modname_new .. ":stair_" .. subname_new .. alternate)
	end
end

function stairsplus:register_stair(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["stair"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("stair", alternate, def, modname, subname, recipeitem, fields)
	end
end
