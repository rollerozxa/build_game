-- mods/default/craftitems.lua

-- support for MT game translation.
local S = default.get_translator

--
-- Craftitem registry
--

minetest.register_craftitem("default:blueberries", {
	description = S("Blueberries"),
	inventory_image = "default_blueberries.png",
	groups = {food_blueberries = 1, food_berry = 1},
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("default:bronze_ingot", {
	description = S("Bronze Ingot"),
	inventory_image = "default_bronze_ingot.png"
})

minetest.register_craftitem("default:clay_brick", {
	description = S("Clay Brick"),
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = S("Clay Lump"),
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:coal_lump", {
	description = S("Coal Lump"),
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1, flammable = 1}
})

minetest.register_craftitem("default:copper_ingot", {
	description = S("Copper Ingot"),
	inventory_image = "default_copper_ingot.png"
})

minetest.register_craftitem("default:copper_lump", {
	description = S("Copper Lump"),
	inventory_image = "default_copper_lump.png"
})

minetest.register_craftitem("default:diamond", {
	description = S("Diamond"),
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:flint", {
	description = S("Flint"),
	inventory_image = "default_flint.png"
})

minetest.register_craftitem("default:gold_ingot", {
	description = S("Gold Ingot"),
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:gold_lump", {
	description = S("Gold Lump"),
	inventory_image = "default_gold_lump.png"
})

minetest.register_craftitem("default:iron_lump", {
	description = S("Iron Lump"),
	inventory_image = "default_iron_lump.png"
})

minetest.register_craftitem("default:mese_crystal", {
	description = S("Mese Crystal"),
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = S("Mese Crystal Fragment"),
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = S("Obsidian Shard"),
	inventory_image = "default_obsidian_shard.png",
})

minetest.register_craftitem("default:paper", {
	description = S("Paper"),
	inventory_image = "default_paper.png",
	groups = {flammable = 3},
})

minetest.register_craftitem("default:steel_ingot", {
	description = S("Steel Ingot"),
	inventory_image = "default_steel_ingot.png"
})

minetest.register_craftitem("default:stick", {
	description = S("Stick"),
	inventory_image = "default_stick.png",
	groups = {stick = 1, flammable = 2},
})

minetest.register_craftitem("default:tin_ingot", {
	description = S("Tin Ingot"),
	inventory_image = "default_tin_ingot.png"
})

minetest.register_craftitem("default:tin_lump", {
	description = S("Tin Lump"),
	inventory_image = "default_tin_lump.png"
})
