extends TileMapLayer


var water_server : LiquidServer
var lava_server : LiquidServer
var star: CharacterBody2D
var star_sprite: Sprite2D
var root
var sssize

func _input(event):
	if Input.is_action_pressed("lava_drop") and lava_server.get_total_amount() < GameManager.max_laval_for_level[0]:
		var pos = self.local_to_map(self.to_local(star.global_position) + Vector2(sssize.x/2, 0.0))
		lava_server.add_liquid(pos.x, pos.y, 1);
	elif Input.is_action_pressed("ui_accept") and water_server.get_total_amount() < GameManager.max_water_for_level[0]:
		var pos = self.local_to_map(self.to_local(star.global_position) - Vector2(sssize.x/2, 0.0))
		water_server.add_liquid(pos.x, pos.y, 1);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_tree().root.get_node("/root/Root")
	star = get_tree().root.get_node("/root/Root/Star")
	star_sprite = star.get_node("StarSprite2D")
	water_server = get_tree().root.get_node("/root/Root/LiquidServer")
	lava_server = get_tree().root.get_node("/root/Root/LavaServer")
	
	sssize = star_sprite.texture.get_size() * star_sprite.scale * star.scale
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
