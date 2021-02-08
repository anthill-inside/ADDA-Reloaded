
extends KinematicBody2D
class_name Actor

onready var health = $Health
var HitAnimation = preload("res://Scenes/HitAnimation.tscn")

func die():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randi_range(1, 3)
	$AnimatedSprite.animation = "Death" + random as String
	
	collision_layer = 0
	collision_mask = 0
	$HitBox.collision_layer = 0
	$HitBox.collision_mask = 0
	z_index -= 1
	#queue_free()


#func _ready():
	#health.connect("Died",self,"die")


func _on_HurtBox_area_entered(area):
	health.set_health(health.current_health - 1)
	var hit = HitAnimation.instance()
	add_child(hit)
	hit.global_position = global_position
	#print(area)
