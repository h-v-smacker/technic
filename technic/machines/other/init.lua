local path = technic.modpath.."/machines/other"

-- mesecons and tubes related
dofile(path.."/injector.lua")
dofile(path.."/constructor.lua")

if technic.config:get_bool("enable_frames") and minetest.get_modpath("mesecons_mvps") ~= nil then
	dofile(path.."/frames.lua")
end

if minetest.get_modpath("mesecons_hydroturbine") then
	dofile(path.."/water_powered_grinder.lua")
end


-- Coal-powered machines
dofile(path.."/coal_alloy_furnace.lua")
dofile(path.."/coal_furnace.lua")
dofile(path.."/solar_furnace.lua")
dofile(path.."/water_extractor.lua")

dofile(path.."/anchor.lua")
