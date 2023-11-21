extends KinematicBody2D

export(int) var force

onready var pull_boxes = $pull_boxes

func _physics_process(delta):
	
	if pull_boxes.is_colliding():
		
		var colider = pull_boxes.get_collider()
		
		if colider.is_in_group("box"):
			
			var pull = -(global_position.x - colider.global_position.x)
			
			colider.motion.x += (pull * force)
