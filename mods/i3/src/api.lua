local make_fs, get_inventory_fs = i3.files.gui()

local S, err, fmt = i3.get("S", "err", "fmt")
local sorter, sort_inventory = i3.get("sorter", "sort_inventory")
local true_str, true_table, is_str, is_func, is_table, clean_name = i3.get("true_str", "true_table", "is_str", "is_func", "is_table", "clean_name")

function i3.add_recipe_filter(name, f)
	if not true_str(name) then
		return err "i3.add_recipe_filter: name missing"
	elseif not is_func(f) then
		return err "i3.add_recipe_filter: function missing"
	end

	i3.recipe_filters[name] = f
end

function i3.set_recipe_filter(name, f)
	if not is_str(name) then
		return err "i3.set_recipe_filter: name missing"
	elseif not is_func(f) then
		return err "i3.set_recipe_filter: function missing"
	end

	i3.recipe_filters = {[name] = f}
end

function i3.add_search_filter(name, f)
	if not true_str(name) then
		return err "i3.add_search_filter: name missing"
	elseif not is_func(f) then
		return err "i3.add_search_filter: function missing"
	end

	i3.search_filters[name] = f
end

function i3.get_recipes(item)
	item = minetest.registered_aliases[item] or item
	local recipes = i3.recipes_cache[item]
	local usages = i3.usages_cache[item]

	return {recipes = recipes, usages = usages}
end

function i3.set_fs(player)
	if not player or player.is_fake_player then return end
	local name = player:get_player_name()
	local data = i3.data[name]
	if not data then return end

	if data.auto_sorting then
		sort_inventory(player, data)
	end

	local fs = make_fs(player, data)
	player:set_inventory_formspec(fs)
end

function i3.new_tab(name, def)
	if not true_str(name) then
		return err "i3.new_tab: tab name missing"
	elseif not true_table(def) then
		return err "i3.new_tab: tab definition missing"
	elseif not true_str(def.description) then
		return err "i3.new_tab: description missing"
	elseif #i3.tabs == 6 then
		return err(fmt("i3.new_tab: cannot add '%s' tab. Limit reached (6).", def.name))
	end

	def.name = name
	table.insert(i3.tabs, def)
end

i3.new_tab("inventory", {
	description = S"Inventory",
	formspec = get_inventory_fs,
	fields = i3.files.fields(),
})

function i3.remove_tab(name)
	if not true_str(name) then
		return err "i3.remove_tab: tab name missing"
	end

	for i, def in ipairs(i3.tabs) do
		if name == def.name then
			table.remove(i3.tabs, i)
			break
		end
	end
end

function i3.get_current_tab(player)
	local name = player:get_player_name()
	local data = i3.data[name]

	return data.tab
end

function i3.set_tab(player, tabname)
	local name = player:get_player_name()
	local data = i3.data[name]

	if not tabname or tabname == "" then
		data.tab = 0
		return
	end

	for i, def in ipairs(i3.tabs) do
		if def.name == tabname then
			data.tab = i
			return
		end
	end

	err(fmt("i3.set_tab: tab name '%s' does not exist", tabname))
end

function i3.override_tab(name, newdef)
	if not true_str(name) then
		return err "i3.override_tab: tab name missing"
	elseif not true_table(newdef) then
		return err "i3.override_tab: tab definition missing"
	elseif not true_str(newdef.description) then
		return err "i3.override_tab: description missing"
	end

	newdef.name = name

	for i, def in ipairs(i3.tabs) do
		if def.name == name then
			i3.tabs[i] = newdef
			break
		end
	end
end

i3.add_search_filter("groups", function(item, groups)
	local def = minetest.registered_items[item]
	local has_groups = true

	for _, group in ipairs(groups) do
		if not def.groups[group] then
			has_groups = nil
			break
		end
	end

	return has_groups
end)

function i3.compress(item, def)
	if not true_str(item) then
		return err "i3.compress: item name missing"
	elseif not true_table(def) then
		return err "i3.compress: replace definition missing"
	elseif not true_str(def.replace) then
		return err "i3.compress: replace string missing"
	elseif not is_table(def.by) then
		return err "i3.compress: replace substrings missing"
	elseif i3.compressed[item] then
		return err(fmt("i3.compress: item '%s' is already compressed", item))
	end

	local t = {}
	i3.compress_groups[item] = i3.compress_groups[item] or {}

	for _, str in ipairs(def.by) do
		local it = item:gsub(def.replace, str)

		table.insert(t, it)
		table.insert(i3.compress_groups[item], it)

		i3.compressed[it] = true
	end
end

function i3.hud_notif(name, msg, img)
	if not true_str(name) then
		return err "i3.hud_notif: player name missing"
	elseif not true_str(msg) then
		return err "i3.hud_notif: message missing"
	end

	local data = i3.data[name]

	if not data then
		return err "i3.hud_notif: no player data initialized"
	end

	data.show_hud = true
	data.hud_msg = msg

	if img then
		data.hud_img = fmt("%s^[resize:16x16", img)
	end
end

function i3.add_sorting_method(name, def)
	if not true_str(name) then
		return err "i3.add_sorting_method: name missing"
	elseif not true_table(def) then
		return err "i3.add_sorting_method: definition missing"
	elseif not is_func(def.func) then
		return err "i3.add_sorting_method: function missing"
	end

	def.name = name
	table.insert(i3.sorting_methods, def)
end

i3.add_sorting_method("alphabetical", {
	description = S"Sort items by name (A-Z)",
	func = function(list, data)
		sorter(list, data.reverse_sorting, 1)
		return list
	end
})

i3.add_sorting_method("numerical", {
	description = S"Sort items by number of items per stack",
	func = function(list, data)
		sorter(list, data.reverse_sorting, 2)
		return list
	end,
})
