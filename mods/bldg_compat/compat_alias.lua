
-- Replace nonexistant nodes with existing ones
for alias, item in pairs({
	bush_stem = 'bush_leaves',
	acacia_bush_stem = 'acacia_bush_leaves',
	pine_bush_stem = 'pine_bush_needles',
	cloud = 'cloud'
}) do
	minetest.register_alias("default:"..alias, "bldg_nodes:"..item)
end


-- "Dummy" out nodes with air
for _, item in pairs({
	'bush_sapling',
	'acacia_bush_sapling',
	'pine_bush_sapling',
	'blueberry_bush_sapling'
}) do
	minetest.register_alias("default:"..item, "air")
end


-- Make Build Game Bug-Free:tm:
for _, item in pairs({
	'butterflies:butterfly_red',
	'butterflies:butterfly_violet',
	'butterflies:butterfly_white',
	'fireflies:firefly'
}) do
	minetest.register_alias(item, "air")
end
