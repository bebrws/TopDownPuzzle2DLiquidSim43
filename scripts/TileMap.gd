extends TileMap


var water_tiles = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tile_cells = self.get_used_cells(0)
	for tile_coords in tile_cells:
		var tc = self.get_cell_atlas_coords(0, tile_coords)
		var ta = self.get_cell_alternative_tile(0, tile_coords)
		for cell_info in GameManager.WATER_CELLS:
			if tc == cell_info.coords and ta == cell_info.alt:
				water_tiles.push_back({
					"coords": tc,
					"alt": ta
				})
	print("tile_cells  ", tile_cells)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for water_tile in water_tiles:
		var tile_below_coords = self.get_neighbor_cell(water_tile.coords, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
		var bc = self.get_cell_atlas_coords(0, tile_below_coords)
	pass
