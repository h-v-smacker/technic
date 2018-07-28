local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

local plastic_nodes = {
	{node = "plastic_siding", name = S("Plastic Siding"), tiles = {"technic_plastic_siding.png"}},
	{node = "plastic_siding_2", name = S("Plastic Siding 2"), tiles = {"technic_plastic_siding_2.png"}},
	{node = "plastic_siding_3", name = S("Plastic Siding 3"), tiles = {"technic_plastic_siding_3.png"}},
	{node = "plastic_bricks", name = S("Plastic Bricks"), tiles = {"technic_plastic_bricks.png"}},
	{node = "plastic_blocks", name = S("Plastic Blocks"), tiles = {"technic_plastic_blocks.png"}},
	{node = "plastic_cross", name = S("Plastic Cross"), tiles = {"technic_plastic_cross.png"}},
	{node = "plastic_waves", name = S("Plastic Waves"), tiles = {"technic_plastic_waves.png"}},
	{node = "plastic_tiles", name = S("Plastic Tiles"), tiles = {"technic_plastic_tiles.png"}},
}

for _,n in pairs(plastic_nodes) do

	minetest.register_node (":technic:" .. n.node, {
		description = n.name,
		drawtype = "normal",
		tiles = n.tiles,
		drop = "technic:plastic_siding",
		groups = {dig_immediate = 2, paintable_plastic_block = 1},
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "technic_paint_palette.png",
	})
	
end
