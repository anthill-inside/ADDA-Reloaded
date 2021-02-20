extends KinematicBody2D
class_name Weapon

export var damage = 1
export var cool_down = 0.5
export var ground_weapon = "res://Items_Ground/Sword.tscn"
export var icon : Texture

onready var curent_cool_down = cool_down
onready var damage_box = $DamageBox
onready var weapon_sprite = $WeaponSprite


export var play_ready_sound = false
export var ready_sound = "res://Audio/422508__nightflame__swinging-staff-whoosh-strong-03.wav"
export var attack_sound = "res://Audio/170958__timgormly__metal-clang1.wav"


enum WEAPON_STATE{READY, USED}
var state = WEAPON_STATE.READY

signal attack()

func _on_hit():
	if state == WEAPON_STATE.READY:
		damage_box.ready_to_strike = false
		curent_cool_down = 0
		weapon_sprite.modulate = Color("75544f4f")
		emit_signal("attack")
		state = WEAPON_STATE.USED
		AudioManager.play(attack_sound)
	pass

func attack():
	pass

func _physics_process(delta):
	if state == WEAPON_STATE.USED:
		if curent_cool_down < cool_down:
			curent_cool_down += delta
		else:
			damage_box.ready_to_strike = true
			print("111111111111")
			weapon_sprite.modulate = Color("ffffffff")
			state = WEAPON_STATE.READY
			if play_ready_sound:
				AudioManager.play(ready_sound)
	var last_hit_box = damage_box.last_hit_box;
	if(last_hit_box is Area2D):
		if damage_box.overlaps_area(last_hit_box):
			last_hit_box.emit_signal("area_entered", damage_box)  
	
