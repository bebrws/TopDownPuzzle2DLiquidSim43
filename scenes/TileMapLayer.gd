extends TileMapLayer


var water_server : LiquidServer
var lava_server : LiquidServer
var star: CharacterBody2D
var star_sprite: Sprite2D
var root

func _input(event):
	var screen_width_and_height = GameManager.get_camera_screen_width_and_height()
	var screen_width = screen_width_and_height[0]
	var screen_height = screen_width_and_height[1]
	
	if Input.is_action_pressed("lava_drop"):
		var sssize = star_sprite.texture.get_size() * star_sprite.scale * star.scale
		var pos = self.local_to_map(self.to_local(star.global_position) + Vector2(sssize.x/2, 0.0))
		lava_server.add_liquid(pos.x, pos.y, 1);
	elif Input.is_action_pressed("ui_accept"):
		var sssize = star_sprite.texture.get_size() * star_sprite.scale * star.scale
		var pos = self.local_to_map(self.to_local(star.global_position) - Vector2(sssize.x/2, 0.0))
		water_server.add_liquid(pos.x, pos.y, 1);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_tree().root.get_node("/root/Root")
	star = get_tree().root.get_node("/root/Root/Star")
	star_sprite = star.get_node("StarSprite2D")
	water_server = get_tree().root.get_node("/root/Root/LiquidServer")
	lava_server = get_tree().root.get_node("/root/Root/LavaServer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
