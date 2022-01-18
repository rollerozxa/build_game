-- mods/default/tools.lua

-- The hand
-- Override the hand item registered in the engine in builtin/game/register.lua
minetest.override_item("", {
	wield_scale = {x=1,y=1,z=2.5},
	tool_capabilities = {
		max_drop_level = 0,
		groupcaps = {}
	}
})
