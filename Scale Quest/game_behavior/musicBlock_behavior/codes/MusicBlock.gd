extends Node2D

export(NodePath) var configRefPath

var objectConfig:Object

var object:Object

var block_active = true

func _get_object():
	
	objectConfig = get_node(configRefPath)

func _on_area_body_entered(body):
	
	if body.is_in_group("player"):
		
		object = body

func _on_area_body_exited(body):

	if body.is_in_group("player"):
		
		object = null

func _ready():
	
	_get_object()

func _input(event):
	
	if event is InputEventKey:
		
		if event.pressed and event.scancode == KEY_T:
			
			if object != null:
			
				objectConfig.callObjects(block_active , true)
				
				block_active =! block_active
