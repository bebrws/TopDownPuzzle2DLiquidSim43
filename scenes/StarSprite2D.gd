extends Sprite2D

var dragging = false
var click_offset = Vector2.ZERO
var camera: Camera2D

func _ready():
	camera = get_viewport().get_camera_2d()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if get_rect().has_point(get_local_mouse_position()):
					GameManager.dragging_star = true
					# Calculate the offset between the click position and the sprite's position
					print("event.position ", event.position)
					print("event.global_position ", event.global_position)
					print("global_position ", global_position)
					click_offset = (global_position - event.global_position) # / camera.zoom
					print("click_offset ", click_offset)
					print("cam event global_position ", camera.to_local(event.global_position))
					print("cam global_position ", camera.to_local(global_position))
					print("cam zoom ", camera.zoom)
			else:
				# Stop dragging when the mouse button is released
				GameManager.dragging_star = false

	elif event is InputEventMouseMotion and GameManager.dragging_star:
		# Update the sprite's x position based on the mouse motion
		var new_position = event.global_position + Vector2(click_offset.x*0.8, click_offset.y)
		global_position.x = new_position.x
		global_position.x = get_global_mouse_position().x
		# Clamp the sprite's position within the camera's view
		if camera:
			var view_size = get_viewport_rect().size / camera.zoom
			var sprite_half_width = texture.get_width() * scale.x / 2
			var left_bound = camera.global_position.x - view_size.x / 2 + sprite_half_width
			var right_bound = camera.global_position.x + view_size.x / 2 - sprite_half_width
			global_position.x = clamp(global_position.x, left_bound, right_bound)
