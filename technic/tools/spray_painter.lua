local S = technic.getter

local spray_painter_max_charge = 10000
local spray_painter_charge_per_application = 1

minetest.register_node ("technic:paint_layer", {
	description = S("Paint"),
	drawtype = "nodebox",
	tiles = {"technic_paint.png^[colorize:#FF0000"},
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
	groups = {attached_node = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
-- 	on_place = minetest.rotate_node,
})


local function spray_paint(itemstack, user, pointed_thing)
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local target = minetest.get_node_or_nil(pointed_thing.above)
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
	minetest.swap_node(pointed_thing.above, {name = "technic:paint_layer", param2 = xxx})

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