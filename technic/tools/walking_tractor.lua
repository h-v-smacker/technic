--[[
	Walking tractor: a dedicated farming tool, a miracle of small mechanization.
	Replaces hoes and harvests useful plants (fully-grown cultivars, mostly from farming)
	Has a variable swipe from 3 to 7 nodes, in either case - in a line, perpendicular
	to the user's direction of sight. For smaller areas there are always hoes.
	Modes 1-3 are for tilling
	Modes 4-6 are for harvesting
]]

-- Configuration
-- Intended to hold as much as the chainsaw, 10000 units
local walking_tractor_max_charge        = 20000
-- Can remove a curious number of objects
local walking_tractor_charge_per_object = 30
-- For tilling: cost is less but spent regardless of actual success
local walking_tractor_charge_per_tilled_node = 25

local S = technic.getter

local walking_tractor_mode_text = {
	S("3 blocks wide tilling"),
	S("5 blocks wide tilling"),
	S("7 blocks wide tilling"),
	S("3 blocks wide harvesting"),
	S("5 blocks wide harvesting"),
	S("7 blocks wide harvesting"),
}

local ripe_for_harvest = {
	"farming:barley_7",
	"farming:beanpole_5",
	"farming:blueberry_4",
	"farming:carrot_8",
	"farming:chili_8",
	"farming:cocoa_4",
	"farming:coffee_5",
	"farming:corn_8",
	"farming:cotton_8",
	"farming:cucumber_4",
	"farming:garlic_5",
	"farming:grapes_8",
	"farming:hemp_8",
	"farming:melon_8",
	"farming:onion_5",
	"farming:pea_5",
	"farming:pepper_5",
	"farming:pineapple_8",
	"farming:potato_4",
	"farming:pumpkin_8",
	"farming:raspberry_4",
	"farming:rhubarb_3",
	"farming:tomato_8",
	"farming:wheat_8",
	"ethereal:onion_5",
	"ethereal:strawberry_8",
}

local node_removed

-- Mode switcher for the tool
local function walking_tractor_setmode(user, itemstack, meta)
	local player_name = user:get_player_name()

	if not meta then
		meta = {mode = nil}
	end
	if not meta.mode then
		minetest.chat_send_player(player_name, 
			S("Use while sneaking to change Walking Tractor modes."))
		meta.mode = 0
	end
	
	meta.mode = meta.mode % 6 + 1
	
	minetest.chat_send_player(player_name, 
		S("Walking Tractor Mode %d"):format(meta.mode) .. ": "
		.. walking_tractor_mode_text[meta.mode])
	itemstack:set_name("technic:walking_tractor_" .. meta.mode);
	itemstack:set_metadata(minetest.serialize(meta))
	return itemstack
end


-- Perform the trimming action
local function work_on_soil(itemstack, user, pointed_thing)
	local meta = minetest.deserialize(itemstack:get_metadata())
	local keys = user:get_player_control()
	
	if not meta or not meta.mode or keys.sneak then
		return walking_tractor_setmode(user, itemstack, meta)
	end
	
	meta.charge = meta.charge or 0
	
	if meta.charge < walking_tractor_charge_per_object then
		return -- no charge for even a single node, aborting
	end
	
	if pointed_thing.type ~= "node" then
		return itemstack
	end
	
	local name = user:get_player_name()
	if minetest.is_protected(pointed_thing.under, name) then
		minetest.record_protection_violation(pointed_thing.under, name)
		return
	end
	
	minetest.sound_play("technic_walking_tractor", {
-- 		to_player = user:get_player_name(),
		gain = 0.5,
	})
	
	local start_pos = {}
	local end_pos = {}

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
	
	local offset = meta.mode
	if offset > 3 then
		offset = offset - 3
	end
	offset = offset + 0.1

	if ldir > 1 then
	
		start_pos = {
			x = pointed_thing.under.x - offset,
			z = pointed_thing.under.z,
			y = pointed_thing.under.y - 0.1
		} 
		end_pos = {
			x = pointed_thing.under.x + offset,
			z = pointed_thing.under.z,
			y = pointed_thing.under.y + 1.1
		} 
	
	else
		start_pos = {
			x = pointed_thing.under.x,
			z = pointed_thing.under.z - offset,
			y = pointed_thing.under.y - 0.1
		} 
		end_pos = {
			x = pointed_thing.under.x,
			z = pointed_thing.under.z + offset,
			y = pointed_thing.under.y + 1.1
		} 
		
	end

	
	
	if meta.mode <= 3 then
	-- tilling
		local found_obj = minetest.find_nodes_in_area(start_pos, end_pos, {"group:soil"})
		for _, f in ipairs(found_obj) do
			-- unfortunately, there is no callback to track the node change without
			-- digging it first
			if not minetest.is_protected(f, name) then
				minetest.remove_node(f)
				minetest.set_node(f, {name = "farming:soil"})
				meta.charge = meta.charge - walking_tractor_charge_per_tilled_node
			end
			-- Abort if no charge left for another node
			if meta.charge < walking_tractor_charge_per_tilled_node then break end
		end
	
	else 
	-- harvesting
		-- Since nodes sometimes cannot be removed, we cannot rely on repeating 
		-- find_node_near() and removing found nodes
		local found_obj = minetest.find_nodes_in_area(start_pos, end_pos, ripe_for_harvest)
		for _, f in ipairs(found_obj) do
			node_removed = false
			-- Callback will set the flag to true if the node is dug successfully,
			-- otherwise skip to the next one.
			minetest.node_dig(f, minetest.get_node(f), user)
			if node_removed then
				meta.charge = meta.charge - walking_tractor_charge_per_object
				-- Abort if no charge left for another node
				if meta.charge < walking_tractor_charge_per_object then break end
			end
		end
	
	end
	
	-- The charge won't expire in creative mode, but the tool still 
	-- has to be charged prior to use
	if not technic.creative_mode then
		technic.set_RE_wear(itemstack, meta.charge, walking_tractor_max_charge)
		itemstack:set_metadata(minetest.serialize(meta))
	end
	return itemstack
end

function check_removal()
	node_removed = true
end

-- Register the tool and its varieties in the game
technic.register_power_tool("technic:walking_tractor", walking_tractor_max_charge)
minetest.register_tool("technic:walking_tractor", {
	description = S("Walking Tractor"),
	inventory_image = "technic_walking_tractor.png",
	stack_max = 1,
	wear_represents = "technic_RE_charge",
	on_refill = technic.refill_RE_charge,
	on_use = work_on_soil,
	after_use = check_removal
})

for i = 1, 6 do
	technic.register_power_tool("technic:walking_tractor_" .. i, walking_tractor_max_charge)
	minetest.register_tool("technic:walking_tractor_" .. i, {
		description = S("Walking Tractor Mode %d"):format(i),
		inventory_image = "technic_walking_tractor.png^technic_tool_mode" .. i .. ".png",
		wield_image = "technic_walking_tractor.png",
		wear_represents = "technic_RE_charge",
		on_refill = technic.refill_RE_charge,
		groups = {not_in_creative_inventory = 1},
		on_use = work_on_soil,
		after_use = check_removal
	})
end


-- Provide a crafting recipe
local trigger = minetest.get_modpath("mesecons_button") and "mesecons_button:button_off" 
	or "default:mese_crystal_fragment"

minetest.register_craft({
	output = 'technic:walking_tractor',
	recipe = {
		{'dye:green',                  'technic:battery',               trigger},
		{'technic:motor',              'technic:battery',               'default:stick'},
		{'technic:diamond_drill_head', 'technic:stainless_steel_ingot', 'technic:rubber'},
	}
})
