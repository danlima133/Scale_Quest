extends Area2D

export(NodePath) var doorOutputPath
export(bool) var need_key = false

const doorClosedTexture = preload("res://assets/objects/doorClosed.tres")

onready var texture = $texture

var outputDoor:Object

var object = null

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
						
						manager.remove_key(1)
						
						_teleport_to_door()
					
				false:
					
					_teleport_to_door()

func _ready():
	
	_get_door()
	
	if need_key == true:
		
		texture.texture = doorClosedTexture

func _on_door_body_entered(body):
	
	if body.is_in_group("player"):
		
		object = body

func _on_door_body_exited(body):
	
	if body.is_in_group("player"):
		
		object = null
