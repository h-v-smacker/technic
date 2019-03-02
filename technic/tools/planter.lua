--[[
	Planter: a tool for placing rows of objects (primarily, farming plants)
	Has 6 mods, corresponding to the width of the row (2...7 blocks). 1 block can be
	always planted by hand.
]]

-- Configuration
-- Intended to hold as much as the chainsaw, 20000 units
local planter_max_charge        = 20000
-- Cost of planting action
local planter_charge_per_object = 25


local S = technic.getter

local planter_mode_text = {
	S("2 blocks wide planting"),
	S("3 blocks wide planting"),
	S("4 blocks wide planting"),
	S("5 blocks wide planting"),
	S("6 blocks wide planting"),
	S("7 blocks wide planting"),
}


-- Mode switcher for the tool
local function planter_setmode(user, itemstack, meta)
	local player_name = user:get_player_name()

	if not meta then
		meta = {
			mode = nil
		}
	end
	if not meta.mode then
		minetest.chat_send_player(player_name, 
			S("Use while sneaking to change Planter modes."))
		meta.mode = 0
	end
	
	meta.mode = meta.mode % 6 + 1
	
	minetest.chat_send_player(player_name, 
		S("Planter Mode %d"):format(meta.mode) .. ": "
		.. planter_mode_text[meta.mode])
	itemstack:set_name("technic:planter_" .. meta.mode);
	itemstack:set_metadata(minetest.serialize(meta))
	return itemstack
end


-- Perform the trimming action
local function work_on_soil(itemstack, user, pointed_thing)
	
	local meta = minetest.deserialize(itemstack:get_metadata())
	local keys = user:get_player_control()
	
	if not meta or not meta.mode or keys.sneak then
		return planter_setmode(user, itemstack, meta)
	end
	
	meta.charge = meta.charge or 0
	
	local offset = meta.mode
	local offet_l = 0
	local offet_r = 0
	if offset % 2 > 0 then
		offset_r = math.floor(offset/2) + 1
		offset_l = math.floor(offset/2)
	else
		offset_r = offset / 2
		offset_l = offset / 2
	end
		
	
	if meta.charge < planter_charge_per_object * (offset+1) then
		return -- no charge for a complete row
	end
	
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local name = user:get_player_name()
	if minetest.is_protected(pointed_thing.under, name) then
		minetest.record_protection_violation(pointed_thing.under, name)
		return
	end
	
	local player_name = user:get_player_name()
	local inv = user:get_inventory()
	
	if not inv:contains_item("main", ItemStack({name=meta.selected, count = offset + 1})) then
		minetest.chat_send_player(player_name, S("Not enough " .. meta.selected .. " to continue!"))
		return itemstack
	end
	
	minetest.sound_play("technic_walking_tractor", {
-- 		to_player = user:get_player_name(),
		pos = user:get_pos(),
		gain = 0.5,
	})

	local c = 0
	
	local ldir = 0
	local udir = user:get_look_dir()
	if math.abs(udir.x) > math.abs(udir.z) then 
		if udir.x > 0 then
			ldir = 0 -- +X
		else 
			ldir = 1 -- -X
		end
	else
		if udir.z > 0 then
			ldir = 2 -- +Z
		else 
			ldir = 3 -- -Z
		end
	end
	
	if ldir == 1 or ldir == 2 then
		offset_r, offset_l = offset_l, offset_r
	end
	
	local work_pos = {}
	for delta = -offset_l,offset_r,1 do
		
		if ldir > 1 then
			-- along z axis value (x changes)
			work_pos = {
				type = "node",
				under = {x = pointed_thing.under.x + delta, y = pointed_thing.under.y, z = pointed_thing.under.z},
				above = {x = pointed_thing.under.x + delta, y = pointed_thing.under.y + 1, z = pointed_thing.under.z},
				ref = nil
			}
		else
			-- along x axis value (z changes)
			work_pos = {
				type = "node",
				under = {x = pointed_thing.under.x, y = pointed_thing.under.y, z = pointed_thing.under.z + delta},
				above = {x = pointed_thing.under.x, y = pointed_thing.under.y + 1, z = pointed_thing.under.z + delta},
				ref = nil
			}
		end
		

		local k = (minetest.registered_items[meta.selected] or {on_place=minetest.item_place}).on_place(ItemStack({name=meta.selected, count=1}), user, work_pos)
		if k then
			c = c + 1
		end
		
	end
	

	meta.charge = meta.charge - planter_charge_per_object * c

	-- The charge won't expire in creative mode, but the tool still 
	-- has to be charged prior to use
	if not technic.creative_mode then
		inv:remove_item("main", ItemStack({name=meta.selected, count = c}))
		technic.set_RE_wear(itemstack, meta.charge, planter_max_charge)
		itemstack:set_metadata(minetest.serialize(meta))
	end
	return itemstack
