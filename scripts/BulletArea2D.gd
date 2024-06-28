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
			var tilemap: TileMap
			for c in get_tree().get_current_scene().get_children():
				if c is TileMap:
					tilemap = c
					
			var collision_point = self.global_position + (bullet_direction * 5.0)
			print("self.global_position ", self.global_position, "  collision_point ", collision_point)
			var hit = false
			while not hit:
				var tile_pos = tilemap.local_to_map(tilemap.to_local(collision_point))
				var ac = tilemap.get_cell_atlas_coords(0, tile_pos)
				var at = tilemap.get_cell_alternative_tile(0, tile_pos)
				if ac == Vector2i(1,0) and at == 2:
					collision_point += bullet_direction * 5.0
				else:
					tilemap.set_cell(0, tile_pos, 1, Vector2i(1,0), 2)
					hit = true
				#var tile_data: TileData = tilemap.get_cell_tile_data(0, tile_pos)
				#if tile_data:
					#print("Hit tile at: ", tile_pos)
					#tilemap.set_cell(0, tile_pos, 1, Vector2i(1,0), 2)
		queue_free()
			
	pass # Replace with function body.
