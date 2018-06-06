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
	paramtype2 = "wallmounted",
-- 	on_place = minetest.rotate_node,
})



local function spray_paint(itemstack, user, pointed_thing)
	if pointed_thing.type ~= "node" then
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
	
-- 	minetest.place_node(pointed_thing.above, {name = "technic:paint_layer"})
	minetest.rotate_node(ItemStack({name = "technic:paint_layer"}), user, pointed_thing)
	
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