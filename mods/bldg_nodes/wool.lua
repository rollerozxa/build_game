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
	local nodename = "bldg_nodes:wool_" .. name

	minetest.register_node(nodename, {
		description = desc .. " Wool",
		tiles = {"wool_" .. name .. ".png"},
		groups = {snappy=3, wool=1},
		sounds = bldg_sounds.sound(),
	})

	minetest.register_alias("wool:"..name, "bldg_nodes:wool_"..name)

	local ndef = table.copy(minetest.registered_nodes[nodename])
	ndef.sunlight_propagates = true

	stairsplus:register_all("bldg_stairsplus", "wool_"..name, nodename, ndef)

	stairsplus:register_alias_all("wool", name, "bldg_stairsplus", "wool_"..name)
end
