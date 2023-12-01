extends Area2D

export(NodePath) var doorOutputPath
export(bool) var need_key = false

const doorClosedTexture = preload("res://assets/objects/doorClosed.tres")
const doorOpenTexture = preload("res://assets/objects/door.tres")

onready var texture = $texture
onready var marker = $marker

var outputDoor:Object

var object = null

func _markerDoorOutput():
	
	match outputDoor.need_key:
		
		true:
			
			outputDoor.marker.play("markerRed")
		
		false:
			
			outputDoor.marker.play("markerGreen")
	
	if need_key == false:
		
		outputDoor.marker.play("markerGreen")
	
	else: outputDoor.marker.play("markerRed")

func _removeMarker():
	
	outputDoor.marker.play("default")

func _setTexture():
	
	match need_key:
		
		true:
			
			texture.texture = doorClosedTexture
		
		false:
			
			texture.texture = doorOpenTexture

func _get_door():
	
	outputDoor = get_node(doorOutputPath)

func _teleport_to_door():
	
	print_debug()
	
	object.global_position = outputDoor.get_node("position").global_position

func _input(event):
	
	if Input.is_action_just_pressed("playerInterecation"):
		
		if object != null:
			
			match need_key:
				
				true:
					
					var manager = owner.get_node("ManagerCollectables")
					
					if manager.keys >= 1:
						
						ServeAudio.play_sound_at_position(preload("res://assets/sfx/opening_closing_door.ogg") , global_position , "SFXs")
						
						manager.remove_key(1)
						
						_teleport_to_door()
						
						need_key = false
						
						_setTexture()
					
					else: ServeAudio.play_sound_at_position(preload("res://assets/sfx/unlocking_door.ogg") , global_position , "SFXs")
					
				false:
					
					ServeAudio.play_sound_at_position(preload("res://assets/sfx/opening_closing_door.ogg") , global_position , "SFXs")
					
					_teleport_to_door()

func _ready():
	
	_get_door()
	
	_setTexture()

func _on_door_body_entered(body):
	
	if body.is_in_group("player"):
		
		object = body
		
		_markerDoorOutput()

func _on_door_body_exited(body):
	
	if body.is_in_group("player"):
		
		object = null
		
		_removeMarker()
