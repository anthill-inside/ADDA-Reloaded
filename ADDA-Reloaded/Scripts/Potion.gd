extends Consumable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func use(target):
	target.health.set_health(target.health.max_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass