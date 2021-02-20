#aextends KinematicBody2D
extends Weapon
class_name CrossBow

#export var damage = 1
#export var cool_down = 0
export var bolt_speed = 120.0
export var bolt_range = 120.0


#onready var weapon_sprite = $WeaponSprite
onready var Bolt = preload("res://Weapons/Bolt.tscn")
onready var audio = $AudioStreamPlayer2D 


func attack():
	if curent_cool_down >= cool_down:
		curent_cool_down = 0
		weapon_sprite.frame = 1
		
		var bolt = Bolt.instance()
		bolt.damage = damage
		#var bolt_velocity = Vector2.ZERO - transform.y * bolt_speed
		var bolt_velocity = Vector2(0, -bolt_speed).rotated(get_parent().rotation + rotation)
		bolt.rotation = get_parent().rotation + rotation
		bolt.velocity = bolt_velocity
		bolt.speed = bolt_speed
		bolt.bolt_range = bolt_range
		get_tree().root.add_child(bolt)
		#add_child(bolt)# _ready is called after that
		#bolt.rotation = rotation
		bolt.global_position = global_position
		emit_signal("attack")
		state = WEAPON_STATE.USED
		AudioManager.play(attack_sound)
	pass

			

func _physics_process(delta):
	if curent_cool_down >= cool_down:
		if state != WEAPON_STATE.READY:
			state = WEAPON_STATE.READY
			weapon_sprite.frame = 0
			AudioManager.play(ready_sound)
