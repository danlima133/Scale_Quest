extends CanvasLayer

onready var name_level = $content/VBoxContainer/nameLevel
onready var room_count = $content/VBoxContainer/roomCount

func _ready():
	
	get_tree().paused = true
	
	name_level.text = MangerLevel.current_level.replace("_" , " ")
	
	room_count.text = "Room %s" % (MangerLevel.countRoom + 1)

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
