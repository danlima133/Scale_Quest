extends Node2D

const activeTexture = preload("res://assets/objects/musicBlockActive/block_musicOff.tres")
const desactiveTexture = preload("res://assets/objects/musicBlockActive/block_musicOn.tres")

export(NodePath) var configRefPath

var objectConfig:Object

var object:Object

var block_active = true

onready var texture = $texture

func set_block():
	
	match block_active:
		
		true:
			
			texture.texture = activeTexture
		
		false:
			
			texture.texture = desactiveTexture

func _get_object():
	
	objectConfig = get_node(configRefPath)

func _on_area_body_entered(body):
	
	if body.is_in_group("player"):
		
		object = body

func _on_area_body_exited(body):

	if body.is_in_group("player"):
		
		object = null

func _process(delta):
	
	set_block()

func _ready():
	
	_get_object()

func _input(event):
	
	if event is InputEventKey:
		
		if event.pressed and event.scancode == KEY_T:
			
			if object != null:
				
				match block_active:
					
					true:
						
						ServeAudio.play_sound_at_position(preload("res://assets/sfx/musical_block_on.ogg") , global_position , "SFXs")
						
					false:
						
						ServeAudio.play_sound_at_position(preload("res://assets/sfx/musical_block_off.ogg") , global_position , "SFXs")
			
				objectConfig.callObjects(block_active , true)
				
				block_active =! block_active
