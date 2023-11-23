extends Node

signal sound_finished(sound)

func play_sound(sound:AudioStream , chanel:String = "Master" , volumedb:float = 1):
	
	var soundPlayer = AudioStreamPlayer.new()
	
	soundPlayer.connect("finished" , self , "_sound_finished" , [soundPlayer])
	
	soundPlayer.stream = sound
	
	soundPlayer.bus = chanel
	
	soundPlayer.volume_db = volumedb
	
	add_child(soundPlayer)
	
	soundPlayer.play()

func play_sound_at_position(sound:AudioStream , position:Vector2 , chanel:String = "Master" , volumedb:float = 1):
	
	var soundPlayer = AudioStreamPlayer2D.new()
	
	soundPlayer.connect("finished" , self , "_sound_finished" , [soundPlayer])
	
	soundPlayer.stream = sound
	
	soundPlayer.bus = chanel
	
	soundPlayer.volume_db = volumedb
	
	soundPlayer.global_position = position
	
	add_child(soundPlayer)
	
	soundPlayer.play()

func _sound_finished(sound):
	
	emit_signal("sound_finished" , sound)
	
	sound.queue_free()
