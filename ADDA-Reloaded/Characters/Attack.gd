extends State


var points
var following_a_path
# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	if not owner.is_on_screen():
		state_machine.transition_to("Idle")


func get_points():
	var start: Vector2 = owner.global_position;
	var end: Vector2 = owner.target.global_position;
	var path: PoolVector2Array = NodesManager.nav2d.get_simple_path(start, end, false)
	#Enemy.set_path(path);
	owner.line.points = path;
	points = path

func _follow_the_path(_delta):
	
	var point = points[0]
	var curent_point =  owner.get_global_position()
		
	if point.distance_to(curent_point) < 10.0:
		if points != null:		
			points.remove(0)
			if points.size() == 0:
				get_points()
		else:
			get_points()	
		point = points[0]
		owner.line.points = points
	
	
	var angle = - owner.get_angle_to(point)
	if angle < 0:
		owner.rotation_dir = 1
	elif angle > 0:
		owner.rotation_dir = -1
	else:
		owner.rotation_dir = 0		
	if (abs(angle) < owner.rotation_speed * _delta):		
		owner.look_at(point)
	else:
		owner.rotation += owner.rotation_dir * owner.rotation_speed * _delta
	
	var velocity: Vector2 = owner.velocity#	if abs(owner.get_angle_to(point)) < PI/2:
	var desired: Vector2 = (point - curent_point).normalized() * owner.speed
	var steer = (desired - velocity).normalized() * owner.rotation_speed * 2 
	velocity += steer 
	velocity = velocity.clamped(owner.speed)
		
	owner.velocity =  velocity
	owner.velocity = owner.move_and_slide(velocity)
	
	
func _attack_player(_delta):
	
	var point = owner.target.get_global_position()
	var curent_point =  owner.get_global_position()
	
	
	var angle = - owner.get_angle_to(point)
	if angle < 0:
		owner.rotation_dir = 1
	elif angle > 0:
		owner.rotation_dir = -1
	else:
		owner.rotation_dir = 0
		
	var friend_check = owner.check_for_friends()
	if abs(angle) < 5 * PI/180 and not friend_check:
		owner.weapon.attack()	
		
	if (abs(angle) < owner.rotation_speed * _delta):		
		owner.look_at(point)
	else:
		owner.rotation += owner.rotation_dir * owner.rotation_speed * _delta
	
	var velocity: Vector2 = owner.velocity
	if abs(owner.get_angle_to(point)) < PI/2:
		var desired: Vector2 = (point - curent_point).normalized() * owner.speed

		var steer = (desired - velocity).normalized() * owner.rotation_speed 
		if curent_point.distance_to(point) < owner.min_distance:
			velocity -= steer 
			velocity = velocity.clamped(owner.speed * 0.6)
		else:
			velocity += steer 
			velocity = velocity.clamped(owner.speed)
		
	else:
		velocity = Vector2.ZERO
#	owner.rotation = velocity.angle() 
	
	
	owner.velocity =  velocity
	
	owner.velocity = owner.move_and_slide(velocity)
	
# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	var result = owner.search_for_target()
	if result and owner.is_on_screen():
		if result.collider is Player:
			following_a_path = false
			points = null
			_attack_player(_delta)
			owner.line.hide()
		else:
			if not following_a_path: 
				get_points()
				following_a_path = true
			_follow_the_path(_delta)
			owner.line.show()

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print(owner.name + " WAAAAAGH!!!")
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	points = null
	following_a_path = false

