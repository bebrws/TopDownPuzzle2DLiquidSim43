extends Area2D

var liquidtilemap: TileMapLayer
var tilemap: TileMapLayer
var root: Node2D
var liquidserver: LiquidServer
var lavaserver: LiquidServer
var char: CharacterBody2D

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
	char = get_tree().root.get_node("/root/Root/Jenny")
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
		var char_tile_pos = tilemap.local_to_map(tilemap.to_local(root.to_local(char.global_position)))
		print("tile_pos ", tile_pos)
		var ac = tilemap.get_cell_atlas_coords(tile_pos)
		print("Lava hit ", ac)
		if char_tile_pos != tile_pos:
			if true or ac == Vector2i(-1,-1):
				var lam = lavaserver.get_liquid(tile_pos.x, tile_pos.y)
				var wam = liquidserver.get_liquid(tile_pos.x, tile_pos.y)
				print("lam ", lam)
				var w = liquidserver.get_cell_by_position(tile_pos.x, tile_pos.y)
				var l = lavaserver.get_cell_by_position(tile_pos.x, tile_pos.y)
				print("wam ", wam, "  lam  ", lam)
				#if w  and l and w.sprite != l.sprite:
				if wam != 0.0:
					print("converting ", tile_pos)
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
					
					#if w:
						#w.cleanup_cell()
		
