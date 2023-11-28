extends KinematicBody2D

const gamePausePreObject = preload("res://gameUI/gamePause/object/gamePause.tscn")
const roomFinishedPreObject = preload("res://gameUI/room/roomFinished/objects/roomFinished.tscn")

func _on_RoomTime_finished():
	
	queue_free()
	
	var roomFinished = roomFinishedPreObject.instance()
	
	get_parent().add_child(roomFinished)

func _input(event):
	
	if Input.is_action_just_pressed("gamePause"):
		
		var gamePuase = gamePausePreObject.instance()
		
		get_parent().add_child(gamePuase)
