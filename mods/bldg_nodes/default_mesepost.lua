--
-- Mese post registration helper
--

function register_mesepost(name, def)
	local post_texture = def.texture .. "^default_mese_post_light_side.png^[makealpha:0,0,0"
	local post_texture_dark = def.texture .. "^default_mese_post_light_side_dark.png^[makealpha:0,0,0"
	-- Allow almost everything to be overridden
	local default_fields = {
		wield_image = post_texture,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-2 / 16, -8 / 16, -2 / 16, 2 / 16, 8 / 16, 2 / 16},
			},
		},
		paramtype = "light",
		tiles = {def.texture, def.texture, post_texture_dark, post_texture_dark, post_texture, post_texture},
		use_texture_alpha = "opaque",
		light_source = minetest.LIGHT_MAX,
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {snappy=3},
		sounds = bldg_sounds.sound_wood(),
	}
	for k, v in pairs(default_fields) do
		if def[k] == nil then
			def[k] = v
		end
	end

	def.texture = nil

	minetest.register_node("bldg_nodes:"..name, def)
	if do_compat then
		minetest.register_alias("default:"..name, "bldg_nodes:"..name)
	end
end

register_mesepost("mese_post_light", {
	description = "Apple Wood Mese Post Light",
	texture = "default_fence_wood.png"
})

register_mesepost("mese_post_light_acacia_wood", {
	description = "Acacia Wood Mese Post Light",
	texture = "default_fence_acacia_wood.png"
})

register_mesepost("mese_post_light_pine_wood", {
	description = "Pine Wood Mese Post Light",
	texture = "default_fence_pine_wood.png"
})

register_mesepost("mese_post_light_aspen_wood", {
	description = "Aspen Wood Mese Post Light",
	texture = "default_fence_aspen_wood.png"
})
