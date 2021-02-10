extends KinematicBody2D
class_name Weapon

export var damage = 1
export var cool_down = 0.5
export var ground_weapon = "res://Items_Ground/Sword.tscn"

onready var curent_cool_down = cool_down
onready var damage_box = $DamageBox
onready var weapon_sprite = $WeaponSprite

func _on_hit():
	if curent_cool_down >= cool_down:
		curent_cool_down = 0
		weapon_sprite.modulate = Color("75544f4f")
	pass

func attack():
	pass

func _physics_process(delta):
	if curent_cool_down < cool_down:
		curent_cool_down += delta
	else:
		weapon_sprite.modulate = Color("ffffffff")
		var last_hit_box = damage_box.last_hit_box;
		if(last_hit_box is Area2D):
			if damage_box.overlaps_area(last_hit_box):
				last_hit_box.emit_signal("area_entered", damage_box)  
	
