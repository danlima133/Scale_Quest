extends Node

const PreObjectNoteMusic = preload("res://gameEffects/effects/musicNoteFly.tscn")

signal effectNotesMusicFinished

func startEffect():
	
	randomize()
	
	for note in MangerLevel.musicsNotesList:
		
		var interval = rand_range(0.5 , 2)
		
		var musicNote = PreObjectNoteMusic.instance()
		
		musicNote.data = note
		
		musicNote.global_position = Vector2(-20 , 0)
		
		add_child(musicNote)
		
		yield(get_tree().create_timer(interval) , "timeout")
	
	emit_signal("effectNotesMusicFinished")
