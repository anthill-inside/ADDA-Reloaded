extends Node
class_name Room


var connected_rooms = {
	Vector2.UP: null,
	Vector2.RIGHT: null,
	Vector2.DOWN: null,
	Vector2.LEFT: null,	
}

var coordinates = Vector2.ZERO

var scene

func is_default():
	if connected_rooms[Vector2.UP] !=null:
		return false
	if connected_rooms[Vector2.RIGHT] !=null:
		return false
	if connected_rooms[Vector2.DOWN] !=null:
		return false
	if connected_rooms[Vector2.LEFT] !=null:
		return false
	if coordinates != Vector2.ZERO:
		return false
	return true

func get_random_direction(chance):
#	while true:
#		for dir in connected_rooms.keys():
#			if randi()%100 <= chance:
#				return dir
		var directions = connected_rooms.keys()
		return directions[randi()% directions.size()]
