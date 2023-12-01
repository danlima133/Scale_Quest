extends Node2D

onready var Maincamera = $camera
onready var player_cutscene = $Sky_Menu/PlayerCutscene
onready var transition = $UI/transition
onready var notes_music = $Sky_Menu/NotesMusic

onready var game_name = $MainGame/base/gameName
onready var buttons = $MainGame/base/buttons
onready var indic = $MainGame/base/indic

onready var music_player = $"%MusicPlayer"

onready var camera_offset = $camera/cameraOffset

onready var reset_game = $ResetGame
onready var mapa_mundi = $MapaMundi

func _ready():
	
	ServeData.loadGame()
	
	$"%CutsceneExecute".active = Global.hasCutscene
	
	match Global.hasCutscene:
		
		false:
			
			reset_game.show()
			
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
	
			if MangerLevel.levelConslused == false: music_player.playMusic()

func creditConclused():
	
	$"%Credits".play("finishedCredit")
	
	yield($"%Credits" , "animation_finished")
	
	$"%Execute".active = false
	
	$"%Credits".play("normal")
	
	Global.hasCredits = false
	
	ServeData.saveGame()
	
	$"%MusicPlayer".playMusic()

func finishedCutscene():
	
	mapa_mundi.get_child(0).show()
	
	reset_game.show()
	
	Global.hasCutscene = false
	
	ServeData.saveGame()

func _on_back_to_main_pressed():
	
	$MainGame.can_pressed = true
	
	camera_offset.play_backwards("ToWolrdMap")
	
	$"%MusicPlayer".current_local = $"%MusicPlayer".local.Menu
	
	$"%MusicPlayer".playMusic()
