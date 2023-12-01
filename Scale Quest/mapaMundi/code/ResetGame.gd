extends Node2D

onready var camera_offset = $"../camera/cameraOffset"

onready var alert_html = $Control/MarginContainer/alertHTML
onready var content = $Control/MarginContainer/VBoxContainer

func _on_reset_game_pressed():
	
	var version = OS.get_name()
	
	var dir = Directory.new()
	
	dir.remove(ServeData.rootDataPath)
	
	match version:
		
		"HTML5":
			
			content.hide()
			
			alert_html.show()
			
		"Windows":
			
			var pathGame = OS.get_executable_path()
			
			OS.shell_open(pathGame)
			
			get_tree().quit()

func _on_no_pressed():
	
	$"../MainGame".can_pressed = true
	
	camera_offset.play_backwards("ToConfig")