end

local function select_plant(itemstack, user, pointed_thing)
	if not user or not user:is_player() or user.is_fake_player then return end
	local meta = minetest.deserialize(itemstack:get_metadata())
	
	if not meta or not meta.selected then
		meta = {}
		meta.selected = "farming:seed_wheat"
		itemstack:set_metadata(minetest.serialize(meta))
	end
	
	minetest.show_formspec(user:get_player_name(), "technic:planter_control",
		"size[8,5]"..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"label[0,0;Crops selected:\n(Press to change)]"..
		"item_image_button[2,0;1,1;" .. meta.selected .. ";change;]" ..
		"button_exit[3,0;1,1;quit;Cancel]"..
		"label[5,0;   \nChange to:]"..
	      "list[current_player;main;7,0;1,1;31]" ..                
		"list[current_player;main;0,1;8,1;]" ..
		"list[current_player;main;0,2;8,3;8]" ..
		default.get_hotbar_bg(0,1))
	return
end


minetest.register_on_player_receive_fields(function(user, formname, fields)
	
	if formname ~= "technic:planter_control" then return false end
	if not user or not user:is_player() or user.is_fake_player then return end
	local itemstack = user:get_wielded_item()
	if not string.find(itemstack:get_name(), "^technic:planter") then return true end
                                          
	if fields.quit then
             return true
	end
                                          
	local meta = minetest.deserialize(itemstack:get_metadata())
	if not meta then
		meta = {}
	end
	                                    
	if fields.change then
		local inv = user:get_inventory()
		local item = inv:get_stack("main", 32) -- using the last cell
		local n = item:get_name()
		if n and n ~= "" then
			meta.selected = n
		end
	end                                     
                                          
	itemstack:set_metadata(minetest.serialize(meta))
	user:set_wielded_item(itemstack)
	select_plant(itemstack, user, nil)
	return true
end)


-- Register the tool and its varieties in the game
technic.register_power_tool("technic:planter", planter_max_charge)
minetest.register_tool("technic:planter", {
	description = S("Planter"),
	groups = {technic_tool = 1, technic_powertool = 1},
	inventory_image = "technic_planter.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = work_on_soil,
	on_place = select_plant,
})

for i = 1, 6 do
	technic.register_power_tool("technic:planter_" .. i, planter_max_charge)
	minetest.register_tool("technic:planter_" .. i, {
		description = S("Planter Mode %d"):format(i),
		groups = {technic_tool = 1, technic_powertool = 1},
		inventory_image = "technic_planter.png^technic_tool_mode" .. i .. ".png",
		wield_image = "technic_planter.png",
		wear_represents = "technic_RE_charge",
		on_refill = technic.refill_RE_charge,
		groups = {not_in_creative_inventory = 1},
		on_use = work_on_soil,
		on_place = select_plant,
	})
end


-- Provide a crafting recipe
local trigger = minetest.get_modpath("mesecons_button") and "mesecons_button:button_off" 
	or "default:mese_crystal_fragment"

minetest.register_craft({
	output = 'technic:planter',
	recipe = {
		{'dye:red',       'technic:battery',               trigger},
		{'technic:motor', 'technic:battery',               'default:stick'},
		{'default:chest', 'technic:stainless_steel_ingot', 'technic:rubber'},
	}
})
