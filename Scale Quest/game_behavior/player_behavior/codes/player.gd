extends KinematicBody2D

const gamePausePreObject = preload("res://gameUI/gamePause/object/gamePause.tscn")

func _on_RoomTime_finished():
	
	queue_free()

func _input(event):
	
	if Input.is_action_just_pressed("gamePause"):
		
		var gamePuase = gamePausePreObject.instance()
		
		get_parent().add_child(gamePuase)
