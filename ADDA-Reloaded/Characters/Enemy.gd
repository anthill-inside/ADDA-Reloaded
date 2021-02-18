extends Actor
class_name Enemy

var target
export var min_distance = 10.0

func is_on_screen():
	return $VisibilityNotifier2D.is_on_screen()

func _physics_process(delta):
	if target == null: 
		target = NodesManager.player
				
	get_input()


func search_for_target():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(global_position, target.global_position,[self], 0b11)
	return result
		
func die():
	.die()
	$StateMachine.queue_free()
	
#func turn(player):
#    var global_pos = global_transform.origin
#    var player_pos = target.global_transform.origin
#    var wtransform = global_transform.looking_at(Vector2(player_pos.x,global_pos.y),Vector2(0,1))
#    var wrotation = Quat(global_transform.basis).slerp(Quat(wtransform.basis), rotation_speed)
#
#    global_transform = Transform(Basis(wrotation), global_transform.origin)

#func _physics_process(delta):
