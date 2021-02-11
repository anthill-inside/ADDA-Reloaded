extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player : Node
var ui : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	player = find_node_by_name(get_tree().get_root(), "Player")
	ui = find_node_by_name(get_tree().get_root(), "UI")
	print(ui.name + " " + player.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed('Reload'):
		get_tree().reload_current_scene()
		
func find_node_by_name(root, name):

	if(root.get_name() == name): return root

	for child in root.get_children():
		if(child.get_name() == name):
			return child

		var found = find_node_by_name(child, name)

		if(found): return found

	return null
