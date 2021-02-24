extends Node

var num_players = 20

var bus = "master"

var available = []  # The available players.

var queue = []  # The queue of sounds to play.

var music_player = AudioStreamPlayer.new()

var play_music = true
var play_sounds = true


func _input(event):
	if event.is_action_pressed("ToggleSound"):
		play_sounds = !play_sounds
	if event.is_action_pressed("ToggleMusic"):
		if play_music:
			music_player.stop()
		else:
			music_player.play()
		play_music = !play_music

func _ready():
	# Create the pool of AudioStreamPlayer nodes.

	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.connect("finished", self, "_on_stream_finished", [p])
		p.bus = bus
		
	music_player = AudioStreamPlayer.new()	
	add_child(music_player)
	music_player.stream = load("res://Audio/Music/111.ogg")
	music_player.volume_db = -6
	music_player.play()


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.

	available.append(stream)


func play(sound_path):
	if play_sounds:
		queue.append(sound_path)
	

func _process(delta):
	# Play a queued sound if any players are available.

	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
