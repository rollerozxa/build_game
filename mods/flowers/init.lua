flowers = {}

local S = minetest.get_translator("flowers")

-- Map Generation
include("mapgen")

--
-- Flowers
--

-- Flower registration

local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy=3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1

	minetest.register_node("flowers:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = "flowers_" .. name .. ".png",
		wield_image = "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = f_groups,
		sounds = default.sound_leaves(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end

flowers.datas = {
	{
		"rose",
		S("Red Rose"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
		{color_red = 1}
	}, {
		"tulip",
		S("Orange Tulip"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
		{color_orange = 1}
	}, {
		"dandelion_yellow",
		S("Yellow Dandelion"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16},
		{color_yellow = 1}
	}, {
		"chrysanthemum_green",
		S("Green Chrysanthemum"),
		{-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
		{color_green = 1}
	}, {
		"geranium",
		S("Blue Geranium"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16},
		{color_blue = 1}
	}, {
		"viola",
		S("Viola"),
		{-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16},
		{color_violet = 1}
	}, {
		"dandelion_white",
		S("White Dandelion"),
		{-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16},
		{color_white = 1}
	}, {
		"tulip_black",
		S("Black Tulip"),
		{-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
		{color_black = 1}
	},
}

for _,item in pairs(flowers.datas) do
	add_simple_flower(unpack(item))
end


--
-- Mushrooms
--

minetest.register_node("flowers:mushroom_red", {
	description = S("Red Mushroom"),
	tiles = {"flowers_mushroom_red.png"},
	inventory_image = "flowers_mushroom_red.png",
	wield_image = "flowers_mushroom_red.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {mushroom = 1, snappy=3, attached_node = 1},
	sounds = default.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16},
	}
})

minetest.register_node("flowers:mushroom_brown", {
	description = S("Brown Mushroom"),
	tiles = {"flowers_mushroom_brown.png"},
	inventory_image = "flowers_mushroom_brown.png",
	wield_image = "flowers_mushroom_brown.png",
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {mushroom=1, food_mushroom=1, snappy=3, attached_node=1},
	sounds = default.sound_leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
})
