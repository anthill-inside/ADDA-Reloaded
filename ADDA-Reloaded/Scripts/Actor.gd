
extends KinematicBody2D
class_name Actor



export var  speed = 200
export var rotation_speed = 1.5

var velocity = Vector2.ZERO
var rotation_dir = 0

var anim = "Idle"

onready var health = $Health
var HitAnimation = preload("res://Effects/HitAnimation.tscn")

func die():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random = rng.randi_range(1, 3)
	anim = "Death" + random as String
	print(anim)
	
	collision_layer = 0
	collision_mask = 0
	$HitBox.collision_layer = 0
	$HitBox.collision_mask = 0
	z_index -= 1
	#queue_free()
func get_input():
	pass	
	
func _physics_process(delta):
	get_input()
	
	if $Health.is_dead == false:
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
