
if minetest.is_creative_enabled("") then
	local instant = {times = {[2] = digtime, [3] = 0}, uses = 0, maxlevel = 256}

	-- Override the hand tool
	minetest.override_item("", {
		range = 10,
		tool_capabilities = {
			max_drop_level = 3,
			groupcaps = {
				crumbly = instant,
				cracky  = instant,
				snappy  = instant,
				choppy  = instant,
				oddly_breakable_by_hand = instant,
				dig_immediate = instant,
			}
		}
	})
end

-- Unlimited node placement
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
	if placer and placer:is_player() then
		return minetest.is_creative_enabled(placer:get_player_name())
	end
end)

-- Don't pick up if the item is already in the inventory
local old_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	if not digger or not digger:is_player() or
		not minetest.is_creative_enabled(digger:get_player_name()) then
		return old_handle_node_drops(pos, drops, digger)
	end
	local inv = digger:get_inventory()
	if inv then
		for _, item in ipairs(drops) do
			if not inv:contains_item("main", item, true) then
				inv:add_item("main", item)
			end
		end
	end
end
