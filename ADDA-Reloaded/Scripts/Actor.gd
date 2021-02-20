
extends KinematicBody2D
class_name Actor


export onready var Weapons = {
	"Sword": preload("res://Weapons/Sword.tscn"),
	"Mace": preload("res://Weapons/Mace.tscn"),
	"Crossbow": preload("res://Weapons/Crossbow.tscn"),
	"Spear": preload("res://Weapons/Spear.tscn"),
	"Pitchfork": preload("res://Weapons/Pitchfork.tscn"),
}
export onready var Consumables = {
	"Potion": preload("res://Consumables/Potion.tscn"),
}

export var play_ready_sound = false

export var groans = [
	"res://Audio/scream-1.wav",
	"res://Audio/scream-2.wav",
	"res://Audio/scream-3.wav",
	"res://Audio/scream-4.wav",
	"res://Audio/scream-5.wav",
	"res://Audio/scream-6.wav",
#"res://Audio/Potion.wav"
]

export var  speed = 200
export var rotation_speed = 1.5

var velocity: = Vector2.ZERO
var rotation_dir = 0

var anim = "Idle"

onready var health = $Health
var HitAnimation = preload("res://Effects/HitAnimation.tscn")

var weapon = null
var weapon_spawn :Node2D
func _ready():
	for _i in self.get_children ():
		if _i.name == "WeaponSpawn":
			weapon_spawn = _i



var consumable 
signal death

func drop_consumable():
	print("dropping")
	if consumable != null && consumable is Consumable:
		var Ground_Consumable = load(consumable.consumable_ground_name)
		var ground_consumable = Ground_Consumable.instance()
		get_tree().root.add_child(ground_consumable)
		ground_consumable.global_position = global_position + Vector2(rand_range(20,40), rand_range(20,40))
		ground_consumable.rotation_degrees = rand_range(0,360)
		consumable.queue_free()
		print("consumable dropped")
	else:
		print("null")
func add_consumable(new_consumable: Consumable):
	drop_consumable()
	consumable = new_consumable
	emit_signal("ConsumableChanged",consumable)

func add_weapon(new_weapon: Weapon):
	drop_weapon()
	add_child(new_weapon)
	weapon = new_weapon
	weapon.global_position = weapon_spawn.global_position
	weapon.play_ready_sound = play_ready_sound
	emit_signal("WeaponChanged", weapon)
		

func drop_weapon():
	if weapon != null:
		var Ground_Weapon = load(weapon.ground_weapon)
		var ground_weapon = Ground_Weapon.instance()
		get_tree().root.add_child(ground_weapon)
		ground_weapon.global_position = global_position + Vector2(rand_range(20,40), rand_range(20,40))
		ground_weapon.rotation_degrees = rand_range(0,360)
		weapon.queue_free()
		print("weapon dropped")


func die():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randi_range(1, 3)
	anim = "Death" + random as String
	
	collision_layer = 0
	collision_mask = 0
	$HitBox.collision_layer = 0
	$HitBox.collision_mask = 0
	z_index -= 1
	emit_signal("death")
	AudioManager.play(groans[randi() % groans.size()]) 
	drop_consumable()
	drop_weapon()
	#queue_free()
func get_input():
	pass
	
func _physics_process(delta):
	get_input()
	
	if health.is_dead == false:
		if velocity == Vector2.ZERO:
			anim = "Idle"
		else:
			if velocity.length() < 0.01:
				velocity = Vector2.ZERO
				
			if velocity.length() > 0.0:
				anim = "Walk"
			else:
				anim = "Idle"
	
	$AnimatedSprite.play(anim);

#func _ready():
	#health.connect("Died",self,"die")


func _on_HurtBox_area_entered(area):
	if area.ready_to_strike:
		area.emit_signal("Hit")
		
		health.set_health(health.current_health - area.damage)
		var hit = HitAnimation.instance()
		hit.modulate = Color.red
		add_child(hit)
		hit.global_position = global_position
