extends CharacterBody2D


@onready var sprite: AnimatedSprite2D = $MinerAnimatedSprite2D
@onready var gunNode: Node2D = $GunNode2D
@onready var centerNode: Node2D = $CenterNode2D

var original_position: Vector2 = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	sprite.play("standing")
	original_position = sprite.position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mp = get_global_mouse_position()
		
		var normalGunVector = centerNode.global_position.direction_to(gunNode.global_position)
		var toMouseVector = centerNode.global_position.direction_to(mp)
		
		var angle = rad_to_deg(normalGunVector.angle_to(toMouseVector))
		gunNode.rotation_degrees = angle
		if (angle < -90 and angle > -180) or (angle < 180 and angle > 90):
			sprite.flip_h = true
		else:
			sprite.flip_h = false
			

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	#if Input.is_action_just_pressed("ui_left"):
		#sprite.flip_h = true
		#sprite.position.x = original_position.x - 12
		#
	#if Input.is_action_just_pressed("ui_right"):
		#sprite.flip_h = false
		#sprite.position.x = original_position.x
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		##if sprite.animation != "walking":
		#sprite.play("walking")
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
