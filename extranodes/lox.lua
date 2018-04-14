local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local freezing_rules = {
	["default:water_source"] = "default:ice",
	["default:water_flowing"] = "default:snowblock",
	["default:river_water_source"] = "default:ice",
	["default:river_water_flowing"] = "default:snowblock",
	["default:lava_source"] = "default:obsidian",
	["default:lava_flowing"] = "default:stone",
	["fire:basic_flame"] = "air",
	["default:dirt"] = "default:dirt_with_snow",
}

minetest.register_craftitem(":technic:lox", {
	description = S("Liquid Oxygen"),
	drawtype = "plantlike",
	tiles = {"technic_lox.png"},
	inventory_image = "technic_lox.png",
	wield_image = "technic_lox.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end
                                            
		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.under, user:get_player_name())
			return
		end
                                            
		local pos = pointed_thing.under

		local loc = {}
		local wrk = false
		for y=0,2,1 do
			for x=-2,2,1 do
				for z = -2,2,1 do
					loc = {x = pos.x - x, y = pos.y - y, z = pos.z - z}
					if freezing_rules[minetest.get_node(loc).name] then
						wrk = true
						minetest.swap_node(loc, {name = freezing_rules[minetest.get_node(loc).name]})
					end
					if math.random(1,5) == 5 then
						if minetest.get_node({x = loc.x, y = loc.y+1, z = loc.z}).name == "air" 
							and minetest.get_node(loc).name ~= "air" 
							and minetest.get_node(loc).name ~= "stairs:slab_snowblock" then
							minetest.set_node({x = loc.x, y = loc.y+1, z = loc.z}, {name = "stairs:slab_snowblock"})
						end
					end
				end
			end
		end
		
		if wrk then
			minetest.sound_play("default_cool_lava", {gain = 1, pos = pos})
		end

		itemstack:take_item()
		local uinv = user:get_inventory()
		if uinv:room_for_item("main", "vessels:steel_bottle 1") then
			uinv:add_item("main", "vessels:steel_bottle 1")
		else 
			minetest.item_drop(ItemStack("vessels:steel_bottle 1"), user, user:getpos())
		end
            
		user:set_hp(user:get_hp() - 1)
		
		return itemstack
	end
})
