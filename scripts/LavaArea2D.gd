extends Area2D

var treestilemap: TileMapLayer
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
	treestilemap = get_tree().root.get_node("/root/Root/TreesTileMapLayer")
	liquidserver = get_tree().root.get_node("/root/Root/LiquidServer")
	lavaserver = get_tree().root.get_node("/root/Root/LavaServer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#if not ("miner" in body.get_groups()):
	#print("Lava hit ", body)
	if body is TileMapLayer:
		#var collshape: RectangleShape2D = $LavaCollisionShape2D.shape		
		var collision_point = self.global_position
		var tree_tile_pos = treestilemap.local_to_map(treestilemap.to_local(collision_point))
		print("tree_tile_pos ", tree_tile_pos)
		var tree_ac = treestilemap.get_cell_atlas_coords(tree_tile_pos)
		if tree_ac in GameManager.TREE_CELLS:
			treestilemap.erase_cell(tree_tile_pos)
			lavaserver.remove_liquid(tree_tile_pos.x, tree_tile_pos.y, 1.0)

		
