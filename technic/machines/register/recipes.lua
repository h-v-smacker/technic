local have_ui = minetest.get_modpath("unified_inventory")

technic.recipes = { cooking = { input_size = 1, output_size = 1 } }

function technic.register_recipe_type(typename, origdata)
	local data = {}
	for k, v in pairs(origdata) do data[k] = v end
	data.input_size = data.input_size or 1
	data.output_size = data.output_size or 1
	if have_ui and unified_inventory.register_craft_type then
		local ctable = {
			description = data.description,
			width = data.input_size,
			height = 1,
		}
		if data.output_size > 1 then
			ctable.icon = data.icon or "technic_recipe_icon_empty.png"
			ctable.icon = ctable.icon .. "^technic_recipe_icon_plus.png"
		else
			ctable.icon = data.icon or "technic_recipe_icon_empty.png"
		end
		
-- 		if data.output_size > 1 then
-- 			-- do something maybe?
-- 		end
		
		unified_inventory.register_craft_type(typename, ctable)
				
	end
	data.recipes = {}
	technic.recipes[typename] = data
end

local function get_recipe_index(items)
	if not items or type(items) ~= "table" then return false end
	local l = {}
	for i, stack in ipairs(items) do
		l[i] = ItemStack(stack):get_name()
	end
	table.sort(l)
	return table.concat(l, "/")
end

local function register_recipe(typename, data)
	-- Handle aliases
	for i, stack in ipairs(data.input) do
		data.input[i] = ItemStack(stack):to_string()
	end
	if type(data.output) == "table" then
		for i, v in ipairs(data.output) do
			data.output[i] = ItemStack(data.output[i]):to_string()
		end
	else
		data.output = ItemStack(data.output):to_string()
	end
	
	local recipe = {time = data.time, input = {}, output = data.output}
	
	local index = get_recipe_index(data.input)
	if not index then
		print("[Technic] ignored registration of garbage recipe!")
		return
	end
	for _, stack in ipairs(data.input) do
		recipe.input[ItemStack(stack):get_name()] = ItemStack(stack):get_count()
	end
	
	technic.recipes[typename].recipes[index] = recipe
	
	if unified_inventory and technic.recipes[typename].output_size == 1 then
		unified_inventory.register_craft({
			type = typename,
			output = data.output,
			items = data.input,
			width = 0,
		})
	end
	
	if unified_inventory and technic.recipes[typename].output_size > 1 then
		local short_output = data.output[1]
		unified_inventory.register_craft({
			type = typename,
			output = short_output,
			items = data.input,
			width = 0,
		})
	end
	
end

function technic.register_recipe(typename, data)
	minetest.after(0.01, register_recipe, typename, data) -- Handle aliases
end

function technic.get_recipe(typename, items)
	if typename == "cooking" then -- Already builtin in Minetest, so use that
		if not items then
			return nil
		end
		local result, new_input = minetest.get_craft_result({
			method = "cooking",
			width = 1,
			items = items})
		-- Compatibility layer
		if not result or result.time == 0 then
			return nil
		else
			return {time = result.time,
			        new_input = new_input.items,
			        output = result.item}
		end
	end
	
	local index = get_recipe_index(items)
	if not index then
		print("[Technic] ignored registration of garbage recipe!")
		return
	end
	
	local recipe = technic.recipes[typename].recipes[index]
	if recipe then
		
		local new_input = {}
		local extra_output = {}
		for i, stack in ipairs(items) do
			
			-- Check if a can is used. If so, with each iteration its contents are depleted,
			-- and when it runs dry, an empty can is added to the recipe's output.
			if technic.cans[stack:get_name()] then
				local level = technic.manage_can_state(stack)
				if not level or level < 1 then
					return nil
				else
					if level > 1 then
						new_input[i] = technic.manage_can_state(ItemStack(stack), -1)
					else
						empty_can = technic.manage_can_state(ItemStack(stack), -1)
						table.insert(extra_output, empty_can)
					end
				end
			else
				if stack:get_count() < recipe.input[stack:get_name()] then
					return nil
				else
					new_input[i] = ItemStack(stack)
					new_input[i]:take_item(recipe.input[stack:get_name()])
				end
			end
		end
		
		-- A necessary hack to avoid reusing the original table
		if #extra_output > 0 then
			local ro = {}
			if type(recipe.output) == "string" then
				table.insert(ro, recipe.output)
			else
				for _,o in ipairs(recipe.output) do
					table.insert(ro, o)
				end
			end
			for _,o in ipairs(extra_output) do
				table.insert(ro, o)
			end
			return {time = recipe.time,
				  new_input = new_input,
				  output = ro}
		end
		-- regular output
		return {time = recipe.time,
			  new_input = new_input,
			  output = recipe.output}
	else
		return nil
	end
end


