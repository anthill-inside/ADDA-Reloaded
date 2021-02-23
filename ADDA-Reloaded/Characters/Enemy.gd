extends Actor
class_name Enemy

var target
export var min_distance = 80.0
var line

func is_on_screen():
	return $VisibilityNotifier2D.is_on_screen()

func _physics_process(delta):
	if target == null: 
		target = NodesManager.player
		
#	line.global_position = Vector2.ZERO
#	line.rotation = -rotation
				
	get_input()


func search_for_target():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = null
	if target != null:
		result = space_state.intersect_ray(global_position, target.global_position,[self], 0b11)
	return result
	
func check_for_friends():
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var result = space_state.intersect_ray(global_position, target.global_position,[self], 0b101)
	return result
		
func die():
	.die()
	$StateMachine.queue_free()
	line.hide()
	
func _ready():
	line = $Line2D
#	remove_child(line)	
#	get_tree().get_current_scene().add_child(line)
	#line.global_position = Vector2(0,0)
	NodesManager.enemies.push_back(self)
	var keys = Weapons.keys()
	var key = keys[randi() % Weapons.size()]
	add_weapon(Weapons[key].instance())
	
	
	match key:
		"Sword", "Mace":
			min_distance = 15.0
			
		"Spear", "Pitchfork":
			min_distance = 80.0
			print(80.0)
		"Crossbow":
			min_distance = 120.0
			print(120.0)
	weapon.get_node("DamageBox").set_collision_mask(0b1000)
