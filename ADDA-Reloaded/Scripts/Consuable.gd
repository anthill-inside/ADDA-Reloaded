extends Node2D
class_name Consumable

export var consumable_ground_name = "res://Items_Ground/Potion.tscn"
export var icon : Texture
var ConsumableGround = load(consumable_ground_name)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func use(target):
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
