extends Node2D

onready var Maincamera = $camera
onready var player_cutscene = $Sky_Menu/PlayerCutscene
onready var transition = $UI/transition
onready var notes_music = $Sky_Menu/NotesMusic

onready var game_name = $MainGame/base/gameName
onready var buttons = $MainGame/base/buttons
onready var indic = $MainGame/base/indic

func _ready():
	
	ServeData.loadGame()
	
	$"%CutsceneExecute".active = Global.hasCutscene
	
	match Global.hasCutscene:
		
		false:
			
			transition.hide()
			
			player_cutscene.hide()
			notes_music.hide()
			
			game_name.modulate = Color(1 , 1 , 1)
			buttons.modulate = Color(1 , 1 , 1)
			indic.modulate = Color(1 , 1 , 1)
			
			if MangerLevel.levelConslused == false:
				
				Maincamera.global_position = Vector2(0 , -512)
				
			else:
				
				Maincamera.global_position = Vector2.ZERO

func creditConclused():
	
	$"%Credits".play("finishedCredit")
	
	yield($"%Credits" , "animation_finished")
	
	$"%Execute".active = false
	
	$"%Credits".play("normal")
	
	Global.hasCredits = false
	
	ServeData.saveGame()

func finishedCutscene():
	
	Global.hasCutscene = false
	
	ServeData.saveGame()
