extends Node2D


var placed_rooms = []

var room_scenes = []

export var number_of_rooms = 10

export var chance_to_generate = 20

export onready var room_size = Vector2(19,11)

onready var tile_map = $TileMap
onready var camera = $Camera2D

var starting_coordinates 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func fill_map():
	for i in starting_coordinates.x * 2:
		for j in starting_coordinates.y * 2:
			tile_map.set_cell(i,j,0)

func draw_room(room):
	if room.scene == null:
		room.scene = load("res://Rooms/Empty.tscn").instance()
	var prefab = room.scene
	var coordinates = starting_coordinates + room.coordinates * room_size
	
	var children = prefab.get_children() 
	
	for child in children:
		var new_child = child.duplicate()
		add_child(new_child)
		new_child.position = child.position + coordinates * tile_map.cell_size
	
	for i in room_size.x:
		for j in room_size.y:
			if (i == 0 or i == room_size.x - 1) or (j == 0 or j == room_size.y - 1):
				tile_map.set_cell(coordinates.x + i, coordinates.y + j, 1)
			else:
				var tile_id = prefab.get_cell(i,j)
				if tile_id == 0:
					tile_map.set_atlas_tile(coordinates.x + i, coordinates.y + j, tile_id)
				else:
					tile_map.set_cell(coordinates.x + i, coordinates.y + j, tile_id)
				#tile_map.update_bitmask_area(Vector2(coordinates.x + i, coordinates.y + j))
	
	for r in room.connected_rooms.keys():
		
		var ep = room_size / 2  + coordinates
		if room.connected_rooms[r] != null:
			match r :
				Vector2.UP:
					ep.y = 0 + coordinates.y
				Vector2.DOWN:
					ep.y = room_size.y - 1 + coordinates.y
				Vector2.RIGHT:
					ep.x = room_size.x - 1 + coordinates.x
				Vector2.LEFT:
					ep.x = 0  + coordinates.x
			
			tile_map.set_cell(ep.x, ep.y, 0)
		else:
			match r :
				Vector2.UP:
					for i in room_size.x + 2:
						tile_map.set_cell(i - 1 + coordinates.x ,coordinates.y - 1, 1)
				Vector2.DOWN:
					for i in room_size.x + 2 :
						tile_map.set_cell(i - 1 + coordinates.x ,coordinates.y + room_size.y, 1)
				Vector2.RIGHT:
					for i in room_size.y + 2:
						tile_map.set_cell( room_size.x + coordinates.x ,coordinates.y + i - 1, 1)
				Vector2.LEFT:
					for i in room_size.y + 2:
						tile_map.set_cell( coordinates.x - 1 ,coordinates.y + i - 1, 1)


func draw_rooms():
	for room in placed_rooms:
		draw_room(room)
		
		
func connect_rooms():
	for room in placed_rooms:
		var dirs = room.connected_rooms.keys()
		for dir in dirs:
			room.connected_rooms[dir] = check_dir(dir, room)
		
		
func check_dir(dir, current_room):
	var new_room_coordinates = current_room.coordinates + dir
	
	for room in placed_rooms:
		if room.coordinates == new_room_coordinates:
			return room
	return null

func place_room(room):
	if !placed_rooms:
		placed_rooms = [room]
		return
	else:
		var current_room = placed_rooms[placed_rooms.size()-1]
		var dir = current_room.get_random_direction(chance_to_generate)		
		var new_current_room = check_dir(dir, current_room)
		
		while true:
			if new_current_room == null:
				room.coordinates = current_room.coordinates + dir
				placed_rooms.append(room)
				return
			else:
				current_room = new_current_room
				dir = current_room.get_random_direction(chance_to_generate)
				new_current_room = check_dir(dir, current_room)
	

func assign_rooms():
	var start_room = placed_rooms[0]
	
	var distance = 0
	var exit_room
	
	for room in placed_rooms:
		if room.coordinates.distance_to(start_room.coordinates) > distance:
			exit_room = room
			
	for room in placed_rooms:
		var rn = randi() % (room_scenes.size() - 2) + 2
		room.scene = room_scenes[rn]
		if room == start_room:
			room.scene = room_scenes[0]
		if room == exit_room:
			room.scene = room_scenes[1]


func generate():	
	starting_coordinates = room_size * number_of_rooms * 2
	camera.position = starting_coordinates * tile_map.cell_size
	
	var dir = Directory.new()
	dir.open("res://Rooms/")
	dir.list_dir_begin (true)	
	room_scenes.append(load("res://Rooms/SpecialRooms/StartRoom.tscn").instance())
	room_scenes.append(load("res://Rooms/SpecialRooms/EndRoom.tscn").instance())
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif dir.file_exists(file):
			print(dir.get_current_dir()+ "/" + file)
			var scene = load(dir.get_current_dir() + "/" + file).instance()
			room_scenes.append(scene)
	
	tile_map.clear()
	for child in get_children():
		if child != camera and child != tile_map:
			child.queue_free()
	
	placed_rooms = []
	#fill_map()
	randomize()
	var rooms = []
	
	for i in number_of_rooms:
		rooms.append(Room.new())
	var default_room = Room.new()	
	placed_rooms = []
	for i in rooms.size():
		var room = rooms[i]
		place_room(room)
		print(room.coordinates)
	assign_rooms()
	connect_rooms()
	draw_rooms()
#	print(tile_map.get_cell(0,0))
#	print(tile_map.get_cell(starting_coordinates.x, starting_coordinates.y))
		
	tile_map.update_bitmask_region(Vector2.ZERO,starting_coordinates * 2)
func _ready():
	generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
