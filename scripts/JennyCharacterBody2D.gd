extends CharacterBody2D

var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")
var box_scene: PackedScene = preload("res://scenes/box.tscn")



@onready var sprite: AnimatedSprite2D = $JennyAnimatedSprite2D
@onready var gunNode: Node2D = $GunNode2D
@onready var centerNode: Node2D = $CenterNode2D

var original_position: Vector2 = Vector2.ZERO
var start_global_position: Vector2 = Vector2.ZERO

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var tilemap: TileMapLayer

# FOR TOUCH SIM
var touch_start_vp_point: Vector2
var touch_start_position: Vector2
var touch_start_dist: float = 0.0

#var is_touching: bool = false
var is_long_pressing: bool = false
var in_air: bool = false
var touch_started: bool = false
var started_in_character: bool = false

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
				
func tap_in_jenny():
	return abs(get_global_mouse_position().x - centerNode.global_position.x) < 10 and abs(get_global_mouse_position().y - centerNode.global_position.y) < 15	
	
func _touch_began(event_position: Vector2):
	#print("BEB tocuh ", event_position, " vp ", get_viewport().get_mouse_position()
	
	
	touch_start_position = event_position
	touch_start_dist = touch_start_position.distance_to(get_global_mouse_position())
	start_global_position = self.global_position
	touch_start_vp_point =  get_viewport().get_mouse_position()
	
	touch_started = true
	#print("x ", abs(get_global_mouse_position().x - centerNode.global_position.x) < 10)
	#print("y ", abs(get_global_mouse_position().y - centerNode.global_position.y) < 15)
	
	#print("touch_start_vp_point.y ", touch_start_vp_point.y, "  self.global_position.y ", self.global_position.y)
	#print("cn.y  ", centerNode.global_position.y)
	#print("get_global_mouse_position().y  ", get_global_mouse_position().y)
	if tap_in_jenny():
		started_in_character = true
	
	if not started_in_character and is_on_floor():
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
	
	started_in_character = false
			
func _handle_double_tap(event_position: Vector2):
	print("Double Tap at ", event_position, " vp ", get_viewport().get_mouse_position(), " self ", self.global_position)
	if tap_in_jenny():
		var box: Area2D = get_tree().root.get_node_or_null("/root/Box")
		if box:
			var mult = (int(self.global_position.x)/16) * 16
			var bmod = int(self.global_position.x) % 16
			var bdif = self.global_position.x - mult
			print("gp ", self.global_position)
			print("modulo is ", bmod, " bdif ", bdif)
			var below_tile_point
			var below_tile_pos
			var below_below_tile_point
			var below_below_tile_pos
			var bbac
			
			below_tile_point = box.global_position + Vector2(0.0, 16.0)
			below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_tile_point))
			below_below_tile_point = box.global_position + Vector2(0.0, 32.0)
			below_below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_below_tile_point))
			bbac = tilemap.get_cell_atlas_coords(below_below_tile_pos)
			print("box at tile_pos ", below_below_tile_pos, " bbac ", bbac)
			if bbac == Vector2i(-1, -1):
				below_tile_point = box.global_position + Vector2(16.0, 16.0)
				below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_tile_point))
				below_below_tile_point = box.global_position + Vector2(8.0, 32.0)
				below_below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_below_tile_point))
				bbac = tilemap.get_cell_atlas_coords(below_below_tile_pos)
			if bbac == Vector2i(-1, -1):
				below_tile_point = box.global_position + Vector2(-16.0, 16.0)
				below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_tile_point))
				below_below_tile_point = box.global_position + Vector2(-8.0, 32.0)
				below_below_tile_pos = tilemap.local_to_map(tilemap.to_local(below_below_tile_point))
				bbac = tilemap.get_cell_atlas_coords(below_below_tile_pos)
			if bbac != Vector2i(-1, -1):
				tilemap.set_cell(below_tile_pos, GameManager.DEFAULT_BOX_CELL_SOURCE, GameManager.DEFAULT_BOX_CELL)
				self.global_position.y -= 20.0
				box.queue_free()
		else:
			print("double tap in jenny")
			var collision_point = self.global_position + Vector2(0.0, 16.0)
			print("self.global_position ", self.global_position, "  collision_point ", collision_point)

			var tile_pos = tilemap.local_to_map(tilemap.to_local(collision_point))
			var ac = tilemap.get_cell_atlas_coords(tile_pos)
			print("Standing at tile_pos ", tile_pos, " ac below ", ac)
			#print("ac ", ac)
			#var bac_pos = tilemap.get_neighbor_cell(tile_pos, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)
			#print("bac_pos ", bac_pos)
			#var bac = tilemap.get_cell_atlas_coords(bac_pos)
			#print("bac ", bac)
			if ac == GameManager.DEFAULT_BOX_CELL:
				tilemap.erase_cell(tile_pos)
				var b= box_scene.instantiate()
				b.global_position = self.global_position - Vector2(0.0, 35.0)
				#b.position = self.position - Vector2(0.0, 30.0)
				get_tree().root.add_child(b)
				#self.add _child(b)
		
	else:
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
	if started_in_character:
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
	
	tilemap = get_tree().get_current_scene().get_node_or_null("/root/Root/PropsTileMapLayer")
	
func _physics_process(delta: float) -> void:
	#print(get_tree().root.get_children())
	var box: Area2D = get_tree().root.get_node_or_null("/root/Box")
	if box:
		box.global_position = self.global_position - Vector2(0.0, 16.0)
		#box.velocity = self.velocity
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
