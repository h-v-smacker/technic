local S = technic.getter

local spray_painter_max_charge = 10000
local spray_painter_charge_per_application = 1

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
-- 	tiles = {"technic_paint.png^[colorize:#FF0000"},
	tiles = {"technic_paint.png"},
	node_box = {
			type = "wallmounted",
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.499, 0.5},
			wall_top = {-0.5, 0.499, -0.5, 0.5, 0.5, 0.5},
			wall_side = {-0.5, -0.5, -0.5, -0.499, 0.5, 0.5},
                },
-- 	node_box = {
-- 		type = "fixed",
-- 		fixed = {-0.5, -0.5, -0.5, 0.5, -0.499, 0.5},
-- 		},
	drop = "",
	groups = {attached_node = 1, dig_immediate = 2},
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "technic_paint_palette.png",
-- 	on_place = minetest.rotate_node,
})


local function spray_painter_setmode(user, itemstack, meta)
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
	
	minetest.chat_send_player(player_name, 
		S("Spray Painter: %s"):format(color_modes[meta.mode].name))
	itemstack:set_name("technic:spray_painter_" .. meta.mode);
	itemstack:set_metadata(minetest.serialize(meta))
	return itemstack
end

local function spray_paint(itemstack, user, pointed_thing)
	
	local meta = minetest.deserialize(itemstack:get_metadata())
	local keys = user:get_player_control()
	
	if not meta or not meta.mode or keys.sneak then
		return spray_painter_setmode(user, itemstack, meta)
	end
	
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	
	local target = minetest.get_node_or_nil(pointed_thing.under) 
	
	if target and target.name == "technic:paint_layer" then
		local p2 = target.param2
-- 		local p2 = meta:get_int("param2")
		local orientation = p2 % 8
		local cindex = (p2 - orientation) / 8
		local new_cindex = cindex + 1
		if new_cindex < color_modes[meta.mode].index - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		if new_cindex > color_modes[meta.mode].index + (color_modes[meta.mode].n - 1) - 1 then
			new_cindex = color_modes[meta.mode].index - 1
		end
		minetest.chat_send_all("---> " .. tostring(orientation) .. " --- " .. tostring(cindex))
		
-- 		minetest.swap_node(pointed_thing.under, {name = target.name, param2 = (cindex + 1)*8 + orientation})
		minetest.swap_node(pointed_thing.under, {name = target.name, param2 = new_cindex*8 + orientation})
		
		return itemstack
	end
	
	
	target = minetest.get_node_or_nil(pointed_thing.above)
		
	if not target or target.name ~= "air" then
		return itemstack
	end

	local meta = minetest.deserialize(itemstack:get_metadata())
	if not meta or not meta.charge or
			meta.charge < spray_painter_charge_per_application then
		return
	end

	local name = user:get_player_name()
	if minetest.is_protected(pointed_thing.under, name) then
		minetest.record_protection_violation(pointed_thing.under, name)
		return
	end
	
	
	
	minetest.chat_send_all("below: " .. minetest.serialize(pointed_thing.under))
	minetest.chat_send_all("above: " .. minetest.serialize(pointed_thing.above))
-- 	minetest.swap_node(pointed_thing.above, {name = "default:dirt"})
-- 	minetest.swap_node(pointed_thing.under, {name = "default:cobble"})
	local rrr = vector.subtract(pointed_thing.under, pointed_thing.above)
	minetest.chat_send_all(minetest.serialize(rrr))
	local xxx = minetest.dir_to_wallmounted(rrr)
	minetest.chat_send_all(minetest.serialize(xxx))
-- 	local t = {x = pointed_thing.above.x, y = pointed_thing.above.y, z = pointed_thing.above.z}
-- 	minetest.chat_send_all("--->" .. minetest.serialize(t))	
-- 	minetest.place_node(t, {name = "technic:paint_layer", param2 = xxx})
	minetest.swap_node(pointed_thing.above, {name = "technic:paint_layer", param2 = (color_modes[meta.mode].index - 1) * 8 + xxx})

-- 	minetest.rotate_node(ItemStack({name = "technic:paint_layer"}), user, pointed_thing)
	
-- 	local player_pos = user:getpos()
-- 	local player_name = user:get_player_name()
-- 	local dir = user:get_look_dir()
-- 
-- 	local start_pos = vector.new(player_pos)
-- 	-- Adjust to head height
-- 	start_pos.y = start_pos.y + 1.6
-- 	local last_air = {}
-- 	for pos in technic.trace_node_ray(start_pos, dir, 5) do
-- 		local node = minetest.get_node_or_nil(pos)
-- 		minetest.chat_send_all(minetest.serialize(pos) .. node.name)
-- 		if not node then
-- 			break
-- 		end
-- 		if node.name == "air" then
-- 			last_air.x = pos.x
-- 			last_air.y = pos.y
-- 			last_air.z = pos.z
-- 		else
-- 			minetest.chat_send_all("---------> " .. minetest.serialize(last_air))
-- 			minetest.place_node(last_air, {name = "default:dirt"})
-- 			break
-- 		end
-- 		minetest.chat_send_all(minetest.serialize(last_air))
-- 		
-- 	end
	
	if not technic.creative_mode then
		technic.set_RE_wear(itemstack, meta.charge - spray_painter_charge_per_application, spray_painter_max_charge)
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
	on_use = spray_paint,
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
		on_use = spray_paint,
	})
end


-- Provide a crafting recipe
local trigger = minetest.get_modpath("mesecons_button") and "mesecons_button:button_off" 
	or "default:mese_crystal_fragment"

minetest.register_craft({
	output = 'technic:spray_painter',
	recipe = {
		{'default:stick', 'default:stick', trigger},
		{'technic:motor', 'default:stick', 'technic:battery'},
		{'technic:stainless_steel_ingot', 'default:stick', 'default:stick'},
	}
})