extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction = 0

var touch_start_vp_position
var start_global_position
var touch_started
var cam_x
var cam: Camera2D
var star_sprite: Sprite2D

func _unhandled_input(event):
	pass
	#if Input.is_action_pressed("star_control"):
		#if Input.is_action_pressed("ui_left"):
			#direction = -1
		#elif Input.is_action_pressed("ui_right"):
			#direction = 1	
		#elif direction != 0 and (Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")):
			#direction = 0 
		#elif event is InputEventMouseButton:
			#if event.button_index == MOUSE_BUTTON_LEFT:
				#if event.is_pressed():
					#_touch_began()
				#else:
					#_touch_ended()
func _touch_began():
	touch_start_vp_position = get_viewport().get_mouse_position()
	start_global_position = self.global_position
	var middle = get_viewport_rect().size.x / 2

	if touch_start_vp_position.x < middle:
		direction = -1
	if touch_start_vp_position.x > middle:
		direction = 1
		
	touch_started = true

func _touch_ended():
	if touch_started == true:
		velocity.x = 0
		direction = 0
		
	touch_started = false
			
			

func _ready() -> void:
	pass
	#cam = get_viewport().get_camera_2d()
	#cam_x = cam.position.x
	#
	#star_sprite = get_node("StarSprite2D")
	#
	#var sssize = star_sprite.texture.get_size() * star_sprite.scale
	
						
func _physics_process(delta: float) -> void:
	pass
	#var wha = GameManager.get_camera_screen_width_and_height()
	#var w = wha[0]
	#var h = wha[1]
	#
	#var cam_x_diff = cam_x - get_viewport().get_camera_2d().position.x
	#
	#var mov = direction * SPEED * delta
	#if direction != 0:
		#var local_to_cam = cam.to_local(self.global_position)
		#if abs(local_to_cam.x + mov) < 275:
			#self.position.x += mov
	
		
