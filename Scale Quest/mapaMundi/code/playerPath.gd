extends Node2D

const pointsLevel = {
	"Major_Plains":0,
	"Whole_Tone_Woods":73,
	"Gypsy_Major_Desert":140,
	"Minor_Volcano":218,
	"Finished":261
}

onready var root_motion = $path/root_motion
onready var move = $path/root_motion/move

var in_move = false

func _ready():
	
	root_motion.offset = MangerLevel.lastPoint
	
	yield(get_tree().create_timer(1) , "timeout")
	
	_next_level()
	
func _next_level():
	
	var levels = MangerLevel.levelsCompleted.keys()
	
	for l in levels:
		
		if MangerLevel.levelsCompleted[l] == false:
			
			_go_to_point(l)
			
			break
		
		elif MangerLevel.levelsCompleted[l] == true and l == "Minor_Volcano":
			
			_go_to_point("Finished")

func _go_to_point(key:String):
	
	in_move = true
	
	move.interpolate_property(root_motion , "offset" , MangerLevel.lastPoint , pointsLevel[key] , 2 , Tween.TRANS_LINEAR)

	move.start()
	
	MangerLevel.lastPoint = pointsLevel[key]
	
	yield(move , "tween_all_completed")
	
	in_move = false
	
	MangerLevel.current_level = key
	
	_get_rooms_by_level()

func _get_rooms_by_level():
	
	var dir = Directory.new()
	
	var erro = dir.open(MangerLevel.rootPathLevels + MangerLevel.current_level)
	
	if erro == OK:
		
		dir.list_dir_begin(true)
		
		var filePath = dir.get_next()
		
		while filePath != "":
			
			MangerLevel.roomOrder.append(filePath)
			
			filePath = dir.get_next()
	
	print(MangerLevel.roomOrder)

func _on_area_mouse_input_event(_viewport, event, _shape_idx):
	
	if MangerLevel.current_level == "Finished":
		
		return
	
	if event is InputEventMouseButton and in_move == false:
		
		if event.pressed and event.button_index == 1:
			
			MangerLevel.load_room()
