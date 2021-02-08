extends Node



export(int) var  max_health = 2
onready var  current_health = max_health setget set_health

var is_dead = false

signal Died


func set_health(health):
	if health > max_health:
		current_health = max_health
	elif health <= 0 and is_dead == false:
		Die()
	else:
		current_health = health


func Die():
	#print("dead")
	is_dead = true
	emit_signal("Died")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
