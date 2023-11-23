extends Node

enum noteType{
	Major_Plain
	Whole_Tone_Woods
	Gypys_Major_Desert
	Minor_Volcano
}

signal levelCompleted

const notesTextures = [
preload("res://assets/tile_major_plains/notesMusic/note_1.tres"),
preload("res://assets/tile_major_plains/notesMusic/note_3.tres"),
preload("res://assets/tile_major_plains/notesMusic/note_4.tres"),
preload("res://assets/tile_major_plains/notesMusic/note_2.tres")
]


export(noteType) var noteRegion
export(AudioStream) var sound_note

onready var dataBase = get_parent()

onready var texture = $"../texture"

func _set_noteData():
	
	dataBase.connect("body_entered" , self , "_getting_note")
	
	texture.texture = notesTextures[noteRegion]

func _getting_note(object):
	
	if object.is_in_group("player"):
		
		emit_signal("levelCompleted")
		
		ServeAudio.play_sound_at_position(sound_note , get_parent().global_position , "SFXs")
		
		dataBase.queue_free()
		
		MangerLevel.load_room()

func _ready():
	
	_set_noteData()

func _on_FinishedLevel_levelCompleted():
	
	print("Finished !")
