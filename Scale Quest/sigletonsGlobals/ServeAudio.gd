extends Node

signal sound_finished(sound)

var soundRoomCount:float

func _ready():
	
	pause_mode = Node.PAUSE_MODE_PROCESS

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

func play_SoundRoom(sound:String):
	
	var audioPlayer = AudioStreamPlayer.new()
	
	audioPlayer.name = "roomSoundPlayer"
	
	audioPlayer.stream = load("res://assets/music/" + sound + ".ogg")
	
	audioPlayer.volume_db = -50
	
	audioPlayer.bus = "Music"
	
	add_child(audioPlayer , true)
	
	audioPlayer.play()
	
	var trasition = get_tree().create_tween()
	
	trasition.tween_property(audioPlayer , "volume_db" , 0 , 1)

func stop_SounRoom(totaly:bool):
	
	var roomSound = getRommSound()
	
	if roomSound == null: return
	
	match totaly:
		
		false:
			
			soundRoomCount = roomSound.get_playback_position()
			
			var trasition = get_tree().create_tween()
			
			trasition.tween_property(roomSound , "volume_db" , -80 , 1)
			
			yield(trasition , "finished")
			
			roomSound.stop()
			
		true:
			
			var trasition = get_tree().create_tween()
	
			trasition.tween_property(roomSound , "volume_db" , -80 , 1)
			
			yield(trasition , "finished")
			
			roomSound.queue_free()

func return_SoundRoom():
	
	var roomSound = getRommSound()
	
	if roomSound == null: return
	
	roomSound.play(soundRoomCount)
	
	soundRoomCount = 0
	
func getRommSound() -> AudioStreamPlayer:
	
	var player:AudioStreamPlayer
	
	player = get_node_or_null("roomSoundPlayer")
	
	return player
