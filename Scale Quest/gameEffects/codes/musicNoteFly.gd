extends Node2D

var data:Dictionary

onready var texture = $texture
onready var sound = $sound

onready var movement = $movement

func _setData():
	
	texture.texture = data["noteTexture"]
	
	sound.stream = data["noteSound"]
	
	_startMove()

func _startMove():
	
	sound.play()
	
	var velocity = rand_range(2 , 3)
	
	var yRand = rand_range(20 , 160)
	
	movement.interpolate_property(self , "global_position" , Vector2(global_position.x , yRand) , Vector2(340 , yRand) , velocity , Tween.TRANS_QUINT , Tween.EASE_OUT)
	
	movement.start()
	
	yield(movement  , "tween_all_completed")
	
	queue_free()

func _ready():
	
	randomize()
	
	_setData()
