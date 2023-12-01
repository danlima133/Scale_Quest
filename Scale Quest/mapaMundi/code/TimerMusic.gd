extends Node

export(int) var timeMin
export(int) var timeMax

onready var timer = $timer
onready var music_player = $"%MusicPlayer"

func _ready():
	
	randomize()

func _on_MusicPlayer_finished():
	
	if music_player.stoped == false:
	
		timer.wait_time = rand_range(timeMin , timeMax)
		
		timer.start()
	
func _on_timer_timeout():
	
	music_player.playMusic()
