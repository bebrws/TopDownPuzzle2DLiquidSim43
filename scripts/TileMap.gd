extends TileMap


var water_tiles = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tile_cells: Array[Vector2i] = self.get_used_cells(0)
	for tile_coords in tile_cells: # tile_coords is Vector2i
		var tc = self.get_cell_atlas_coords(0, tile_coords)
		#var ta = self.get_cell_alternative_tile(0, tile_coords)
		for water_coord in GameManager.WATER_CELLS:
			if tc == water_coord:
				water_tiles.push_back(tile_coords)
				#water_tiles.push_back({
					#"coords": tc,
					#"alt": ta
				#})
	print("water_tiles  ", water_tiles)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_water_tiles = []
	for water_tile_coord in water_tiles:
		var atlas_water_for_current_coords = self.get_cell_atlas_coords(0, water_tile_coord)
		var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
		var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
		#print("atlas_below_water_coords ", atlas_below_water_coords)
		if atlas_below_water_coords in GameManager.EMPTY_CELLS:
			#print("BEB tilemap_below_coords", tilemap_below_coords, "has empty cell")
			new_water_tiles.push_back(tilemap_below_coords)
			self.set_cell(0, tilemap_below_coords, 1, GameManager.DEFAULT_WATER_CELL)
			self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_EMPTY_CELL)
		else:
			new_water_tiles.push_back(water_tile_coord)
	water_tiles = new_water_tiles
	pass
