local fmt, upper = string.format, string.upper

local old_is_creative_enabled = minetest.is_creative_enabled

function minetest.is_creative_enabled(name)
	if name == "" then
		return old_is_creative_enabled(name)
	end

	return minetest.check_player_privs(name, {creative = true}) or old_is_creative_enabled(name)
end

local S = minetest.get_translator"i3"
local ES = function(...) return minetest.formspec_escape(S(...)) end

local function is_num(x)
	return type(x) == "number"
end

local function is_str(x)
	return type(x) == "string"
end

local function is_table(x)
	return type(x) == "table"
end

local function is_func(x)
	return type(x) == "function"
end

local function true_str(str)
	return is_str(str) and str ~= ""
end

local function true_table(x)
	return is_table(x) and next(x)
end

local function reset_compression(data)
	data.alt_items = nil
	data.expand = ""
end

local function msg(name, str)
	local prefix = "[i3]"
	return minetest.chat_send_player(name, fmt("%s %s", minetest.colorize("#ff0", prefix), str))
end

local function err(str)
	return minetest.log("error", str)
end

local function round(num, decimal)
	local mul = 10 ^ decimal
	return math.floor(num * mul + 0.5) / mul
end

local function toupper(str)
	return str:gsub("%f[%w]%l", upper):gsub("_", " ")
end

local function search(data)
	reset_compression(data)

	local filter = data.filter
	local opt = "^(.-)%+([%w_]+)=([%w_,]+)"
	local search_filter = next(i3.search_filters) and string.match(filter, opt)
	local filters = {}

	if search_filter then
		search_filter = search_filter:trim()

		for filter_name, values in string.gmatch(filter, string.sub(opt, 6)) do
			if i3.search_filters[filter_name] then
				values = string.split(values, ",")
				filters[filter_name] = values
			end
		end
	end

	local filtered_list, c = {}, 0

	for i = 1, #data.items_raw do
		local item = data.items_raw[i]
		local def = minetest.registered_items[item]
		local desc = string.lower(minetest.get_translated_string(data.lang_code, def and def.description)) or ""
		local search_in = fmt("%s", desc)
		local temp, j, to_add = {}, 1

		if search_filter then
			for filter_name, values in pairs(filters) do
				if values then
					local func = i3.search_filters[filter_name]
					to_add = (j > 1 and temp[item] or j == 1) and
						func(item, values) and (search_filter == "" or
						string.find(search_in, search_filter, 1, true))

					if to_add then
						temp[item] = true
					end

					j = j + 1
				end
			end
		else
			local ok = true

			for keyword in string.gmatch(filter, "%S+") do
				if not string.find(search_in, keyword, 1, true) then
					ok = nil
					break
				end
			end

			if ok then
				to_add = true
			end
		end

		if to_add then
			c = c + 1
			filtered_list[c] = item
		end
	end

	data.items = filtered_list
end

local function table_merge(t1, t2, hash)
	t1 = t1 or {}
	t2 = t2 or {}

	if hash then
		for k, v in pairs(t2) do
			t1[k] = v
		end
	else
		local c = #t1

		for i = 1, #t2 do
			c = c + 1
			t1[c] = t2[i]
		end
	end

	return t1
end

local function clean_name(item)
	if string.sub(item, 1, 1) == ":" or string.sub(item, 1, 1) == " " or string.sub(item, 1, 1) == "_" then
		item = string.sub(item, 2)
	end

	return item
end

local function valid_item(def)
	return def and def.groups.not_in_creative_inventory ~= 1 and
		def.description and def.description ~= ""
end

local function apply_recipe_filters(recipes, player)
	for _, filter in pairs(i3.recipe_filters) do
		recipes = filter(recipes, player)
	end

	return recipes
end

local function compression_active(data)
	return not next(i3.recipe_filters) and data.filter == ""
end

local function compressible(item, data)
	return compression_active(data) and i3.compress_groups[item]
end

local function sort_by_category(data)
	reset_compression(data)
	local items = data.items_raw

	if data.filter ~= "" then
		search(data)
		items = data.items
	end

	local new = {}

	for i = 1, #items do
		local item = items[i]
		local to_add = true

		if data.itab == 2 then
			to_add = minetest.registered_nodes[item]
		elseif data.itab == 3 then
			to_add = minetest.registered_craftitems[item] or minetest.registered_tools[item]
		end

		if to_add then
			table.insert(new, item)
		end
	end

	data.items = new
end

local function spawn_item(player, stack)
	local dir     = player:get_look_dir()
	local ppos    = player:get_pos()
	      ppos.y  = ppos.y + player:get_properties().eye_height
	local look_at = vector.add(ppos, vector.multiply(dir, 1))

	minetest.add_item(look_at, stack)
end

local function get_recipes(player, item)
	item = minetest.registered_aliases[item] or item
	local recipes = i3.recipes_cache[item]
	local usages = i3.usages_cache[item]

	if recipes then
		recipes = apply_recipe_filters(recipes, player)
	end

	local no_recipes = not recipes or #recipes == 0
	if no_recipes and not usages then return end
	usages = apply_recipe_filters(usages, player)
	local no_usages = not usages or #usages == 0

	return not no_recipes and recipes or nil,
	       not no_usages  and usages  or nil
end

local function get_stack(player, stack)
	local inv = player:get_inventory()

	if inv:room_for_item("main", stack) then
		inv:add_item("main", stack)
	else
		spawn_item(player, stack)
	end
end

local function play_sound(name, sound, volume)
	minetest.sound_play(sound, {to_player = name, gain = volume}, true)
end

