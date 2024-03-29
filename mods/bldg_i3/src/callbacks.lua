local storage = ...
local fill_caches = i3.files.caches()
local init_hud = i3.files.hud()
local set_fs = i3.set_fs

local reset_data = i3.get("reset_data")

minetest.register_on_player_hpchange(function(player, hpchange)
	local name = player:get_player_name()
	local data = i3.data[name]
	if not data then return end

	local hp_max = player:get_properties().hp_max
	data.hp = math.min(hp_max, player:get_hp() + hpchange)

	set_fs(player)
end)

minetest.register_on_chatcommand(function(name)
	local player = minetest.get_player_by_name(name)
	minetest.after(0, set_fs, player)
end)

minetest.register_on_priv_grant(function(name, _, priv)
	if priv == "creative" or priv == "all" then
		local data = i3.data[name]
		reset_data(data)

		local player = minetest.get_player_by_name(name)
		minetest.after(0, set_fs, player)
	end
end)

minetest.register_on_player_inventory_action(function(player, _, _, info)
	local name = player:get_player_name()

	if not minetest.is_creative_enabled(name) and
	  ((info.from_list == "main"  and info.to_list == "craft") or
	   (info.from_list == "craft" and info.to_list == "main")  or
	   (info.from_list == "craftresult" and info.to_list == "main")) then
		set_fs(player)
	end
end)

if minetest.global_exists("skins") then
	i3.modules.skins = true
end

minetest.register_on_mods_loaded(function()
	fill_caches()
end)

local function get_lang_code(info)
	return info and info.lang_code
end

local function get_formspec_version(info)
	return info and info.formspec_version or 1
end

local function outdated(name)
	minetest.show_formspec(name, "i3_outdated",
		("size[6.5,1.3]image[0,0;1,1;i3_cancel.png]label[1,0;%s]button_exit[2.6,0.8;1,1;;OK]"):format(
		"Your Minetest client is outdated.\nGet the latest version on minetest.net to play the game."))
end

local function init_data(player, info)
	local name = player:get_player_name()
	i3.data[name] = i3.data[name] or {}
	local data = i3.data[name]

	data.player_name     = name
	data.filter          = ""
	data.pagenum         = 1
	data.items           = i3.init_items
	data.items_raw       = i3.init_items
	data.sort            = "alphabetical"
	data.show_setting    = "home"
	data.ignore_hotbar   = false
	data.auto_sorting    = false
	data.reverse_sorting = false
	data.inv_compress    = true
	data.export_counts   = {}
	data.tab             = 1
	data.itab            = 1
	data.subcat          = 1
	data.scrbar_inv      = 0
	data.lang_code       = get_lang_code(info)
	data.fs_version      = info.formspec_version

	local inv = player:get_inventory()
	inv:set_size("main", i3.settings.inv_size)

	minetest.after(0, set_fs, player)
end

local function save_data(player_name)
	local _data = table.copy(i3.data)

	for name, v in pairs(_data) do
	for dat in pairs(v) do
		if not i3.saves[dat] then
			_data[name][dat] = nil

			if player_name and i3.data[player_name] then
				i3.data[player_name][dat] = nil -- To free up some memory
			end
		end
	end
	end

	storage:set_string("data", minetest.serialize(_data))
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local info = minetest.get_player_information and minetest.get_player_information(name)

	if not info or get_formspec_version(info) < 4 then
		return outdated(name)
	end

	init_data(player, info)
	init_hud(player)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	save_data(name)
end)

minetest.register_on_shutdown(save_data)

local function routine()
	save_data()
	minetest.after(i3.settings.save_interval, routine)
end

minetest.after(i3.settings.save_interval, routine)
