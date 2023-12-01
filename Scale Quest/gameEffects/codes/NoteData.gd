extends Node

const rootDataPath = "res://gameEffects/resources/notesColorsRamp/Note_"

onready var particleOrigin = get_parent()

var initialRamp:Gradient

var mainRamp:Gradient

func setNote(noteID:int):
	
	mainRamp = load(rootDataPath + str(noteID) + "/" + "main.tres")
	
	initialRamp = load(rootDataPath + str(noteID) + "/" + "initialRamp.tres")

func setData():
	
	particleOrigin.set("color_ramp" , mainRamp)
	
	particleOrigin.set("color_initial_ramp" , initialRamp)

	particleOrigin.emitting = true