local function safe_teleport(player, pos)
	local vel = player:get_velocity()
	player:add_velocity(vector.multiply(vel, -1))

	local p = vector.new(pos)
	      p.y = p.y + 0.25

	player:set_pos(p)
end

local function get_sorting_idx(name)
	local idx = 1

	for i, def in ipairs(i3.sorting_methods) do
		if name == def.name then
			idx = i
		end
	end

	return idx
end

local function sorter(inv, reverse, mode)
	table.sort(inv, function(a, b)
		if mode == 1 then
			a, b = a:get_name(), b:get_name()
		else
			a, b = a:get_count(), b:get_count()
		end

		if reverse then
			return a > b
		end

		return a < b
	end)
end

local function pre_sorting(list, start_i)
	local new_inv, special = {}, {}

	for i = start_i, #list do
		local stack = list[i]
		local empty = stack:is_empty()
		local meta  = stack:get_meta():to_table()
		local wear  = stack:get_wear() > 0

		if not empty then
			if next(meta.fields) or wear then
				table.insert(special, stack)
			else
				table.insert(new_inv, stack)
			end
		end
	end

	new_inv = table_merge(new_inv, special)
	return new_inv
end

local function compress_items(list, start_i)
	local hash, new_inv, special = {}, {}, {}

	for i = start_i, #list do
		local stack    = list[i]
		local name     = stack:get_name()
		local count    = stack:get_count()
		local stackmax = stack:get_stack_max()
		local empty    = stack:is_empty()
		local meta     = stack:get_meta():to_table()
		local wear     = stack:get_wear() > 0

		if not empty then
			if next(meta.fields) or wear or count >= stackmax then
				table.insert(special, stack)
			else
				hash[name] = hash[name] or 0
				hash[name] = hash[name] - count
			end
		end
	end

	for name, count in pairs(hash) do
		local stackmax = ItemStack(name):get_stack_max()
		local iter = math.ceil(count / stackmax)
		local leftover = count

		for _ = 1, iter do
			table.insert(new_inv, ItemStack(fmt("%s %u", name, math.min(stackmax, leftover))))
			leftover = leftover - stackmax
		end
	end

	new_inv = table_merge(new_inv, special)
	return new_inv
end

local function sort_inventory(player, data)
	local inv = player:get_inventory()
	local list = inv:get_list"main"
	local size = inv:get_size"main"
	local start_i = data.ignore_hotbar and (i3.settings.hotbar_len + 1) or 1

	if data.inv_compress then
		list = compress_items(list, start_i)
	else
		list = pre_sorting(list, start_i)
	end

	local idx = get_sorting_idx(data.sort)
	local new_inv = i3.sorting_methods[idx].func(list, data)
	if not new_inv then return end

	if not data.ignore_hotbar then
		inv:set_list("main", new_inv)
		return
	end

	for i = start_i, size do
		local index = i - start_i + 1
		inv:set_stack("main", i, new_inv[index] or "")
	end
end

local function reset_data(data)
	data.filter        = ""
	data.expand        = ""
	data.pagenum       = 1
	data.rnum          = 1
	data.unum          = 1
	data.scrbar_rcp    = 1
	data.scrbar_usg    = 1
	data.query_item    = nil
	data.recipes       = nil
	data.usages        = nil
	data.export_rcp    = nil
	data.export_usg    = nil
	data.alt_items     = nil
	data.confirm_trash = nil
	data.show_settings = nil
	data.show_setting  = "home"
	data.items         = data.items_raw

	if data.itab > 1 then
		sort_by_category(data)
	end
end

local function add_hud_waypoint(player, name, pos, color)
	return player:hud_add {
		hud_elem_type = "waypoint",
		name = name,
		text = " m",
		world_pos = pos,
		number = color,
		z_index = -300,
	}
end

local function get_detached_inv(name, player_name)
	return minetest.get_inventory {
		type = "detached",
		name = fmt("i3_%s_%s", name, player_name)
	}
end

-- Much faster implementation of `unpack`
local function createunpack(n)
	local ret = {"local t = ... return "}

	for k = 2, n do
		ret[2 + (k - 2) * 4] = "t["
		ret[3 + (k - 2) * 4] = k - 1
		ret[4 + (k - 2) * 4] = "]"

		if k ~= n then
			ret[5 + (k - 2) * 4] = ","
		end
	end

	return loadstring(table.concat(ret))
end

local newunpack = createunpack(33)

-------------------------------------------------------------------------------

local _ = {
	-- Compression
	compressible = compressible,
	compression_active = compression_active,

	-- Sorting
	search = search,
	sorter = sorter,
	get_recipes = get_recipes,
	sort_inventory = sort_inventory,
	get_sorting_idx = get_sorting_idx,
	sort_by_category = sort_by_category,

	-- Type checks
	is_str = is_str,
	is_num = is_num,
	is_func = is_func,
	true_str = true_str,
	true_table = true_table,

	-- Console
	err = err,
	msg = msg,

	-- Misc. functions
	valid_item = valid_item,
	spawn_item = spawn_item,
	clean_name = clean_name,
	play_sound = play_sound,
	reset_data = reset_data,
	safe_teleport = safe_teleport,
	add_hud_waypoint = add_hud_waypoint,

	-- Inventory
	get_stack = get_stack,
	get_detached_inv = get_detached_inv,

	-- i18n
	S = S,
	ES = ES,

	-- String
	fmt = string.format,
	upper = string.upper,
	toupper = toupper,

	-- Table
	unpack = newunpack,
	is_table = is_table,

	-- Math
	round = round,

}

function i3.get(...)
	local t = {}

	for i, var in ipairs{...} do
		t[i] = _[var]
	end

	return newunpack(t)
end
