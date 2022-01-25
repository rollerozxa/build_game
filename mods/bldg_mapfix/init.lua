
minetest.register_chatcommand("mapfix", {
	params = "<size>",
	description = "Recalculate the light of an area.",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local pos = vector.round(player:get_pos())
		local size = tonumber(param) or 24

		if size < 1 or size > 120 then
			return false, minetest.colorize("#ff0000ff", "Invalid size (Must be between 1 and 120)")
		end

		size = math.floor(size - 8)

		local vm = minetest.get_voxel_manip(vector.subtract(pos, size), vector.add(pos, size))
		vm:write_to_map()

		return true, "Done"
	end,
})
