local hotbar_len = i3.settings.hotbar_len
local debug_mode = i3.settings.debug_mode

local PNG, styles, fs_elements, colors = i3.files.styles()

local sprintf = string.format
local VoxelArea, VoxelManip = VoxelArea, VoxelManip

local upper = i3.get("upper")
local msg = i3.get("msg")
local round = i3.get("round")
local get_detached_inv = i3.get("get_detached_inv")
local S, ES, toupper = i3.get("S", "ES", "toupper")
local compression_active, compressible = i3.get("compression_active", "compressible")
local true_str, is_num = i3.get("true_str", "is_num")
local unpack = i3.get("unpack")
local get_sorting_idx, get_recipes = i3.get("get_sorting_idx", "get_recipes")

local function fmt(elem, ...)
	if not fs_elements[elem] then
		return sprintf(elem, ...)
	end

	return sprintf(fs_elements[elem], ...)
end

local function snip(str, limit)
	return #str > limit and fmt("%s...", string.sub(str, 1, limit - 3)) or str
end

local function get_inv_slots(fs)
	local inv_x = 0.22
	local inv_y = 6.9
	local size, spacing = 1, 0.1

	fs"style_type[box;colors=#77777710,#77777710,#777,#777]"

	for i = 0, hotbar_len - 1 do
		fs("box", i * size + inv_x + (i * spacing), inv_y, size, size, "")
	end

	fs(fmt("style_type[list;size=%f;spacing=%f]", size, spacing),
	   fmt("list[current_player;main;%f,%f;%u,1;]", inv_x, inv_y, hotbar_len))

	fs(fmt("style_type[list;size=%f;spacing=%f]", size, spacing),
	   fmt("list[current_player;main;%f,%f;%u,%u;%u]", inv_x, inv_y + 1.15,
		hotbar_len, i3.settings.inv_size / hotbar_len, hotbar_len),
	   "style_type[list;size=1;spacing=0.15]")

	fs"listring[current_player;craft]listring[current_player;main]"
end

local function add_subtitle(fs, name, y, ctn_len, font_size, sep, label)
	fs(fmt("style[%s;font=bold;font_size=%u]", name, font_size))
	fs("button", 0, y, ctn_len, 0.5, name, minetest.formspec_escape(label))

	if sep then
		fs("image", 0, y + 0.55, ctn_len, 0.035, PNG.bar)
	end
end

local function get_isometric_view(fs, pos, X, Y, t, cubes, depth, high)
	pos   = vector.round(pos)
	cubes = cubes or 0
	depth = depth or -1
	high  = high or math.huge

	t = t or {}
	t[depth] = {}

	local width = 8
	local base_height = 4
	local base_depth = depth == -1
	local max_depth = -7
	local height = base_depth and (base_height - 1) or depth

	local pos1 = vector.new(pos.x - width, pos.y + depth, pos.z - width)
	local pos2 = vector.new(pos.x + width, pos.y + height, pos.z + width)

	local vm = VoxelManip(pos1, pos2)
	local emin, emax = vm:get_emerged_area()
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()

	for idx in area:iterp(pos1, pos2) do
		local cube = i3.cubes[data[idx]]
		local plant = i3.plants[data[idx]]
		local img = cube or plant

		if img then
			local p = area:position(idx)
			      p = vector.subtract(p, pos)

			local size = 0.25
			local x = 2 + (size / 2 * (p.z - p.x))
			local y = 1 + (size / 4 * (p.x + p.z - 2 * p.y))

			if y < high then
				high = y
			end

			if plant then
				size = size - 0.05
			end

			cubes = cubes + 1
			table.insert(t[depth], {x + X, y + Y, size, size, img})
		end
	end

	local maxc = ((width * 2) ^ 2) * base_height

	if cubes < maxc and depth > max_depth then
		-- if there's not enough map to preview, go deeper
		depth = depth - 1
		return get_isometric_view(fs, pos, X, Y, t, cubes, depth, high)
	end

	local shift = -0.3 - high

	for i = max_depth, 0 do
		local dth = t[i]
		if dth then
			dth[0] = #dth
			for j = 1, dth[0] do
				local params = dth[j]
				      params[2] = params[2] + shift
				table.insert(fs, fmt("image[%f,%f;%.1f,%.1f;%s]", unpack(params)))
			end
		end
	end

	shift = shift + (base_depth and 0.45 or 0.95)
	fs("image", 2.7, Y + shift, 0.3, 0.3, PNG.flag)
end

