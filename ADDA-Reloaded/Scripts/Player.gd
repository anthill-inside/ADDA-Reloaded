
extends Actor

#export var  speed = 200
#export var rotation_speed = 1.5

#var velocity = Vector2.ZERO
#var rotation_dir = 0

#var anim = "Idle"

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if $Health.is_dead == false:
		if Input.is_action_pressed('Right'):
			rotation_dir += 1
		if Input.is_action_pressed('Left'):
			rotation_dir -= 1
		if Input.is_action_pressed('Down'):
			velocity -= transform.x * speed
		if Input.is_action_pressed('Up'):
			velocity += transform.x * speed 




#func _on_HurtBox_area_entered(area):
	#pass # Replace with function body.



