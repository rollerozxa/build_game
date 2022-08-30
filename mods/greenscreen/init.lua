
local greenscreen = {
	compress_colours = {},
	-- Different colours (itemstring,description)
	colours = {
		white	= "#FFF",
		grey	= "#888",
		black	= "#000",
		red		= "#F00",
		orange	= "#F80",
		yellow	= "#FF0",
		green	= "#0F0",
		cyan	= "#0FF",
		blue	= "#00F",
		purple 	= "#F0F",
	}
}

for name, colour in pairs(greenscreen.colours) do
	if name ~= "green" then
		table.insert(greenscreen.compress_colours, "greenscreen:"..name.."screen")
	end

	minetest.register_node("greenscreen:"..name.."screen", {
		description = name:sub(1,1):upper()..name:sub(2).." screen ("..colour..")",
		tiles = { "^[resize:8x8^[colorize:"..colour..":255" },
		light_source = minetest.LIGHT_MAX,
		groups = { snappy=3, dig_immediate=3, oddly_breakable_by_hand=3 },
		sounds = bldg_sounds.sound_stone(),
	})
end

i3.compress("greenscreen:greenscreen", {
	replace = "greenscreen:greenscreen",
	by = greenscreen.compress_colours
})