local function get_waypoint_fs(fs, data, player, yextra, ctn_len)
	fs(fmt("box[0,%f;4.9,0.6;#bababa25]", yextra + 1.1))
	fs("label", 0, yextra + 0.85, ES"Waypoint name:")
	fs(fmt("field[0.1,%f;4.8,0.6;waypoint_name;;]", yextra + 1.1))
	fs("image_button", 5.1, yextra + 1.15, 0.5, 0.5, "", "waypoint_add", "")
	fs(fmt("tooltip[waypoint_add;%s]", ES"Add waypoint"))

	if #data.waypoints == 0 then return end
	fs("style_type[label;font=bold;font_size=17]")

	for i, v in ipairs(data.waypoints) do
		local y = yextra + 1.35 + (i - (i * 0.3))
		local icon_size, yi = 0.35, y + 0.12

		fs"style_type[box;colors=#bababa30,#bababa30,#bababa05,#bababa05]"
		fs("box", 0, y, ctn_len, 0.6, "")

		local waypoint_name, lim = v.name, 18

		if #v.name > lim then
			waypoint_name = snip(waypoint_name, lim)
		end

		local hex = fmt("%02x", v.color)

		while #hex < 6 do
			hex = "0" .. hex
		end

		local teleport_priv = minetest.check_player_privs(player, {teleport = true})
		local waypoint_preview = data.waypoint_see and data.waypoint_see == i

		fs("label", 0.15, y + 0.33, minetest.colorize(fmt("#%s", hex), waypoint_name))

		local tooltip = fmt("Name: %s\nPosition:%s", minetest.colorize("#dbeeff", v.name),
				v.pos:sub(2,-2):gsub("(%-*%d*%.?%d+)", minetest.colorize("#dbeeff", " %1")))

		if teleport_priv then
			tooltip = fmt("%s\n%s", tooltip, minetest.colorize("#ff0", ES"[Click to teleport]"))
		end

		fs("tooltip", 0, y, ctn_len - 2.1, 0.65, tooltip)

		local del = fmt("waypoint_%u_delete", i)
		fs(fmt("style[%s;fgimg=%s;fgimg_hovered=%s;content_offset=0]", del, PNG.trash, PNG.trash_hover))
		fs("image_button", ctn_len - 0.5, yi, icon_size, icon_size, "", del, "")
		fs(fmt("tooltip[%s;%s]", del, ES"Remove waypoint"))

		local rfs = fmt("waypoint_%u_refresh", i)
		fs(fmt("style[%s;fgimg=%s;fgimg_hovered=%s;content_offset=0]", rfs, PNG.refresh, PNG.refresh_hover))
		fs("image_button", ctn_len - 1, yi, icon_size, icon_size, "", rfs, "")
		fs(fmt("tooltip[%s;%s]", rfs, ES"Change color"))

		local see = fmt("waypoint_%u_see", i)
		fs(fmt("style[%s;fgimg=%s;fgimg_hovered=%s;content_offset=0]",
			see, waypoint_preview and PNG.search_hover or PNG.search, PNG.search, PNG.search_hover))
		fs("image_button", ctn_len - 1.5, yi, icon_size, icon_size, "", see, "")
		fs(fmt("tooltip[%s;%s]", see, ES"Preview the waypoint area"))

		local vsb = fmt("waypoint_%u_hide", i)
		fs(fmt("style[%s;fgimg=%s;content_offset=0]", vsb, v.hide and PNG.nonvisible or PNG.visible))
		fs("image_button", ctn_len - 2, yi, icon_size, icon_size, "", vsb, "")
		fs(fmt("tooltip[%s;%s]", vsb, v.hide and ES"Show waypoint" or ES"Hide waypoint"))

		if teleport_priv then
			local tp = fmt("waypoint_%u_teleport", i)
			fs("button", 0, y, ctn_len - 2.1, 0.6, tp, "")
		end

		if waypoint_preview then
			fs("image", 0.25, y - 3.5, 5, 4, PNG.bg_content)
			fs("button", 0.25, y - 3.35, 5, 0.55, "area_preview", v.name)
			fs("image_button", 4.65, y - 3.25, 0.25, 0.25,
				PNG.cancel_hover .. "^\\[brighten", "close_preview", "")

			local pos = minetest.string_to_pos(data.waypoints[i].pos)
			get_isometric_view(fs, pos, 0.6, y - 2.5)
		end
	end

	fs"style_type[label;font=normal;font_size=16]"
end

