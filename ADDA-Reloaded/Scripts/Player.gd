
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
	if event.is_action_pressed("Interact"):
		if(item_to_interact != null):
			item_to_interact.interact(self)
	if event.is_action_pressed("Use"):
		consumable.use(self)

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
		item_to_interact = ground_consumable
		print("consumable dropped")
	else:
		print("null")




func drop_weapon():
	if weapon != null:
		var Ground_Weapon = load(weapon.ground_weapon)
		var ground_weapon = Ground_Weapon.instance()
		get_tree().root.add_child(ground_weapon)
		ground_weapon.global_position = global_position + Vector2(rand_range(20,40), rand_range(20,40))
		ground_weapon.rotation_degrees = rand_range(0,360)
		weapon.queue_free()
		item_to_interact = ground_weapon
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
						
		if Input.is_action_pressed('Sword'):
			if weapon != null:
				weapon.queue_free()
			weapon = Weapons.Sword.instance()
			add_child(weapon)
			weapon.global_position = weapon_spawn.global_position
		if Input.is_action_pressed('Mace'):
			if weapon != null:
				weapon.queue_free()
			weapon = Weapons.Mace.instance()
			add_child(weapon)
			weapon.global_position = weapon_spawn.global_position
		if Input.is_action_pressed("Crossbow"):
			if weapon != null:
				weapon.queue_free()
			weapon = Weapons.Crossbow.instance()
			add_child(weapon)
			weapon.global_position = weapon_spawn.global_position
		if Input.is_action_pressed("Spear"):
			if weapon != null:
				weapon.queue_free()
			weapon = Weapons.Spear.instance()
			add_child(weapon)
			weapon.global_position = weapon_spawn.global_position
		if Input.is_action_pressed("Pitchfork"):
			if weapon != null:
				weapon.queue_free()
			weapon = Weapons.Pitchfork.instance()
			add_child(weapon)
			weapon.global_position = weapon_spawn.global_position



#func _on_HurtBox_area_entered(area):
	#pass # Replace with function body.





func _on_Interaction_zone_area_entered(area):
	item_to_interact = area


func _on_Interaction_zone_area_exited(area):
	item_to_interact = null
