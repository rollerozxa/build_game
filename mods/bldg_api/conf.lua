
-- Grab current minetest.settings
local global_conf = minetest.settings

-- Grab settings from (world)/minetest.conf and overlay it on top of
-- the 'conf' settings variable
bldg.conf_world = Settings(minetest.get_worldpath()..'/minetest.conf')

-- Merge them onto a new throwaway config. First the global config
-- then the per-world config overriding any potential overlap.
bldg.conf = Settings(minetest.get_worldpath()..'/blackhole') -- Just anything to please sandboxer
for k,v in pairs(global_conf:to_table()) do
	if type(v) ~= "table" then
		bldg.conf:set(k,v)
	end
end
for k,v in pairs(bldg.conf_world:to_table()) do
	if type(v) ~= "table" then
		bldg.conf:set(k,v)
	end
end
