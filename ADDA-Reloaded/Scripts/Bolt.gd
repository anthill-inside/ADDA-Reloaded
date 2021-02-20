extends Weapon

var velocity : Vector2
var bolt_range :float
var speed : float

export var miss_sound = "res://Audio/arrow-miss.wav"

var MissAnimation = preload("res://Effects/HitAnimation.tscn")

func miss():
	AudioManager.play(miss_sound)
	var hit = MissAnimation.instance()
	get_tree().get_root().add_child(hit)
	hit.global_position = $Point.global_position
	queue_free()



func _on_hit():
	._on_hit()
	queue_free()

func _ready():
	$Timer.wait_time = bolt_range / speed;
	$Timer.start()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		miss()

func _on_Timer_timeout():
	miss()
