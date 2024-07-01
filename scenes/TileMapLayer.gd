extends TileMapLayer


@export var water_server : LiquidServer;

func _input(event):
	if Input.is_action_pressed("ui_accept"):
		var pos = self.local_to_map(get_local_mouse_position())
		water_server.add_liquid(pos.x, pos.y, 1);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
