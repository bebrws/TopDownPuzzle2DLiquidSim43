@tool
extends Area2D

@export var speed: float = 1000.0
@export var bullet_direction: Vector2 = Vector2(0.0,0.0)

@export var radius: float = 4.0:
	set(r):
		if $BulletCollisionShape2D:
			$BulletCollisionShape2D.shape.radius = r


func _physics_process(delta):
	position +=  bullet_direction * speed * delta
	

func _draw() -> void:
	draw_circle(Vector2.ZERO, self.radius, Color.BLACK)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BulletCollisionShape2D.shape.radius = self.radius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if not ("miner" in body.get_groups()):
		print("Bullet hit ", body)
		if body is TileMap:
			var tilemap
			var collision_point = self.global_position
			for c in get_tree().get_current_scene().get_children():
				if c is TileMap:
					tilemap = c
			var tile_pos = tilemap.local_to_map(tilemap.to_local(collision_point))
			var tile_data = tilemap.get_cell_tile_data(0, tile_pos)
			
			if tile_data:
				print("Hit tile at: ", tile_pos)
		queue_free()
			
	pass # Replace with function body.
