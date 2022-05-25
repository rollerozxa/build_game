local PNG = i3.files.styles()
local replacements = {fuel = {}}

local fmt = i3.get("fmt")
local true_table, is_table, valid_item = i3.get("true_table", "is_table", "valid_item")

local function init_recipes()
	local _select, _preselect = {}, {}

	for name, def in pairs(minetest.registered_items) do
		if name ~= "" and valid_item(def) then
			_preselect[name] = true
		end
	end

	for name in pairs(_preselect) do
		table.insert(i3.init_items, name)
		_select[name] = true
	end

	table.sort(i3.init_items)
end

local function get_cube(tiles)
	if not true_table(tiles) then
		return PNG.blank
	end

	local top = tiles[1] or PNG.blank
	if is_table(top) then
		top = top.name or top.image
	end

	local left = tiles[3] or top or PNG.blank
	if is_table(left) then
		left = left.name or left.image
	end

	local right = tiles[5] or left or PNG.blank
	if is_table(right) then
		right = right.name or right.image
	end

	return minetest.inventorycube(top, left, right)
end

local function init_cubes()
	for name, def in pairs(minetest.registered_nodes) do
		if def then
			local id = minetest.get_content_id(name)

			if def.drawtype == "normal" or def.drawtype == "liquid" or
					string.sub(def.drawtype, 1, 9) == "glasslike" or
					string.sub(def.drawtype, 1, 8) == "allfaces" then
				i3.cubes[id] = get_cube(def.tiles)
			elseif string.sub(def.drawtype, 1, 9) == "plantlike" or string.sub(def.drawtype, 1, 8) == "firelike" then
				i3.plants[id] = def.inventory_image .. "^\\[resize:16x16"
			end
		end
	end
end

return function()
	init_recipes()
	init_cubes()
end
