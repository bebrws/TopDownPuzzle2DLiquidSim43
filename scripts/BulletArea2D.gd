@tool
extends Area2D

@export var speed: float = 1000.0
@export var bullet_direction: Vector2 = Vector2(0.0,0.0)

@export var radius: float = 10:
	set(r):
		$BulletCollisionShape2D.shape.radius = r


func _physics_process(delta):
	position +=  bullet_direction * speed * delta
	
	
func _draw() -> void:
	draw_circle(Vector2.ZERO, self.radius, Color.BLACK)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
