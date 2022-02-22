
-- Load support for MT game translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14
default.get_translator = S

-- GUI related stuff
minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
	local formspec = [[
			bgcolor[#080808BB;true]
			listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF] ]]
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;i3_bg_full.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;i3_bg_full.png;true]"
	end
	player:set_formspec_prepend(formspec)
end)

minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 2.5 },
	tool_capabilities = {
		max_drop_level = 0,
		groupcaps = {}
	}
})

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

-- Load files
include("functions")
include("trees")
include("nodes")
include("torch")
include("mapgen")
include("aliases")
