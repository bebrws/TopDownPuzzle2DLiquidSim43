extends Camera2D

var target_node: Node2D

var star_character: CharacterBody2D
var screen_width: float
var screen_height: float

var last_sc_x = 0.0
var last_sc_y = 0.0

func get_camera_screen_width_and_height():
	var viewport = get_viewport()
	var camera = self # viewport.get_camera_2d()
	
	if camera:
		var viewport_size = viewport.get_visible_rect().size
		var screen_width = viewport_size.x / camera.zoom.x
		var screen_height = viewport_size.y / camera.zoom.y
		return [screen_width, screen_height]
	else:
		print("No active Camera2D found")
		return [0,0]
		
func _ready():
	var screen_width_and_height = get_camera_screen_width_and_height()
	screen_width = screen_width_and_height[0]
	screen_height = screen_width_and_height[1]
	
	target_node = get_parent().get_node_or_null("Jenny")
	star_character = get_parent().get_node_or_null("Star")

	last_sc_x = global_position.x
	last_sc_y = global_position.y
	
func _process(delta):
	#var camera_pos = global_position
	#var viewport_size = get_viewport_rect().size
	#var zoom_factor = zoom
#
	#var top_left = camera_pos - (viewport_size / (2 * zoom_factor))

	star_character.global_position.x -= last_sc_x - global_position.x
	star_character.global_position.y -= last_sc_y - global_position.y
	
	last_sc_x = global_position.x
	last_sc_y = global_position.y
