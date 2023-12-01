extends KinematicBody2D

const gamePausePreObject = preload("res://gameUI/gamePause/object/gamePause.tscn")
const roomFinishedPreObject = preload("res://gameUI/room/roomFinished/objects/roomFinished.tscn")

onready var movement_behavior = $movementBehavior
onready var movement_animation = $texture/movement_animation

func _on_RoomTime_finished():
	
	queue_free()
	
	var roomFinished = roomFinishedPreObject.instance()
	
	get_parent().add_child(roomFinished)

func _input(event):
	
	if Input.is_action_just_pressed("gamePause"):
		
		var gamePuase = gamePausePreObject.instance()
		
		get_parent().add_child(gamePuase)

func _playViolin():
	
	movement_animation.play("play_vilion")
	
	movement_behavior.can_move = false
	
	yield(movement_animation , "animation_finished")
	
	movement_behavior.can_move = true
