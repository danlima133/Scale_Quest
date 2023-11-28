extends Node

onready var buttons = $base/buttons
onready var indicTexture = $base/indic
onready var move_anim = $base/indic/moveAnim

onready var camera_offset = $"../camera/cameraOffset"

var indexButton:int
var lastIndex:int
var indexMax:int

var can_pressed = true

func _ready():
	
	indexMax = buttons.get_child_count() - 1
	
	_get_nextButton()

func _input(event):
	
	if event is InputEventKey:
		
		if event.pressed and can_pressed:
		
			match event.scancode:
				
				KEY_DOWN:
					
					indexButton += 1
					
					if indexButton > indexMax:
						
						indexButton = 0
				
				KEY_UP:
					
					indexButton -= 1
					
					if indexButton < 0:
						
						indexButton = indexMax
			
			_get_nextButton()

	if Input.is_action_just_pressed("ui_accept") and can_pressed:
		
		_pressedButton()

func _get_nextButton():
	
	var button = buttons.get_child(indexButton) as Button
	
	var posStart = indicTexture.rect_global_position
	var posFinal = (button.rect_global_position - Vector2(0 , 8))
	
	move_anim.interpolate_property(indicTexture , "rect_global_position" , posStart , posFinal , 0.5 , Tween.TRANS_EXPO , Tween.EASE_OUT)
	
	move_anim.start()

func _pressedButton():
	
	can_pressed = false
	
	match indexButton:
		
		0:
			
			camera_offset.play("ToWolrdMap")
			
		1:
			
			camera_offset.play("ToConfig")
			
		2:
			
			get_tree().quit()
