extends RigidBody2D

export var consumable_name = "res://Consumables/Potion.tscn"
onready var Consumable = load(consumable_name)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func pick_up(player):
	var consumable = Consumable.instance()
	if consumable != null:
		player.drop_consumable()
		player.consumable = consumable
		queue_free()
				

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
