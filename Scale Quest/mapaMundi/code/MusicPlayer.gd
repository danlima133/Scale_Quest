extends AudioStreamPlayer

const MusicMenu = preload("res://assets/music/Menu.ogg")
const MusicMapaMundi = preload("res://assets/music/Mapa_Mundi.ogg")

enum local {
	Menu,
	MapaMundi
}

onready var timer = $TimerMusic/timer

var current_local:int

var positionMusic:float
var timerPosition:float

func playMusic():
	
	timer.stop()
	
	if playing == true:
		
		var trans = get_tree().create_tween()
		
		trans.tween_property(self , "volume_db" , -40 , 1)
		
		yield(trans , "finished")
	
	match current_local:
		
		local.Menu:
			
			stream = MusicMenu
		
		local.MapaMundi:
			
			stream = MusicMapaMundi
			
	var transition = get_tree().create_tween()
	
	volume_db = -40
	
	play()
	
	transition.tween_property(self , "volume_db" , 0 , 1)
	
	yield(transition , "finished")
	
	transition = null

func stopMusic(totaly:bool = false):
	
	var transition = get_tree().create_tween()
	
	transition.tween_property(self , "volume_db" , -40 , 1)
	
	yield(transition , "finished")
	
	if totaly == true: positionMusic = get_playback_position()
	
	stop()
	
	transition = null

func resumeMusic():

	var transition = get_tree().create_tween()
	
	volume_db = -40
	
	play(positionMusic)
	
	positionMusic = 0
	
	transition.tween_property(self , "volume_db" , 0 , 1)
	
	yield(transition , "finished")
	
	transition = null
