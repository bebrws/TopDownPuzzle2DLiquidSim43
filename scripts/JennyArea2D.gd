extends Area2D


var tilemap: TileMapLayer
var water_server : LiquidServer;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_tree().get_current_scene().get_children():
		if c is TileMapLayer:
			tilemap = c	
		if c is LiquidServer:
			water_server = c
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_tilemap_collision():
	var collision_point = self.global_position
	#var pos = tilemap.local_to_map(get_local_mouse_position()/water_server.get_quadrant_size())
	var pos = tilemap.local_to_map(get_local_mouse_position())
	print("Jenny hit tile pos ", pos)
	#GameManager.DEFAULT_LAVA_CELL	

func _on_body_entered(body: Node2D) -> void:
	get_tilemap_collision()


func _on_area_entered(area: Area2D) -> void:
	get_tilemap_collision()
