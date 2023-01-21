-- The Build Game Core. Huzzah.

-- global build game namespace
bldg = {}

minetest.register_craftitem(":", {
	wield_image = "wieldhand.png",
	wield_scale = { x = 1, y = 1, z = 2.5 },
	tool_capabilities = {
		max_drop_level = 0,
		groupcaps = {}
	},
	on_place = function(itemstack, placer, pointed_thing)
		if minetest.is_creative_enabled(placer:get_player_name()) then
			local pointed_node = minetest.get_node(pointed_thing.under)
			return pointed_node
		end
	end
})

-- GUI related stuff
minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
	player:set_formspec_prepend([[
		bgcolor[#080808BB;true]
		listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]
		background9[5,5;1,1;i3_bg_full.png;true;10]
	]])
end)

dofile(minetest.get_modpath('bldg_core').."/creative.lua")
