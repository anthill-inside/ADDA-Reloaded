
extends Actor
class_name Player

var interactable_items = []
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

func add_weapon(new_weapon: Weapon):
	.add_weapon(new_weapon)
	new_weapon.weapon_sprite.light_mask = 2

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if health.is_dead == false:
		if Input.is_action_pressed('Right'):
			rotation_dir += 1
		if Input.is_action_pressed('Left'):
			rotation_dir -= 1
		if Input.is_action_pressed('Down'):
			velocity -= transform.x * speed * 0.8
		if Input.is_action_pressed('Up'):
			velocity += transform.x * speed 
			
		if Input.is_action_pressed('Click'):
			for _i in self.get_children ():
					if _i is Weapon:
						_i.attack()


func _physics_process(delta):
	_set_active_thingy()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)


func _set_active_thingy():
	var square = INF
	var index = 0
	if interactable_items:
		for i in interactable_items.size():
			var new_square = interactable_items[i].global_position.distance_squared_to(global_position)
			if new_square < square:
				index = i
				square = new_square
		if(item_to_interact != null):
			_free_active_thingy()
		item_to_interact = interactable_items[index]
		interactable_items[index].is_active = true

	
func _add_interactable_item(item):
	interactable_items.append(item)
func _remove_interactable_item(item):
	if item == item_to_interact:
		_free_active_thingy()
	interactable_items.erase(item)
	
func _free_active_thingy():
	if(item_to_interact != null):
		item_to_interact.is_active = false
		item_to_interact = null


func _on_Interaction_zone_area_entered(area):
	if !health.is_dead:
		_add_interactable_item(area)

func _on_Interaction_zone_area_exited(area):
	_remove_interactable_item(area)


func die():
	.die()
	_free_active_thingy()

signal HealthChanged(max_health, current_health)

func send_health():
	emit_signal("HealthChanged",health.max_health, health.current_health)


signal WeaponChanged(weapon)
signal ConsumableChanged(consumable)
func _on_Health_HealthChanged(max_health, current_health):
	emit_signal("HealthChanged",max_health, current_health)

func _ready():
	._ready()
	add_consumable(Consumables.Potion.instance())
	send_health()
	NodesManager.player = self
	
	var keys = Weapons.keys()
	var key = keys[randi() % Weapons.size()]
	print(key)
	add_weapon(Weapons[key].instance())
