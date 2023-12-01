extends Node

const PreEffectNote = preload("res://gameEffects/effects/musicExplosion.tscn")

enum noteType{
	Major_Plain
	Whole_Tone_Woods
	Gypys_Major_Desert
	Minor_Volcano
}

signal levelCompleted

const notesTextures = [
preload("res://assets/notesMusic/note_1.tres"),
preload("res://assets/notesMusic/note_2.tres"),
preload("res://assets/notesMusic/note_4.tres"),
preload("res://assets/notesMusic/note_3.tres")
]

export(noteType) var noteRegion
export(AudioStream) var sound_note

export(NodePath) var roomTimePath
export(NodePath) var cutsceneNotesPath

export(Color) var shineColor

onready var dataBase = get_parent()

onready var texture = $"../texture"

var roomTimeObject:Object
var cutsceneObject:Object

func _set_noteData():
	
	dataBase.connect("body_entered" , self , "_getting_note")
	
	texture.texture = notesTextures[noteRegion]

func _getting_note(object):
	
	if object.is_in_group("player"):
		
		_makeEffect()
		
		get_tree().call_group("roomTime" , "_stop_timer")
		
		emit_signal("levelCompleted")
		
		ServeAudio.play_sound_at_position(sound_note , get_parent().global_position , "MusicNotes")
		
		dataBase.hide()
		
		dataBase.get_node("shape").set_deferred("disabled" , true)
		
		MangerLevel.musicsNotesList.append({"noteSound":sound_note , "noteTexture":notesTextures[noteRegion]})
		
		yield(ServeAudio , "sound_finished")
		
		_get_TimeAvarage()

func _get_TimeAvarage():
	
	roomTimeObject = get_node(roomTimePath)
	
	var timeRoomConclusion:float = (roomTimeObject.timeLevel - roomTimeObject.timer_count)
	
	MangerLevel.levelsAvarageTime[MangerLevel.current_level].append(timeRoomConclusion)
	
	if MangerLevel.roomOrder.size() == (MangerLevel.countRoom + 1):
		
		var timeCount:int
		
		for t in MangerLevel.levelsAvarageTime[MangerLevel.current_level]:
			
			timeCount += t
			
		timeCount /= MangerLevel.roomOrder.size()
		
		if timeCount < MangerLevel.levelsTimeReal[MangerLevel.current_level]:
		
			MangerLevel.levelsTimeReal[MangerLevel.current_level] = int(timeCount)
		
		else:
			
			if MangerLevel.levelsTimeReal[MangerLevel.current_level] == 0:
				
				MangerLevel.levelsTimeReal[MangerLevel.current_level] = int(timeCount)
		
		yield(get_tree().create_timer(1) , "timeout")
		
		cutsceneObject = get_node(cutsceneNotesPath)
		
		cutsceneObject.startEffect()
		
		yield(cutsceneObject , "effectNotesMusicFinished")
		
		MangerLevel.musicsNotesList.clear()
	
	MangerLevel.load_room(dataBase.owner)

func _makeEffect():
	
	var effect = PreEffectNote.instance()
	
	effect.get_node("NoteData").setNote(noteRegion + 1)
	
	effect.global_position = dataBase.global_position + Vector2(8 , 8)
	
	dataBase.get_parent().add_child(effect)
	
	effect.get_node("NoteData").setData()

func _ready():
	
	texture.material.set("shader_param/shine_color" , shineColor)
	
	_set_noteData()

func _on_FinishedLevel_levelCompleted():
	
	print("Finished !")
