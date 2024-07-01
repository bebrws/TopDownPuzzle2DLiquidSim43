extends TileMapLayer


var water_server : LiquidServer
var lava_server : LiquidServer

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var pos = self.local_to_map(get_local_mouse_position())
		water_server.add_liquid(pos.x, pos.y, 1);
	if Input.is_action_pressed("lava_drop"):
		var pos = self.local_to_map(get_local_mouse_position())
		lava_server.add_liquid(pos.x, pos.y, 1);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water_server = get_tree().root.get_node("/root/Root/LiquidServer")
	lava_server = get_tree().root.get_node("/root/Root/LavaServer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
