extends Camera2D

#@onready var target = $JennyCharacterBody2D
var target_node: Node2D

var star_control: TextureRect
var star_control_label: Label
var screen_width: float
var screen_height: float
var star_control_label_position: Vector2

func get_camera_screen_width_and_height():
	var viewport = get_viewport()
	var camera = self # viewport.get_camera_2d()
	
	if camera:
		var zoom = camera.zoom.x  # Assuming uniform zoom
		var viewport_size = viewport.get_visible_rect().size
		var screen_width = viewport_size.x / zoom
		var screen_height = viewport_size.y / zoom
		return [screen_width, screen_height]
	else:
		print("No active Camera2D found")
		return [0,0]
		
func _ready():
	var screen_width_and_height = get_camera_screen_width_and_height()
	screen_width = screen_width_and_height[0]
	screen_height = screen_width_and_height[1]
	
	target_node = get_parent().get_node_or_null("JennyCharacterBody2D")
	star_control = get_parent().get_node_or_null("StarControl")
	star_control_label = get_parent().get_node_or_null("StarControlLabel")
	star_control_label_position = star_control_label.position
	pass
	
func _process(delta):
	#star_control.global_position.x = lerpf(star_control.global_position.x, self.global_position.x - screen_width/2, 0.3)
	#star_control.global_position.y = lerpf(star_control.global_position.y, self.global_position.y - screen_height/2, 0.3)
	
	var camera_pos = global_position
	var viewport_size = get_viewport_rect().size
	var zoom_factor = zoom

	var top_left = camera_pos - (viewport_size / (2 * zoom_factor))

	# Set the TextureRect's global position to the calculated top-left corner
	star_control.global_position = top_left
	star_control_label.global_position = top_left + star_control_label_position # Vector2(0.0, 50.0)
