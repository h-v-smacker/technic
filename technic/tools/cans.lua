local S = technic.getter

technic.cans = {
	["technic:water_can"] = {
		can_name = "technic:water_can",
		can_description = S("Water Can"),
		can_inventory_image = "technic_water_can.png",
		can_capacity = 16,
		liquid_source_name = "default:water_source",
		liquid_flowing_name = "default:water_flowing",
		recipe = {
			{'technic:zinc_ingot', 'technic:rubber', 'technic:zinc_ingot'},
			{'technic:carbon_steel_ingot', '', 'technic:carbon_steel_ingot'},
			{'technic:zinc_ingot', 'technic:carbon_steel_ingot', 'technic:zinc_ingot'},
		}
	},
	["technic:lava_can"] = {
		can_name = "technic:lava_can",
		can_description = S("Lava Can"),
		can_inventory_image = "technic_lava_can.png",
		can_capacity = 8,
		liquid_source_name = "default:lava_source",
		liquid_flowing_name = "default:lava_flowing",
		recipe = {
			{'technic:zinc_ingot', 'technic:stainless_steel_ingot', 'technic:zinc_ingot'},
			{'technic:stainless_steel_ingot', '', 'technic:stainless_steel_ingot'},
			{'technic:zinc_ingot', 'technic:stainless_steel_ingot', 'technic:zinc_ingot'},
		}
	},
	["technic:freshwater_can"] = {
		can_name = "technic:freshwater_can",
		can_description = S("Freshwater Can"),
		can_inventory_image = "technic_freshwater_can.png",
		can_capacity = 16,
		liquid_source_name = "default:river_water_source",
		liquid_flowing_name = "default:river_water_flowing",
		recipe = {
			{'default:tin_ingot', 'technic:rubber',    'default:tin_ingot'},
			{'default:tin_ingot', '',                  'default:tin_ingot'},
			{'default:tin_ingot', 'default:tin_ingot', 'default:tin_ingot'},
		}
	}
}


local function set_can_wear(itemstack, level, max_level)
	local temp
	if level == 0 then
		temp = 0
	else
		temp = 65536 - math.floor(level / max_level * 65535)
		if temp > 65535 then temp = 65535 end
		if temp < 1 then temp = 1 end
	end
	itemstack:set_wear(temp)
end

local function get_can_level(itemstack)
	if itemstack:get_metadata() == "" then
		return 0
	else
		return tonumber(itemstack:get_metadata())
	end
end

-- General-purpose function to manage cans externally (e.g. in recipes)
technic.manage_can_state = function(itemstack, change)

	if not technic.cans[itemstack:get_name()] then
		return nil
	end

	local capacity = technic.cans[itemstack:get_name()].can_capacity
	if not capacity then
		return nil
	end
	
	local current_capacity = tonumber(itemstack:get_metadata())
	
	if not change then
		return current_capacity
	end
	
	current_capacity = current_capacity + change
	if current_capacity > capacity then
		current_capacity = capacity
	elseif current_capacity < 0 then
		current_capacity = 0
	end
	
	itemstack:set_metadata(tostring(current_capacity))
	
	set_can_wear(itemstack, current_capacity, capacity)
	
	return itemstack
	
end

function technic.register_can(d)
	local data = {}
	for k, v in pairs(d) do data[k] = v end
	minetest.register_tool(data.can_name, {
		description = data.can_description,
		inventory_image = data.can_inventory_image,
		stack_max = 1,
		wear_represents = "content_level",
		liquids_pointable = true,
		groups = {technic_can = 1, technic_tool = 1},
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type ~= "node" then return end
			local node = minetest.get_node(pointed_thing.under)
			if node.name ~= data.liquid_source_name then return end
			local charge = get_can_level(itemstack)
			if charge == data.can_capacity then return end
			if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
				minetest.log("action", user:get_player_name().." tried to take "..node.name.." at protected position "..minetest.pos_to_string(pointed_thing.under).." with a "..data.can_name)
				return
			end
			minetest.remove_node(pointed_thing.under)
			charge = charge + 1
			itemstack:set_metadata(tostring(charge))
			set_can_wear(itemstack, charge, data.can_capacity)
			return itemstack
		end,
		on_place = function(itemstack, user, pointed_thing)
			if pointed_thing.type ~= "node" then return end
			local pos = pointed_thing.under
			local def = minetest.registered_nodes[minetest.get_node(pos).name] or {}
			if def.on_rightclick and user and not user:get_player_control().sneak then
				return def.on_rightclick(pos, minetest.get_node(pos), user, itemstack, pointed_thing)
			end
			if not def.buildable_to then
				pos = pointed_thing.above
				def = minetest.registered_nodes[minetest.get_node(pos).name] or {}
				if not def.buildable_to then return end
			end
			local charge = get_can_level(itemstack)
			if charge == 0 then return end
			if minetest.is_protected(pos, user:get_player_name()) then
				minetest.log("action", user:get_player_name().." tried to place "..data.liquid_source_name.." at protected position "..minetest.pos_to_string(pos).." with a "..data.can_name)
				return
			end
			minetest.set_node(pos, {name=data.liquid_source_name})
			charge = charge - 1
			itemstack:set_metadata(tostring(charge))
			set_can_wear(itemstack, charge, data.can_capacity)
			return itemstack
		end,
		on_refill = function(stack)
			stack:set_metadata(tostring(data.can_capacity))
			set_can_wear(stack, data.can_capacity, data.can_capacity)
			return stack
		end,
	})
end

-- Registration of cans
for can, def in pairs(technic.cans) do
	
	technic.register_can({
		can_name = def.can_name,
		can_description = def.can_description,
		can_inventory_image = def.can_inventory_image,
		can_capacity = def.can_capacity,
		liquid_source_name = def.liquid_source_name,
		liquid_flowing_name = def.liquid_flowing_name
	})

	minetest.register_craft({
		output = can,
		recipe = def.recipe
	})

end
