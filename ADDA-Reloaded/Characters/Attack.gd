extends State


# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if not owner.is_on_screen():
		state_machine.transition_to("Idle")


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	var angle = - owner.get_angle_to(owner.target.get_global_position())
	if angle < 0:
		owner.rotation_dir = 1
	elif angle > 0:
		owner.rotation_dir = -1
	else:
		owner.rotation_dir = 0
		
	if (abs(angle) < owner.rotation_speed * _delta):		
		owner.look_at(owner.target.get_global_position())
	else:
		owner.rotation += owner.rotation_dir * owner.rotation_speed * _delta
	
	var velocity: Vector2 = owner.velocity
	if abs(owner.get_angle_to(owner.target.get_global_position())) < PI/2:
		var desired: Vector2 = (owner.target.position - owner.position).normalized() * owner.speed

		var steer = (desired - velocity).normalized() * owner.rotation_speed 

		velocity += steer 
		velocity = velocity.clamped(owner.speed)
	else:
		velocity = Vector2.ZERO
#	owner.rotation = velocity.angle() 
	
	print(velocity)
	
	owner.velocity =  velocity
	
	owner.velocity = owner.move_and_slide(velocity)


#	rotation += rotation_dir * rotation_speed * delta
#	velocity = move_and_slide(velocity)

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print(owner.name + " WAAAAAGH!!!")
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
