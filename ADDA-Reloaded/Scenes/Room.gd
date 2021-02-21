extends Node
class_name Room


enum entrance_position {TOP, LEFT, RIGHT, BOTTOM}

var connected_rooms = {
	Vector2.UP: null,
	Vector2.RIGHT: null,
	Vector2.DOWN: null,
	Vector2.LEFT: null,	
}

func _init():
	pass
