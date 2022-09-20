
-- LBM's to process some stuff.

minetest.register_lbm({
	label = "Wipe container metadata",
	name = "bldg_compat:wipe_container_metadata",
	nodenames = {"default:chest", "default:furnace", "default:furnace_active"},
	--run_at_every_load = true,
	action = function(pos, node)
		minetest.get_meta(pos):from_table(nil)
	end
})
