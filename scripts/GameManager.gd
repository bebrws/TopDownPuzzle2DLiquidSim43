extends Node

const DEFAULT_EMPTY_CELL = Vector2i(5,15)

const EMPTY_CELLS = [
	Vector2i(5,15)
]

const DEFAULT_WATER_CELL = Vector2i(4,10)

const DEFAULT_LAVA_CELL = Vector2i(6,12)

const DEFAULT_ROCK_CELL = Vector2i(1,0)

const WATER_CELLS = [
	Vector2i(4,9),
	Vector2i(4,10),
	Vector2i(5,10),
]

const LAVA_CELLS = [
	Vector2i(6,11),
	Vector2i(6,12),
	Vector2i(7,12)
]

const GROUND_CELLS = [
	Vector2i(1,0),
	Vector2i(1,1)
]



#var EMPTY_CELLS = [
	#{
		#"coords": Vector2i(1,0),
		#"alt": 2
	#}
#]
#
#var WATER_CELLS = [
	#{
		#"coords": Vector2i(4,9),
		#"alt": 0
	#},
	#{
		#"coords": Vector2i(4,10),
		#"alt": 0
	#},
	#{
		#"coords": Vector2i(5,10),
		#"alt": 0
	#}
#]
#
#var LAVA_CELLS = [
	#{
		#"coords": Vector2i(6,11),
		##"alt": 0
	#},
	#{
		#"coords": Vector2i(6,12),
		##"alt": 0
	#},
	#{
		#"coords": Vector2i(7,12),
		##"alt": 0
	#}
#]
#
#var GROUND_CELLS = [
	#{
		#"coords": Vector2i(1,0),
		#"alt": 0
	#},
	#{
		#"coords": Vector2i(1,1),
		#"alt": 0
	#}
#]




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
