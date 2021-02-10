extends RigidBody2D

export var weapon_name = "res://Weapons/Sword.tscn"
onready var Weapon = load(weapon_name)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func pick_up(player):
	var weapon = Weapon.instance()
	if weapon != null:
		player.drop_weapon()
		player.add_child(weapon)
		player.weapon = weapon
		weapon.global_position = player.weapon_spawn.global_position
		queue_free()
				

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
