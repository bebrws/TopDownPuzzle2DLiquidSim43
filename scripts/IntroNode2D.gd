@tool
extends Node2D

const WIDTH: float = 10000.0
const HEIGHT: float = 10000.0

func _draw() -> void:
	draw_rect(Rect2(-WIDTH/2, -HEIGHT/2, WIDTH, HEIGHT), Color.WHITE)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.set_current_animation("StarIntro")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("left_click"):
		GameManager.switch_scene("res://scenes/root.tscn")
