extends TileMap


func set_atlas_tile(x, y, tile_id):
	var rect = tile_set.tile_get_region(tile_id)
	var t_x = randi() % int(rect.size.x / tile_set.autotile_get_size(tile_id).x)
	var t_y = randi() % int(rect.size.y / tile_set.autotile_get_size(tile_id).y)
	
	var b1 = true
	if randi() % 2:
		b1 = false   
	var b2 = true
	if randi() % 2:
		b2 = false 
	var b3 = true
	if randi() % 2:
		b3 = false 
	
	set_cell(x, y, tile_id,b1,b2,b3,Vector2(t_x,t_y))
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
