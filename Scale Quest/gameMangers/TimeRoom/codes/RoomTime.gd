extends Node

signal finished
signal half_time

export(int) var timeLevel

onready var time = $time

var timer_count:int
var time_stop:int

var half_time = true
var stop = false

func _input(event):
	
	if event is InputEventKey:
		
		if event.pressed and event.scancode == KEY_P:
			
			_stop_timer()
		
		elif event.pressed and event.scancode == KEY_R:
			
			_resume_time()

func _set_timer():
	
	time.wait_time = timeLevel
	
	time.start()

func _stop_timer():
	
	stop = true
	
	time_stop = time.time_left
	
	time.stop()

func _resume_time():
	
	stop = false
	
	time.start(time_stop)
	
	time_stop = 0

func _half_time():
	
	emit_signal("half_time")

func _process(delta):
	
	if stop == false:
		
		timer_count = time.time_left
		
		if timer_count <= (timeLevel/2) and half_time:
			
			half_time = false
			
			_half_time()

func _ready():
	
	_set_timer()

func _on_time_timeout():
	
	emit_signal("finished")

