extends Camera2D

#@onready var target = $JennyCharacterBody2D
var target_node: Node2D

#@onready var target_node = $"../$JennyCharacterBody2D"


func _ready():
	#self.make_current()
	target_node = get_parent().get_node("JennyCharacterBody2D")
	pass
	
func _process(delta):
	#if target_node:
		#global_position = target_node.global_position
	pass
