-- stairs/init.lua

-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- Global namespace for functions

stairs = {}

-- Load support for MT game translation.
local S = minetest.get_translator("stairs")
-- Same as S, but will be ignored by translation file update scripts
local T = S


-- Register aliases for new pine node names

minetest.register_alias("stairs:stair_pinewood", "stairs:stair_pine_wood")
minetest.register_alias("stairs:slab_pinewood", "stairs:slab_pine_wood")


-- Get setting for replace ABM

local replace = minetest.settings:get_bool("enable_stairs_replace_abm")

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	if placer then
		local placer_pos = placer:get_pos()
		if placer_pos then
			param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
		end

		local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
		local fpos = finepos.y % 1

		if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
				or (fpos < -0.5 and fpos > -0.999999999) then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

local function warn_if_exists(nodename)
	if minetest.registered_nodes[nodename] then
		minetest.log("warning", "Overwriting stairs node: " .. nodename)
	end
end

-- get node settings to use for stairs
local function get_node_vars(nodename)

	local def = minetest.registered_nodes[nodename]

	if def then
		return def.light_source, def.use_texture_alpha, def.sunlight_propagates
	end

	return nil, nil, nil
end

-- Register stair
-- Node will be called stairs:stair_<subname>

function stairs.register_stair(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local light_source, texture_alpha, sunlight = get_node_vars(recipeitem)

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	warn_if_exists("stairs:stair_" .. subname)
	minetest.register_node(":stairs:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = texture_alpha,
		sunlight_propagates = sunlight,
		light_source = light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":stairs:stair_" .. subname .. "upside_down", {
			replace_name = "stairs:stair_" .. subname,
			groups = {slabs_replace = 1},
		})
	end
end


-- Register slab
-- Node will be called stairs:slab_<subname>

function stairs.register_slab(subname, recipeitem, groups, images, description,
		sounds, worldaligntex)
	local light_source, texture_alpha, sunlight = get_node_vars(recipeitem)

	-- Set world-aligned textures
	local slab_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			slab_images[i] = {
				name = image,
			}
			if worldaligntex then
				slab_images[i].align_style = "world"
			end
		else
			slab_images[i] = table.copy(image)
			if worldaligntex and image.align_style == nil then
				slab_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.slab = 1
	warn_if_exists("stairs:slab_" .. subname)
	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = slab_images,
		use_texture_alpha = texture_alpha,
		sunlight_propagates = sunlight,
		light_source = light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			local under = minetest.get_node(pointed_thing.under)
			local wield_item = itemstack:get_name()
			local player_name = placer and placer:get_player_name() or ""

			if under and under.name:find("^stairs:slab_") then
				-- place slab using under node orientation
				local dir = minetest.dir_to_facedir(vector.subtract(
					pointed_thing.above, pointed_thing.under), true)

				local p2 = under.param2

				-- Placing a slab on an upside down slab should make it right-side up.
				if p2 >= 20 and dir == 8 then
					p2 = p2 - 20
				-- same for the opposite case: slab below normal slab
				elseif p2 <= 3 and dir == 4 then
					p2 = p2 + 20
				end

				-- else attempt to place node with proper param2
				minetest.item_place_node(ItemStack(wield_item), placer, pointed_thing, p2)
				if not minetest.is_creative_enabled(player_name) then
					itemstack:take_item()
				end
				return itemstack
			else
				return rotate_and_place(itemstack, placer, pointed_thing)
			end
		end,
	})

	-- for replace ABM
	if replace then
		minetest.register_node(":stairs:slab_" .. subname .. "upside_down", {
			replace_name = "stairs:slab_".. subname,
			groups = {slabs_replace = 1},
		})
	end
end


-- Optionally replace old "upside_down" nodes with new param2 versions.
-- Disabled by default.

