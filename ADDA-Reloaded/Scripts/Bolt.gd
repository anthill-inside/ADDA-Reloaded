extends "res://Scripts/Weapon.gd"

var velocity : Vector2
var bolt_range :float
var speed : float


func _on_hit():
	queue_free()

func _ready():
	print(bolt_range / speed)
	$Timer.wait_time = bolt_range / speed;
	$Timer.start()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		queue_free()


func _on_Timer_timeout():
	queue_free()