local function get_container(fs, data, player, yoffset, ctn_len)
	local name = data.player_name
	local esc_name = minetest.formspec_escape(name)

	add_subtitle(fs, "player_name", 0, ctn_len, 22, true, esc_name)

	yoffset = yoffset - 0.5

	fs(fmt("list[detached:i3_trash;main;%f,%f;1,1;]", 4.45, yoffset + 1.25))
	fs("image", 4.45, yoffset + 1.25, 1, 1, PNG.trash)

	local yextra = 2

	for i, title in ipairs(i3.categories) do
		local btn_name = fmt("btn_%s", title)
		fs(fmt("style[btn_%s;fgimg=%s;fgimg_hovered=%s;content_offset=0]", title,
			data.subcat == i and PNG[fmt("%s_hover", title)] or PNG[title],
			PNG[fmt("%s_hover", title)]))
		fs("image_button", 0.25 + ((i - 1) * 1.18), yextra - 0.2, 0.5, 0.5, "", btn_name, "")
		fs(fmt("tooltip[%s;%s]", btn_name, title:gsub("^%l", upper)))
	end

	fs("box", 0, yextra + 0.45, ctn_len, 0.045, "#bababa50")
	fs("box", (data.subcat - 1) * 1.18, yextra + 0.45, 1, 0.045, "#f9826c")

	local function not_installed(modname)
		fs("hypertext", 0, yextra + 0.9, ctn_len, 0.6, "not_installed",
			fmt("<global size=16><center><style color=%s font=mono>%s</style> not installed</center>",
				colors.blue, modname))
	end

	if data.subcat == 1 then
		get_waypoint_fs(fs, data, player, yextra, ctn_len)

	--[[elseif data.subcat == 2 then
		if not i3.modules.skins then
			return not_installed "skinsdb"
		end

		local _skins = skins.get_skinlist_for_player(name)
		local skin_name = skins.get_player_skin(player).name
		local sks, id = {}, 1

		for i, skin in ipairs(_skins) do
			if skin.name == skin_name then
				id = i
			end

			table.insert(sks, skin.name)
		end

		sks = table.concat(sks, ","):gsub(";", "")
		fs("label", 0, yextra + 0.85, fmt("%s:", ES"Select a skin"))
		fs(fmt("dropdown[0,%f;4,0.6;skins;%s;%u;true]", yextra + 1.1, sks, id))]]
	end
end

