extends Node

enum noteType{
	Major_Plain
	Whole_Tone_Woods
	Gypys_Major_Desert
	Minor_Volcano
}

signal levelCompleted

const notesTextures = [
preload("res://assets/notesMusic/note_1.tres"),
preload("res://assets/notesMusic/note_3.tres"),
preload("res://assets/notesMusic/note_4.tres"),
preload("res://assets/notesMusic/note_2.tres")
]


export(noteType) var noteRegion
export(AudioStream) var sound_note

export(NodePath) var roomTimePath

onready var dataBase = get_parent()

onready var texture = $"../texture"

var roomTimeObject:Object

func _set_noteData():
	
	dataBase.connect("body_entered" , self , "_getting_note")
	
	texture.texture = notesTextures[noteRegion]

func _getting_note(object):
	
	if object.is_in_group("player"):
		
		get_tree().call_group("roomTime" , "_stop_timer")
		
		emit_signal("levelCompleted")
		
		ServeAudio.play_sound_at_position(sound_note , get_parent().global_position , "SFXs")
		
		dataBase.hide()
		
		dataBase.get_node("shape").set_deferred("disabled" , true)
		
		yield(ServeAudio , "sound_finished")
		
		_get_TimeAvarage()

func _get_TimeAvarage():
	
	roomTimeObject = get_node(roomTimePath)
	
	var timeRoomConclusion:float = (roomTimeObject.timeLevel - roomTimeObject.timer_count)
	
	MangerLevel.levelsAvarageTime[MangerLevel.current_level].append(timeRoomConclusion)
	
	if MangerLevel.roomOrder.size() == (MangerLevel.countRoom + 1):
		
		var timeCount:float
		
		for t in MangerLevel.levelsAvarageTime[MangerLevel.current_level]:
			
			timeCount += t
			
		timeCount /= MangerLevel.roomOrder.size()
		
		if timeCount < MangerLevel.levelsTimeReal[MangerLevel.current_level]:
		
			MangerLevel.levelsTimeReal[MangerLevel.current_level] = timeCount
		
		else:
			
			if MangerLevel.levelsTimeReal[MangerLevel.current_level] == 0:
				
				MangerLevel.levelsTimeReal[MangerLevel.current_level] = timeCount
	
	MangerLevel.load_room(dataBase.owner)

func _ready():
	
	_set_noteData()

func _on_FinishedLevel_levelCompleted():
	
	print("Finished !")
