extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal Victory()
# Called when the node enters the scene tree for the first time.
func _ready():
	NodesManager.amulet = self
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_InteractionArea_interacted(player):
	emit_signal("Victory")
	AudioManager.play("res://Audio/RPG Sound Pack/battle/spell.wav")
	
	for enemy in NodesManager.enemies:
		if(enemy.health):
			enemy.health.set_health(0)
	queue_free()
