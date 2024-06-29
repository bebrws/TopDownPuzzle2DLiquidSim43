extends CharacterBody2D

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

@onready var sprite: AnimatedSprite2D = $JennyAnimatedSprite2D
@onready var gunNode: Node2D = $GunNode2D
@onready var centerNode: Node2D = $CenterNode2D

var original_position: Vector2 = Vector2.ZERO
var start_global_position: Vector2 = Vector2.ZERO

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")



# FOR TOUCH SIM
var touch_start_vp_point: Vector2
var touch_start_position: Vector2
var touch_start_dist: float = 0.0

#var is_touching: bool = false
var is_long_pressing: bool = false
var in_air: bool = false
var touch_started: bool = false

# Thresholds
const TAP_DRAG_THRESHOLD: float = 80.0

var direction = 0


func _unhandled_input(event):
	get_viewport().set_input_as_handled()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_double_click():
				_handle_double_tap(event.position)
			elif event.is_pressed():
				_touch_began(event.position)
			else:
				_touch_ended(event.position)
				

func _touch_began(event_position: Vector2):
	#print("BEB tocuh ", event_position, " vp ", get_viewport().get_mouse_position()
	touch_started = true
	touch_start_position = event_position
	touch_start_dist = touch_start_position.distance_to(get_global_mouse_position())
	start_global_position = self.global_position
	touch_start_vp_point =  get_viewport().get_mouse_position()
	#print("touch_start_position ", touch_start_position, "    global pos  ", self.global_position)
	
	if is_on_floor():
		var touch_direction = get_global_mouse_position().direction_to(self.global_position)
		if touch_direction.x < 0:
			direction = 1
		else:
			direction = -1
		velocity.x = direction * SPEED
	

func _touch_ended(event_position: Vector2):
	if touch_started == true:
		velocity.x = 0 # move_toward(velocity.x, 0, SPEED)
		direction = 0
	touch_started = false
	var dist = touch_start_position.distance_to(event_position)
	if dist > TAP_DRAG_THRESHOLD:
		print("long press dist ", dist)
		_handle_long_press(event_position)
			
func _handle_double_tap(event_position: Vector2):
	print("Double Tap at ", event_position, " vp ", get_viewport().get_mouse_position(), " self ", self.global_position)
	var velxadd = (get_global_mouse_position().x - self.global_position.x) * 4
	# var velxadd = (get_viewport().get_mouse_position().x - touch_start_vp_point.x) * 4
	#var velxadd = (get_viewport().get_mouse_position().x - self.global_position.x) * 4
	if velxadd > 100.0:
		velxadd = 100.0
	if velxadd < -100.0:
		velxadd = -100.0
	print("velxadd ",  velxadd)
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = velxadd

func _handle_long_press(event_position: Vector2):
	#var dir = touch_start_position.direction_to(event_position)
	var dir = start_global_position.direction_to(get_global_mouse_position())
	print("Long Press at ", event_position, " dir ", dir)
	var b = bullet_scene.instantiate()
	b.bullet_direction = dir
	#b.position = self.global_position
	b.position = centerNode.global_position
	get_tree().root.add_child(b)

func _ready() -> void:
	sprite.play("standing")
	original_position = sprite.position
	
func _physics_process(delta: float) -> void:
	
	#print("m ", get_viewport().get_mouse_position(), "   gm  ", get_global_mouse_position())
	
	
	#if touch_started:
		#var touch_dist = touch_start_position.distance_to(get_global_mouse_position())
		##print("touch_start_dist ", touch_start_dist, " touch dist   ", touch_dist)
		#var touch_dist_diff = abs(touch_start_dist - touch_dist)
		##print("touch diff ", touch_dist_diff)
		#if touch_dist_diff > 5.0:
			#velocity.x = 0
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		in_air = true
	else:
		if in_air:
			velocity.x = 0 # move_toward(velocity.x, 0, SPEED)
		in_air = false
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mp = get_global_mouse_position()
		
		var normalGunVector = centerNode.global_position.direction_to(gunNode.global_position)
		var toMouseVector = centerNode.global_position.direction_to(mp)
		
		var angle = rad_to_deg(normalGunVector.angle_to(toMouseVector))
		#print("angle ", angle)
		gunNode.rotation_degrees = angle
		if (angle < -90 and angle > -180) or (angle < 180 and angle > 90):
			sprite.flip_h = false
		else:
			sprite.flip_h = true

	var direction = 1
	move_and_slide()
