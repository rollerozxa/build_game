
local dyes = {
	{"white",      "White",		"DCDCDC"},
	{"grey",       "Grey",		"838383"},
	{"dark_grey",  "Dark Grey",	"3B3B3B"},
	{"black",      "Black",		"1D1D1D"},
	{"violet",     "Violet",	"5D03A9"},
	{"blue",       "Blue",		"004891"},
	{"cyan",       "Cyan",		"00838B"},
	{"dark_green", "Dark Green","206700"},
	{"green",      "Green",		"42AB0C"},
	{"yellow",     "Yellow",	"FEE110"},
	{"brown",      "Brown",		"562B00"},
	{"orange",     "Orange",	"D65215"},
	{"red",        "Red",		"800404"},
	{"magenta",    "Magenta",	"C9036D"},
	{"pink",       "Pink",		"FF8484"},
}

local nodes = {
	brick = {
		description = "Brick Block",
		tiles = {"unifiedbricks_brickblock.png"},
		overlay_tiles = {"unifiedbricks_mortar.png"},
		sounds = bldg_sounds.sound_stone(),
	},
	clay = {
		description = "Clay Block",
		tiles = {"unifiedbricks_clayblock.png"},
		sounds = bldg_sounds.sound_dirt(),
	},
	brick_multicolor_dark = {
		description = "Brick Block (dark multicolor)",
		tiles = {"unifiedbricks_brickblock_multicolor_dark.png"},
		overlay_tiles = {"unifiedbricks_mortar.png"},
		sounds = bldg_sounds.sound_stone(),
	},
	brick_multicolor_medium = {
		description = "Brick Block (medium multicolor)",
		tiles = {"unifiedbricks_brickblock_multicolor_medium.png"},
		overlay_tiles = {"unifiedbricks_mortar.png"},
		sounds = bldg_sounds.sound_stone(),
	},
	brick_multicolor_light = {
		description = "Brick Block (light multicolor)",
		tiles = {"unifiedbricks_brickblock_multicolor_light.png"},
		overlay_tiles = {"unifiedbricks_mortar.png"},
		sounds = bldg_sounds.sound_stone(),
	}
}

for name, def in pairs(nodes) do
	if not def.groups then def.groups = {} end
	def.groups.snappy = 3

	local compressions = {}

	for _, colour in pairs(dyes) do
		local ndef = table.copy(def)

		local cl_id = colour[1]
		local cl_name = colour[2]
		local cl_colour = colour[3]

		local name2 = name.."_"..cl_id
		ndef.description = cl_name.." "..ndef.description
		ndef.tiles[1] = ndef.tiles[1].."^[multiply:#"..cl_colour

		local itemstring = "bldg_nodes:"..name2
		minetest.register_node(itemstring, ndef)

		if cl_id ~= "red" then
			table.insert(compressions, itemstring)
		end
	end

	i3.compress("bldg_nodes:"..name.."_red", {
		replace = "bldg_nodes:"..name.."_red",
		by = compressions
	})
end
