-- The Build Game Core. Huzzah.

-- global build game namespace
bldg = {}


minetest.override_item("", {
	wield_scale = { x = 1, y = 1, z = 2.5 },
	tool_capabilities = {
		max_drop_level = 0,
		groupcaps = {}
	}
})

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
