extends Area2D

var liquidtilemap: TileMapLayer
var tilemap: TileMapLayer
var root: Node2D
var liquidserver: LiquidServer
var lavaserver: LiquidServer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#root = get_tree().get_current_scene().get_child(0).find_parent("Root")
	#for c in get_tree().get_current_scene().get_children():
		#if c is TileMapLayer and c.name == "LiquidTileMapLayer":
			#liquidtilemap = c
		#elif c is TileMapLayer and c.name == "TileMapLayer":
			#tilemap = c
		#elif c.name == "LiquidServer":
			#liquidserver = c
	root = get_tree().root.get_node("/root/Root")
	tilemap = get_tree().root.get_node("/root/Root/TileMapLayer")
	liquidtilemap = get_tree().root.get_node("/root/Root/LiquidTileMapLayer")
	liquidserver = get_tree().root.get_node("/root/Root/LiquidServer")
	lavaserver = get_tree().root.get_node("/root/Root/LavaServer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#if not ("miner" in body.get_groups()):
	print("Lava hit ", body)
	if body is TileMapLayer:
		#print("Collision wiht tilemap")		
		var collshape: RectangleShape2D = $LavaCollisionShape2D.shape		
		#var collision_point = self.global_position + Vector2(0.0, collshape.size.y)
		var collision_point = self.global_position
		#print("self.global_position ", self.global_position, "  collision_point ", collision_point)
		var tile_pos = tilemap.local_to_map(tilemap.to_local(root.to_local(collision_point)))
		print("tile_pos ", tile_pos)
		var ac = tilemap.get_cell_atlas_coords(tile_pos)
		print("Lava hit ", ac)
		if ac == Vector2i(-1,-1): #GameManager.DEFAULT_WATER_CELL:
			#tilemap.erase_cell(tile_pos)
			var c = liquidserver.get_cell_by_position(tile_pos.x, tile_pos.y)
			print("cis ", c)
			if c:
				tilemap.set_cell(tile_pos,0,Vector2i(1,0))
				liquidserver.remove_liquid(tile_pos.x, tile_pos.y+1,1.0)
				liquidserver.remove_liquid(tile_pos.x, tile_pos.y,1.0)
				liquidserver.remove_liquid(tile_pos.x, tile_pos.y-1,1.0)
				liquidserver.remove_liquid(tile_pos.x+1, tile_pos.y+1,1.0)
				liquidserver.remove_liquid(tile_pos.x, tile_pos.y,1.0)
				liquidserver.remove_liquid(tile_pos.x-1, tile_pos.y-1,1.0)	
				lavaserver.remove_liquid(tile_pos.x, tile_pos.y+1,1.0)
				lavaserver.remove_liquid(tile_pos.x, tile_pos.y,1.0)
				lavaserver.remove_liquid(tile_pos.x, tile_pos.y-1,1.0)
				lavaserver.remove_liquid(tile_pos.x+1, tile_pos.y+1,1.0)
				lavaserver.remove_liquid(tile_pos.x, tile_pos.y,1.0)
				lavaserver.remove_liquid(tile_pos.x-1, tile_pos.y-1,1.0)			
		#var isEmpty = tilemap.get_cell_source_id(tile_pos)
		#if isEmpty == -1:
			#var empty = true
		#if ac in GameManager.EMPTY_CELLS:
			#collision_point += bullet_direction * DIR_INC
		#else:
			#tilemap.set_cell(0, tile_pos, 1, GameManager.DEFAULT_EMPTY_CELL)
				
			#var tile_data: TileData = tilemap.get_cell_tile_data(0, tile_pos)
			#if tile_data:
				#print("Hit tile at: ", tile_pos)
				#tilemap.set_cell(0, tile_pos, 1, Vector2i(1,0), 2)
		queue_free()
