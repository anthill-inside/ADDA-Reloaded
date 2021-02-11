extends Area2D

var is_active = false
var tip
var sprite

signal interacted(player)

func interact(player):
	emit_signal("interacted", player)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	tip = get_node("../Tip")
	sprite = get_node("../Sprite")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active :
		tip.visible = true
		sprite.modulate = Color("fffb00")
	else:
		tip.visible = false
		sprite.modulate = Color("ffffff")
		
