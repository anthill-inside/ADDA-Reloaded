extends State

var result
# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass

func _input(event):
	if event.is_action_pressed('raycast_print') and result != null:
		print(result.collider.name)

# Virtual function. Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	result = owner.search_for_target()
	if result:
		if result.collider is Player and owner.is_on_screen():
			state_machine.transition_to("Attack")



# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	print(owner.name + " Whatever...")
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass


func _on_Health_HealthChanged(max_health, current_health):
	if state_machine.state == self:
		state_machine.transition_to("Attack")