local function show_popup(fs, data)
	if data.confirm_trash then
		fs"style_type[box;colors=#999,#999,#808080,#808080]"

		for _ = 1, 3 do
			fs("box", 2.97, 10.75, 4.3, 0.5, "")
		end

		fs("label", 3.12, 11, "Confirm trash?")
		fs("image_button", 5.17, 10.75, 1, 0.5, "", "confirm_trash_yes", "Yes")
		fs("image_button", 6.27, 10.75, 1, 0.5, "", "confirm_trash_no", "No")

	elseif data.show_settings then
		fs"style_type[box;colors=#999,#999,#808080,#808080]"

		for _ = 1, 3 do
			fs("box", 2.1, 9.25, 6, 2, "")
		end

		for _ = 1, 3 do
			fs("box", 2.1, 9.25, 6, 0.5, "#707070")
		end

		fs("image_button", 7.75, 9.35, 0.25, 0.25, PNG.cancel_hover .. "^\\[brighten", "close_settings", "")

		local show_home = data.show_setting == "home"
		local show_sorting = data.show_setting == "sorting"
		local show_misc = data.show_setting == "misc"

		fs(fmt("style[setting_home;textcolor=%s;font=bold;sound=i3_click]",
			show_home and colors.yellow or "#fff"),
		   fmt("style[setting_sorting;textcolor=%s;font=bold;sound=i3_click]",
			show_sorting and colors.yellow or "#fff"),
		   fmt("style[setting_misc;textcolor=%s;font=bold;sound=i3_click]",
			show_misc and colors.yellow or "#fff"))

		fs("button", 2.2, 9.25, 1.8, 0.55, "setting_home", "Home")
		fs("button", 4,   9.25, 1.8, 0.55, "setting_sorting", "Sorting")
		fs("button", 5.8, 9.25, 1.8, 0.55, "setting_misc", "Misc.")

		if show_home then
			local coords, c, str = {"X", "Y", "Z"}, 0, ES"No home set"

			if data.home then
				str = data.home:gsub(",", "  "):sub(2,-2):gsub("%.%d", ""):gsub(
					"(%-?%d+)", function(a)
						c = c + 1
						return fmt("<b>%s: <style color=%s font=mono>%s</style></b>",
							coords[c], colors.black, a)
					end)
			end

			fs("hypertext", 2.1, 9.9, 6, 0.6, "home_pos", fmt("<global size=16><center>%s</center>", str))
			fs("image_button", 4.2, 10.4, 1.8, 0.7, "", "set_home", "Set home")

		elseif show_sorting then
			fs("button", 2.1, 9.7, 6, 0.8, "select_sorting", ES"Select the inventory sorting method:")

			fs(fmt("style[prev_sort;fgimg=%s;fgimg_hovered=%s]", PNG.prev, PNG.prev_hover),
			   fmt("style[next_sort;fgimg=%s;fgimg_hovered=%s]", PNG.next, PNG.next_hover))

			fs("image_button", 2.2, 10.6, 0.35, 0.35, "",  "prev_sort", "")
			fs("image_button", 7.65, 10.6, 0.35, 0.35, "", "next_sort", "")

			fs"style[sort_method;font=bold;font_size=20]"
			fs("button", 2.55, 10.36, 5.1, 0.8, "sort_method", toupper(data.sort))

			local idx = get_sorting_idx(data.sort)
			local desc = i3.sorting_methods[idx].description

			if desc then
				fs(fmt("tooltip[%s;%s]", "sort_method", desc))
			end

		elseif show_misc then
			fs("checkbox", 2.4, 10.05, "cb_inv_compress", "Compression", tostring(data.inv_compress))
			fs("checkbox", 2.4, 10.5,  "cb_reverse_sorting", "Reverse mode", tostring(data.reverse_sorting))
			fs("checkbox", 2.4, 10.95, "cb_ignore_hotbar", "Ignore hotbar", tostring(data.ignore_hotbar))
			fs("checkbox", 5.4, 10.05, "cb_auto_sorting", "Automation", tostring(data.auto_sorting))

			for _ = 1, 3 do
				fs("box", 5.4, 10.68, 2.4, 0.45, "#707070")
			end

			fs(fmt("tooltip[cb_inv_compress;%s;#707070;#fff]",
				ES"Enable this option to compress your inventory"),
			   fmt("tooltip[cb_reverse_sorting;%s;#707070;#fff]",
				ES"Enable this option to sort your inventory in reverse order"),
			   fmt("tooltip[cb_ignore_hotbar;%s;#707070;#fff]",
				ES"Enable this option to sort your inventory except the hotbar slots"),
			   fmt("tooltip[cb_auto_sorting;%s;#707070;#fff]",
				ES"Enable this option to sort your inventory automatically"))
		end
	end
end

local function get_inventory_fs(player, data, fs)
	fs"listcolors[#bababa50;#bababa99]"

	get_inv_slots(fs)

	local props = player:get_properties()
	local ctn_len, ctn_hgt, yoffset = 5.7, 6.3, 0

	if props.mesh ~= "" then
		local anim = player:get_local_animation()
		local armor_skin = i3.modules.armor or i3.modules.skins
		local t = {}

		for _, v in ipairs(props.textures) do
			table.insert(t, (minetest.formspec_escape(v):gsub(",", "!")))
		end

		local textures = table.concat(t, ","):gsub("!", ",")

		--fs("style[player_model;bgcolor=black]")
		fs("model", 0.2, 0.2, armor_skin and 4 or 3.4, ctn_hgt,
			"player_model", props.mesh, textures, "0,-150", "false", "false",
			fmt("%u,%u%s", anim.x, anim.y, data.fs_version >= 5 and ";30" or ""))
	else
		local size = 2.5
		fs("image", 0.7, 0.2, size, size * props.visual_size.y, props.textures[1])
	end

	local max_val = 7

	if data.subcat == 1 then
		local wp = #data.waypoints

		if wp > 0 then
			local mul = (wp > 8 and 7) or (wp > 4 and 6) or 5
			max_val = max_val + 11 + (wp * mul)
		end
	end

	fs(fmt([[
		scrollbaroptions[arrows=hide;thumbsize=%d;max=%d]
		scrollbar[%f,0.2;0.2,%f;vertical;scrbar_inv;%u]
		scrollbaroptions[arrows=default;thumbsize=0;max=1]
	]],
	(max_val * 4) / 12, max_val, 9.8, ctn_hgt, data.scrbar_inv))

	fs(fmt("scroll_container[3.9,0.2;%f,%f;scrbar_inv;vertical]", ctn_len, ctn_hgt))
	get_container(fs, data, player, yoffset, ctn_len)
	fs"scroll_container_end[]"

	local btn = {
		{"trash",    ES"Clear inventory"},
		{"sort",     ES"Sort inventory"},
		{"settings", ES"Settings"},
		{"home",     ES"Go home"},
	}

	for i, v in ipairs(btn) do
		local btn_name, tooltip = unpack(v)
		fs(fmt("style[%s;fgimg=%s;fgimg_hovered=%s;content_offset=0]",
			btn_name, PNG[btn_name], PNG[fmt("%s_hover", btn_name)]))
		fs("image_button", i + 3.43 - (i * 0.4), 11.43, 0.35, 0.35, "", btn_name, "")
		fs(fmt("tooltip[%s;%s]", btn_name, tooltip))
	end

	show_popup(fs, data)
