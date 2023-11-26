extends CanvasLayer

func _ready():
	
	get_tree().paused = true

func _input(event):
	
	if Input.is_action_just_pressed("gamePause"):
		
		get_tree().paused = false
		
		queue_free()

func _on_back_to_game_pressed():
	
	get_tree().paused = false
	
	queue_free()

func _on_back_to_main_pressed():
	
	LoadScene.loadScene("res://mapaMundi/object/MapaMundi.tscn" , get_parent())
	
	get_tree().paused = false
	
	queue_free()

func _on_restart_room_pressed():
	
	get_tree().paused = false
	
	LoadScene.loadScene(MangerLevel.rootPathLevels + MangerLevel.current_level + "/" + MangerLevel.roomOrder[MangerLevel.countRoom] , get_parent())

	queue_free()
