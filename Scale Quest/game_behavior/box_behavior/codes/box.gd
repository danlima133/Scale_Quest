extends StaticBody2D

export(float) var gravity

var motion:Vector2

func _gravity(delta):
	
	motion.y += (gravity * delta)

func _physics_process(delta):
	
#	_gravity(delta)
	
	translate(motion * delta)
