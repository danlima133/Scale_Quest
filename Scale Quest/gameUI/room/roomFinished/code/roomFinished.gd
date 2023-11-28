extends CanvasLayer

func _on_try_again_pressed():
	
	LoadScene.loadScene(MangerLevel.rootPathLevels + MangerLevel.current_level + "/" + MangerLevel.roomOrder[MangerLevel.countRoom] , get_parent())

func _on_back_to_main_pressed():
	
	MangerLevel.countRoom = -1
	
	ServeAudio.stop_SounRoom(true)
	
	LoadScene.loadScene("res://mapaMundi/object/MapaMundi.tscn" , get_parent())
