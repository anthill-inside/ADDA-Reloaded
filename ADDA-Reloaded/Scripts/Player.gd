
extends Actor
class_name Player
#export var  speed = 200
#export var rotation_speed = 1.5
#var Weapon = preload ("res://Weapons/Weapon.tscn")
#onready var Crossbow = preload ("res://Weapons/Crossbow.tscn")
#var velocity = Vector2.ZERO
#var rotation_dir = 0

#var anim = "Idle"
var item_to_interact  = null



func _input(event):
	if event.is_action_pressed('Sword'):
		add_weapon(Weapons.Sword.instance())			
	if event.is_action_pressed('Mace'):
		add_weapon(Weapons.Mace.instance())
	if event.is_action_pressed("Crossbow"):
		add_weapon(Weapons.Crossbow.instance())
	if event.is_action_pressed("Spear"):
		add_weapon(Weapons.Spear.instance())
	if event.is_action_pressed("Pitchfork"):
		add_weapon(Weapons.Pitchfork.instance())
	
	if event.is_action_pressed("Interact"):
		if(item_to_interact != null):
			item_to_interact.interact(self)
	if event.is_action_pressed("Use") && consumable != null:
		consumable.use(self)
		emit_signal("ConsumableChanged",null)

var consumable 

func drop_consumable():
	print("dropping")
	if consumable != null && consumable is Consumable:
		var Ground_Consumable = load(consumable.consumable_ground_name)
		var ground_consumable = Ground_Consumable.instance()
		get_tree().root.add_child(ground_consumable)
		ground_consumable.global_position = global_position + Vector2(rand_range(20,40), rand_range(20,40))
		ground_consumable.rotation_degrees = rand_range(0,360)
		consumable.queue_free()
		print("consumable dropped")
	else:
		print("null")
func add_consumable(new_consumable):
	drop_consumable()
	consumable = new_consumable
	emit_signal("ConsumableChanged",consumable)

func add_weapon(new_weapon: Weapon):
	drop_weapon()
	add_child(new_weapon)
	weapon = new_weapon
	weapon.global_position = weapon_spawn.global_position
	weapon.play_ready_sound = true
	emit_signal("WeaponChanged", weapon)
		

func drop_weapon():
	if weapon != null:
		var Ground_Weapon = load(weapon.ground_weapon)
		var ground_weapon = Ground_Weapon.instance()
		get_tree().root.add_child(ground_weapon)
		ground_weapon.global_position = global_position + Vector2(rand_range(20,40), rand_range(20,40))
		ground_weapon.rotation_degrees = rand_range(0,360)
		weapon.queue_free()
		print("weapon dropped")


func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if health.is_dead == false:
		if Input.is_action_pressed('Right'):
			rotation_dir += 1
		if Input.is_action_pressed('Left'):
			rotation_dir -= 1
		if Input.is_action_pressed('Down'):
			velocity -= transform.x * speed
		if Input.is_action_pressed('Up'):
			velocity += transform.x * speed 
			
		if Input.is_action_pressed('Click'):
			for _i in self.get_children ():
					if _i is Weapon:
						_i.attack()



#func _on_HurtBox_area_entered(area):
	#pass # Replace with function body.


func _set_active_thingy(thingy):
	if(item_to_interact != null):
		_free_active_thingy()
	item_to_interact = thingy
	thingy.is_active = true
	
func _free_active_thingy():
	if(item_to_interact != null):
		item_to_interact.is_active = false
		item_to_interact = null


func _on_Interaction_zone_area_entered(area):
	_set_active_thingy(area)

func _on_Interaction_zone_area_exited(area):
	_free_active_thingy()

signal HealthChanged(max_health, current_health)

func send_health():
	emit_signal("HealthChanged",health.max_health, health.current_health)


signal WeaponChanged(weapon)
signal ConsumableChanged(consumable)
func _on_Health_HealthChanged(max_health, current_health):
	emit_signal("HealthChanged",max_health, current_health)

func _ready():
	send_health()
