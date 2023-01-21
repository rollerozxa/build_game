
function bldg.register_node(def)
	-- Shorthand, which is disabled if someone uses the long form
	local name
	if not def.name:find(":") then
		name = minetest.get_current_modname()..":"..def.name
	else
		name = def.name
	end

	def.groups = def.groups or { snappy = 3 }

	if type(def.tiles) == "string" then
		def.tiles = { def.tiles }
	end

	minetest.register_node(name, def)
end
