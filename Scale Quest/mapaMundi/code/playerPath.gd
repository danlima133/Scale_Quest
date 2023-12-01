extends Node2D

const conclusionLevelPreObject = preload("res://gameUI/levelConclusion/objetcs/conclusionLevel.tscn")

const pointsLevel = {
	"Major_Plains":0,
	"Whole_Tone_Woods":73,
	"Gypsy_Major_Desert":140,
	"Minor_Volcano":218,
	"Finished":261
}

onready var root_motion = $path/root_motion
onready var move = $path/root_motion/move

onready var playerTexture = $path/root_motion/player

onready var baseUI = $"../UI/base"

var in_move = false

func _ready():
	
	ServeData.loadGame()
	
	root_motion.offset = MangerLevel.lastPoint
	
	if MangerLevel.conlusedGame == true:
		
		if MangerLevel.levelConslused == true:
				
			if LoadScene.has_load == true: yield(LoadScene , "loadCompleted")
			
			MangerLevel.levelConslused = false
			
			var levelConlusion = conclusionLevelPreObject.instance()
		
			levelConlusion.get_node("name_level").text = MangerLevel.current_level.replace("_"  , " ")
		
			baseUI.add_child(levelConlusion)
			
			yield(get_tree().create_timer(1.5) , "timeout")
		
			baseUI.get_node("conclusionLevel").queue_free()
			
			MangerLevel.current_level = ""
	
	match MangerLevel.levelConslused:
		
		false:
			
			if LoadScene.has_load == true: yield(LoadScene , "loadCompleted")
			
			_next_level()
			
		true:
			
			$"%MusicPlayer".current_local = $"%MusicPlayer".local.MapaMundi
			$"%MusicPlayer".playMusic()
			
			if LoadScene.has_load == true: yield(LoadScene , "loadCompleted")
			
			MangerLevel.levelConslused = false
			
			var levelConlusion = conclusionLevelPreObject.instance()
		
			levelConlusion.get_node("name_level").text = MangerLevel.current_level.replace("_"  , " ")
		
			baseUI.add_child(levelConlusion)
		
			yield(get_tree().create_timer(1) , "timeout")
		
			baseUI.get_node("conclusionLevel").queue_free()
			
			_next_level()
	
func _next_level():
	
	var levels = MangerLevel.levelsCompleted.keys()
	
	for l in levels:
		
		if MangerLevel.levelsCompleted[l] == false:
			
			_go_to_point(l)
			
			break
		
		elif MangerLevel.levelsCompleted[l] == true and l == "Minor_Volcano" and Global.hasCredits:
			
			_go_to_point("Finished")
			
			MangerLevel.conlusedGame = true
			
			ServeData.saveGame()

func _go_to_point(key:String):
	
	_focusPlayer(0)
	
	in_move = true
	
	if MangerLevel.current_level != key: playerTexture.play("run")
	
	move.interpolate_property(root_motion , "offset" , MangerLevel.lastPoint , pointsLevel[key] , 2 , Tween.TRANS_LINEAR)

	move.start()
	
	MangerLevel.lastPoint = pointsLevel[key]
	
	yield(move , "tween_all_completed")
	
	playerTexture.play("idle")
	
	in_move = false
	
	MangerLevel.current_level = key
	
	_get_rooms_by_level()
	
	ServeData.saveGame()
	
	if MangerLevel.current_level == "Finished" and Global.hasCredits:
		
		$"%MusicPlayer".stopMusic(true)
		
		Global.hasCredits = false
		
		$"%Execute".active = true

func _get_rooms_by_level():
	
	MangerLevel.roomOrder = []
	
#	if MangerLevel.roomOrder.empty() == false: return
	
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
			
			$"%MusicPlayer".stopMusic(true)
			
			MangerLevel.load_room(owner)

func _focusPlayer(value:float):
	
	if MangerLevel.current_level == "Finished": return
	
	var anim = get_tree().create_tween()
	
	anim.tween_property(playerTexture.material , "shader_param/line_thickness" , value , 0.2)

func _on_area_mouse_mouse_entered():
	
	_focusPlayer(0.5)

func _on_area_mouse_mouse_exited():
	
	_focusPlayer(0)
