extends Area2D

onready var damage  = get_parent().damage
var ready_to_strike = true
signal Hit

var last_hit_box


func _on_DamageBox_area_entered(area):
	last_hit_box = area
