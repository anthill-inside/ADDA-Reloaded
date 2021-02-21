extends Node2D

var rooms = []

export var number_of_rooms = 10

export var chance_to_generate = 20

export onready var room_size = Vector2(3,3)

onready var tile_map = $TileMap

var starting_coordinates 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _input(event):
	if event.is_action_pressed('Sword'):
		generate()
func fill_map():
	for i in starting_coordinates.x * 2:
		for j in starting_coordinates.y * 2:
			tile_map.set_cell(i,j,0)

func draw_room(coordinates, room):
	for i in room_size.x:
		for j in room_size.y:
			if (i == 0 or i == room_size.x - 1) or (j == 0 or j == room_size.y - 1):
				tile_map.set_cell(coordinates.x + i, coordinates.y + j, 1)
			else:
				tile_map.set_cell(coordinates.x + i, coordinates.y + j, 0)
	
	
#	var connected_rooms = {
#	Vector2.UP: null,
#	Vector2.RIGHT: null,
#	Vector2.DOWN: null,
#	Vector2.LEFT: null,	
#}	
	
	
	for r in connected_rooms.keys():
		
		var ep = room_size / 2  + coordinates
		match r :
			Vector2.UP:
				ep.y = 0 + coordinates.y
			Vector2.DOWN:
				ep.y = room_size.y - 1 + coordinates.y
			Vector2.RIGHT:
				ep.x = room_size.x - 1 + coordinates.x
			Room.entrance_position.LEFT:
				ep.x = 0  + coordinates.x
			
		tile_map.set_cell(ep.x, ep.y, 0)

func generate():	
	starting_coordinates = room_dimensions * number_of_rooms * 2
	$Camera2D.position = starting_coordinates * $TileMap.cell_size
	
	tile_map.clear()
	#fill_map()
	randomize()
	var next_room_coordinates = starting_coordinates
	for i in number_of_rooms:
		print(next_room_coordinates)
		var room : = Room.new(randi()%4, [])
		
		rooms.append(Room)
		draw_room(next_room_coordinates, room)
		
		var direction =  {
			"UP": next_room_coordinates, 
			"DOWN": next_room_coordinates, 
			"RIGHT": next_room_coordinates, 
			"LEFT": next_room_coordinates,
			}
		var d_key = direction.k
		match room.type:
			Room.room_type.SINGLE:				
				direction.UP.y -= room_dimensions.y
				direction.DOWN += room_dimensions.y
				direction.RIGHT += room_dimensions.x
				direction.LEFT -= room_dimensions.x
				
			Room.room_type.DOUBLE_H:				
				direction.UP.y -= room_dimensions.y
				direction.DOWN += room_dimensions.y
				direction.RIGHT += room_dimensions.x * 2
				direction.LEFT -= room_dimensions.x
				
			Room.room_type.DOUBLE_V:
				direction.UP.y -= room_dimensions.y
				direction.DOWN += room_dimensions.y *2
				direction.RIGHT += room_dimensions.x
				direction.LEFT -= room_dimensions.x
				
			Room.room_type.QUAD:
				direction.UP.y -= room_dimensions.y
				direction.DOWN += room_dimensions.y * 2
				direction.RIGHT += room_dimensions.x * 2
				direction.LEFT -= room_dimensions.x
		
		if direction[d_key[randi()%4]]
	
#	print(tile_map.get_cell(0,0))
#	print(tile_map.get_cell(starting_coordinates.x, starting_coordinates.y))
		
	tile_map.update_bitmask_region(Vector2.ZERO,starting_coordinates * 2)
func _ready():
	generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
