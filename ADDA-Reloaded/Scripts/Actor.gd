
extends KinematicBody2D
class_name Actor


onready var Weapons = {
	"Sword": preload("res://Weapons/Sword.tscn"),
	"Mace": preload("res://Weapons/Mace.tscn"),
	"Crossbow": preload("res://Weapons/Crossbow.tscn"),
	"Spear": preload("res://Weapons/Spear.tscn"),
	"Pitchfork": preload("res://Weapons/Pitchfork.tscn"),
}


export var  speed = 200
export var rotation_speed = 1.5

var velocity = Vector2.ZERO
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


signal death
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
	#queue_free()
func get_input():
	pass
#	if Input.is_action_pressed('Sword'):
#		if weapon != null:
#			weapon.queue_free()
#		weapon = Weapons.Sword.instance()
#		add_child(weapon)
#		weapon.global_position = weapon_spawn.global_position
#	if Input.is_action_pressed('Mace'):
#		if weapon != null:
#			weapon.queue_free()
#		weapon = Weapons.Mace.instance()
#		add_child(weapon)
#		weapon.global_position = weapon_spawn.global_position
#	if Input.is_action_pressed("Crossbow"):
#		if weapon != null:
#			weapon.queue_free()
#		weapon = Weapons.Crossbow.instance()
#		add_child(weapon)
#		weapon.global_position = weapon_spawn.global_position
#	if Input.is_action_pressed("Spear"):
#		if weapon != null:
#			weapon.queue_free()
#		weapon = Weapons.Spear.instance()
#		add_child(weapon)
#		weapon.global_position = weapon_spawn.global_position
#	if Input.is_action_pressed("Pitchfork"):
#		if weapon != null:
#			weapon.queue_free()
#		weapon = Weapons.Pitchfork.instance()
#		add_child(weapon)
#		weapon.global_position = weapon_spawn.global_position
	
func _physics_process(delta):
	get_input()
	
	if health.is_dead == false:
		if velocity == Vector2.ZERO:
			anim = "Idle"
		else:
			if velocity.length() < 1.0:
				velocity = 0
				
			if velocity.length() > 0.0:
				anim = "Walk"
			else:
				anim = "Idle"
		
	$AnimatedSprite.play(anim);
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

#func _ready():
	#health.connect("Died",self,"die")


func _on_HurtBox_area_entered(area):
	area.emit_signal("Hit")
	
	health.set_health(health.current_health - area.damage)
	var hit = HitAnimation.instance()
	add_child(hit)
	hit.global_position = global_position
