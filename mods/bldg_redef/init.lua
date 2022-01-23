-- Taken from Linuxdirk's redef mod, thanks! <3

minetest.register_on_mods_loaded(function()
	for id,definition in pairs(minetest.registered_nodes) do
		local groups = definition.groups
		local origin = definition.mod_origin

		local stair_or_slab = groups.stair or groups.slab
		local moreblocks_object = origin == 'moreblocks'

		if stair_or_slab or moreblocks_object then
			local tiles = definition.tiles
			local target_tiles = {}

			for index,_ in pairs(tiles) do
				if type(tiles[index]) == 'table' then
					tiles[index].align_style = 'world'
					target_tiles[index] = tiles[index]
				else
					target_tiles[index] = {
						name = tiles[index],
						align_style = 'world'
					}
				end
			end

			minetest.override_item(id, {
				tiles = target_tiles
			})
		end
	end
end)
