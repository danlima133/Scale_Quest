extends Node

func _input(event):
	
	if Input.is_action_just_pressed("toggleFullscreen"):
		
		OS.window_fullscreen =! OS.window_fullscreen
