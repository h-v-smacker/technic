-- This is a decorative tool to paint exposed surfaces in some basic colors
-- can be used to cover up unpleasant areas (e.g. cobblestone walls)
-- or to mark areas with colors (colored paths on floors, color lines on walls)
-- Colors are grouped together in 9 modes. The HEX values are taken from the dye
-- textures from dye mod of minetest_game. Within every mode, the colors are cycled from
-- brighter to darker hue on every subsequent application of the tool.

local S = technic.getter

local spray_painter_max_charge = 10000
local spray_painter_cpa = 10

local color_modes = {
	{name = S("Red"), index = 1, n = 2, ct = {"c91818", "730505"}},
	{name = S("Yellow and Orange"), index = 3, n = 4, ct = {"fcf611", "ffc20b", "e0601a", "b52607"}},
	{name = S("Green and Dark Green"), index = 7, n = 4, ct = {"67eb1c", "4bb71c", "2b7b00", "154f00"}},
	{name = S("Blue and Violet"), index = 11, n = 4, ct = {"00519d", "003376", "480680", "3b0367"}},
	{name = S("Pink and Magenta"), index = 15, n = 4, ct = {"ffa5a5", "ff7272", "d80481", "a90145"}},
	{name = S("Cyan"), index = 19, n = 2, ct = {"00959d", "00676f"}},
	{name = S("Brown"), index = 21, n = 2, ct = {"6c3800", "391a00"}},
	{name = S("White and Grey"), index = 23, n = 4, ct = {"eeeeee", "b8b8b8", "9c9c9c", "5c5c5c"}},
	{name = S("Dark Grey and Black"), index = 27, n = 4, ct = {"494949", "292929", "222222", "1b1b1b"}} -- 2 middle colors are swapped
}

minetest.register_node ("technic:paint_layer", {
	description = S("Paint"),
	drawtype = "nodebox",
	tiles = {"technic_paint.png"},
	node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
			wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
                },
	drop = "",
	groups = {attached_node = 1, dig_immediate = 2, not_in_creative_inventory = 1, not_blocking_trains = 1},
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "technic_paint_palette.png",
})

minetest.register_node ("technic:fluorescent_paint_layer", {
	description = S("Fluorescent Paint"),
	drawtype = "nodebox",
	tiles = {"technic_paint.png"},
	node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
			wall_top = {-0.5, 0.49, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.49, 0.5, 0.5},
                },
	drop = "",
	groups = {attached_node = 1, dig_immediate = 2, not_in_creative_inventory = 1, not_blocking_trains = 1},
	light_source = 5,
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "technic_paint_palette.png",
})


local function spray_painter_setmode(user, itemstack, meta, f)
	local player_name = user:get_player_name()
	
	if not meta then
		meta = {mode = nil}
	end
	if not meta.mode then
		minetest.chat_send_player(player_name, 
			S("Use while sneaking to change Spray Painter modes."))
		meta.mode = 0
	end
	
	meta.mode = meta.mode % 9 + 1
	
	local tool = "technic:spray_painter"
	if f then
		tool = "technic:fluorescent_spray_painter"
	end
	
	minetest.chat_send_player(player_name, 
		S("Spray Painter: %s"):format(color_modes[meta.mode].name))
	itemstack:set_name(tool .. "_" .. meta.mode);
	itemstack:set_metadata(minetest.serialize(meta))
	return itemstack
end

