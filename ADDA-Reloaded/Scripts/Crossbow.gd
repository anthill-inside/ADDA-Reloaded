extends KinematicBody2D

export var damage = 1
export var cool_down = 0
export var bolt_speed = 120.0
export var bolt_range = 120.0

onready var curent_cool_down = cool_down
onready var weapon_sprite = $WeaponSprite
onready var Bolt = preload("res://Weapons/Bolt.tscn")

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
	
	pass

func get_input(): 
	if Input.is_action_pressed('Click'):
		attack()
			

func _physics_process(delta):
	if curent_cool_down < cool_down:
		curent_cool_down += delta
	else:
		weapon_sprite.frame = 0
		get_input()
