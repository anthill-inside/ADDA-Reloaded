extends Control

export var default_weapon_texture : Texture
export var default_consumable_texture : Texture
export var heart_texture : Texture
export var half_heart_texture : Texture
export var dead_heart_texture : Texture

var max_health
var curent_health
var weapon
var consumable
var player

var curent_consumable 
var curent_weapon

onready var heart_boxes = [$Node2D/VBoxContainer/HBoxContainer/HeartBox]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _death():#
	queue_free()
func _health_changed(new_max_health, new_current_healh):#
	max_health = new_max_health
	curent_health = new_current_healh
	print(max_health as String + " " + curent_health as String)
	
	var n_boxes = max_health/2 + max_health%2
	var boxes_now = $Node2D/VBoxContainer/HBoxContainer.get_child_count()
	
	if boxes_now < n_boxes:
		for i in n_boxes - boxes_now:
			var n = heart_boxes[0].duplicate()
			$Node2D/VBoxContainer/HBoxContainer/.add_child(n)
			heart_boxes.push_back(n)
	var curent_box 
	if curent_health % 2 == 0:
		curent_box = curent_health / 2 - 1
	else:
		curent_box = curent_health / 2
	for i in boxes_now:
		if i < curent_box:
			heart_boxes[i].texture = heart_texture
		elif i == curent_box:
			if curent_health % 2 == 0:
				heart_boxes[i].texture = heart_texture 
			else:
				heart_boxes[i].texture = half_heart_texture
		else:
				heart_boxes[i].texture = dead_heart_texture 
			 
				
	
func _weapon_changed(new_weapon):
	weapon = new_weapon
	if weapon != null:
		curent_weapon.texture_under = weapon.icon
		curent_weapon.max_value = weapon.cool_down * 10
		curent_weapon.value = weapon.curent_cool_down * 10
	else:
		curent_weapon.texture_under = default_weapon_texture
func _consumable_changed(consumable):#
	if consumable != null:
		curent_consumable.texture = consumable.icon
	else:
		curent_consumable.texture = default_consumable_texture
# Called when the node enters the scene tree for the first time.
func _ready():	
	player = find_node_by_name(get_tree().get_root(), "Player")
	weapon = player.weapon
	consumable = player.consumable
	
	if(player != null):
		player.connect("death", self, "_death")
		player.connect("HealthChanged", self, "_health_changed")
		player.connect("WeaponChanged", self, "_weapon_changed")
		player.connect("ConsumableChanged", self, "_consumable_changed")
		
	curent_consumable = $Node2D/VBoxContainer/CurenConsumable	
	curent_weapon = $Node2D/VBoxContainer/CurenWeapon
	if consumable != null:
		curent_consumable.texture = consumable.icon
	else:
		curent_consumable.texture = default_consumable_texture
		
	if weapon != null:
		curent_weapon.texture_under = weapon.icon
		curent_weapon.max_value = weapon.cool_down * 10
		curent_weapon.value = weapon.curent_cool_down * 10
	else:
		curent_weapon.texture_under = default_weapon_texture
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(weapon != null):
		curent_weapon.value = weapon.curent_cool_down * 10

func find_node_by_name(root, name):

	if(root.get_name() == name): return root

	for child in root.get_children():
		if(child.get_name() == name):
			return child

		var found = find_node_by_name(child, name)

		if(found): return found

	return null
