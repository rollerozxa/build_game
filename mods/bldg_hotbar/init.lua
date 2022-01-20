
local storage = minetest.get_mod_storage()

local hotbar_size_default = 9

local function validate_size(s)
	local size = s and tonumber(s) or hotbar_size_default
	return math.floor(0.5 + math.max(1, math.min(size, 32)))
end

local base_img = "bldg_hotbar_bg.png"
local imgref_len = string.len(base_img) + 8 -- accounts for the stuff in the string.format() below.

local img = {}
for i = 0, 31 do
	img[i+1] = string.format(":%04i,0=%s", i*78, base_img)
end
local hb_img = table.concat(img)

local function set_hotbar_size(player, s)
	local hotbar_size = validate_size(s)
	player:hud_set_hotbar_itemcount(hotbar_size)
	player:hud_set_hotbar_selected_image("bldg_hotbar_selected.png")
	player:hud_set_hotbar_image("[combine:"..(hotbar_size*78).."x78"..string.sub(hb_img, 1, hotbar_size*imgref_len))
	return hotbar_size
end

minetest.register_on_joinplayer(function(player)
	minetest.after(0.5,function()
		local name = player:get_player_name()
		if storage:get_int("size_"..name) ~= 0 then
			set_hotbar_size(player, storage:get_int("size_"..name))
		else
			set_hotbar_size(player, hotbar_size_default)
		end
	end)
end)

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar, from 1 to 32 slots, default 9",
	func = function(name, slots)
		local size = set_hotbar_size(minetest.get_player_by_name(name), slots)
		minetest.chat_send_player(name, "[_] Hotbar size set to " ..size.. ".")
		storage:set_int("size_"..name, size)
	end,
})