local function spray_paint(itemstack, user, pointed_thing, ptype)
	
	local meta = minetest.deserialize(itemstack:get_metadata())
	local keys = user:get_player_control()
	
	if user.get_pos == nil then
		-- we are held in a node breaker and it will not work
		return itemstack
	end
	
	if not meta or not meta.mode or keys.sneak then
		return spray_painter_setmode(user, itemstack, meta, ptype)
	end
	
	if not meta or not meta.charge or meta.charge < spray_painter_cpa then
		return itemstack
	end
	
	
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	minetest.sound_play("technic_spray_painter", {
		pos = user:get_pos(),
		gain = 0.4,
	})
	
	-- player needs to own both the wall and its surface
	local pname = user:get_player_name()
	if minetest.is_protected(pointed_thing.under, pname) or 
		minetest.is_protected(pointed_thing.above, pname) then
		minetest.record_protection_violation(pointed_thing.under, pname)
		return itemstack
	end
	
	local paint_name = "technic:paint_layer"
	if ptype then
		paint_name = "technic:fluorescent_paint_layer"
	end
	
	local target = minetest.get_node_or_nil(pointed_thing.under) 
	
	-- if pointing at plastic blocks
	
	if target and minetest.get_item_group(target.name, "paintable_plastic_block") > 0 then
		
		local p2 = target.param2
		local orientation = p2 % 8
		local cindex = (p2 - orientation) / 8
		local new_cindex = cindex + 1
		if new_cindex < color_modes[meta.mode].index - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		if new_cindex > color_modes[meta.mode].index + (color_modes[meta.mode].n - 1) - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		
		minetest.swap_node(pointed_thing.under, {
									name = target.name, 
									param2 = new_cindex*8 + orientation
									})
		
		if not technic.creative_mode then
			meta.charge = meta.charge - spray_painter_cpa
			technic.set_RE_wear(itemstack, meta.charge, spray_painter_max_charge)
			itemstack:set_metadata(minetest.serialize(meta))
		end
		
		
		return itemstack
	end
	

	-- if the tool is pointed at a layer of paint -> cycling colors
	
	if target and target.name == paint_name then
	
		local p2 = target.param2
		local orientation = p2 % 8
		local cindex = (p2 - orientation) / 8
		local new_cindex = cindex + 1
		if new_cindex < color_modes[meta.mode].index - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		if new_cindex > color_modes[meta.mode].index + (color_modes[meta.mode].n - 1) - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		
		minetest.swap_node(pointed_thing.under, {
									name = target.name, 
									param2 = new_cindex*8 + orientation
									})
		
		if not technic.creative_mode then
			meta.charge = meta.charge - spray_painter_cpa
			technic.set_RE_wear(itemstack, meta.charge, spray_painter_max_charge)
			itemstack:set_metadata(minetest.serialize(meta))
		end
		
		return itemstack
	end
	
	-- otherwise, spray some paint anew
	
	target = minetest.get_node_or_nil(pointed_thing.above)
		
	if not target or target.name ~= "air" then
		return itemstack
	end

	local diff = vector.subtract(pointed_thing.under, pointed_thing.above)
	local wdr = minetest.dir_to_wallmounted(diff)
	minetest.swap_node(pointed_thing.above, {
								name = paint_name, 
								param2 = (color_modes[meta.mode].index - 1) * 8 + wdr
								})

	if not technic.creative_mode then
		meta.charge = meta.charge - spray_painter_cpa
		technic.set_RE_wear(itemstack, meta.charge, spray_painter_max_charge)
		itemstack:set_metadata(minetest.serialize(meta))
	end
	return itemstack
	
end
                                  
technic.register_power_tool("technic:spray_painter", spray_painter_max_charge)
minetest.register_tool("technic:spray_painter", {
	description = S("Spray Painter"),
	inventory_image = "technic_spray_painter.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
		spray_paint(itemstack, user, pointed_thing, false)
		return itemstack
	end,
})


for i = 1, 9 do
	technic.register_power_tool("technic:spray_painter_" .. i, spray_painter_max_charge)
	minetest.register_tool("technic:spray_painter_" .. i, {
		description = S("Spray Painter: %s"):format(color_modes[i].name),
		inventory_image = "technic_spray_painter.png^technic_tool_mode" .. i .. ".png",
		wield_image = "technic_spray_painter.png",
		wear_represents = "technic_RE_charge",
		on_refill = technic.refill_RE_charge,
		groups = {not_in_creative_inventory = 1},
		on_use = function(itemstack, user, pointed_thing)
			spray_paint(itemstack, user, pointed_thing, false)
			return itemstack
		end,
	})
end


-- Provide a crafting recipe
local trigger = minetest.get_modpath("mesecons_button") and "mesecons_button:button_off" 
	or "default:mese_crystal_fragment"

minetest.register_craft({
	output = 'technic:spray_painter',
	recipe = {
		{'pipeworks:tube_1', 'technic:stainless_steel_ingot', 'technic:battery'},
		{'', 'vessels:steel_bottle', trigger},
		{'dye:red', 'dye:green', 'dye:blue'},
	}
})


-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

technic.register_power_tool("technic:fluorescent_spray_painter", spray_painter_max_charge)
minetest.register_tool("technic:fluorescent_spray_painter", {
	description = S("Fluorescent Spray Painter"),
	inventory_image = "technic_spray_painter_fluorescent.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = function(itemstack, user, pointed_thing)
		spray_paint(itemstack, user, pointed_thing, true)
		return itemstack
	end,
})


for i = 1, 9 do
	technic.register_power_tool("technic:fluorescent_spray_painter_" .. i, spray_painter_max_charge)
	minetest.register_tool("technic:fluorescent_spray_painter_" .. i, {
		description = S("Fluorescent Spray Painter: %s"):format(color_modes[i].name),
		inventory_image = "technic_spray_painter_fluorescent.png^technic_tool_mode" .. i .. ".png",
		wield_image = "technic_spray_painter_fluorescent.png",
		wear_represents = "technic_RE_charge",
		on_refill = technic.refill_RE_charge,
		groups = {not_in_creative_inventory = 1},
		on_use = function(itemstack, user, pointed_thing)
			spray_paint(itemstack, user, pointed_thing, true)
			return itemstack
		end,
	})
end


-- Provide a crafting recipe
local trigger = minetest.get_modpath("mesecons_button") and "mesecons_button:button_off" 
	or "default:mese_crystal_fragment"

minetest.register_craft({
	output = 'technic:fluorescent_spray_painter',
	recipe = {
		{'pipeworks:tube_1', 'technic:stainless_steel_ingot', 'technic:battery'},
		{'technic:uranium_ingot', 'vessels:steel_bottle', trigger},
		{'dye:red', 'dye:green', 'dye:blue'},
	}
})