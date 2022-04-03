
local dyes = {
	{"white",      "White"},
	{"grey",       "Grey"},
	{"dark_grey",  "Dark Grey"},
	{"black",      "Black"},
	{"violet",     "Violet"},
	{"blue",       "Blue"},
	{"cyan",       "Cyan"},
	{"dark_green", "Dark Green"},
	{"green",      "Green"},
	{"yellow",     "Yellow"},
	{"brown",      "Brown"},
	{"orange",     "Orange"},
	{"red",        "Red"},
	{"magenta",    "Magenta"},
	{"pink",       "Pink"},
}

for i = 1, #dyes do
	local name, desc = unpack(dyes[i])

	minetest.register_node("wool:" .. name, {
		description = desc .. " Wool",
		tiles = {"wool_" .. name .. ".png"},
		is_ground_content = false,
		groups = {snappy=3, wool=1},
		sounds = bldg_sounds.sound(),
	})
end
