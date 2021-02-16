extends RigidBody2D

export var weapon_name = "res://Weapons/Sword.tscn"
export var pick_up_sound = "res://Audio/420612__glaneur-de-sons__sword-swing-b-strong-02.wav"
onready var Weapon = load(weapon_name)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func pick_up(player):
	var weapon = Weapon.instance()
	if weapon != null:
#		player.drop_weapon()
#		player.add_child(weapon)
#		player.weapon = weapon
#		weapon.global_position = player.weapon_spawn.global_position
		AudioManager.play(pick_up_sound)
		player.add_weapon(weapon)
		queue_free()
				

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
