extends Node2D
class_name Consumable

export var consumable_ground_name = "res://Items_Ground/Potion.tscn"
export var icon : Texture
export var use_sound = "res://Audio/264981__renatalmar__sfx-magic.wav"
var ConsumableGround = load(consumable_ground_name)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func use(target):
	AudioManager.play(use_sound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
