extends Node

var hasCutscene = true
var hasCredits = true

func _ready():
	
	pause_mode = Node.PAUSE_MODE_PROCESS

func _input(event):
	
	if Input.is_action_just_pressed("toggleFullscreen"):
		
		OS.window_fullscreen =! OS.window_fullscreen
