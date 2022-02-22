
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

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/functions.lua")
dofile(default_path.."/trees.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/torch.lua")
dofile(default_path.."/mapgen.lua")
dofile(default_path.."/aliases.lua")
