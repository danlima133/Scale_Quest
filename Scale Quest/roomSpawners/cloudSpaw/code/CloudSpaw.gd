extends Node

const cloudPreObject = preload("res://roomSpawners/cloudSpaw/objects/cloud.tscn")

export(float) var timeMin
export(float) var timeMax

onready var clouds = $clouds
onready var timerColdow = $timer

func _ready():
	
	randomize()
	
	_try_spaw()

func _try_spaw():
	
	var timer = rand_range(timeMin , timeMax)
	
	timerColdow.wait_time = timer
	
	timerColdow.start()

func _spaw():
	
	var cloud = cloudPreObject.instance()
	
	cloud.global_position = Vector2(400 , rand_range(48 , 112))
	
	if clouds.get_child_count() < 3:
	
		clouds.add_child(cloud)
	
	else: cloud = null
	
	_try_spaw()

func _on_timer_timeout():
	
	_spaw()
