extends RigidBody2D

onready var floorCheck = $floor

var on_floor = true

func _process(delta):
	
	if floorCheck.is_colliding():
		
		match on_floor:
			
			true:
				
				ServeAudio.play_sound_at_position(preload("res://assets/sfx/box_fall_impact.ogg") , floorCheck.get_collision_point() , "SFXs")
				
				on_floor = false
	
	else: on_floor = true
