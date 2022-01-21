local PNG = i3.files.styles()
local replacements = {fuel = {}}

IMPORT("maxn", "copy", "insert", "sort", "match", "sub")
IMPORT("fmt", "reg_items", "reg_aliases", "reg_nodes", "draw_cube", "ItemStack")
IMPORT("true_str", "true_table", "is_table", "valid_item", "table_merge", "table_replace", "rcp_eq")

local function init_recipes()
	local _select, _preselect = {}, {}

	for name, def in pairs(reg_items) do
		if name ~= "" and valid_item(def) then
			_preselect[name] = true
		end
	end

	for name in pairs(_preselect) do
		insert(i3.init_items, name)
		_select[name] = true
	end

	sort(i3.init_items)
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

	return draw_cube(top, left, right)
end

local function init_cubes()
	for name, def in pairs(reg_nodes) do
		if def then
			local id = core.get_content_id(name)

			if def.drawtype == "normal" or def.drawtype == "liquid" or
					sub(def.drawtype, 1, 9) == "glasslike" or
					sub(def.drawtype, 1, 8) == "allfaces" then
				i3.cubes[id] = get_cube(def.tiles)
			elseif sub(def.drawtype, 1, 9) == "plantlike" or sub(def.drawtype, 1, 8) == "firelike" then
				i3.plants[id] = def.inventory_image .. "^\\[resize:16x16"
			end
		end
	end
end

return function()
	init_recipes()
	init_cubes()
end
