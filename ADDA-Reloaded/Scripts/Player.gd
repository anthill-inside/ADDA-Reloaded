
extends Actor

export var  speed = 200
export var rotation_speed = 1.5

var velocity = Vector2.ZERO
var rotation_dir = 0

var anim = "Idle"

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('Right'):
		rotation_dir += 1
	if Input.is_action_pressed('Left'):
		rotation_dir -= 1
	if Input.is_action_pressed('Down'):
		velocity -= transform.x * speed
	if Input.is_action_pressed('Up'):
		velocity += transform.x * speed

func _physics_process(delta):
	get_input()
	
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


func _on_HurtBox_area_entered(area):
	pass # Replace with function body.


func die():
	pass # Replace with function body.
