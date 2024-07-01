extends TileMap


var delta_sum = 0.0
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
	delta_sum += delta
	
	if delta_sum > 0.05:
		delta_sum = 0.0
		var new_water_tiles_vert = []
		#var water_flow_dirs = [TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE]
		for water_tile_coord in water_tiles:
			var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
			var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
			#print("water_tile_coords sides ", tilemap_below_coords)
			if atlas_below_water_coords in GameManager.EMPTY_CELLS:
				#print("FINDING EMPOTY")
				#print("BEB tilemap_below_coords", tilemap_below_coords, "has empty cell")
				new_water_tiles_vert.push_back(tilemap_below_coords)
				self.set_cell(0, tilemap_below_coords, 1, GameManager.DEFAULT_WATER_CELL)
				self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_EMPTY_CELL)
			else:
				new_water_tiles_vert.push_back(water_tile_coord)

		var new_water_tiles_hor = []
		
		var water_flow_dirs = [TileSet.CELL_NEIGHBOR_LEFT_SIDE, TileSet.CELL_NEIGHBOR_RIGHT_SIDE]
		
		var water_dir_index = randi() % len(water_flow_dirs)
		
		for water_tile_coord in new_water_tiles_vert:
			var tilemap_side_coords = self.get_neighbor_cell(water_tile_coord, water_flow_dirs[water_dir_index])
			var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_side_coords)
			#print("water_tile_coords sides ", tilemap_side_coords)
			var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
			var atlas_side_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
			#print("water_tile_coords sides ", tilemap_side_coords)
			#if atlas_below_water_coords in GameManager.EMPTY_CELLS:			
			
			if atlas_side_water_coords in GameManager.EMPTY_CELLS:
				#print("FINDING EMPOTY")
				#print("BEB tilemap_side_coords", tilemap_side_coords, "has empty cell")
				new_water_tiles_hor.push_back(tilemap_side_coords)
				self.set_cell(0, tilemap_side_coords, 1, GameManager.DEFAULT_WATER_CELL)
				self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_EMPTY_CELL)
			else:
				new_water_tiles_hor.push_back(water_tile_coord)
						
		water_tiles = new_water_tiles_hor
		
		var new_water_tiles_lava = []
		for water_tile_coord in water_tiles:
			var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
			var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
			#print("water_tile_coords sides ", tilemap_below_coords)
			if atlas_below_water_coords == GameManager.DEFAULT_LAVA_CELL:
				#print("FINDING EMPOTY")
				#print("BEB tilemap_below_coords", tilemap_below_coords, "has empty cell")
				#new_water_tiles_lava.push_back(tilemap_below_coords)
				#self.set_cell(0, tilemap_below_coords, 1, GameManager.DEFAULT_ROCK_CELL)
				self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_ROCK_CELL)
			else:
				new_water_tiles_lava.push_back(water_tile_coord)
		water_tiles = new_water_tiles_lava
		



func _process_will_stop(delta: float) -> void:
	delta_sum += delta
	var fell_vertically = false
	if delta_sum > 0.05:
		delta_sum = 0.0
		var new_water_tiles_vert = []
		#var water_flow_dirs = [TileSet.CELL_NEIGHBOR_BOTTOM_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE]
		for water_tile_coord in water_tiles:
			var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
			var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
			#print("water_tile_coords sides ", tilemap_below_coords)
			if atlas_below_water_coords in GameManager.EMPTY_CELLS:
				#print("FINDING EMPOTY")
				#print("BEB tilemap_below_coords", tilemap_below_coords, "has empty cell")
				new_water_tiles_vert.push_back(tilemap_below_coords)
				self.set_cell(0, tilemap_below_coords, 1, GameManager.DEFAULT_WATER_CELL)
				self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_EMPTY_CELL)
				fell_vertically = true
			else:
				new_water_tiles_vert.push_back(water_tile_coord)

		var new_water_tiles_hor = []

		if fell_vertically:		
			var water_flow_dirs = [TileSet.CELL_NEIGHBOR_LEFT_SIDE, TileSet.CELL_NEIGHBOR_RIGHT_SIDE]
			
			var water_dir_index = randi() % len(water_flow_dirs)
			
			for water_tile_coord in new_water_tiles_vert:
				var tilemap_below_coords = self.get_neighbor_cell(water_tile_coord, water_flow_dirs[water_dir_index])
				var atlas_below_water_coords = self.get_cell_atlas_coords(0, tilemap_below_coords)
				#print("water_tile_coords sides ", tilemap_below_coords)
				if atlas_below_water_coords in GameManager.EMPTY_CELLS:
					#print("FINDING EMPOTY")
					#print("BEB tilemap_below_coords", tilemap_below_coords, "has empty cell")
					new_water_tiles_hor.push_back(tilemap_below_coords)
					self.set_cell(0, tilemap_below_coords, 1, GameManager.DEFAULT_WATER_CELL)
					self.set_cell(0, water_tile_coord, 1, GameManager.DEFAULT_EMPTY_CELL)
				else:
					new_water_tiles_hor.push_back(water_tile_coord)
		if fell_vertically:
			water_tiles = new_water_tiles_hor
		else:
			water_tiles = new_water_tiles_vert