if replace then
	minetest.register_abm({
		label = "Slab replace",
		nodenames = {"group:slabs_replace"},
		interval = 16,
		chance = 1,
		action = function(pos, node)
			node.name = minetest.registered_nodes[node.name].replace_name
			node.param2 = node.param2 + 20
			if node.param2 == 21 then
				node.param2 = 23
			elseif node.param2 == 23 then
				node.param2 = 21
			end
			minetest.set_node(pos, node)
		end,
	})
end


-- Register inner stair
-- Node will be called stairs:stair_inner_<subname>

function stairs.register_stair_inner(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local light_source, texture_alpha, sunlight = get_node_vars(recipeitem)

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Inner " .. description
	end
	warn_if_exists("stairs:stair_inner_" .. subname)
	minetest.register_node(":stairs:stair_inner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = texture_alpha,
		sunlight_propagates = sunlight,
		light_source = light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5},
				{-0.5, 0.0, -0.5, 0.0, 0.5, 0.0},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})
end


-- Register outer stair
-- Node will be called stairs:stair_outer_<subname>

function stairs.register_stair_outer(subname, recipeitem, groups, images,
		description, sounds, worldaligntex, full_description)
	local light_source, texture_alpha, sunlight = get_node_vars(recipeitem)

	-- Set backface culling and world-aligned textures
	local stair_images = {}
	for i, image in ipairs(images) do
		if type(image) == "string" then
			stair_images[i] = {
				name = image,
				backface_culling = true,
			}
			if worldaligntex then
				stair_images[i].align_style = "world"
			end
		else
			stair_images[i] = table.copy(image)
			if stair_images[i].backface_culling == nil then
				stair_images[i].backface_culling = true
			end
			if worldaligntex and stair_images[i].align_style == nil then
				stair_images[i].align_style = "world"
			end
		end
	end
	local new_groups = table.copy(groups)
	new_groups.stair = 1
	if full_description then
		description = full_description
	else
		description = "Outer " .. description
	end
	warn_if_exists("stairs:stair_outer_" .. subname)
	minetest.register_node(":stairs:stair_outer_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = stair_images,
		use_texture_alpha = texture_alpha,
		sunlight_propagates = sunlight,
		light_source = light_source,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = new_groups,
		sounds = sounds,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
				{-0.5, 0.0, 0.0, 0.0, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			return rotate_and_place(itemstack, placer, pointed_thing)
		end,
	})
end


-- Stair/slab registration function.
-- Nodes will be called stairs:{stair,slab}_<subname>

function stairs.register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex,
		desc_stair_inner, desc_stair_outer)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair,
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_inner)
	stairs.register_stair_outer(subname, recipeitem, groups, images,
		desc_stair, sounds, worldaligntex, desc_stair_outer)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab,
		sounds, worldaligntex)
end

