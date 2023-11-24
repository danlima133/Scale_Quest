extends Node2D

const sizeX = 16
const sizeY = 4

export(String , FILE , "*.platformData") var dataPath

onready var texture = $path/root_motion/body/texture
onready var shape = $path/root_motion/body/shape

onready var movement = $movement

var proprities:Dictionary

var back = true

var triger = false
var in_move = false

func _get_data():
	
	var file = File.new()
	
	if file.file_exists(dataPath):
	
		var erro = file.open(dataPath , File.READ)
		
		if erro == OK:
			
			var text = file.get_as_text()
			
			var jsonData = parse_json(text)
			
			var dataType = typeof(jsonData)
			
			if dataType == TYPE_DICTIONARY:
				
				proprities = jsonData
				
				_make_platform_by_data()
				
				_processPlatform()
				
				print(proprities)

	
	file.close()

func _make_platform_by_data():
	
	var size = proprities["size"]
	
	var collision = RectangleShape2D.new()
	
	var rect = Rect2(0 , 0 , (sizeX * size) , sizeY)
	
	collision.extents = (Vector2((sizeX * size)/2 , sizeY/2))
	
	texture.region_rect = rect
	
	shape.shape = collision

func _processPlatform():
	
	movement.playback_speed = proprities["velocity"]
	
	movement.playback_speed = clamp(movement.playback_speed , 0.1 , 2)
	
	if proprities["independet"] == true:
		
		movement.play("move")

func sent_platform():
	
	if in_move == false:
	
		in_move = true
		
		movement.play("move")
	
func call_platform():
	
	if in_move == false:
	
		in_move = true
		
		movement.play_backwards("move")

func _ready():
	
	_get_data()

func triger(case:bool):

	if proprities["independet"] == false and in_move == false:
		
		match case:
			
			true:
				
				sent_platform()
			
			false:
				
				call_platform()
		
		triger = case

func _on_movement_animation_finished(anim_name):
	
	in_move = false
	
	if proprities["independet"] == true:
		
		yield(get_tree().create_timer(proprities["wait_time"]) , "timeout")
		
		match back:
			
			true:
				
				call_platform()
				
				back = false
			
			false:
				
				sent_platform()
				
				back = true
