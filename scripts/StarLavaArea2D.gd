extends Area2D

var water_server 
var lava_server
var tilemap: TileMapLayer
var star_sprite
var sssize

func _ready():
	star_sprite = get_tree().root.get_node("/root/Root/Star")
	sssize = star_sprite.texture.get_size() * star_sprite.scale
	
	tilemap = get_tree().root.get_node("/root/Root/TileMapLayer")
	water_server = get_tree().root.get_node("/root/Root/LiquidServer")
	lava_server = get_tree().root.get_node("/root/Root/LavaServer")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed: # and event.button_index == MOUSE_BUTTON_LEFT:
		var pos = tilemap.local_to_map(tilemap.to_local(star_sprite.global_position) + Vector2(sssize.x/2, 0.0))
		lava_server.add_liquid(pos.x, pos.y, 1);
