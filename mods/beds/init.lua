-- beds/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("beds")
local esc = minetest.formspec_escape

beds = {}
beds.get_translator = S

local modpath = minetest.get_modpath("beds")

-- Load files

dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
