extends TextureRect


var camera: Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_parent().get_node("Camera2D")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var camera_pos = camera.global_position
	var viewport_size = camera.get_viewport_rect().size
	var zoom_factor = camera.zoom

	var top_left = camera_pos - (viewport_size / (2 * zoom_factor))
	
	self.global_position = top_left	
	pass


func _physics_process(delta: float) -> void:
	pass
