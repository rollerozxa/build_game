
local nodes = {
	rose = {
		description = "Red Rose",
		selbox = {-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16}
	},
	tulip = {
		description = "Orange Tulip",
		selbox = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16}
	},
	dandelion_yellow = {
		description = "Yellow Dandelion",
		selbox = {-4 / 16, -0.5, -4 / 16, 4 / 16, -2 / 16, 4 / 16}
	},
	chrysanthemum_green = {
		description = "Green Chrysanthemum",
		selbox = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}
	},
	geranium = {
		description = "Blue Geranium",
		selbox = {-2 / 16, -0.5, -2 / 16, 2 / 16, 2 / 16, 2 / 16}
	},
	viola = {
		description = "Viola",
		selbox = {-5 / 16, -0.5, -5 / 16, 5 / 16, -1 / 16, 5 / 16}
	},
	dandelion_white = {
		description = "White Dandelion",
		selbox = {-5 / 16, -0.5, -5 / 16, 5 / 16, -2 / 16, 5 / 16}
	},
	tulip_black = {
		description = "Black Tulip",
		selbox = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16}
	},

	-- Mushrooms are definitively flowers... trust me.
	mushroom_red = {
		description = "Red Mushroom",
		selbox = {-4 / 16, -0.5, -4 / 16, 4 / 16, -1 / 16, 4 / 16}
	},
	mushroom_brown = {
		description = "Brown Mushroom",
		selbox = {-3 / 16, -0.5, -3 / 16, 3 / 16, -2 / 16, 3 / 16},
	}
}

for name, def in pairs(nodes) do
	def.drawtype = "plantlike"
	def.waving = 1
	local texture = "flowers_"..name..".png"
	def.tiles = {texture}
	def.inventory_image = texture
	def.wield_image = texture
	def.sunglight_propagates = true
	def.paramtype = "light"
	def.walkable = false
	def.buildable_to = true
	if not def.groups then def.groups = {} end
	def.groups.snappy = 3
	def.groups.attached_node = 1
	def.sounds = bldg_sounds.sound_leaves()
	def.selection_box = {
		type = "fixed",
		fixed = def.selbox
	}
	def.selbox = nil

	minetest.register_node("bldg_nodes:"..name, def)

	if do_compat then
		minetest.register_alias("flowers:"..name, "bldg_nodes:"..name)
	end
end
