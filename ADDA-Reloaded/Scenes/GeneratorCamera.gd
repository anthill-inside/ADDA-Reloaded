extends Camera2D

var speed = 400  # speed in pixels/sec

var velocity = Vector2.ZERO

func _input(event):
	if event.is_action_pressed('ZoomIn'):
		zoom *= 1.1
	if event.is_action_pressed('ZoomOut'):
		zoom *= 0.9


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('Right'):
		velocity.x += 1
	if Input.is_action_pressed('Left'):
		velocity.x -= 1
	if Input.is_action_pressed('Down'):
		velocity.y += 1
	if Input.is_action_pressed('Up'):
		velocity.y -= 1
		
	# Make sure diagonal movement isn't faster

	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()	
	position += velocity * delta
	
