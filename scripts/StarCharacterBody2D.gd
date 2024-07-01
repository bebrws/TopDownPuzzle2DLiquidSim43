extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 0

var touch_start_vp_position
var start_global_position
var touch_started
var cam_x

func _unhandled_input(event):
	if Input.is_action_pressed("star_control"):
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				#if event.is_double_click():
					#_handle_double_tap()
				if event.is_pressed():
					_touch_began()
				else:
					_touch_ended()
		#else:
			#_touch_ended()
		
#func tap_in_jenny():
	##print("tapjenny x ", abs(get_global_mouse_position().x - centerNode.global_position.x))
	##print("tapjenny y ", abs(get_global_mouse_position().y - centerNode.global_position.y))
	#return abs(get_global_mouse_position().x - centerNode.global_position.x) < 10 and abs(get_global_mouse_position().y - centerNode.global_position.y) < 15	

func _touch_began():
	touch_start_vp_position = get_viewport().get_mouse_position()
	start_global_position = self.global_position
	var middle = get_viewport_rect().size.x / 2
	
	if touch_start_vp_position.x < middle:
		direction = -1
	if touch_start_vp_position.x > middle:
		direction = 1
		
	touch_started = true
	print(middle, " middle " , " vp m ", get_viewport().get_mouse_position())
	#if get_viewport().get_mouse_position()

func _touch_ended():
	if touch_started == true:
		velocity.x = 0
		direction = 0
		
	touch_started = false
			
			
func get_camera_screen_width_and_height():
	var viewport = get_viewport()
	var camera = self # viewport.get_camera_2d()
	
	if camera:
		var zoom = get_viewport().get_camera_2d().zoom
		var viewport_size = viewport.get_visible_rect().size
		var screen_width = viewport_size.x / zoom.x
		var screen_height = viewport_size.y / zoom.y
		return [screen_width, screen_height]
	else:
		print("No active Camera2D found")
		return [0,0]
					

func _ready() -> void:
	cam_x = get_viewport().get_camera_2d().position.x
						
func _physics_process(delta: float) -> void:
	#if direction != 0:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		

	#move_and_slide()
	#var vp = get_viewport()
	
	var wha = get_camera_screen_width_and_height()
	var w = wha[0]
	var h = wha[1]
	
	var cam_x_diff = cam_x - get_viewport().get_camera_2d().position.x
	
	
	var mov = direction * SPEED * delta
	if direction != 0:
		print("cam_x_diff ", cam_x_diff, " wha  ", wha, " cmaera ", get_viewport().get_camera_2d().position)
		print("pos x ", self.position.x)
		print("equ x ", self.position.x + mov + cam_x_diff)
		print("if d ", direction != 0)
		print("if p ", abs(self.position.x + mov) < 215 + cam_x_diff)
		print("if  ", direction != 0 and abs(self.position.x + mov + cam_x_diff) < 215)
		if direction != 0 and abs(self.position.x + mov + cam_x_diff) < 215:
			self.position.x += mov
		
	#cam_x = get_viewport().get_camera_2d().position.x
		
