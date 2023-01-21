--[[
More Blocks: slope definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Node will be called <modname>:slope_<subname>

function stairsplus:register_slope_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":slope_" .. subname_old .. alternate, modname_new .. ":slope_" .. subname_new .. alternate)
	end
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["slope"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("slope", alternate, def, modname, subname, recipeitem, fields)
	end
end