-- Local function so we can apply translations
local function my_register_stair_and_slab(subname, recipeitem, groups, images,
		desc_stair, desc_slab, sounds, worldaligntex)
	stairs.register_stair(subname, recipeitem, groups, images, S(desc_stair),
		sounds, worldaligntex)
	stairs.register_stair_inner(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Inner " .. desc_stair))
	stairs.register_stair_outer(subname, recipeitem, groups, images, "",
		sounds, worldaligntex, T("Outer " .. desc_stair))
	stairs.register_slab(subname, recipeitem, groups, images, S(desc_slab),
		sounds, worldaligntex)
end


-- Register default stairs and slabs

my_register_stair_and_slab(
	"wood",
	"default:wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"default_wood.png"},
	"Wooden Stair",
	"Wooden Slab",
	default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"junglewood",
	"default:junglewood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"default_junglewood.png"},
	"Jungle Wood Stair",
	"Jungle Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"pine_wood",
	"default:pine_wood",
	{choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	{"default_pine_wood.png"},
	"Pine Wood Stair",
	"Pine Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"acacia_wood",
	"default:acacia_wood",
	{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	{"default_acacia_wood.png"},
	"Acacia Wood Stair",
	"Acacia Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"aspen_wood",
	"default:aspen_wood",
	{choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	{"default_aspen_wood.png"},
	"Aspen Wood Stair",
	"Aspen Wood Slab",
	default.node_sound_wood_defaults(),
	false
)

my_register_stair_and_slab(
	"stone",
	"default:stone",
	{cracky = 3},
	{"default_stone.png"},
	"Stone Stair",
	"Stone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"cobble",
	"default:cobble",
	{cracky = 3},
	{"default_cobble.png"},
	"Cobblestone Stair",
	"Cobblestone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"mossycobble",
	"default:mossycobble",
	{cracky = 3},
	{"default_mossycobble.png"},
	"Mossy Cobblestone Stair",
	"Mossy Cobblestone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"stonebrick",
	"default:stonebrick",
	{cracky = 2},
	{"default_stone_brick.png"},
	"Stone Brick Stair",
	"Stone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"stone_block",
	"default:stone_block",
	{cracky = 2},
	{"default_stone_block.png"},
	"Stone Block Stair",
	"Stone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_stone",
	"default:desert_stone",
	{cracky = 3},
	{"default_desert_stone.png"},
	"Desert Stone Stair",
	"Desert Stone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_cobble",
	"default:desert_cobble",
	{cracky = 3},
	{"default_desert_cobble.png"},
	"Desert Cobblestone Stair",
	"Desert Cobblestone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_stonebrick",
	"default:desert_stonebrick",
	{cracky = 2},
	{"default_desert_stone_brick.png"},
	"Desert Stone Brick Stair",
	"Desert Stone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"desert_stone_block",
	"default:desert_stone_block",
	{cracky = 2},
	{"default_desert_stone_block.png"},
	"Desert Stone Block Stair",
	"Desert Stone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"sandstone",
	"default:sandstone",
	{crumbly = 1, cracky = 3},
	{"default_sandstone.png"},
	"Sandstone Stair",
	"Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"sandstonebrick",
	"default:sandstonebrick",
	{cracky = 2},
	{"default_sandstone_brick.png"},
	"Sandstone Brick Stair",
	"Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"sandstone_block",
	"default:sandstone_block",
	{cracky = 2},
	{"default_sandstone_block.png"},
	"Sandstone Block Stair",
	"Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_sandstone",
	"default:desert_sandstone",
	{crumbly = 1, cracky = 3},
	{"default_desert_sandstone.png"},
	"Desert Sandstone Stair",
	"Desert Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"desert_sandstone_brick",
	"default:desert_sandstone_brick",
	{cracky = 2},
	{"default_desert_sandstone_brick.png"},
	"Desert Sandstone Brick Stair",
	"Desert Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"desert_sandstone_block",
	"default:desert_sandstone_block",
	{cracky = 2},
	{"default_desert_sandstone_block.png"},
	"Desert Sandstone Block Stair",
	"Desert Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"silver_sandstone",
	"default:silver_sandstone",
	{crumbly = 1, cracky = 3},
	{"default_silver_sandstone.png"},
	"Silver Sandstone Stair",
	"Silver Sandstone Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"silver_sandstone_brick",
	"default:silver_sandstone_brick",
	{cracky = 2},
	{"default_silver_sandstone_brick.png"},
	"Silver Sandstone Brick Stair",
	"Silver Sandstone Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"silver_sandstone_block",
	"default:silver_sandstone_block",
	{cracky = 2},
	{"default_silver_sandstone_block.png"},
	"Silver Sandstone Block Stair",
	"Silver Sandstone Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"obsidian",
	"default:obsidian",
	{cracky = 1, level = 2},
	{"default_obsidian.png"},
	"Obsidian Stair",
	"Obsidian Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"obsidianbrick",
	"default:obsidianbrick",
	{cracky = 1, level = 2},
	{"default_obsidian_brick.png"},
	"Obsidian Brick Stair",
	"Obsidian Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"obsidian_block",
	"default:obsidian_block",
	{cracky = 1, level = 2},
	{"default_obsidian_block.png"},
	"Obsidian Block Stair",
	"Obsidian Block Slab",
	default.node_sound_stone_defaults(),
	true
)

my_register_stair_and_slab(
	"brick",
	"default:brick",
	{cracky = 3},
	{"default_brick.png"},
	"Brick Stair",
	"Brick Slab",
	default.node_sound_stone_defaults(),
	false
)

my_register_stair_and_slab(
	"steelblock",
	"default:steelblock",
	{cracky = 1, level = 2},
	{"default_steel_block.png"},
	"Steel Block Stair",
	"Steel Block Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"tinblock",
	"default:tinblock",
	{cracky = 1, level = 2},
	{"default_tin_block.png"},
	"Tin Block Stair",
	"Tin Block Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"copperblock",
	"default:copperblock",
	{cracky = 1, level = 2},
	{"default_copper_block.png"},
	"Copper Block Stair",
	"Copper Block Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"bronzeblock",
	"default:bronzeblock",
	{cracky = 1, level = 2},
	{"default_bronze_block.png"},
	"Bronze Block Stair",
	"Bronze Block Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"goldblock",
	"default:goldblock",
	{cracky = 1},
	{"default_gold_block.png"},
	"Gold Block Stair",
	"Gold Block Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"ice",
	"default:ice",
	{cracky = 3, cools_lava = 1, slippery = 3},
	{"default_ice.png"},
	"Ice Stair",
	"Ice Slab",
	default.node_sound_ice_defaults(),
	true
)

my_register_stair_and_slab(
	"snowblock",
	"default:snowblock",
	{crumbly = 3, cools_lava = 1, snowy = 1},
	{"default_snow.png"},
	"Snow Block Stair",
	"Snow Block Slab",
	default.node_sound_snow_defaults(),
	true
)

-- Glass stair nodes need to be registered individually to utilize specialized textures.

stairs.register_stair(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_split.png", "default_glass.png",
	"stairs_glass_stairside.png^[transformFX", "stairs_glass_stairside.png",
	"default_glass.png", "stairs_glass_split.png"},
	S("Glass Stair"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"default_glass.png", "default_glass.png", "stairs_glass_split.png"},
	S("Glass Slab"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_stairside.png^[transformR270", "default_glass.png",
	"stairs_glass_stairside.png^[transformFX", "default_glass.png",
	"default_glass.png", "stairs_glass_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Inner Glass Stair")
)

stairs.register_stair_outer(
	"glass",
	"default:glass",
	{cracky = 3, oddly_breakable_by_hand = 3},
	{"stairs_glass_stairside.png^[transformR90", "default_glass.png",
	"stairs_glass_outer_stairside.png", "stairs_glass_stairside.png",
	"stairs_glass_stairside.png^[transformR90","stairs_glass_outer_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Outer Glass Stair")
)

stairs.register_stair(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_split.png", "default_obsidian_glass.png",
	"stairs_obsidian_glass_stairside.png^[transformFX", "stairs_obsidian_glass_stairside.png",
	"default_obsidian_glass.png", "stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Stair"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_slab(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"default_obsidian_glass.png", "default_obsidian_glass.png", "stairs_obsidian_glass_split.png"},
	S("Obsidian Glass Slab"),
	default.node_sound_glass_defaults(),
	false
)

stairs.register_stair_inner(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_stairside.png^[transformR270", "default_obsidian_glass.png",
	"stairs_obsidian_glass_stairside.png^[transformFX", "default_obsidian_glass.png",
	"default_obsidian_glass.png", "stairs_obsidian_glass_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Inner Obsidian Glass Stair")
)

stairs.register_stair_outer(
	"obsidian_glass",
	"default:obsidian_glass",
	{cracky = 3},
	{"stairs_obsidian_glass_stairside.png^[transformR90", "default_obsidian_glass.png",
	"stairs_obsidian_glass_outer_stairside.png", "stairs_obsidian_glass_stairside.png",
	"stairs_obsidian_glass_stairside.png^[transformR90","stairs_obsidian_glass_outer_stairside.png"},
	"",
	default.node_sound_glass_defaults(),
	false,
	S("Outer Obsidian Glass Stair")
)
