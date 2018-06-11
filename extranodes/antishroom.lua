-- a tool to convert a mushroom biome into green forest with thick trees and flowers

local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_craftitem(":technic:antishroom",{
	description = "Mushroom biome converter",
	inventory_image = "antishroom.png",
	wield_image = "antishroom_wield.png",
	on_use = function(itemstack, user, pointed_thing)
	
		if pointed_thing.type ~= "node" then
			return itemstack
		end
		
		local pos = pointed_thing.under
		local target = minetest.get_node_or_nil(pos)
		
		if target and target.name == "ethereal:mushroom_dirt" then
		
			local start_pos = {
				x = pos.x - 16,
				z = pos.z - 16,
				y = pos.y - 5 
			} 
			
			local end_pos = {
				x = pos.x + 16,
				z = pos.z + 16,
				y = pos.y + 15
			} 

			local rlist = {
						["ethereal:mushroom_dirt"]  = "default:dirt_with_grass",
						["ethereal:mushroom_trunk"] = "default:tree",
						["ethereal:mushroom"]       = "default:leaves",
						["ethereal:mushroom_pore"]  = "default:apple"
					}
					
			local mlist = {}
			for t,r in pairs(rlist) do
				table.insert(mlist, t)
			end
			
			local found_mushroom_parts = minetest.find_nodes_in_area(start_pos, end_pos, mlist)
			for _, f in ipairs(found_mushroom_parts) do
				local node = minetest.get_node(f)
				
				if not minetest.is_protected(f, user:get_player_name()) then
					
					minetest.swap_node(f, { name = rlist[node.name] } )
					
					if minetest.get_modpath("bonemeal") and node.name == "ethereal:mushroom_dirt" then
						if math.random(1,5) > 4 then
							bonemeal:on_use(f, 1, nil)
						end
					end
				
				end

			end
			
			itemstack:take_item()
			return itemstack
		else
			return itemstack
		end
		
		
	end,
})