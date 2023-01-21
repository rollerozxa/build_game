
bldg = {}

-- Less verbose file include function taken from NodeCore
-- https://gitlab.com/sztest/nodecore/-/blob/master/mods/nc_api/init.lua
local include = rawget(_G, "include") or function(...)
	local parts = {...}
	table.insert(parts, 1, minetest.get_modpath(minetest.get_current_modname()))
	if parts[#parts]:sub(-4) ~= ".lua" then
		parts[#parts] = parts[#parts] .. ".lua"
	end
	return dofile(table.concat(parts, "/"))
end
rawset(_G, "include", include)

include('conf')
include('leafdecay')
include('node')

--
-- Dig upwards
--

function bldg.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end
