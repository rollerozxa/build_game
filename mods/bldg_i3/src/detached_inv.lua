local set_fs = i3.set_fs
local fmt, play_sound = i3.get("fmt", "play_sound")

local trash = minetest.create_detached_inventory("i3_trash", {
	allow_put = function(_, _, _, stack)
		return stack:get_count()
	end,

	on_put = function(inv, listname, _, _, player)
		inv:set_list(listname, {})

		local name = player:get_player_name()
		play_sound(name, "i3_trash", 1.0)

		if not minetest.is_creative_enabled(name) then
			set_fs(player)
		end
	end,
})

trash:set_size("main", 1)

return init_detached