end

local function hide_items(player, data)
	if compression_active(data) then
		local new = {}

		for i = 1, #data.items do
			local item = data.items[i]
			if not i3.compressed[item] then
				table.insert(new, item)
			end
		end

		data.items = new
	end

	if not minetest.is_creative_enabled(data.player_name) then
		local new = {}

		for i = 1, #data.items do
			local item = data.items[i]
			local recipes, usages = get_recipes(player, item)

			if recipes or usages then
				table.insert(new, item)
			end
		end

		data.items = new
	end
end

local function get_items_fs(fs, data, player, full_height)
	hide_items(player, data)

	local items = data.alt_items or data.items or {}
	local rows, lines = 8, 12
	local ipp = rows * lines
	local size = 0.85

	fs("bg9", data.inv_width + 0.1, 0, 7.9, full_height, PNG.bg_full, 10)

	fs(fmt("box[%f,0.2;4.05,0.6;#bababa25]", data.inv_width + 0.3),
	   "set_focus[filter]",
	   fmt("field[%f,0.2;2.95,0.6;filter;;%s]", data.inv_width + 0.35, minetest.formspec_escape(data.filter)),
	   "field_close_on_enter[filter;false]")

	fs("image_button", data.inv_width + 3.35, 0.35, 0.3,  0.3,  "", "cancel", "")
	fs("image_button", data.inv_width + 3.85, 0.32, 0.35, 0.35, "", "search", "")
	fs("image_button", data.inv_width + 5.27, 0.3,  0.35, 0.35, "", "prev_page", "")
	fs("image_button", data.inv_width + 7.45, 0.3,  0.35, 0.35, "", "next_page", "")

	data.pagemax = math.max(1, math.ceil(#items / ipp))

	fs("button", data.inv_width + 5.6, 0.14, 1.88, 0.7, "pagenum",
		fmt("%s / %u", minetest.colorize(colors.yellow, data.pagenum), data.pagemax))

	if #items == 0 then
		local lbl = ES"No item to show"

		if minetest.sha1(data.filter) == "7f7342b806f4d8dfb16e57ce289ee8cf72d5aa37" then
			lbl = ES"uwu"
		end

		if next(i3.recipe_filters) and #i3.init_items > 0 and data.filter == "" then
			lbl = ES"Collect items to reveal more recipes"
		end

		fs("button", data.inv_width + 0.1, 3, 8, 1, "no_item", lbl)
	else
		local first_item = (data.pagenum - 1) * ipp

		for i = first_item, first_item + ipp - 1 do
			local item = items[i + 1]
			if not item then break end

			local _compressed = item:sub(1, 1) == "_"
			local name = _compressed and item:sub(2) or item

			local X = i % rows
			      X = X - (X * 0.045) + data.inv_width + 0.28

			local Y = round((i % ipp - X) / rows + 1, 0)
			      Y = Y - (Y * 0.085) + 0.95

			table.insert(fs, fmt("item_image_button", X, Y, size, size, name, item, ""))

			if compressible(item, data) then
				local expand = data.expand == name

				fs(fmt("tooltip[%s;%s]", item, expand and ES"Click to hide" or ES"Click to expand"))
				fs"style_type[label;font=bold;font_size=20]"
				fs("label", X + 0.65, Y + 0.7, expand and "-" or "+")
				fs"style_type[label;font=normal;font_size=16]"
			end
		end
	end

	local _tabs = {"All", "Nodes", "Items"}
	local tab_len, tab_hgh = 1.8, 0.5

	for i, title in ipairs(_tabs) do
		local selected = i == data.itab
		fs(fmt([[style_type[image_button;fgimg=%s;fgimg_hovered=%s;noclip=true;
			font_size=16;textcolor=%s;content_offset=0] ]],
		selected and PNG.tab_small_hover or PNG.tab_small,
		PNG.tab_small_hover, selected and "#fff" or "#ddd"))

		fs"style_type[image_button:hovered;textcolor=#fff]"
		fs("image_button", (data.inv_width - 0.65) + (i * (tab_len + 0.1)),
			full_height, tab_len, tab_hgh, "", fmt("itab_%u", i), title)
	end
end

local function get_tabs_fs(fs, player, data, full_height)
	local tab_len, tab_hgh, c, over = 3, 0.5, 0
	local _tabs = table.copy(i3.tabs)

	for i, def in ipairs(i3.tabs) do
		if def.access and not def.access(player, data) then
			table.remove(_tabs, i)
		end
	end

	local shift = math.min(3, #_tabs)

	for i, def in ipairs(_tabs) do
		if not over and c > 2 then
			over = true
			c = 0
		end

		local btm = i <= 3

		if not btm then
			shift = #_tabs - 3
		end

		local selected = i == data.tab

		fs(fmt([[style_type[image_button;fgimg=%s;fgimg_hovered=%s;noclip=true;
			font_size=16;textcolor=%s;content_offset=0] ]],
		selected and (btm and PNG.tab_hover or PNG.tab_hover_top) or (btm and PNG.tab or PNG.tab_top),
		btm and PNG.tab_hover or PNG.tab_hover_top, selected and "#fff" or "#ddd"))

		local X = (data.inv_width / 2) + (c * (tab_len + 0.1)) - ((tab_len + 0.05) * (shift / 2))
		local Y = btm and full_height or -tab_hgh

		fs"style_type[image_button:hovered;textcolor=#fff]"
		fs("image_button", X, Y, tab_len, tab_hgh, "", fmt("tab_%s", def.name), minetest.formspec_escape(def.description))

		if true_str(def.image) then
			local desc = minetest.get_translated_string(data.lang_code, def.description)
			fs("style_type[image;noclip=true]")
			fs("image", X + (tab_len / 2) - ((#desc * 0.1) / 2) - 0.55,
				Y + 0.05, 0.35, 0.35, fmt("%s^\\[resize:16x16", def.image))
		end

		c = c + 1
	end
end

local function get_debug_grid(data, fs, full_height)
	fs"style[hide_debug_grid;noclip=true]"
	fs("button", -2, full_height - 1, 2, 1, "hide_debug_grid", "Toggle grid")
	if data.hide_debug_grid then return end

	fs("style_type[label;font_size=8;noclip=true]")
	local spacing, i = 0.2, 1

	for x = 0, data.inv_width + 8, spacing do
		fs("box", x, 0, 0.01, full_height, "#ff0")
		fs("label", x, full_height + 0.1, tostring(i))
		i = i + 1
	end

	i = 61

	for y = 0, full_height, spacing do
		fs("box", 0, y, data.inv_width + 8, 0.01, "#ff0")
		fs("label", -0.15, y, tostring(i))
		i = i - 1
	end

	fs("box", data.inv_width / 2, 0, 0.01, full_height, "#f00")
	fs("box", 0, full_height / 2, data.inv_width, 0.01, "#f00")
	fs"style_type[label;font_size=16]"
end

local function make_fs(player, data)
	local start = debug_mode and minetest.get_us_time() or nil

	local fs = setmetatable({}, {
		__call = function(t, ...)
			local args = {...}
			local elem = fs_elements[args[1]]

			if elem then
				table.insert(t, fmt(elem, select(2, ...)))
			else
				table.insert(t, table.concat(args))
			end
		end
	})

	data.inv_width = 10.23
	local full_height = 12

	fs(fmt("formspec_version[4]size[%f,%f]no_prepend[]bgcolor[#0000]",
		data.inv_width + 8, full_height), styles)

	fs("bg9", 0, 0, data.inv_width, full_height, PNG.bg_full, 10)

	local tab = i3.tabs[data.tab]
	if tab then
		tab.formspec(player, data, fs)
	end

	get_items_fs(fs, data, player, full_height)

	if #i3.tabs > 1 then
		get_tabs_fs(fs, player, data, full_height)
	end

	if debug_mode then
		get_debug_grid(data, fs, full_height)
		msg(data.player_name, fmt("make_fs(): %.2f ms", (minetest.get_us_time() - start) / 1000))
		msg(data.player_name, fmt("#fs elements: %u", #fs))
	end

	return table.concat(fs)
end

return make_fs, get_inventory_fs
